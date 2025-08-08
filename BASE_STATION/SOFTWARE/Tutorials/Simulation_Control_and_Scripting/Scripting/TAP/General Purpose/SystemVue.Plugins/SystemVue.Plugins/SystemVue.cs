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
using System.IO;
using Microsoft.Win32;
using System.ComponentModel;
using Keysight.Tap;

namespace SystemVue.Plugins
{
    [Display("InterfaceSystemVue", Group: "SystemVue", Description: "Interface of SystemVue COM API.")]
    public class ISystemVue:Dut
    {
        #region Units Map
        static Dictionary<Int32, String> s_unitsDict = new Dictionary<Int32, String> {
            [33771] = "MHz",
            [1001] = "Hz",
            [1002] = "KHz",
            [1003] = "MHz",
            [1004] = "GHz",
            [1005] = "THz",
            [34769] = "Ohm",
            [2001] = "Ohm",
            [2002] = "KOhm",
            [2003] = "MOhm",
            [35769] = "S",
            [3001] = "S",
            [3002] = "mS",
            [3003] = "uS",
            [3004] = "pS",
            [36769] = "nH",
            [4001] = "nH",
            [4002] = "mH",
            [4003] = "H",
            [4004] = "uH",
            [4005] = "pH",
            [37769] = "pF",
            [5001] = "pF",
            [5002] = "uF",
            [5003] = "mF",
            [5004] = "nF",
            [5005] = "fF",
            [5006] = "F",
            [38769] = "mm",
            [6001] = "mm",
            [6002] = "mil",
            [6003] = "in",
            [6004] = "m",
            [6005] = "cm",
            [6006] = "um",
            [39769] = "ns",
            [7001] = "ns",
            [7002] = "us",
            [7003] = "ms",
            [7004] = "s",
            [7005] = "ps",
            [40769] = "Deg",
            [8001] = "Deg",
            [8002] = "Rad",
            [41769] = "V",
            [9001] = "V",
            [9002] = "KV",
            [9003] = "mV",
            [9004] = "uV",
            [9005] = "nV",
            [9006] = "pV",
            [9007] = "dBV",
            [9008] = "dBmV",
            [9009] = "dBuV",
            [42769] = "A",
            [10001] = "A",
            [10002] = "mA",
            [10003] = "uA",
            [10004] = "nA",
            [10005] = "pA",
            [43770] = "dBm",
            [11001] = "W",
            [11002] = "dBm",
            [11003] = "uW",
            [11004] = "mW",
            [11005] = "KW",
            [11006] = "MW",
            [11007] = "dBW",
            [44769] = "C",
            [12001] = "C",
            [12002] = "F",
            [12003] = "K",
            [45770] = "dB",
            [13001] = "dB10",
            [13002] = "dB",
            [13003] = "Abs",
            [13005] = "%",
            [46769] = "Point",
            [14001] = "Point",
            [14002] = "Pica",
            [14003] = "Mil",
            [14004] = "In",
            [14005] = "Mm",
            [14006] = "Cm",
            [47769] = "dB",
            [15001] = "dB",
            [15002] = "dB20",
            [15003] = "Abs"
        };
        #endregion

        // Instance of SystemVue application
        GENESYS.Application m_app;

        public ISystemVue() { }

        public bool StartSystemVue()
        {
            Boolean bSuccessed = false;

            if (m_app != null)
                return true;

            try
            {
                // Start a new instance of SystemVue
                m_app = new GENESYS.Application();
                bSuccessed = true;
            }
            catch
            {
                // If we have a exception, the COM server is probably not registered.  
                // Register it by running SystemVue.exe /regserver
                m_app = null;
            }
            return bSuccessed;
        }


        
        // Member boolean to track visibility
        bool m_bVisible = false;

        // Method to set/get Visible property of SystemVue - by default SystemVue will start hidden under COM control
        public bool Visible
        {
            get { return m_bVisible; }
            set
            {
                m_bVisible = value; 
                if (m_app != null)
                {
                    m_app.Application.Visible = m_bVisible;
                }
            }
        }

        // Some external environments need a separate method to set visibility
        public void SetVisible(bool bVisible)
        {
            Visible = bVisible;
        }


        // Destructor
        ~ISystemVue()
        {
            ExitSystemVue();
        }

