using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Runtime.InteropServices;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Windows.Threading;
using System.Windows.Interop;

namespace SystemVue.Plugins
{
    /// <summary>
    /// Interaction logic for StatusDialog.xaml
    /// </summary>
    public partial class StatusDialog : Window
    {
        public StatusDialog()
        {
            InitializeComponent();
            this.Closing += new System.ComponentModel.CancelEventHandler(StatusDialog_Closing);
        }

        private void StatusDialog_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            e.Cancel = true;
            this.Hide();
        }

        public void Show(String message)
        {
            if (this.Dispatcher.CheckAccess())
            {
                PostShow(message);
            }
            else
            {
                this.Dispatcher.BeginInvoke(DispatcherPriority.Normal, (ThreadStart)delegate
                {
                    PostShow(message);
                });
            }
        }

        new public void Close()
        {
            if (this.Dispatcher.CheckAccess())
            {
                this.Hide();
            }
            else
            {
                this.Dispatcher.BeginInvoke(DispatcherPriority.Normal, (ThreadStart)delegate
                {
                    this.Hide();
                });
            }
        }

        public void PostSetMessage(String message)
        {
            if (this.Dispatcher.CheckAccess())
            {
                messageBox.Text = message;
            }
            else
            {
                this.Dispatcher.BeginInvoke(DispatcherPriority.Normal, (ThreadStart)delegate
                {
                    messageBox.Text = message;
                });
            }
        }

        private void PostShow(String message)
        {
            messageBox.Text = message;
            statusBar.Items.Clear();
            ProgressBar progbar = new ProgressBar();
            progbar.Background = Brushes.Gray;
            progbar.Foreground = Brushes.Green;
            progbar.Width = 400;
            progbar.Height = 15;
            progbar.IsIndeterminate = true;
            statusBar.Items.Add(progbar);

            this.Show();
        }
    }
}
