using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Windows.Forms;

namespace Excel_to_RF_Sys
{
    enum Result { NoError, Error, FileNotFound, Err_Template, PartLimitExceeded, NotEnoughData }    

    public class ExcelData
    {
        public double[] m_gainArray, m_NFArray, m_P1dBArray, m_PSatArray, m_IP3Array, m_IP2Array;
        public string[] m_stageNameArray;
        public bool useGain, useNF, useP1dB, usePSat, useIP3, useIP2, useStageName;

        public const int s_maxStages = 100, s_defaultStages = 30;

        public ExcelData()
        {
            //reset arrays
            m_gainArray = new double[s_maxStages];
            m_NFArray = new double[s_maxStages];
            m_P1dBArray = new double[s_maxStages];
            m_PSatArray = new double[s_maxStages];
            m_IP3Array = new double[s_maxStages];
            m_IP2Array = new double[s_maxStages];
            m_stageNameArray = new string[s_maxStages];

            useGain = false;
            useNF = false;
            useP1dB = false;
            usePSat = false;
            useIP3 = false;
            useIP2 = false;
            useStageName = false;
        }
    }

    public class ExcelDataMigrator
    {
        SystemVueExample.SystemVue m_appInterface;
        const double s_tolerance = 0.001;
        ExcelData m_data;
        bool m_useInputRef;
        Result m_errCode;

        private bool Success(Result errCode) { return errCode == Result.NoError; }

        public bool HasError() { return m_errCode != Result.NoError; }

        public String GetError() 
        {
            String errorMsg = "";

            if (m_errCode == Result.Error)
                errorMsg = "Error has occured.";
            else if (m_errCode == Result.FileNotFound)
                errorMsg = "No workspace was loaded.";
            else if (m_errCode == Result.Err_Template)
                errorMsg = "Schematic 'Sch1' not found in 'Designs' folder. Use Spreadsheet_Template workspace from Spectrasys/Scripting examples folder.";
            else if (m_errCode == Result.PartLimitExceeded)
                errorMsg = "Number of parts from spreadsheet exceeds number of parts in template.";
            else if (m_errCode == Result.NotEnoughData)
                errorMsg = "Insufficent data to create parts.";
            else
                errorMsg = "";

            return errorMsg; 
        }

        public ExcelDataMigrator(ExcelData data, bool useInputRef)
        {
            m_data = data;
            m_useInputRef = useInputRef;
            m_errCode = Result.NoError;
        }

