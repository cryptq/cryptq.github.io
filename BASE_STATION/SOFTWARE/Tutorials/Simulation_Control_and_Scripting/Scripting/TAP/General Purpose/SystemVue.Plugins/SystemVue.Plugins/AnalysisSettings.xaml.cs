using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace SystemVue.Plugins
{
    /// <summary>
    /// Interaction logic for AnalysisSettings.xaml
    /// </summary>
    public partial class AnalysisSettings : Window, INotifyPropertyChanged
    {
        private Dictionary<String, ObservableCollection<Parameter>> m_parameterSettings = new Dictionary<string, ObservableCollection<Parameter>>();
        ISystemVue m_svCntl;

        public event PropertyChangedEventHandler PropertyChanged;

        public AnalysisSettings(ISystemVue svCntl, Dictionary<String, ObservableCollection<Parameter>> parameterSettings)
        {
            m_svCntl = svCntl;
            foreach(var analysisName in parameterSettings.Keys)
            {
                ObservableCollection<Parameter> analysisParams = new ObservableCollection<Parameter>();
                foreach (var param in parameterSettings[analysisName])
                {
                    analysisParams.Add(new Parameter()
                    {
                        Name = param.Name,
                        Path = param.Path,
                        Value = param.Value,
                        Unit = param.Unit,
                        Description = param.Description
                    });
                }
                m_parameterSettings.Add(analysisName, analysisParams);
            }
            
            InitializeComponent();
            if (comboAnalyses.Items.Count > 0)
                comboAnalyses.SelectedIndex = 0;
        }

        public Dictionary<String, ObservableCollection<Parameter>> ParameterSettings { get { return m_parameterSettings; } }

        public ObservableCollection<Parameter> ParameterList
        {
            get
            {
                String selectedAnalysis = comboAnalyses.SelectedValue as String;
                if (!String.IsNullOrEmpty(selectedAnalysis) && m_parameterSettings.ContainsKey(selectedAnalysis))
                {
                    return m_parameterSettings[selectedAnalysis];
                }
                else
                {
                    return new ObservableCollection<Parameter>();
                }
            }
        }
        public List<String> AnalysisList { get { return Param.Instance.Analyses.Keys.ToList(); } }

        private void comboAnalyses_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            String selectedAnalysis = comboAnalyses.SelectedValue as String;
            if (!String.IsNullOrEmpty(selectedAnalysis))
            {
                if (!m_parameterSettings.ContainsKey(selectedAnalysis))
                {
                    m_parameterSettings.Add(selectedAnalysis, new ObservableCollection<Parameter>());

                    String analysisPath = Param.Instance.Analyses[selectedAnalysis];
                    GENESYS.IItem analysisItem = m_svCntl.GetItem(analysisPath);
                    GENESYS.IItem designNameItem = analysisItem.GetItemByName("DesignName");
                    String designName = designNameItem.GetVarValue(0) as String;
                    if (String.IsNullOrEmpty(designName)) return; // Sweep Analysis?

                    String designPath = Param.Instance.Designs[designName];
                    List<SVParameter> svParams = m_svCntl.GetDesignParameterList(designPath);
                    foreach (var svParam in svParams)
                    {
                        Parameter parameter = new Parameter();
                        parameter.Name = svParam.Name;
                        parameter.Path = svParam.Path;
                        if (!String.IsNullOrEmpty(svParam.Entry))
                        {
                            parameter.Value = svParam.Entry;
                        }
                        else
                        {
                            parameter.Value = svParam.Value.ToString();
                        }
                        parameter.Unit = svParam.Unit;
                        parameter.Description = svParam.Description;
                        m_parameterSettings[selectedAnalysis].Add(parameter);
                    }
                }

                OnPropertyChanged("ParameterList");
            }
        }

        private void buttonOK_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = true;
            this.Close();
        }

        private void buttonCancel_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = false;
            this.Close();
        }

        private void OnPropertyChanged(String propertyName)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(propertyName));
            }
        }
    }

    public class Parameter : INotifyPropertyChanged
    {
        String m_name;
        String m_value;
        String m_description;
        String m_unit;

        public event PropertyChangedEventHandler PropertyChanged;

        public String Name
        {
            get { return m_name; }
            set
            {
                m_name = value;
                OnPropertyChanged("Name");
            }
        }

        public String Path { get; set; }

        public String Value
        {
            get { return m_value; }
            set
            {
                m_value = value;
                OnPropertyChanged("Value");
            }
        }
        public String Description
        {
            get { return m_description; }
            set
            {
                m_description = value;
                OnPropertyChanged("Description");
            }
        }
        public String Unit
        {
            get
            {
                return m_unit;
            }
            set
            {
                m_unit = value;
                OnPropertyChanged("Unit");
            }
        }

        private void OnPropertyChanged(String propertyName)
        {
            PropertyChangedEventHandler handler = PropertyChanged;
            if (handler != null)
            {
                handler(this, new PropertyChangedEventArgs(propertyName));
            }
        }
    }
}
