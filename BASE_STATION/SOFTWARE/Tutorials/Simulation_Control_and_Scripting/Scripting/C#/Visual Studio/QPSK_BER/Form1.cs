using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Threading;
using System.Windows.Threading;

namespace _QPSK_BER
{
    public partial class Form1 : Form
    {
        QPSK_BER qpskBerApplication;
        Thread thread;
        DispatcherTimer m_timer;

        public Form1()
        {
            InitializeComponent();
            qpskBerApplication = new QPSK_BER();

            // By default, SystemVue is initally hidden
            qpskBerApplication.Visible = (bool)HideSystemVue.Checked == false;

            // Start timer loop to update table
            m_timer = new DispatcherTimer();
            m_timer.Interval = TimeSpan.FromMilliseconds(100);
            m_timer.Tick += new EventHandler(delegate(object s, EventArgs a)
            {
                try
                {
                    if( ! qpskBerApplication.SimulationResults.IsEmpty )
                        simulationResultBindingSource.DataSource = qpskBerApplication.SimulationResults.SourceCollection;

                    // Refresh data in grid
                    dataGridView1.DataSource = typeof(_QPSK_BER.QPSK_BER.SimulationResult);
                    dataGridView1.DataSource = simulationResultBindingSource;
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                }
            });
            m_timer.Start();
        }

        private void LaunchSystemVue_Click(object sender, EventArgs e)
        {
            if (thread == null || thread.IsAlive == false)
            {
                if (thread != null)
                    thread.Join();
                thread = new Thread(qpskBerApplication.RunAnalysis);
                thread.Start();
            }
        }

        private void Clear_Click(object sender, EventArgs e)
        {
            qpskBerApplication.Clear();    
        }

        private void HideSystemVue_CheckedChanged(object sender, EventArgs e)
        {
            if (qpskBerApplication != null)
                qpskBerApplication.Visible = (bool)HideSystemVue.Checked == false;
        }
    }
}
