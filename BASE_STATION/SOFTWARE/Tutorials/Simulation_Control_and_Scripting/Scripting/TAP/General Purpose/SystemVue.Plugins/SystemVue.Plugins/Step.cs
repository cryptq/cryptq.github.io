// Author: MyName
// Copyright:   Copyright 2016 Keysight Technologies
//              You have a royalty-free right to use, modify, reproduce and distribute
//              the sample application files (and/or any modified version) in any way
//              you find useful, provided that you agree that Keysight Technologies has no
//              warranty, obligations or liability for any sample application files.
using System;
using System.Collections.Generic;
using System.Linq;
using System.ComponentModel;
using System.Collections.ObjectModel;
using System.Threading;
using System.Windows.Threading;
using Microsoft.Win32;
using Keysight.Tap;  // Use Platform infrastructure/core components (log,TestStep definition, etc)

namespace SystemVue.Plugins
{
    [Display("SVStart", Groups: new[] { "SystemVue", "Start and Exit" }, Description: "Start SystemVue")]
    public class StartSV : SVcontrol
    {
        #region Settings
        [Display("Visible", Group: "Parameters")]
        [Browsable(true)]
        public Boolean Visible { get; set; }
        #endregion

        public StartSV()
        {
            // ToDo: Set default values for properties / settings.
            Visible = true;
        }

        public override void Run()
        {
            svCntl.StartSystemVue();
            svCntl.SetVisible(Visible);
        }
    }

    [Display("SVExit", Groups: new[] { "SystemVue", "Start and Exit" }, Description: "Exit SystemVue")]
    public class ExitSV : SVcontrol
    {
        public ExitSV()
        {
            // ToDo: Set default values for properties / settings.
        }

        public override void Run()
        {
            svCntl.ExitSystemVue();
            Param.Instance.OnWorkspaceClosed();
        }
    }

    [Display("SVOpenWorkspace", Groups: new[] { "SystemVue", "Control Workspaces" }, Description: "Open SystemVue Workspace")]
    public class SVOpenWorkspace : SVcontrol
    {
        #region Settings
        [FilePathAttribute]
        [Display("Filepath", Group: "File")]
        [Browsable(true)]
        public String FilePath { get; set; }

        [Display("Get Workspace Information", Description: "Get Analysis, Design and DataSet information from workspace file.", Order:100)]
        [Browsable(true)]
        public void Update()
        {
            if(String.IsNullOrEmpty(FilePath))
            {
                Log.Error("Please set Filepath.");
                return;
            }

            StatusDialog statusDialog = new StatusDialog();
            String message = "Getting Analysis, Design and DataSet information from workspace file...";
            statusDialog.Show(message);
            
            Exception exception = null;
            Thread thread = new Thread((ThreadStart)delegate
            {
                try
                {
                    String workspacePath = System.IO.Path.GetFullPath(FilePath);
                    Param.Instance.GetWorkspaceInformation(svCntl, workspacePath);
                }
                catch (Exception e)
                {
                    exception = e;
                }
            });

            thread.Start();

            while (!thread.Join(100))
                DoEvents();

            statusDialog.Close();
            if (exception == null)
            {
                Log.Info("Analyses, Designs and Datasets information have been imported.");
            }
            else
            {
                Log.Error(exception.Message);
            }
        }
        #endregion

        public SVOpenWorkspace()
        {
            String registryPath = @"CLSID\{F5B1D95F-3323-47D4-A5E2-6B8DE50BC055}\LocalServer32";
            try
            {
                RegistryKey keyClassesRoot = RegistryKey.OpenBaseKey(RegistryHive.ClassesRoot, RegistryView.Registry64);
                RegistryKey keyLocalServer = keyClassesRoot.OpenSubKey(registryPath);
                if (keyLocalServer != null)
                {
                    String svEXEDir = keyLocalServer.GetValue(null) as String;
                    svEXEDir = svEXEDir.Trim(new Char[] { '"' });
                    String svInstallDir = svEXEDir.Remove(svEXEDir.LastIndexOf(@"\Bin") );
                    FilePath = svInstallDir + @"\Template\Data Flow Template.wsv";
                    keyLocalServer.Close();
                }
            }
            catch{ }
        }

        public override void Run()
        {
            try
            {
                String workspacePath = System.IO.Path.GetFullPath(FilePath);
                Param.Instance.GetWorkspaceInformation(svCntl, workspacePath);
            }
            catch (Exception e)
            {
                Log.Error(e.Message);
                UpgradeVerdict(Verdict.Error);
            }
        }