        //This takes the data from the excel spreadsheet and starts to move them into spectrasys
        public void MigrateData(string templatePath)
        {
            bool bResult = true;
            m_errCode = Result.NoError;

            if (m_appInterface == null)
                m_appInterface = new SystemVueExample.SystemVue();

            m_appInterface.OpenWorkspace(templatePath);
            m_appInterface.Visible = true;

            string workspaceName = getWorkspaceName(templatePath);

            GENESYS.IItem item = m_appInterface.GetItem(workspaceName + ".Designs.Sch1.PartList");
            int partsCount = 0;

            if (item != null)
                partsCount = item.GetItemCount(); //The actual count is partsCount minus 3 because of the input/output and partslib
            else             
                m_errCode = Result.Err_Template;

            if (Success(m_errCode) && m_data.m_gainArray.Count() > (partsCount - 3))
                m_errCode = Result.PartLimitExceeded;

            for (int i = 0; i < ExcelData.s_maxStages && Success(m_errCode); i++)
            {
                if (i < m_data.m_gainArray.Length)
                {
                    if (m_useInputRef)
                        inputReferencedMath(i);

                    GenerateUnknownParams(i);

                    if (gainNFCalculate(i)) //It is an attenuator
                    {
                        string partString = workspaceName + ".Designs.Sch1.PartList.Part_" + (i + 1) + ".ParamSet.L";
                        bResult = m_appInterface.SetParameter(partString, Math.Abs(m_data.m_gainArray[i]));
                        System.Diagnostics.Debug.Assert(bResult);
                    }
                    else //If it is an amplifier
                    {
                        if (m_data.useP1dB || m_data.usePSat || m_data.useIP3 || m_data.useIP2)
                        {
                            //changes the attenuator to an amplifier
                            string attChange = workspaceName + ".Designs.Sch1.PartList.Part_" + (i + 1) + ".ChangeModel \"RFAMP@Models\"";
                            //changes the symbol to correct amplifier
                            string symChange = workspaceName + ".Designs.Sch1.PartList.Part_" + (i + 1) + ".ChangeSymbol \"AMPL@Symbols\"";
                            m_appInterface.RunScript(symChange + "\r\n" + attChange);
                            string partString = workspaceName + ".Designs.Sch1.PartList.Part_" + (i + 1) + ".ParamSet.";

                            //Add stuff 
                            SetAmpParameter(partString, i);

                        }
                        else
                            m_errCode = Result.NotEnoughData;
                            //"Amplifier defected but no parameters found";
                    }
                    if (m_data.useStageName) //If the Stage Names is checked
                    {
                        bResult = SetName(workspaceName, "Part_" + (i + 1), i + 1, "\"" + m_data.m_stageNameArray[i] + "\"");
                        System.Diagnostics.Debug.Assert(bResult);
                    }
                }
                else if (m_data.m_gainArray.Length <= i)
                {
                    bResult = SetShort(workspaceName + ".Designs.Sch1.PartList.Part_" + (i + 1));
                    System.Diagnostics.Debug.Assert(bResult);
                }
            }

            if (bResult)
            {
                GENESYS.IItem ThisDesign = m_appInterface.GetItem(workspaceName + "Designs.Sch1");
                bResult = m_appInterface.RunScript(workspaceName + ".Designs.Sch1.CloseWindow");
                System.Diagnostics.Debug.Assert(bResult);
                bResult = m_appInterface.RunScript(workspaceName + ".Designs.Sch1.OpenWindow");
                System.Diagnostics.Debug.Assert(bResult);
                bResult = m_appInterface.RunScript(workspaceName + ".Designs.System1_Data_Folder.[Cascaded Equ Table].CloseWindow");
                System.Diagnostics.Debug.Assert(bResult);
                bResult = m_appInterface.RunScript(workspaceName + ".Designs.System1_Data_Folder.[Cascaded Equ Table].OpenWindow");
                System.Diagnostics.Debug.Assert(bResult);
                bResult = m_appInterface.RunScript(workspaceName + ".Notes.CloseWindow");
                System.Diagnostics.Debug.Assert(bResult);
                bResult = m_appInterface.RunScript(workspaceName + ".Notes.OpenWindow");
                System.Diagnostics.Debug.Assert(bResult);
                bResult = m_appInterface.RunScript(workspaceName + "Application.Menu.Edit.Select.All.Execute()");
                System.Diagnostics.Debug.Assert(bResult);
                bResult = m_appInterface.RunScript(workspaceName + "Application.Menu.Edit.Select.None.Execute()");
                System.Diagnostics.Debug.Assert(bResult);
            }
        }

        private void GenerateUnknownParams(int index)
        {
            if (m_data.useP1dB)
            {
                if (!m_data.usePSat)
                    m_data.m_PSatArray[index] = m_data.m_P1dBArray[index] + 3;
                if (!m_data.useIP3)
                    m_data.m_IP3Array[index] = m_data.m_P1dBArray[index] + 10;
                if (!m_data.useIP2)
                    m_data.m_IP2Array[index] = m_data.m_P1dBArray[index] + 20;
            }
            else if (m_data.usePSat)
            {
                m_data.m_P1dBArray[index] = m_data.m_PSatArray[index] - 3;
                if (!m_data.useIP3)
                    m_data.m_IP3Array[index] = m_data.m_PSatArray[index] + 7;
                if (!m_data.useIP2)
                    m_data.m_IP2Array[index] = m_data.m_PSatArray[index] + 17;
            }
            else if (m_data.useIP3)
            {
                m_data.m_PSatArray[index] = m_data.m_IP3Array[index] - 7;
                m_data.m_P1dBArray[index] = m_data.m_IP3Array[index] - 10;
                if (!m_data.useIP2)
                    m_data.m_IP2Array[index] = m_data.m_IP3Array[index] + 20;
            }
            else
            {
                m_data.m_IP3Array[index] = m_data.m_IP2Array[index] - 10;
                m_data.m_PSatArray[index] = m_data.m_IP2Array[index] - 17;
                m_data.m_P1dBArray[index] = m_data.m_IP2Array[index] - 20;
            }
        }

