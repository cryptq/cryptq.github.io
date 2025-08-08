/*
 * Minimal DecompilerExporter for Ghidra
 * Exports function prototypes and decompiled bodies.
 */

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

import ghidra.app.decompiler.*;
import ghidra.app.decompiler.DecompileOptions.CommentStyleEnum;
import ghidra.app.decompiler.parallel.ChunkingParallelDecompiler;
import ghidra.app.decompiler.parallel.ParallelDecompiler;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.AddressSetView;
import ghidra.program.model.listing.Function;
import ghidra.program.model.listing.FunctionIterator;
import ghidra.program.model.listing.Listing;
import ghidra.program.model.listing.Program;
import ghidra.program.model.mem.Memory;
import ghidra.program.model.mem.MemoryAccessException;
import ghidra.util.task.TaskMonitor;
import ghidra.util.task.TaskMonitorAdapter;
import generic.cache.CachingPool;
import generic.cache.CountingBasicFactory;
import generic.concurrent.QCallback;

public class DecompilerExporter extends GhidraScript {
    private static final String EOL = System.getProperty("line.separator");
    private DecompileOptions options;
    private String outDir = "/tmp/decomp";

    @Override
    protected void run() throws Exception {
        String[] args = getScriptArgs();
        if (args.length > 0) outDir = args[0];
        Files.createDirectories(Paths.get(outDir));

        options = new DecompileOptions();
        options.setCommentStyle(CommentStyleEnum.CPPStyle);

        AddressSetView addrSet = currentProgram.getMemory();
        CachingPool<DecompInterface> pool = new CachingPool<>(new DecompilerFactory(currentProgram));
        ParallelDecompilerCallback callback = new ParallelDecompilerCallback(pool);
        ChunkingTaskMonitor chunkMon = new ChunkingTaskMonitor(monitor);
        ChunkingParallelDecompiler<CPPResult> decomp = ParallelDecompiler
            .createChunkingParallelDecompiler(callback, chunkMon);

        exportFunctions(addrSet, decomp, chunkMon);
        pool.dispose();
        decomp.dispose();
        println("Export completed to " + outDir);
    }

    private void exportFunctions(AddressSetView addrSet,
            ChunkingParallelDecompiler<CPPResult> decomp, ChunkingTaskMonitor chunkMon) throws Exception {
        Listing listing = currentProgram.getListing();
        FunctionIterator iter = listing.getFunctions(addrSet, true);
        List<Function> batch = new ArrayList<>();
        int total = currentProgram.getFunctionManager().getFunctionCount();
        chunkMon.doInitialize(total);
        while (iter.hasNext()) {
            Function f = iter.next();
            if (f.isExternal() || f.isThunk()) continue;
            batch.add(f);
            if (batch.size() >= 500) {
                writeBatch(batch, decomp, chunkMon);
                batch.clear();
            }
        }
        if (!batch.isEmpty()) writeBatch(batch, decomp, chunkMon);
    }

    private void writeBatch(List<Function> funcs,
            ChunkingParallelDecompiler<CPPResult> decomp, ChunkingTaskMonitor chunkMon) throws Exception {
        List<CPPResult> results = decomp.decompileFunctions(funcs);
        for (CPPResult r : results) {
            if (r == null) continue;
            String base = String.format("%s/%s_%s", outDir, sanitize(r.name), Long.toHexString(r.entry.getOffset()));
            // write prototype
            try (PrintWriter pw = new PrintWriter(base + ".h")) {
                pw.println(r.prototype + ";");
            }
            // write body
            try (PrintWriter pw = new PrintWriter(base + ".c")) {
                pw.println("#include \"" + sanitize(r.name) + ".h\"");
                pw.println(r.body);
            }
        }
    }

    private String sanitize(String s) {
        return s.replaceAll("[^0-9A-Za-z_]", "_");
    }

    private class CPPResult {
        String name, prototype, body;
        ghidra.program.model.address.Address entry;
        CPPResult(String n, ghidra.program.model.address.Address e, String p, String b) {
            name = n; entry = e; prototype = p; body = b;
        }
    }

    private class DecompilerFactory extends CountingBasicFactory<DecompInterface> {
        private final Program prog;
        DecompilerFactory(Program p) { prog = p; }
        @Override public DecompInterface doCreate(int i) throws IOException {
            DecompInterface d = new DecompInterface(); d.setOptions(options); d.openProgram(prog); return d;
        }
        @Override public void doDispose(DecompInterface d) { d.dispose(); }
    }

    private class ParallelDecompilerCallback implements QCallback<Function,CPPResult> {
        private final CachingPool<DecompInterface> pool;
        ParallelDecompilerCallback(CachingPool<DecompInterface> p) { pool = p; }
        @Override public CPPResult process(Function f, TaskMonitor m) throws Exception {
            DecompInterface d = pool.get();
            try {
                DecompileResults dr = d.decompileFunction(f, options.getDefaultTimeout(), m);
                if (dr == null || !dr.decompileCompleted()) return null;
                String sig = dr.getDecompiledFunction().getSignature();
                String code = dr.getDecompiledFunction().getC();
                return new CPPResult(f.getName(), f.getEntryPoint(), sig, code);
            } finally { pool.release(d); }
        }
    }

    private class ChunkingTaskMonitor extends TaskMonitorAdapter {
        private final TaskMonitor mon;
        ChunkingTaskMonitor(TaskMonitor m) { mon = m; }
        void doInitialize(long v) { mon.initialize(v); }
        @Override public void setProgress(long v) { mon.setProgress(v); }
        @Override public void setMessage(String msg) { mon.setMessage(msg); }
        @Override public void checkCanceled() throws ghidra.util.exception.CancelledException { mon.checkCanceled(); }
    }
}