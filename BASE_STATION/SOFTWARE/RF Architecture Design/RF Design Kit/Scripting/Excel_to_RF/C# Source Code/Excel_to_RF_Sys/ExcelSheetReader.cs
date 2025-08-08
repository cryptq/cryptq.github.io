using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Office.Interop.Excel;

namespace Excel_to_RF_Sys
{
    public class ExcelSheetReader
    {
        private _Worksheet m_objsheet;
        public ExcelSheetReader( _Worksheet objsheet )
        {
            m_objsheet = objsheet;
        }

        private String m_output;
        private String m_error;

        public String Error { get { return m_error; } }
        public String Output { get { return m_output; } }

        public bool convertStartStopToInt(string RowStart, string RowEnd, out int start, out int stop)
        {
            bool success = true;
            if (!(int.TryParse(RowStart, out start)))
            {
                m_error = "Row start value " + RowStart + " is invalid.";
                success = false;
            }
            if (!(int.TryParse(RowEnd, out stop)) && success)
            {
                m_error = "Row end value " + RowEnd + " is invalid.";
                success = false;
            }
            return success;
        }

        public bool convertNumberToInt(string RowNumber, out int Index)
        {
            bool success = true;
            if (!(int.TryParse(RowNumber, out Index)))
            {
                m_error = "Row number " + RowNumber + " is invalid.";
                success = false;
            }
            return success;
        }

        public bool validateColumnStartStop(string start, string stop)
        {
            bool success = true;
            int index;
            if (int.TryParse(start, out index))
            {
                m_error = "Column start entry " + start + " is invalid.";
                success = false;
            }
            if (int.TryParse(stop, out index) && success)
            {
                m_error = "Column stop entry " + stop + " is invalid.";
                success = false;
            }
            return success;
        }

        public bool validateColumnLetter(string columnLetter)
        {
            bool success = true;
            int index;
            if (int.TryParse(columnLetter, out index))
            {
                m_error = "Column entry " + columnLetter + " is invalid.";
                success = false;
            }
            return success;
        }

        //This function deals with excel data when saved as columns
        public bool organizedInColumns(int RowStart, int RowEnd, string columnLetter, out double[] ColumnDouble)
        {
            //The following is if the data is divided by Columns. Here are all the necessary variables
            string Letter = columnLetter.Substring(0, 1);
            bool success = validateColumnLetter(columnLetter);
            m_output = "";

            //Now parse through the cells and take the values from each cell
            int counter = 0;
            int size = RowEnd - RowStart + 1;
            if (size > 0)
                ColumnDouble = new double[size];
            else
                ColumnDouble = new double[ExcelData.s_maxStages];

            double value;
            for (int i = RowStart; success && i < RowEnd + 1; i++)
            {
                if (m_objsheet.get_Range(Letter + (RowStart + counter)).get_Value() == null)
                {
                    m_error = "Referencing an empty cell at: " + Letter + (RowStart + counter);
                    success = false;
                    break;
                }
                else if (double.TryParse(m_objsheet.get_Range(Letter + (RowStart + counter)).get_Value().ToString(), out value))
                {
                    ColumnDouble[counter] = value;
                    m_output += value.ToString() + ", ";
                    counter++;
                }
                else
                {
                    m_error = "Invalid data at: " + Letter + (RowStart + counter);
                    success = false;
                    break;
                }
            }
            return success;

        }

        //This function deals with excel data when saved as rows
        public bool organizedInRows(string ColumnStart, string ColumnStop, string RowNumber, out double[] RowDouble)
        {
            //The following is if the data is divided by Rows. Here are all the necessary variables
            int Index = 0;
            bool success = convertNumberToInt(RowNumber, out Index);
            m_output = "";

            //check length of starting index string to see if it is 2, 3, or 4 units in length
            char[] starting = ColumnStart.Substring(0, 1).ToCharArray();
            int asciistart = (int)starting[0];
            char[] ending = ColumnStop.Substring(0, 1).ToCharArray();
            int asciiend = (int)ending[0];

            char[] letterArray = new char[ExcelData.s_maxStages];
            int asciinext = asciistart;
            int size = asciiend - asciistart + 1;
            int counter = 0;
            double value;

            if (size > 0)
                RowDouble = new double[size];
            else
                RowDouble = new double[ExcelData.s_maxStages];

            //forloop to obtain all the asciis
            for (int i = asciistart; success && i < asciiend + 1; i++)
            {
                letterArray[i - asciistart] = (char)asciinext;
                if (m_objsheet.get_Range(Convert.ToString(letterArray[counter]) + Index.ToString()).get_Value() == null)
                {
                    m_error = "Referencing an empty cell at: " + letterArray[i - asciistart] + (Index);
                    success = false;
                    break;
                }
                else if (double.TryParse(m_objsheet.get_Range(Convert.ToString(letterArray[counter]) + Index.ToString()).get_Value().ToString(), out value))
                {
                    RowDouble[counter] = value;
                    m_output += value.ToString() + ", ";
                    asciinext++;
                    counter++;
                }
                else
                {
                    m_error = "Invalid data at: " + letterArray[i - asciistart] + (Index);
                    success = false;
                    break;
                }
            }
            return success;
        }

