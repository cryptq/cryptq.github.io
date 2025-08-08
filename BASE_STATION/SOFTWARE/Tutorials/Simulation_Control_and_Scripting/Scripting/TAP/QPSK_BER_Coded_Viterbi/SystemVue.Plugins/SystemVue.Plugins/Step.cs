// Author: MyName
// Copyright:   Copyright 2016 Keysight Technologies
//              You have a royalty-free right to use, modify, reproduce and distribute
//              the sample application files (and/or any modified version) in any way
//              you find useful, provided that you agree that Keysight Technologies has no
//              warranty, obligations or liability for any sample application files.
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.Threading;

using Keysight.Tap;  // Use Platform infrastructure/core components (log,TestStep definition, etc)

namespace SystemVue.Plugins
{
    [Display("SVStart", Groups: new[] { "SystemVue", "Birth and Death" }, Description: "Start SystemVue")]
    public class StartSV : SVcontrol
    {
        public StartSV()
        {
            // ToDo: Set default values for properties / settings.
        }

        public override void Run()
        {
            svCntl.StartSystemVue();
            svCntl.SetVisible(true);
            Verdict = Verdict.Pass;
        }
    }

    [Display("SVExit", Groups: new[] { "SystemVue", "Birth and Death" }, Description: "Exit SystemVue")]
    public class ExitSV : SVcontrol
    {
        public ExitSV()
        {
            // ToDo: Set default values for properties / settings.
        }

        public override void Run()
        {
            svCntl.ExitSystemVue();
        }
    }

    [Display("SVOpenWorkspace", Groups: new[] { "SystemVue", "Control Workspaces" }, Description: "Open SystemVue Workspace")]
    public class SVOpenWorkspace : SVcontrol
    {
        #region Settings
        [FilePathAttribute]
        [Display("Filepath", Group: "File")]
        [Browsable(true)]
        public string FilePath { get; set; }
        #endregion

        public SVOpenWorkspace()
        {
            // ToDo: Set default values for properties / settings.
            FilePath = "Comms/BER/QPSK_BER_Coded_Viterbi.wsv";
        }

        public override void Run()
        {
            String workspacePath = System.IO.Path.GetFullPath(FilePath);
            svCntl.OpenWorkspace(workspacePath);
            Verdict = Verdict.Pass;
        }
    }

    [Display("SVOpenExampleWorkspace", Groups: new[] { "SystemVue", "Control Workspaces" }, Description: "Open SystemVue Example Workspace")]
    public class SVOpenExampleWorkspace : SVcontrol
    {
        #region Settings
        [FilePathAttribute]
        [Display("Filepath", Group: "File")]
        [Browsable(true)]
        public string FilePath { get; set; }
        #endregion

        public SVOpenExampleWorkspace()
        {
            // ToDo: Set default values for properties / settings.
            FilePath = "Comms/BER/QPSK_BER_Coded_Viterbi.wsv";
        }

        public override void Run()
        {
            svCntl.OpenExampleWorkspace(FilePath);
            Verdict = Verdict.Pass;
        }
    }

    [Display("SVRunAnalysis", Groups: new[] { "SystemVue", "Run Analysis" }, Description: "Run SystemVue Analysis")]
    public class SVRunAnalysis : SVcontrol
    {

        public SVRunAnalysis()
        {
            // ToDo: Set default values for properties / settings.
        }

        public override void Run()
        {
            // Run a simple VB command in SystemVue to run the appropriate analysis
            svCntl.RunScript("QPSK_BER_Coded_Viterbi.Analyses.Uncoded_QPSK_BER_Analysis.RunAnalysis()");
            UpgradeVerdict(Verdict.Pass);
        }
    }

    [Display("SVSweepAnalysis", Groups: new[] { "SystemVue", "Run Analysis" }, Description: "Run SystemVue Sweep Analysis")]
    public class SVSweepAnalysis : SVcontrol
    {
        #region Settings
        [Display(Group: "Parameters", Name: "EbN0", Description: "Set the NDensity parameter EbN0")]
        public int EbN0 { get; set; }
        [Display(Group: "SweepRange", Name: "Start")]
        public int Start { get; set; }
        [Display(Group: "SweepRange", Name: "Stop")]
        public int Stop { get; set; }
        #endregion

        public SVSweepAnalysis()
        {
            // ToDo: Set default values for properties / settings.
            EbN0 = Parms.EbN0;
            Start = 0;
            Stop = 10;
        }