        //Sets the parameter for any amplifiers
        private void SetAmpParameter(string path, int index)
        {
            bool bResult;
            bResult = m_appInterface.SetParameter(path + "G", m_data.m_gainArray[index]);
            System.Diagnostics.Debug.Assert(bResult);
            bResult = m_appInterface.SetParameter(path + "NF", m_data.m_NFArray[index]);
            System.Diagnostics.Debug.Assert(bResult);
            bResult = m_appInterface.SetParameter(path + "OIP2", m_data.m_IP2Array[index]);
            System.Diagnostics.Debug.Assert(bResult);
            bResult = m_appInterface.SetParameter(path + "OIP3", m_data.m_IP3Array[index]);
            System.Diagnostics.Debug.Assert(bResult);
            bResult = m_appInterface.SetParameter(path + "OPSAT", m_data.m_PSatArray[index]);
            System.Diagnostics.Debug.Assert(bResult);
            bResult = m_appInterface.SetParameter(path + "OP1dB", m_data.m_P1dBArray[index]);
            System.Diagnostics.Debug.Assert(bResult);
        }

        //This is the logic checker for Gain and NF to check if it an attenuator or amplifer
        public bool gainNFCalculate(int i)
        {
            bool gainNFBool = true;
            if (m_data.useNF)
            {
                if (m_data.m_gainArray[i] <= 0 && (Math.Abs(m_data.m_gainArray[i] + m_data.m_NFArray[i]) <= s_tolerance) && m_data.m_P1dBArray[i] >= 60)
                    gainNFBool = true;
                else
                    gainNFBool = false;
            }
            else
            {
                if (m_data.m_gainArray[i] <= 0 && m_data.m_P1dBArray[i] >= 60)
                    gainNFBool = true;
                else
                    gainNFBool = false;
            }

            return gainNFBool;
        }

        //Function for input referenced spreadsheet data
        public void inputReferencedMath(int index)
        {
            m_data.m_IP2Array[index] = m_data.m_IP2Array[index] + m_data.m_gainArray[index];
            m_data.m_IP3Array[index] = m_data.m_IP3Array[index] + m_data.m_gainArray[index];
            m_data.m_P1dBArray[index] = m_data.m_P1dBArray[index] + m_data.m_gainArray[index] - 1;
            double gainTotal = 0;
            for (int i = 0; i < index; i++)
                gainTotal += m_data.m_gainArray[i];
            m_data.m_PSatArray[index] = m_data.m_PSatArray[index] + (m_data.m_gainArray[index] - Math.Abs(gainTotal));
        }

        //Gets the workspacename for COM path purposes
        public string getWorkspaceName(string path)
        {
            char[] delimiters = { '/', ':', '\\', '.' };
            string[] words = path.Split(delimiters);
            return words[(words.Length - 2)];
        }

        //Finds name based on its property
        public string FindItemNameFromProperty(GENESYS.IItem item, string variable, string value)
        {
            string path = "";
            if (item != null)
            {
                int itemcount = item.GetItemCount();

                for (int i = 0; i < itemcount; i++)
                {
                    GENESYS.IItem part = item.GetItemByIndex(i);
                    int varcount = part.GetVarCount();
                    for (int j = 0; j < varcount; j++)
                    {
                        string name = part.GetVarName(j);
                        if (name.Equals(variable))
                        {
                            string varValue = part.GetVarValue(j);

                            if (varValue.Equals(value))
                                path = part.GetName();
                        }
                    }
                }
            }

            return path;
        }

        // Setting all the unused Parts as short
        public bool SetShort(string path)
        {
            return m_appInterface.RunScript("val=" + 2 + "\r\n" + path + ".SetProperty \"SimOverride\" , val");
        }

        public bool SetName(string path, string value, int index, string name)
        {
            string path2;
            path2 = FindPartPathByDesignator(path + ".Designs.Sch1.Schematic.Page", value);
            return m_appInterface.RunScript("var=" + name + "\r\n" + path2 + ".SetProperty \"Designator\" , var" + "\r\n" + path + ".Designs.Sch1.PartList.Part_" + index + ".SetName" + " var"); ;
        }

        //Finds the Part path based on its current designator name
        public string FindPartPathByDesignator(string path, string value)
        {
            GENESYS.IItem item = m_appInterface.GetItem(path);

            path += "." + FindItemNameFromProperty(item, "Designator", value);

            return path;
        }
    }
}
