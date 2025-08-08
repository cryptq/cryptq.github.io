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
using System.IO;
using Keysight.Tap;
using System.Diagnostics;

namespace SystemVue.Plugins
{
    [Display("Report", Group: "SystemVue Results", Description: "Result logging and reporting in HTML format")]
    [ShortName("SVReport")]
    public class Report : ResultListener
    {
        #region Settings
        [FilePathAttribute]
        [Display("Logo File Path", Group: "File")]
        [Browsable(true)]
        public string LogoFilePath { get; set; }

        [FilePathAttribute]
        [Display("Report File Save Path", Group: "File")]
        //[DirectoryPath]
        [Browsable(true)]
        public string ReportFilePath { get; set; }

        [DisplayName("Operator name")]
        public string OperatorName { get; set; }
        #endregion

        private List<string> strListTestStepName = new List<string>();

        public Report()
        {

        }

        public override void OnTestPlanRunStart(TestPlanRun planRun)
        {
            //Add handling code for test plan run start.
            Rules.Add(() => LogoFilePath != null, "An Logo File is not selected. This test plan requires a specific path of logo.", "LogoFilePath");
            Rules.Add(() => ReportFilePath != null, "An Report File Path is not selected. This test plan requires a specific path for report.", "ReportFilePath");
            Rules.Add(() => OperatorName != null, "An Operator Name is not set. This test plan requires a specific operator name.", "OperatorName");
        }

        public override void OnTestStepRunStart(TestStepRun stepRun)
        {
            //Add handling code for test step run start.
        }

        public override void OnResultPublished(Guid stepRun, ResultTable result)
        {
            // Add handling code for result data.
            OnActivity();
        }

        public override void OnTestStepRunCompleted(TestStepRun stepRun)
        {
            //log.Info("...teststep run completed in {0}", stepRun.Duration);
            string strStepType = stepRun.TestStepTypeName;
            //stepRun.TestStepTypeName= "TapPlugin.BasicSteps.SequenceStep, TapPlugin.BasicSteps, Version=4.2.11.0, Culture=neutral, PublicKeyToken=null";
            string strTestStepName = "";

            //if (stepRun.Verdict == Verdict.Pass)
            //{
               // if (strStepType.Contains("TapPlugin.BasicSteps.SequenceStep"))
               // {
                    //log.Info("@@@" + stepRun.TestStepName + "-----" + stepRun.Verdict);
                    switch (stepRun.Verdict)
                    {
                        case Verdict.Pass:
                            strTestStepName = "<tr><td>" + stepRun.TestStepName + "</td><td><font color=\"blue\"><b>Pass</b></font></td><td>" + stepRun.Duration + "</td></tr>\r\n";
                            break;

                        case Verdict.Fail:
                            strTestStepName = "<tr><td>" + stepRun.TestStepName + "</td><td><font color=\"red\"><b>Fail</b></font></td><td>" + stepRun.Duration + "</td></tr>\r\n";
                            break;

                        case Verdict.Aborted:
                            strTestStepName = "<tr><td>" + stepRun.TestStepName + "</td><td><font color=\"red\"><b>Aborted</b></font></td><td>" + stepRun.Duration + "</td></tr>\r\n";
                            break;

                        case Verdict.Error:
                            strTestStepName = "<tr><td>" + stepRun.TestStepName + "</td><td><font color=\"red\"><b>Error</b></font></td><td>" + stepRun.Duration + "</td></tr>\r\n";
                            break;

                        case Verdict.NotSet:
                            strTestStepName = "<tr><td>" + stepRun.TestStepName + "</td><td><font color=\"gray\"><b>Not Set</b></font></td><td>" + stepRun.Duration + "</td></tr>\r\n";
                            break;

                        case Verdict.Inconclusive:
                            strTestStepName = "<tr><td>" + stepRun.TestStepName + "</td><td><font color=\"gray\"><b>Inconclusive</b></font></td><td>" + stepRun.Duration + "</td></tr>\r\n";
                            break;

                        default:
                            strTestStepName = "<tr><td>" + stepRun.TestStepName + "</td><td><font color=\"gray\"><b>---</b></font></td><td>" + stepRun.Duration + "</td></tr>\r\n";
                            break;
                    }
               // }
            //}
                strListTestStepName.Add(strTestStepName);   
        }

