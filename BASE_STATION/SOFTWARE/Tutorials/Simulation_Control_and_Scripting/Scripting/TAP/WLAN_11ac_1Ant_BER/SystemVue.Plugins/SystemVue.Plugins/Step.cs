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
            FilePath = String.Empty;
        }

        public override void Run()
        {
            String workspacePath = System.IO.Path.GetFullPath(FilePath);
            svCntl.OpenWorkspace(workspacePath);
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
            FilePath = String.Empty;
        }

        public override void Run()
        {
            svCntl.OpenExampleWorkspace(FilePath);
        }
    }

    [Display("SVRunAnalysis", Groups: new[] { "SystemVue", "Run Analysis" }, Description: "Run SystemVue Analysis")]
    public class SVRunAnalysis : SVcontrol
    {
        #region Settings
        [Display("AnalysisFullName", Group: "Parameters")]
        [Browsable(true)]
        public string FullName { get; set; }
        #endregion

        public SVRunAnalysis()
        {
            // ToDo: Set default values for properties / settings.
            FullName = String.Empty;
        }

        public override void Run()
        {
            // Run a simple VB command in SystemVue to run the appropriate analysis
            if (!String.IsNullOrEmpty(FullName))
            {
                String script = String.Format("{0}.RunAnalysis()", FullName);
                svCntl.RunScript(script);
                UpgradeVerdict(Verdict.Pass);
            }
            else
            {
                Log.Error("Please set Analysis Name.");
                UpgradeVerdict(Verdict.Error);
            }
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
            svCntl.SetParameter("WLAN_11ac_1Ant.Designs.WLAN_11ac_1Ant_SRC.Parameters.ParamSet.[EbN0]", EbN0);
        }
    }

    [Display("GetData", Groups: new[] { "SystemVue", "Step" }, Description: "GetData")]
    public class GetData : SVcontrol
    {
        #region Settings
        [Display(Group: "Parameter", Name: "DataFullName", Description: "Full name of data")]
        public String FullName { get; set; }
        #endregion

        public GetData()
        {
            FullName = String.Empty;
        }

        public override void Run()
        {
            if(!String.IsNullOrEmpty(FullName))
            {
                Double answer = svCntl.GetData(FullName);
                String result = "The BER is: " + answer;
                Log.Info(result);
                UpgradeVerdict(Verdict.Pass);
            }
            else
            {
                Log.Error("Please set the FullName of data.");
                UpgradeVerdict(Verdict.Error);
            }
        }
    }

    [Display("BER Test", Groups: new[] { "SystemVue", "TestCase" }, Description: "BER Test")]
    [AllowAnyChild]
    public class TestBER : SVcontrol
    {
        public TestBER()
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
