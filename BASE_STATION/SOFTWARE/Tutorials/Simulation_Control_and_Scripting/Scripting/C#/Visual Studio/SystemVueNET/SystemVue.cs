using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using Microsoft.Win32;

namespace SystemVueExample
{
    public class SystemVue
    {

        // Instance of SystemVue application
        public GENESYS.Application m_app;

        // Constructor, called when a instance of this class is created
        public SystemVue()
        {
            try
            {
                // Start a new instance of SystemVue
                m_app = new GENESYS.Application();
            }
            catch
            {
                // If we have a exception, the COM server is probably not registered.  
                // Register it by running SystemVue.exe /regserver
                m_app = null;
            }

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
        ~SystemVue()
        {
            Exit();
        }

        public void Exit()
        {
            if (m_app == null)
                return;

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
            m_app.Quit();
            m_app = null;
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

        // Open a workspace, given the path
        public bool OpenWorkspace(string sPath)
        {
            string sCommand;

            sCommand = "OpenWorkspace(\"";
            sCommand += sPath.Replace('/', '\\'); // SystemVue 2011.10 and earlier must have backslashes
            sCommand += "\")";
            if (!Environment.Is64BitProcess)
                sCommand += "\n" + SetEqnWorkingDir();

            return RunScript(sCommand);

        }

        public bool OpenExampleWorkspace(string sPath)
        {
            string sCommand;

            sCommand = "FileOpenExample(\"";
            sCommand += sPath.Replace('/', '\\'); // SystemVue 2011.10 and earlier must have backslashes
            sCommand += "\")";
            if (!Environment.Is64BitProcess)
                sCommand += "\n" + SetEqnWorkingDir();

            return RunScript(sCommand);

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

        // Get data from dataset, assuming double
        public double GetData(string sDataName)
        {
            return GetData<double>(sDataName);
        }

        // Get data from dataset of data type T.
        // Example 1 Scalar: double values = GetData<double>("Path_to_DataName")
        // Example 2 Vector: double[] values = GetData<double[]>("Path_to_DataName")
        // Example 3 2D Array: double[,] values = GetData<double[,]>("Path_to_DataName")
        public T GetData<T>(string sDataName)
        {
            GENESYS.IItem item = GetItem(sDataName);

            T data = default(T);

            if (item != null)
            {
                for (int i = 0; i < item.GetVarCount(); i++)
                {
                    string itemName = item.GetVarName(i);
                    if (itemName == "Data")
                    {
                        data = (T)(((GENESYS.IItem)item).GetVarValue(i));
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
    }
}