using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.Windows.Data;

namespace _QPSK_BER
{
    class QPSK_BER
    {
        // This function does all of the BER simulation management
        public void RunAnalysis()
        {
            // Create a new instance only if needed
            if (systemVue == null)
            {
                // Start a new instance of SystemVue
                systemVue = new SystemVueExample.SystemVue();

                // Open the workspace

                systemVue.OpenExampleWorkspace("Comms/BER/QPSK_BER_Coded_Viterbi.wsv");

                systemVue.Visible = Visible;

            }

            // Sweep Eb/N0 -2 to 10 and calculate the BER
            for (int EbN0 = -2; EbN0 <= 10; EbN0++)
            {
                // Set the NDenstity parameter
                systemVue.SetParameter("QPSK_BER_Coded_Viterbi.WorkspaceVariables.VarBlock.[EbN0]", EbN0);

                systemVue.RunScript("QPSK_BER_Coded_Viterbi.Analyses.Uncoded_QPSK_BER_Analysis.RunAnalysis()");

                // Read BER from dataset
                double BER = systemVue.GetData(
                    "QPSK_BER_Coded_Viterbi.Analyses.Uncoded_QPSK_BER_Data.Eqns.VarBlock.B11_BER");

                QPSK_BER.SimulationResult newSim = new QPSK_BER.SimulationResult();
                newSim.BER = BER;
                newSim.EbN0 = EbN0;
                newSim.Test = BER > .1 ? "Fail" : "Pass";
                m_SimulationResults.Add(newSim);
            }

        }

        // Manage the viewing of simulation results by GUI
        public ICollectionView SimulationResults { get; private set; }

        // Structure to store the simulation results in
        List<SimulationResult> m_SimulationResults;

        // Instance of SystemVue COM wrapper implemented by SystemVueNET project in this solution
        SystemVueExample.SystemVue systemVue;

        // Constructor
        public QPSK_BER()
        {
            // By default, build a empty list of simulation results
            m_SimulationResults = new List<QPSK_BER.SimulationResult>();

            // Declare empty view for the ICollectionView
            CollectionViewSource.GetDefaultView(m_SimulationResults);

            // Connect Simulation results to our data member
            SimulationResults = new ListCollectionView(m_SimulationResults);
        }

        // Delete old simulation results
        public void Clear()
        {
            m_SimulationResults.Clear();
            SimulationResults.Refresh();
        }

        private bool m_bVisible = false;

        // Control SystemVue visiblity
        public bool Visible
        {
            get { return m_bVisible; }
            set
            {
                m_bVisible = value;
                if (systemVue != null)
                    systemVue.Visible = value;
            }
        }

        // Class to store each simulation result - with notification built in
        public class SimulationResult : INotifyPropertyChanged
        {
            private double m_dBER;
            private double m_dEbN0;
            private string m_sTest;

            public SimulationResult()
            {
                BER = 0;
                EbN0 = 0;
                Test = "True";
            }


            public double BER
            {
                get { return m_dBER; }
                set
                {
                    m_dBER = value;
                    NotifyPropertyChanged("BER");
                }
            }

            public double EbN0
            {
                get { return m_dEbN0; }
                set
                {
                    m_dEbN0 = value;
                    NotifyPropertyChanged("EbN0");
                }
            }

            public string Test
            {
                get { return m_sTest; }
                set
                {
                    m_sTest = value;
                    NotifyPropertyChanged("Test");
                }
            }

            #region INotifyPropertyChanged Members

            public event PropertyChangedEventHandler PropertyChanged;

            #endregion

            #region Private Helpers

            private void NotifyPropertyChanged(string propertyName)
            {
                if (PropertyChanged != null)
                {
                    PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
                }
            }

            #endregion
        }

    }
}