        public bool ExitSystemVue()
        {
            // Close and save all workspaces
            try
            {
                for (int i = 0; i < m_app.Manager.GetWorkspaceCount(); i++)
                {
                    GENESYS.Workspace workspace = m_app.Manager.GetWorkspaceByIndex(i);
                    // COM interface does not support quitting without saving, so save to temp file, and then delete it
                    string file = Path.GetTempFileName();
                    workspace.SaveAs(file);
                    File.Delete(file);
                }
            }
            catch
            {
            }

            // Quit the application
            if (m_app != null)
                m_app.Quit();
            m_app = null;
            return true;
        }

        // Run a VB script command
        public bool RunScript(string csScript)
        {
            bool bStatus = true;

            try
            {
                // Run a script, assuming Visual Basic
                m_app.Application.RunScript(csScript, GENESYS.ScriptLanguage.genLangVBScript);
            }
            catch
            {
                bStatus = false;
            }

            return bStatus;
        }

        public String GetErrors()
        {
            return m_app.Manager.GetErrors();
        }

        // Open a workspace, given the path
        public bool OpenWorkspace(string sPath)
        {
            Boolean bSuccessed = false;
            string sCommand;

            sCommand = "OpenWorkspace(\"";
            sCommand += sPath.Replace('/', '\\'); // SystemVue 2011.10 and earlier must have backslashes
            sCommand += "\")";
            if (!Environment.Is64BitProcess)
                sCommand += "\n" + SetEqnWorkingDir();

            bSuccessed = RunScript(sCommand);
            return bSuccessed;
        }

        public bool OpenExampleWorkspace(string sPath)
        {
            Boolean bSuccessed = false;
            string sCommand;

            sCommand = "FileOpenExample(\"";
            sCommand += sPath.Replace('/', '\\'); // SystemVue 2011.10 and earlier must have backslashes
            sCommand += "\")";
            if (!Environment.Is64BitProcess)
                sCommand += "\n" + SetEqnWorkingDir();


            bSuccessed = RunScript(sCommand);
            return bSuccessed;
        }

        public void CloseWorkspace()
        {
            try
            {
                for (int i = 0; i < m_app.Manager.GetWorkspaceCount(); i++)
                {
                    GENESYS.Workspace workspace = m_app.Manager.GetWorkspaceByIndex(i);
                    // COM interface does not support quitting without saving, so save to temp file, and then delete it
                    string file = Path.GetTempFileName();
                    workspace.SaveAs(file);
                    File.Delete(file);
                }
            }
            catch
            {
            }

            RunScript("Application.Menu.File.CloseWorkspace.Execute()");
        }

        public void StopSimulation()
        {
            try
            {
                GENESYS.IItem managerItem = (GENESYS.IItem)m_app.Manager;
                Int32 itemCount = managerItem.GetItemCount();
                for (int i = 0; i < itemCount; i++)
                {
                    GENESYS.IItem workspaceItem = managerItem.GetItemByIndex(i);
                    RunScript(String.Format("{0}.StopSimulation()", workspaceItem.GetName()));
                }
            }
            catch
            {
            }
        }

        private string SetEqnWorkingDir()
        {
            string sCommand;
            sCommand = "wsdoc=Application.Manager.GetWorkspaceByIndex(0)\n";
            sCommand += "path = GetExeDir()\n";
            sCommand += "wsdoc.SetEqnWorkingDir(path)\n";

            return sCommand;
        }

        private void SetAutoCalcOff(string sParamPath)
        {
            // See if this is a varblock and turn off automation
            try
            {
                int iIndex = sParamPath.IndexOf(".VarBlock"); // if not found, exception thrown and caught below
                string sVarBlockPath = sParamPath.Remove(iIndex);
                GENESYS.IItem equationBlock = GetItem(sVarBlockPath);
                RunScript("autocalc=false\r\n" + sVarBlockPath + ".SetProperty \"AutoCalc\", autocalc");
            }
            catch
            {
                // If not found, igore as it is not equation block
            }
        }

        // Set a scalar double parameter
        public bool SetStringParameter(string sParamPath, string sParamValue)
        {
            bool bSuccess = true;

            SetAutoCalcOff(sParamPath);

            bSuccess = RunScript(sParamPath + ".Set( \"'" + sParamValue + "\" )");

            return bSuccess;
        }

        // Set a scalar double parameter
        public bool SetParameter(string sParamPath, double sParamValue)
        {
            bool bSuccess = true;

            SetAutoCalcOff(sParamPath);

            bSuccess = RunScript(sParamPath + ".Set( " + sParamValue + " )");

            return bSuccess;
        }