        public override void OnTestPlanRunCompleted(TestPlanRun planRun, Stream logStream)
        {
            //log.Info("...Set test plan run duration {0}", planRun.Duration);
            string exactLogFilePath = Path.GetFullPath(LogoFilePath);
            string exactReportFilePath = Path.GetFullPath(ReportFilePath);

            string strResultHTMLFileName = System.String.Format("{0:0000}-{1:00}-{2:00} {3:00}-{4:00}-{5:00}-{6}_{7}.html", DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second, planRun.Verdict.ToString(), planRun.TestPlanName);
            string strResultTxtFileName = System.String.Format("{0:0000}-{1:00}-{2:00} {3:00}-{4:00}-{5:00}-{6}_{7}.txt", DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second, planRun.Verdict.ToString(), planRun.TestPlanName);

            StreamWriter swHTML = new StreamWriter(exactReportFilePath + "\\" + strResultHTMLFileName);

            //Start Build HTML Report
            swHTML.Write("<!DOCTYPE html><html><head><style type=\"text/css\">table {font-family: arial, sans-serif;border-collapse: collapse;width: 80%;}\r\n");
            swHTML.Write("td,th{border: 1px solid #dddddd;text-align: left;padding: 8px;}\r\n");
            swHTML.Write("tr:nth-child(even){background-color: #dddddd;} body {display: block;margin-top: 40px;margin-left: 40px;line-height:0.8em;}</style></head>\r\n");
            swHTML.Write("<body><p><image src=\"" + exactLogFilePath + "\"></p>\r\n");
            swHTML.Write("<h3 style=\"font-family:verdana;\">" + planRun.TestPlanName + "</h3></p>\r\n"); 

            swHTML.Write("<h5 style=\"font-family:verdana;\">Report generated : " + DateTime.Now.ToString() + "</h5>\r\n");
            //swHTML.Write("<h5 style=\"font-family:verdana;\">UE " + UEModelName + "</h5>\r\n");
            swHTML.Write("<h5 style=\"font-family:verdana;\">Operator: " + OperatorName + "</h5>\r\n");
            //swHTML.Write("<h5 style=\"font-family:verdana;\">Instrument: " + IDN + "</h5>\r\n");

            swHTML.Write("<table>\r\n");
            swHTML.Write("<tr><th>Test Step Name</th><th>Verdict</th><th>Duration</th></tr>\r\n");

            foreach (string strTestStepName in strListTestStepName)
            {
                // swHTML.Write("<tr><td>" + strTestStepName + "</td><td><font color=\"red\"><b>PASS</b></font></td><td>120ms</td></tr>");
                swHTML.Write(strTestStepName);
            }

            switch (planRun.Verdict)
            {
                case Verdict.Pass:
                    swHTML.Write("<tr><td></td><td><font color=\"blue\"><b>*Pass</b></font></td><td>" + planRun.Duration + "</td></tr>\r\n");
                    break;

                case Verdict.Fail:
                    swHTML.Write("<tr><td></td><td><font color=\"red\"><b>*Fail</b></font></td><td>" + planRun.Duration + "</td></tr>\r\n");
                    break;

                case Verdict.Aborted:
                    swHTML.Write("<tr><td></td><td><font color=\"red\"><b>*Aborted</b></font></td><td>" + planRun.Duration + "</td></tr>\r\n");
                    break;

                case Verdict.Error:
                    swHTML.Write("<tr><td></td><td><font color=\"red\"><b>*Error</b></font></td><td>" + planRun.Duration + "</td></tr>\r\n");
                    break;

                case Verdict.NotSet:
                    swHTML.Write("<tr><td></td><td><font color=\"gray\"><b>*Not Set</b></font></td><td>" + planRun.Duration + "</td></tr>\r\n");
                    break;

                case Verdict.Inconclusive:
                    swHTML.Write("<tr><td></td><td><font color=\"gray\"><b>*Inconclusive</b></font></td><td>" + planRun.Duration + "</td></tr>\r\n");
                    break;

                default:
                    swHTML.Write("<tr><td></td><td><font color=\"gray\"><b>*---</b></font></td><td>" + planRun.Duration + "</td></tr>\r\n");
                    break;
            }

            swHTML.Write("</table><p></p>");
            swHTML.Write("<a href=\"" + strResultTxtFileName + "\" target=\"_blank\">Detailed Result Log</a>");

            swHTML.Write("</body></html>\r\n");
            swHTML.Close();

            Process.Start("iexplore.exe", exactReportFilePath + "\\" + strResultHTMLFileName);

            // Write Log Stream
            using (FileStream DestinationStream = File.Create(exactReportFilePath + "\\" + strResultTxtFileName))
            {
                logStream.CopyTo(DestinationStream);
            }
        }

        public override void Open()
        {
            base.Open();
            //Add resource open code.
        }

        public override void Close()
        {
            base.Close();
            //Add resource close code.

        }
    }
}