        private static void DoEvents()
        {
            // Create new nested message pump.
            DispatcherFrame nestedFrame = new DispatcherFrame();

            // Dispatch a callback to the current message queue, when getting called, 
            // this callback will end the nested message loop.
            // note that the priority of this callback should be lower than the that of UI event messages.
            DispatcherOperation exitOperation = Dispatcher.CurrentDispatcher.BeginInvoke(
                                                DispatcherPriority.Background, (ThreadStart)delegate
                                                {
                                                    nestedFrame.Continue = false;
                                                });

            // pump the nested message loop, the nested message loop will 
            // immediately process the messages left inside the message queue.
            Dispatcher.PushFrame(nestedFrame);

            // If the "exitFrame" callback doesn't get finished, Abort it.
            if (exitOperation.Status != DispatcherOperationStatus.Completed)
            {
                exitOperation.Abort();
            }
        }
    }

    [Display("SVCloseWorkspace", Groups: new[] { "SystemVue", "Control Workspaces" }, Description: "Close SystemVue Workspace")]
    public class SVCloseWorkspace : SVcontrol
    {
        public SVCloseWorkspace()
        {
        }

        public override void Run()
        {
            svCntl.CloseWorkspace();
            Param.Instance.OnWorkspaceClosed();
        }
    }

    [Display("SVRunAnalysis", Groups: new[] { "SystemVue", "Run Analysis" }, Description: "Run SystemVue Analysis")]
    public class SVRunAnalysis : SVcontrol
    {
        private List<String> m_analyses = new List<string>();
        #region Settings
        [Browsable(false)]
        public Boolean AnalysisListAvailable
        {
            get { return (Param.Instance.Analyses.Count > 0 || m_analyses.Count > 0); }
        }

        [Browsable(false)]
        public Boolean AnalysisListUnAvailable
        {
            get { return !AnalysisListAvailable; }
        }

        [Browsable(false)]
        public List<String> Analyses
        {
            get
            {
                if (Param.Instance.Analyses.Keys.Count > 0)
                    return Param.Instance.Analyses.Keys.ToList();
                else
                    return m_analyses;
            }
            set { m_analyses = value; }
        }

        [Display("Analyses")]
        [EnabledIf("AnalysisListAvailable")]
        [AvailableValues("Analyses")]
        public string SelectedAnalysis { get; set; }

        [Display("AnalysisName")]
        [EnabledIf("AnalysisListUnAvailable")]
        public string AnalysisName { get; set; }
        #endregion

        public SVRunAnalysis()
        {
            SelectedAnalysis = String.Empty;
            AnalysisName = String.Empty;
        }

