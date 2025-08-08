using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Keysight.SystemVue.Extensibility;

namespace SystemVueCustomUI
{
    /// <summary>
    /// Interaction logic for Sine_UI.xaml
    /// </summary>
    [ModelUI("Sine_UI")]
    public partial class Sine_UI : UserControl, IModelCustomUI
    {
        private IModel model;

        public Sine_UI()
        {
            InitializeComponent();
        }

        public void OnConnection(IModel model)
        {
            this.model = model;
        }

        public void OnDisconnection()
        {
        }

        private void Amplitude_LostFocus(object sender, RoutedEventArgs e)
        {
            model.SetParameter(Amplitude.Name, Amplitude.Text);
        }

        private void Offset_LostFocus(object sender, RoutedEventArgs e)
        {
            model.SetParameter(Offset.Name, Offset.Text);
        }

        private void Frequency_LostFocus(object sender, RoutedEventArgs e)
        {
            model.SetParameter(Frequency.Name, Frequency.Text);
        }

        private void Phase_LostFocus(object sender, RoutedEventArgs e)
        {
            model.SetParameter(Phase.Name, Phase.Text);
        }

        private void SampleRate_LostFocus(object sender, RoutedEventArgs e)
        {
            model.SetParameter(SampleRate.Name, SampleRate.Text);
        }
    }
}