        public override void Run()
        {
            for (int EbN0 = Start; EbN0 <= Stop; EbN0++)
            {
                // Set the NDenstity parameter
                svCntl.SetParameter("QPSK_BER_Coded_Viterbi.WorkspaceVariables.VarBlock.[EbN0]", EbN0);

                // Run a simple VB command in SystemVue to run the appropriate analysis
                svCntl.RunScript("QPSK_BER_Coded_Viterbi.Analyses.Uncoded_QPSK_BER_Analysis.RunAnalysis()");

                // Read BER from dataset
                double BER = svCntl.GetData("QPSK_BER_Coded_Viterbi.Analyses.Uncoded_QPSK_BER_Data.Eqns.VarBlock.B11_BER");

                string result = "Eb/N0 = " + EbN0 + "\tBER = " + BER;
                Log.Info(result);
            }
            UpgradeVerdict(Verdict.Pass);
        }
    }
    
    [Display("SVSetParm", Groups: new[] { "SystemVue", "Step" }, Description: "Set SystemVue Workspace Parameters")]
    public class SVSetParm : SVcontrol
    {
        #region Settings
        [Display(Group: "Parameters", Name: "EbN0", Description: "SEt the NDensity parameter EbN0")]
        public int EbN0 { get; set; }
        #endregion

        public SVSetParm()
        {
            // ToDo: Set default values for properties / settings.
            EbN0 = 0;
        }

        public override void Run()
        {
            // Set the NDenstity parameter
            svCntl.SetParameter("QPSK_BER_Coded_Viterbi.WorkspaceVariables.VarBlock.[EbN0]", EbN0);
            Parms.EbN0 = EbN0;
        }
    }

    [Display("RunScriptVerbs", Groups: new[] { "SystemVue", "Step" }, Description: "Execute SystemVue Script Verb")]
    public class RunScriptVerb : SVcontrol
    {
        #region Settings
        [Display(Group: "Script", Name: "Verb", Description: "SystemVue Script Verb")]
        public String Verb { get; set; }
        #endregion

        public RunScriptVerb()
        {
            Verb = "QPSK_BER_Coded_Viterbi.WorkspaceVariables.VarBlock.EbN0";
        }

        public override void PrePlanRun()
        {
            base.PrePlanRun(); // Do not remove
            // ToDo: Optionally add any setup code this step needs to run before the testplan starts
        }

        public override void Run()
        {
            // ToDo: Add test case code here
            RunChildSteps(); //If step has child steps.
            //bool result = svCntl.RunScript(Verb);
            double answer = svCntl.GetData(Verb);
            string result = "the answer is .." + answer;
            Log.Info(result);
            // If no verdict is used, the verdict will default to NotSet.
            // You can change the verdict using UpgradeVerdict() as shown below.
            // UpgradeVerdict(Verdict.Pass);
        }

        public override void PostPlanRun()
        {
            // ToDo: Optionally add any cleanup code this step needs to run after the entire testplan has finished
            base.PostPlanRun(); // Do not remove
        }
    }

    [Display("5G", Groups: new[] { "SystemVue", "TestCase" }, Description: "5G Test Cases")]
    [AllowAnyChild]
    public class Test5G : SVcontrol
    {
        #region Settings
        [Display(Group: "Standard", Name: "Freq", Description: "5G Test Case")]
        public double Freq { get; set; }
        #endregion

        public Test5G()
        {
            Freq = 28e9;
        }

        public override void PrePlanRun()
        {
            base.PrePlanRun(); // Do not remove
            // ToDo: Optionally add any setup code this step needs to run before the testplan starts
        }

        public override void Run()
        {
            // ToDo: Add test case code here
            RunChildSteps(); //If step has child steps.
            Wait(800);      //wait 1000 ms
            // If no verdict is used, the verdict will default to NotSet.
            // You can change the verdict using UpgradeVerdict() as shown below.
            UpgradeVerdict(Verdict.Pass);
        }

        public override void PostPlanRun()
        {
            // ToDo: Optionally add any cleanup code this step needs to run after the entire testplan has finished
            base.PostPlanRun(); // Do not remove
        }

        public void Wait(int ms)
        {
            Thread.Sleep(ms);     // Thread.Sleep Method using System.Threading namespace
        }
    }

}