        //Logic for stage names (similar to Column data functions but specifically for stage names
        public bool organizedInColumnsNames(int RowStart, int RowEnd, string columnLetter, out string[] Columnstring)
        {
            //The following is if the stage names are divided by Columns. Here are all the necessary variables
            string Letter = columnLetter.Substring(0, 1);
            bool success = validateColumnLetter(columnLetter);
            m_output = "";

            //Now parse through the cells and take the values from each cell
            int counter = 0;
            int size = RowEnd - RowStart + 1;
            if (size > 0)
                Columnstring = new string[size];
            else
                Columnstring = new string[ExcelData.s_maxStages];

            if (success)
            {
                m_output += System.Environment.NewLine + "These are the Stage Names: ";
                for (int i = RowStart; success && i < (RowEnd + 1); i++)
                {
                    string value = m_objsheet.Cells[(RowStart + counter), Letter].Text;
                    if (!String.IsNullOrEmpty(value))
                    {
                        Columnstring[counter] = value;
                        m_output += Columnstring[counter] + ", ";
                        for (int j = 0; j < counter - 0; j++)
                        {
                            if (Columnstring[counter] == Columnstring[j])
                            {
                                m_error = "There are duplicate Stage Names at " + Letter + (RowStart + counter) + ". Please make all names unique.";
                                success = false;
                                break;
                            }
                        }
                    }
                    else
                    {
                        Columnstring[counter] = "Part_" + (counter + 1);
                        m_output += "Part_" + (counter + 1) + ",";
                    }
                    counter++;
                }
            }
            return success;
        }

        //Logic for stage names (similar to Row data functions but specifically for stage names
        public bool organizedInRowsNames(string ColumnStart, string ColumnStop, string RowNumber, out string[] RowNames)
        {
            //The following is if the stage names are divided by Rows. Here are all the necessary variables
            int Index = 0;
            bool success = convertNumberToInt(RowNumber, out Index);
            m_output = "";

            //check length of starting index string to see if it is 2, 3, or 4 units in length
            char[] starting = ColumnStart.Substring(0, 1).ToCharArray();
            int asciistart = (int)starting[0];
            char[] ending = ColumnStop.Substring(0, 1).ToCharArray();
            int asciiend = (int)ending[0];

            char[] letterArray = new char[ExcelData.s_maxStages];
            int size = asciiend - asciistart + 1;
            int asciinext = asciistart;
            int counter = 0;

            if (size > 0)
                RowNames = new string[size];
            else
                RowNames = new string[ExcelData.s_maxStages];

            //forloop to obtain all the asciis
            if (success)
            {
                m_output += System.Environment.NewLine + "These are the Stage Names: ";
                for (int i = asciistart; success && i < asciiend + 1; i++)
                {
                    letterArray[i - asciistart] = (char)asciinext;
                    Range range = m_objsheet.get_Range(Convert.ToString(letterArray[counter]) + Index.ToString());
                    string value = range.get_Value();
                    if (!String.IsNullOrEmpty(value))
                    {
                        //m_objsheet.get_Range(Convert.ToString(letterArray[counter]) + Index.ToString()).get_Value().ToString()
                        RowNames[counter] = value;
                        m_output += RowNames[counter] + ", ";
                        for (int j = 0; j < counter - 0; j++)
                        {
                            if (RowNames[counter] == RowNames[j])
                            {
                                m_error = "There are duplicate Stage Names at " + letterArray[i - asciistart] + (Index) + ". Please make all names unique.";
                                success = false;
                                break;
                            }
                        }
                        asciinext++;
                        counter++;
                    }
                    else
                    {
                        RowNames[counter] = "Part_" + (counter + 1);
                        m_output += "Part_" + (counter + 1) + ",";
                    }
                }
            }
            return success;
        }
    }
}