        public bool SetEntry(string sParamPath, String sParamEntry)
        {
            bool bSuccess = true;

            SetAutoCalcOff(sParamPath);

            bSuccess = RunScript(sParamPath + ".Set( \"" + sParamEntry + "\" )");

            return bSuccess;
        }

        public List<SVParameter> GetDesignParameterList(String designPath)
        {
            List<SVParameter> svParameters = new List<SVParameter>();
            GENESYS.IItem design = GetItem(designPath);
            try
            {
                GENESYS.IItem parameters = design.GetItemByName("Parameters");
                GENESYS.IItem paramSet = parameters.GetItemByName("ParamSet");
                Int32 itemCount = paramSet.GetItemCount();
                for (Int32 i = 0; i < itemCount; i++)
                {
                    GENESYS.IItem param = paramSet.GetItemByIndex(i);

                    SVParameter svParam = new SVParameter();
                    svParam.Name = param.GetName();
                    svParam.Path = designPath + ".Parameters.ParamSet." + svParam.Name;
                    svParam.Unit = "None";

                    for (Int32 j = 0; j < param.GetVarCount(); j++)
                    {
                        String varName = param.GetVarName(j);
                        switch (varName)
                        {
                            case "Description":
                                svParam.Description = param.GetVarValue(j);
                                break;

                            case "Data":
                                svParam.Value = param.GetVarValue(j);
                                break;

                            case "Unit":
                                {
                                    Int32 iUnit = param.GetVarValue(j);
                                    if (s_unitsDict.ContainsKey(iUnit))
                                    {
                                        svParam.Unit = s_unitsDict[iUnit];
                                    }
                                }
                                break;

                            case "DataEntry":
                                svParam.Entry = param.GetVarValue(j);
                                break;
                        }
                    }

                    svParameters.Add(svParam);
                }
            }
            catch
            {

            }

            return svParameters;
        }

        public List<String> GetDataSetVariableList(String datasetPath)
        {
            List<String> variables = new List<String>();
            GENESYS.IItem dataSet = GetItem(datasetPath);
            try
            {
                GENESYS.IItem equation = dataSet.GetItemByName("Eqns");
                GENESYS.IItem varBlock = equation.GetItemByName("VarBlock");
                Int32 itemCount = varBlock.GetItemCount();
                for (Int32 i = 0; i < itemCount; i++)
                {
                    GENESYS.IItem var = varBlock.GetItemByIndex(i);
                    variables.Add(var.GetName());
                }
            }
            catch
            {

            }

            return variables;
        }

        public void TraverseWorkspace(out Dictionary<String, String> analysisList, out Dictionary<String, String> designList, out Dictionary<String, String> datasetList)
        {
            analysisList = new Dictionary<String, String>();
            designList = new Dictionary<String, String>();
            datasetList = new Dictionary<String, String>();
            if (m_app != null)
            {
                GENESYS.IItem me = (GENESYS.IItem)m_app.Manager;
                String path = String.Empty;
                traverseWorkspacefromItem(me, path, ref analysisList, ref designList, ref datasetList);
            }
        }

        private void traverseWorkspacefromItem(GENESYS.IItem rootItem, String path, ref Dictionary<String, String> analysisList, ref Dictionary<String, String> designList, ref Dictionary<String, String> datasetList)
        {
            Int32 itemCount = rootItem.GetItemCount();
            for (Int32 i = 0; i < itemCount; i++)
            {
                GENESYS.IItem childItem = rootItem.GetItemByIndex(i);
                String childPath = String.IsNullOrEmpty(path) ? childItem.GetName() : path + "." + childItem.GetName();
                if (isFolderItem(childItem))
                {
                    traverseWorkspacefromItem(childItem, childPath, ref analysisList, ref designList, ref datasetList);
                }
                else if (isAnalysisItem(childItem))
                {
                    analysisList.Add(childItem.GetName(), childPath);
                }
                else if(isDesignItem(childItem))
                {
                    designList.Add(childItem.GetName(), childPath);
                }
                else if (isDataSetItem(childItem))
                {
                    datasetList.Add(childItem.GetName(), childPath);
                } 
            }
        }

        public GENESYS.IItem FindItemByName(String name, out String path)
        {
            GENESYS.IItem item = null;
            path = String.Empty;
            if (m_app != null)
            {
                GENESYS.IItem me = (GENESYS.IItem)m_app.Manager;
                item = FindItemByName(me, String.Empty, name, ref path);
            }

            return item;
        }

