using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Windows.Forms;
using Microsoft.Office.Interop.Excel;
using System.IO;
using Microsoft.Win32;
using System.Reflection;
using Excel_to_RF_Sys;

enum Organized { Rows, Columns };
namespace Excel_Form
{
    public partial class ExceltoSpectrasys : Form
    {        
        string m_startIndex, m_stopIndex, m_stageNameIndex, m_GainRef, m_NFRef, m_P1dBRef, m_PSatRef, m_IP3Ref, m_IP2Ref;              

        Organized m_RowCol = Organized.Columns;
        Microsoft.Office.Interop.Excel.Application appExcel = new Microsoft.Office.Interop.Excel.Application();
        Workbook newWorkbook = null;
        _Worksheet objsheet = null;
       
        ExcelSheetReader m_reader;
        ExcelDataMigrator m_migrator;
        ExcelData m_data;
        Thread thread;
        String m_templatePath;

        public ExceltoSpectrasys()
        {
            InitializeComponent();
            richTextBox1.Text += "Welcome to Import Excel RF System Chain." + System.Environment.NewLine + "1. Input the Excel cell references in the text boxes" + System.Environment.NewLine + "2.Click on the 'Read Excel Data' button and check the textbox for correct numbers." + System.Environment.NewLine + "3. Click the 'Select and Run Workspace' button. Browse to the “Spreadsheet_Template.*” file. The simulator will open. Then run the analysis.	" + System.Environment.NewLine + "Note: Allows for up to a max of 30 Stages. To increase number of stages refer to section Updating the Spreadsheet_Template.* file";
        }
        //Opens up the help.rtf file (Which can be editted)
        private void helpButton_Click(object sender, EventArgs e)
        {
            Assembly asm = Assembly.GetExecutingAssembly();
            Stream stream = asm.GetManifestResourceStream("Excel_to_RF_Sys.help.rtf");
            richTextBox1.LoadFile(stream, RichTextBoxStreamType.RichText);
        }