        public override void Run()
        {
            String analysisPath;
            if (!String.IsNullOrEmpty(SelectedAnalysis) && Param.Instance.Analyses.ContainsKey(SelectedAnalysis))
            {
                analysisPath = Param.Instance.Analyses[SelectedAnalysis];
                analysisPath = ISystemVue.AddSquareBracketsToPath(analysisPath);
            }
            else if(!String.IsNullOrEmpty(AnalysisName) && Param.Instance.Analyses.ContainsKey(AnalysisName))
            {
                analysisPath = Param.Instance.Analyses[AnalysisName];
                analysisPath = ISystemVue.AddSquareBracketsToPath(analysisPath);
            }
            else
            {
                Log.Error("Please set correct Analysis Name.");
                return;
            }

            String script = String.Format("{0}.RunAnalysis()", analysisPath);
            svCntl.RunScript(script);
            String errors = svCntl.GetErrors();
            if (!String.IsNullOrEmpty(errors))
            {
                String[] errorList = errors.Split(new Char[] { '\n' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (String error in errorList)
                {
                    if(error.TrimStart().StartsWith("(ERROR)"))
                        Log.Error("Error messages from SystemVue: " + error);
                    else if(error.TrimStart().StartsWith("(WARNING)"))
                        Log.Error("Warning messages from SystemVue: " + error);
                }

                if (errors.Contains("(ERROR)"))
                {
                    UpgradeVerdict(Verdict.Error);
                }
            }
        }

        public override void OnParameteriesChanged()
        {
            OnPropertyChanged("Analyses");
        }
    }

    [Display("SVSweepAnalysis", Groups: new[] { "SystemVue", "Run Analysis" }, Description: "Run SystemVue Sweep Analysis")]
    public class SVSweepAnalysis : SVcontrol
    {
        private List<String> m_analyses = new List<string>();
        #region Settings
        [Browsable(false)]
        public Boolean AnalysisListAvailable
        {
            get { return (Param.Instance.Analyses.Count > 0 || m_analyses.Count > 0); }
        }

        [Browsable(false)]
        public Boolean AnalysisListUnAvailable
        {
            get { return !AnalysisListAvailable; }
        }

        [Browsable(false)]
        public List<String> Analyses
        {
            get
            {
                if (Param.Instance.Analyses.Keys.Count > 0)
                    return Param.Instance.Analyses.Keys.ToList();
                else
                    return m_analyses;
            }
            set { m_analyses = value; }
        }

        [Display("Analyses")]
        [EnabledIf("AnalysisListAvailable")]
        [AvailableValues("Analyses")]
        public string SelectedAnalysis { get; set; }

        [Display("AnalysisName")]
        [EnabledIf("AnalysisListUnAvailable")]
        public string AnalysisName { get; set; }

        [Display(Name: "Parameter Path", Group: "Parameters", Description: "The full path of the parameter")]
        public String ParamPath { get; set; }

        [Display(Group: "SweepRange", Name: "Start")]
        public Double Start { get; set; }
        [Display(Group: "SweepRange", Name: "Stop")]
        public Double Stop { get; set; }
        [Display(Group: "SweepRange", Name: "Step")]
        public Double Step { get; set; }
        #endregion

        public SVSweepAnalysis()
        {
            Start = 0;
            Stop = 6;
            Step = 1;
        }

        public override void Run()
        {
            String analysisPath;
            if (!String.IsNullOrEmpty(SelectedAnalysis) && Param.Instance.Analyses.ContainsKey(SelectedAnalysis))
            {
                analysisPath = Param.Instance.Analyses[SelectedAnalysis];
                analysisPath = ISystemVue.AddSquareBracketsToPath(analysisPath);
            }
            else if (!String.IsNullOrEmpty(AnalysisName) && Param.Instance.Analyses.ContainsKey(AnalysisName))
            {
                analysisPath = Param.Instance.Analyses[AnalysisName];
                analysisPath = ISystemVue.AddSquareBracketsToPath(analysisPath);
            }
            else
            {
                Log.Error("Please set correct Analysis Name.");
                return;
            }

            if (String.IsNullOrEmpty(ParamPath) || !ParamPath.Contains('.'))
            {
                Log.Error("Please set valid Data Path.");
                UpgradeVerdict(Verdict.Error);

                return;
            }

            String dataName = ParamPath.Substring(ParamPath.LastIndexOf('.') + 1);

            for (Double value = Start; value <= Stop; value += Step)
            {
                // Set the NDenstity parameter
                if (!svCntl.SetParameter(ParamPath, value))
                {
                    Log.Error(String.Format("Fail to set parameter: {0} to {1}", ParamPath, value));
                    UpgradeVerdict(Verdict.Error);
                    break;
                }

                String script = String.Format("{0}.RunAnalysis()", analysisPath);
                svCntl.RunScript(script);
                String errors = svCntl.GetErrors();
                if (!String.IsNullOrEmpty(errors))
                {
                    Log.Error("Error messages from SystemVue: " + errors);
                    if (errors.Contains("(ERROR)"))
                    {
                        UpgradeVerdict(Verdict.Error);
                        break;
                    }  
                }

                String result = dataName + " = " + value;
                Log.Info(result);
            }
        }
    }

    [Display("SVStopRunningAnalyses", Groups: new[] { "SystemVue", "Run Analysis" }, Description: "Stop Running Analyses")]
    public class SVStopRunningAnalyses : SVcontrol
    {
        public override void Run()
        {
            svCntl.StopSimulation();
        }
    }

    [Display("SVSetParameter", Groups: new[] { "SystemVue", "Data Access" }, Description: "Set SystemVue Workspace Parameters")]
    public class SVSetParameter : SVcontrol
    {
        #region Settings
        [Display(Name: "Parameter Path", Group: "Parameters", Description: "The full path of the parameter")]
        public String Path { get; set; }
        [Display(Name: "Parameter Value", Group: "Parameters", Description: "The value of the parameter")]
        public String Value { get; set; }
        #endregion

        public SVSetParameter()
        {
            Path = String.Empty;
            Value = string.Empty;
        }

        public override void Run()
        {
            // Set the NDenstity parameter
            svCntl.SetEntry(Path, Value);
        }
    }

    [Display("SVSetAnalysisParameter", Groups: new[] { "SystemVue", "Data Access" }, Description: "Set SystemVue Workspace Parameters")]
    public class SVSetAnalysisParameter : SVcontrol
    {
        #region Settings
        [Display(Name: "Analysis Name", Group: "Parameters", Description: "The name of the analysis")]
        public String AnalysisName { get; set; }
        [Display(Name: "Parameter Name", Group: "Parameters", Description: "The name of the parameter")]
        public String ParamName { get; set; }
        [Display(Name: "Parameter Value", Group: "Parameters", Description: "The value of the parameter")]
        public String Value { get; set; }
        #endregion

        public SVSetAnalysisParameter()
        {
            AnalysisName = String.Empty;
            ParamName = String.Empty;
            Value = String.Empty;
        }

        public override void Run()
        {
            String analysisPath;
            if (!String.IsNullOrEmpty(AnalysisName) && Param.Instance.Analyses.ContainsKey(AnalysisName))
            {
                analysisPath = Param.Instance.Analyses[AnalysisName];
            }
            else
            {
                Log.Error("Please set correct Analysis Name.");
                return;
            }

            GENESYS.IItem analysisItem = svCntl.GetItem(analysisPath);
            GENESYS.IItem designNameItem = analysisItem.GetItemByName("DesignName");
            String designName = designNameItem.GetVarValue(0) as String;
            if (String.IsNullOrEmpty(designName)) return; // Sweep Analysis?

            String designPath = Param.Instance.Designs[designName];
            List<SVParameter> svParams = svCntl.GetDesignParameterList(designPath);
            if(String.IsNullOrEmpty(ParamName) || !svParams.Any(item => item.Name == ParamName) )
            {
                Log.Error("Please set correct Parameter Name.");
                return;
            }

            SVParameter param = svParams.First(item => item.Name == ParamName);
            svCntl.SetEntry(param.Path, Value);
        }
    }

    [Display("SVSetAnalysisParameters", Groups: new[] { "SystemVue", "Data Access" }, Description: "Set SystemVue Analysis Parameters")]
    public class SVSetAnalysisParameters : SVcontrol
    {
        #region Settings
        [Display("Analysis Setup", Description: "Setup Analysis Parameters.")]
        [Browsable(true)]
        public void AnalysisSetup()
        {
            AnalysisSettings analysisSettings = new AnalysisSettings(svCntl, Param.Instance.ParameterSettings);
            if(analysisSettings.ShowDialog().Value)
            {
                Param.Instance.ParameterSettings = analysisSettings.ParameterSettings;
            }
        }
        #endregion

        public SVSetAnalysisParameters()
        {
        }

        public override void Run()
        {
            foreach (ObservableCollection<Parameter> paramSettings in Param.Instance.ParameterSettings.Values)
            {
                foreach (var param in paramSettings)
                {
                    svCntl.SetEntry(param.Path, param.Value);
                }
            }
        }
    }

    [Display("SVGetData", Groups: new[] { "SystemVue", "Data Access" }, Description: "Get Data")]
    public class SVGetData : SVcontrol
    {
        #region Settings
        [Display(Name: "Data Path", Group: "Parameters", Description: "The full path of the Data")]
        public String DataPath { get; set; }
        #endregion

        public SVGetData()
        {
            DataPath = String.Empty;
        }

        public override void Run()
        {
            try
            {
                String dataName = DataPath.Substring(DataPath.LastIndexOf('.') + 1);

                Object varData = svCntl.GetData(DataPath);
                if(varData == null)
                {
                    Log.Error("Data does not exist: " + DataPath);
                    UpgradeVerdict(Verdict.Error);
                }
                else if (varData is Double[])
                {
                    Double[] varDataArray = varData as Double[];
                    String indepName = "Time";
                    Array varIndep = svCntl.GetData(DataPath + "_" + indepName) as Array;
                    if (varIndep == null)
                    {
                        indepName = "Freq";
                        varIndep = svCntl.GetData(DataPath + "_" + indepName) as Array;
                    }
                    if (varIndep == null)
                    {
                        indepName = "Index";
                        varIndep = svCntl.GetData(DataPath + "_" + indepName) as Array;
                    }

                    if (varIndep != null)
                    {
                        if (varDataArray.Length == varIndep.Length * 2)
                        {
                            Double[] realArray = new Double[varIndep.Length];
                            Double[] imagArray = new Double[varIndep.Length];
                            for (Int32 i = 0; i < varIndep.Length; i++)
                            {
                                realArray[i] = varDataArray[2 * i];
                                imagArray[i] = varDataArray[2 * i + 1];
                            }

                            Results.PublishTable(dataName, new List<String> { "Imag", "Real" }, imagArray, realArray);
                        }
                        else
                        {
                            Results.PublishTable(dataName, new List<String> { indepName, dataName }, varIndep, varDataArray);
                        }
                    }
                    else
                    {
                        Results.PublishTable(dataName, new List<String> { dataName }, varDataArray);
                    }
                }
                else
                {
                    Results.PublishTable(dataName, new List<String> { dataName }, varData as Array);
                }
            }
            catch (Exception e)
            {
                Log.Error(e.Message);
                UpgradeVerdict(Verdict.Error);
            }
        }
    }

    [Display("SVGetDataSetData", Groups: new[] { "SystemVue", "Data Access" }, Description: "Get Data from DataSet")]
    public class SVGetDataSetData : SVcontrol
    {
        List<String> m_dataSets = new List<string>();
        String m_seletedDataset;

        #region Settings
        [Browsable(false)]
        public List<String> DataSets
        {
            get
            {
                if (Param.Instance.DataSets.Keys.Count > 0)
                    return Param.Instance.DataSets.Keys.ToList();
                else
                    return m_dataSets;
            }
            set { m_dataSets = value; }
        }

        [Display("DataSets")]
        [AvailableValues("DataSets")]
        public String SelectedDataSet
        {
            get { return m_seletedDataset; }
            set
            {
                m_seletedDataset = value;
                try
                {
                    List<String> dataList = svCntl.GetDataSetVariableList(Param.Instance.DataSets[m_seletedDataset]);
                    if (dataList != null && dataList.Count > 0)
                        DataList = dataList;
                }
                catch { }
            }
        }

        [Browsable(false)]
        public List<String> DataList { get; set; }

        [Display("Data", Order: 100)]
        [AvailableValues("DataList")]
        public String SelectedData { get; set; }
        #endregion

        public SVGetDataSetData()
        {
        }

        public override void Run()
        {
            if (String.IsNullOrEmpty(m_seletedDataset))
                return;

            String varBlockPath = Param.Instance.DataSets[m_seletedDataset] + ".Eqns.VarBlock";
            String dataPath = varBlockPath + "." + SelectedData;
            if (!String.IsNullOrEmpty(dataPath))
            {
                Object varData = svCntl.GetData(dataPath);
                if (varData is Double[])
                {
                    Double[] varDataArray = varData as Double[];
                    String indepName = "Time";
                    Array varIndep = svCntl.GetData(dataPath + "_" + indepName) as Array;
                    if (varIndep == null)
                    {
                        indepName = "Freq";
                        varIndep = svCntl.GetData(dataPath + "_" + indepName) as Array;
                    }
                    if (varIndep == null)
                    {
                        indepName = "Index";
                        varIndep = svCntl.GetData(dataPath + "_" + indepName) as Array;
                    }

                    if (varIndep != null)
                    {
                        if (varDataArray.Length == varIndep.Length * 2)
                        {
                            Double[] realArray = new Double[varIndep.Length];
                            Double[] imagArray = new Double[varIndep.Length];
                            for (Int32 i = 0; i < varIndep.Length; i++)
                            {
                                realArray[i] = varDataArray[2 * i];
                                imagArray[i] = varDataArray[2 * i + 1];
                            }

                            Results.PublishTable(SelectedData, new List<String> { "Imag", "Real" }, imagArray, realArray);
                        }
                        else
                        {
                            Results.PublishTable(SelectedData, new List<String> { indepName, SelectedData }, varIndep, varDataArray);
                        }
                    }
                    else
                    {
                        Results.PublishTable(SelectedData, new List<String> { SelectedData }, varDataArray);
                    }
                }
                else
                {
                    Results.PublishTable(SelectedData, new List<String> { SelectedData }, varData as Array);
                }
            }
            else
            {
                Log.Error("Please set the FullName of data.");
                UpgradeVerdict(Verdict.Error);
            }
        }
    }

    [Display("SVCustomStep", Groups: new[] { "SystemVue", "Test Case" }, Description: "Custom Test Step")]
    [AllowAnyChild]
    public class SVCustomStep : SVcontrol
    {
        public SVCustomStep()
        {
           
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