        private GENESYS.IItem FindItemByName(GENESYS.IItem rootItem, String currentPath, String name, ref String path)
        {
            GENESYS.IItem item = null;

            Int32 itemCount = rootItem.GetItemCount();
            for (Int32 i = 0; i < itemCount; i++)
            {
                GENESYS.IItem childItem = rootItem.GetItemByIndex(i);
                if (isFolderItem(childItem))
                {
                    item = FindItemByName(childItem, String.IsNullOrEmpty(currentPath) ? childItem.GetName() : currentPath + "." + childItem.GetName(), name, ref path);
                }
                else if (childItem.GetName() == name)
                {
                    item = childItem;
                    path = String.IsNullOrEmpty(currentPath) ? childItem.GetName() : currentPath + "." + childItem.GetName();
                    break;
                }

            }

            return item;
        }

        private Boolean isAnalysisItem(GENESYS.IItem item)
        {
            Boolean isAnalysis = false;
            try
            {
                if (item.GetItemByName("DesignName") != null)
                    isAnalysis = true;
            }
            catch
            {
                isAnalysis = false;
            }

            return isAnalysis;
        }

        private Boolean isDesignItem(GENESYS.IItem item)
        {
            Boolean isDesign = false;
            try
            {
                if (item.GetItemByName("PartList") != null)
                    isDesign = true;
            }
            catch
            {
                isDesign = false;
            }

            return isDesign;
        }

        private Boolean isDataSetItem(GENESYS.IItem item)
        {
            Boolean isDataSet = false;
            try
            {
                if (item.GetItemByName("Eqns") != null)
                    isDataSet = true;
            }
            catch
            {
                isDataSet = false;
            }

            return isDataSet;
        }

        private Boolean isFolderItem(GENESYS.IItem item)
        {
            Boolean isFolder = false;
            for(Int32 i = 0; i < item.GetVarCount(); i++)
            {
                if(item.GetVarName(i) == "IsOpen")
                {
                    isFolder = true;
                    break;
                }
            }

            return isFolder;
        }

        public Object GetData(String sDataName)
        {
            GENESYS.IItem item = GetItem(sDataName);

            Object data = null;

            if (item != null)
            {
                for (int i = 0; i < item.GetVarCount(); i++)
                {
                    string itemName = item.GetVarName(i);
                    if (itemName == "Data")
                    {
                        data = item.GetVarValue(i);
                        break;
                    }
                }
            }

            return data;
        }

        // Get data from dataset, assuming double
        public double GetDoubleData(string sDataName)
        {
            GENESYS.IItem item = GetItem(sDataName);  

            double data = 0.0;

            if (item != null)
            {
                for (int i = 0; i < item.GetVarCount(); i++)
                {
                    string itemName = item.GetVarName(i);
                    if (itemName == "Data")
                    {
                        data = (double)(((GENESYS.IItem)item).GetVarValue(i));
                        break;
                    }
                }
            }

            return data;
        }

        // Find a item in a Genesys item
        public GENESYS.IItem GetItem(string sItemName)
        {
            GENESYS.IItem me = null;
            if (m_app != null)
            {
                me = (GENESYS.IItem)m_app.Manager;
                me = GetItem(me, sItemName);
            }
            return me;
        }

        // Find a item, given a path
        static GENESYS.IItem GetItem(GENESYS.IItem parent, string sItemName)
        {
            GENESYS.IItem item = parent;

            string[] path = sItemName.Split('.');
            try
            {
                foreach (string itemName in path)
                {
                    if (item != null)
                        item = item.GetItemByName(itemName); 
                }
            }
            catch
            {
                item = null;
            }
            return item;
        }

        public static String AddSquareBracketsToPath(String path)
        {
            String newPath = String.Empty;
            String[] elements = path.Split('.');
            for (int i = 0; i < elements.Length; i++)
            {
                newPath = newPath + "." + (elements[i].Contains(" ") ? "[" + elements[i] + "]" : elements[i]);
            }

            newPath = newPath.TrimStart('.');

            return newPath;
        }

    }

    public class SVParameter
    {
        public String Name { get; set; }
        public String Path { get; set; }
        public String Description { get; set; }
        public Object Value { get; set; }
        public String Unit { get; set; }
        public String Entry { get; set; }
    }

    public abstract class SVcontrol : TestStep
    {
        #region Settings
            [Display(Group: "SystemVue", Name: "InterfaceSystemVue", Collapsed:true)]
        #endregion

        public ISystemVue svCntl { get; set; }
        public SVcontrol() {}

        public virtual void OnParameteriesChanged() {}
    }
    
}