        //This opens up the Excel file to read data into C# arrays and prints out the cell data onto the rich text box
        private void ReadDataButton_Click_1(object sender, EventArgs e)
        {
            bool success = true;

            WriteDataButton.Enabled = false;

            if (ValidateCheckHasEntry())
            {
                OpenFileDialog openFile = new OpenFileDialog();
                openFile.Filter = "Excel Files (*.xls, *xlsx, *.xl, *.xlsm, *.xlsb, *.xlam, *.xltx, *.xltm, .*xlt, *.xlm, *.xlw,*.xlsm)| *.xls; *xlsx; *.xl; *.xlsm; *.xlsb; *.xlam; *.xltx; *.xltm; .*xlt; *.xlm; *.xlw;*.xlsm";
                openFile.FilterIndex = 1;
                var Openread = openFile.ShowDialog();
                if (Openread == System.Windows.Forms.DialogResult.OK)
                {
                    string strfilename = openFile.FileName;
                    richTextBox1.Text = "File address obtained.";

                    //This is to see if the excel exists
                    if (System.IO.File.Exists(strfilename))
                    {
                        // then go and load this into excel
                        newWorkbook = appExcel.Workbooks.Open(strfilename, true, true);
                        objsheet = (_Worksheet)appExcel.ActiveWorkbook.ActiveSheet;
                        m_reader = new ExcelSheetReader(objsheet);
                    }
                    else
                    {
                        System.Windows.Forms.MessageBox.Show("Unable to open file!");
                        System.Runtime.InteropServices.Marshal.ReleaseComObject(appExcel);
                        success = false;
                        appExcel = null;
                    }

                    m_data = new ExcelData(); 
                    success = ReadExcelInfo();

                    if (success && m_data.m_gainArray.Length > ExcelData.s_defaultStages)
                        MessageBox.Show("Excel data exceeds " + ExcelData.s_defaultStages + ". When choosing a workspace to write to, please choose one that will accomodate your Excel data range.", "Data size out of range", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
                    
                    //This is where the excel file is closed
                    objsheet.Application.ActiveWorkbook.Close(false);
                    appExcel.Quit();
                    if (success)
                        WriteDataButton.Enabled = true;

                }
                else if (Openread != System.Windows.Forms.DialogResult.OK)
                {
                    richTextBox1.Text = "No File given";
                }
            }   
        }

        //This button opens up Spectrasys to write data into the parts
        private void WriteDataButton_Click(object sender, EventArgs e)
        {
            bool openWorkspace = true;
            OpenFileDialog openFile = new OpenFileDialog();
            openFile.Filter = "Genesys and SystemVue Files (*.wsg,*.wsv)|*.wsg;*.wsv";
            openFile.FilterIndex = 1;                      
            var Openwrite = openFile.ShowDialog();
            if (Openwrite == System.Windows.Forms.DialogResult.OK)
                m_templatePath = openFile.FileName;
            else if (Openwrite != System.Windows.Forms.DialogResult.OK)
            {
                openWorkspace = false;
                AppendOutputText("Workspace file not found.");
            }

            if (openWorkspace)
            {
                AppendOutputText( System.Environment.NewLine + "Opening " + m_templatePath );
                if (thread == null || thread.IsAlive == false)
                {
                    if (thread != null)
                        thread.Join();
                    thread = new Thread(RunDataMigrator);
                    thread.Start();
                }
            }
        }

        public void RunDataMigrator()
        {
            if( m_migrator == null )
                m_migrator = new ExcelDataMigrator(m_data, Input_Ref.Checked);

            m_migrator.MigrateData(m_templatePath);

            if (m_migrator.HasError())
                AppendOutputText(System.Environment.NewLine + m_migrator.GetError());
        }

        delegate void SetTextCallback(string text);

        private void AppendOutputText(string text)
        {
            if (this.richTextBox1.InvokeRequired)
            {
                SetTextCallback d = new SetTextCallback(AppendOutputText);
                this.Invoke(d, new object[] { text });
            }
            else
            {
                this.richTextBox1.Text += System.Environment.NewLine + text;
            }
        }

        public void logOutput(ExcelSheetReader reader, string varName)
        {
            if (String.IsNullOrEmpty(m_reader.Error) && !String.IsNullOrEmpty(m_reader.Output))
                AppendOutputText( "This is " + varName + " data: " + m_reader.Output);
        }

        //This function calls appropriate functions to get data out of the excel and prints onto rich text box 
        private bool ReadExcelInfo()
        {
            bool success = true;

            m_data.useGain = true;
            m_data.useNF = NF_check.Checked;
            m_data.useP1dB = P1dB_check.Checked;
            m_data.usePSat = PSat_check.Checked;
            m_data.useIP2 = IP2_check.Checked;
            m_data.useIP3 = IP3_check.Checked;
            m_data.useStageName = StageNamecheck.Checked;

            if (m_RowCol == Organized.Columns)
            {
                int start = 0, stop = 0;
                success = m_reader.convertStartStopToInt(m_startIndex, m_stopIndex, out start, out stop);

                if (success)
                {
                    richTextBox1.Text += System.Environment.NewLine + "Obtaining Column data." + System.Environment.NewLine;

                    success = m_reader.organizedInColumns(start, stop, m_GainRef, out m_data.m_gainArray);
                    logOutput(m_reader, "Gain");

                    if (success && m_data.useNF)
                    {
                        success = m_reader.organizedInColumns(start, stop, m_NFRef, out m_data.m_NFArray);
                        logOutput(m_reader, "Noise Freq");
                    }

                    if (success && m_data.useP1dB)
                    {
                        success = m_reader.organizedInColumns(start, stop, m_P1dBRef, out m_data.m_P1dBArray);
                        logOutput(m_reader, "P1db");
                    }

                    if (success && m_data.usePSat)
                    {
                        success = m_reader.organizedInColumns(start, stop, m_PSatRef, out m_data.m_PSatArray);
                        logOutput(m_reader, "Psat");
                    }

                    if (success && m_data.useIP3)
                    {
                        success = m_reader.organizedInColumns(start, stop, m_IP3Ref, out m_data.m_IP3Array);
                        logOutput(m_reader, "IP3");
                    }

                    if (success && m_data.useIP2)
                    {
                        success = m_reader.organizedInColumns(start, stop, m_IP2Ref, out m_data.m_IP2Array);
                        logOutput(m_reader, "IP2");
                    }

                    if (success && m_data.useStageName)
                    {
                        success = m_reader.organizedInColumnsNames(start, stop, m_stageNameIndex, out m_data.m_stageNameArray);
                        if (success && !String.IsNullOrEmpty(m_reader.Output))
                            richTextBox1.Text += m_reader.Output;
                    }
                }
            }
            if (m_RowCol == Organized.Rows)
            {
                success = m_reader.validateColumnStartStop(m_startIndex, m_stopIndex);

                if (success)
                {
                    richTextBox1.Text += System.Environment.NewLine + "Obtaining Row data." + System.Environment.NewLine;

                    success = m_reader.organizedInRows(m_startIndex, m_stopIndex, m_GainRef, out m_data.m_gainArray);
                    logOutput(m_reader, "Gain");

                    if (success && m_data.useNF)
                    {
                        success = m_reader.organizedInRows(m_startIndex, m_stopIndex, m_NFRef, out m_data.m_NFArray);
                        logOutput(m_reader, "Noise Freq");
                    }

                    if (success && m_data.useP1dB)
                    {
                        success = m_reader.organizedInRows(m_startIndex, m_stopIndex, m_P1dBRef, out m_data.m_P1dBArray);
                        logOutput(m_reader, "P1db");
                    }

                    if (success && m_data.usePSat)
                    {
                        success = m_reader.organizedInRows(m_startIndex, m_stopIndex, m_PSatRef, out m_data.m_PSatArray);
                        logOutput(m_reader, "Psat");
                    }

                    if (success && m_data.useIP3)
                    {
                        success = m_reader.organizedInRows(m_startIndex, m_stopIndex, m_IP3Ref, out m_data.m_IP3Array);
                        logOutput(m_reader, "IP3");
                    }

                    if (success && m_data.useIP2)
                    {
                        success = m_reader.organizedInRows(m_startIndex, m_stopIndex, m_IP2Ref, out m_data.m_IP2Array);
                        logOutput(m_reader, "IP2");
                    }

                    if (success && m_data.useStageName)
                    {
                        success = m_reader.organizedInRowsNames(m_startIndex, m_stopIndex, m_stageNameIndex, out m_data.m_stageNameArray);
                        if (success && !String.IsNullOrEmpty(m_reader.Output))
                            richTextBox1.Text += m_reader.Output;
                    }
                }
            }

            if (!success)
                richTextBox1.Text = m_reader.Error;

            return success;
        }

        //When the Read Excel data button is clicked, this checked for any incomplete inputs
        private bool ValidateCheckHasEntry()
        {
            if (String.IsNullOrEmpty(m_GainRef))
            {
                richTextBox1.Text = "Gain has no entry";
                return false;
            }
            else if (NF_check.Checked && String.IsNullOrEmpty(m_NFRef))
            {
                richTextBox1.Text = "Noise Frequency is checked but has no entry";
                return false;
            }
            else if (P1dB_check.Checked && String.IsNullOrEmpty(m_P1dBRef))
            {
                richTextBox1.Text = "P1dB is checked but has no entry";
                return false;
            }
            else if (PSat_check.Checked && String.IsNullOrEmpty(m_PSatRef))
            {
                richTextBox1.Text = "PSat is checked but has no entry";
                return false;
            }
            else if (IP2_check.Checked && String.IsNullOrEmpty(m_IP2Ref))
            {
                richTextBox1.Text = "IP2 is checked but has no entry";
                return false;
            }
            else if (IP3_check.Checked && String.IsNullOrEmpty(m_IP3Ref))
            {
                richTextBox1.Text = "IP3 is checked but has no entry";
                return false;
            }
            else if (StageNamecheck.Checked && String.IsNullOrEmpty(m_stageNameIndex))
            {
                richTextBox1.Text = "Stage Name is checked but has no entry";
                return false;
            }
            else if (String.IsNullOrEmpty(m_startIndex))
            {
                richTextBox1.Text = "Start Index has no entry";
                return false;
            }
            else if (String.IsNullOrEmpty(m_stopIndex))
            {
                richTextBox1.Text = "Stop Index has no entry";
                return false;
            }
            else
                return true;
        }

        //These functions below are for buttons/labels/textboxes
        private void ColumnsButton_CheckedChanged(object sender, EventArgs e)
        {
            m_RowCol = Organized.Columns;
            DataGroupRowColumnLabel.Text = "Column";
            StartRowColumnLabel.Text = "Start Row:";
            StopRowColumnLabel.Text = "Stop Row:";
        }

        private void RowsButton_CheckedChanged(object sender, EventArgs e)
        {
            m_RowCol = Organized.Rows;
            DataGroupRowColumnLabel.Text = "Row";
            StartRowColumnLabel.Text = "Start Column:";
            StopRowColumnLabel.Text = "Stop Column:";
        }

        private void noiseFigure_TextChanged(object sender, EventArgs e)
        {
            m_NFRef = noiseFigure.Text;
            NF_check.Checked = true;
        }

        private void Gain_TextChanged(object sender, EventArgs e)
        {
            m_GainRef = Gain.Text;
        }

        private void P1dB_ref_TextChanged(object sender, EventArgs e)
        {
            m_P1dBRef = P1dB_ref.Text;
            P1dB_check.Checked = true;
        }

        private void PSat_ref_TextChanged(object sender, EventArgs e)
        {
            m_PSatRef = PSat_ref.Text;
            PSat_check.Checked = true;
        }

        private void IP3_ref_TextChanged(object sender, EventArgs e)
        {
            m_IP3Ref = IP3_ref.Text;
            IP3_check.Checked = true;
        }

        private void IP2_ref_TextChanged(object sender, EventArgs e)
        {
            m_IP2Ref = IP2_ref.Text;
            IP2_check.Checked = true;
        }

        private void RowColumnRefStart_TextChanged(object sender, EventArgs e)
        {
            m_startIndex = RowColumnRefStart.Text;
        }

        private void RowColumnRefStop_TextChanged(object sender, EventArgs e)
        {
            m_stopIndex = RowColumnRefStop.Text;
        }

        private void StageNameText_TextChanged(object sender, EventArgs e)
        {
            m_stageNameIndex = StageNameText.Text;
            StageNamecheck.Checked = true;
        }
    }
}