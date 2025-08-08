using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.ObjectModel;
using System.ComponentModel;

namespace SystemVue.Plugins
{
    public class Param
    {
        static public Param Instance = new Param();

        private String m_currentWorkspacePath;

        private Param()
        {
            m_currentWorkspacePath = String.Empty;
            Analyses = new Dictionary<string, string>();
            Designs = new Dictionary<string, string>();
            DataSets = new Dictionary<string, string>();
            ParameterSettings = new Dictionary<string, ObservableCollection<Parameter>>();
        }

        private List<SVcontrol> m_svControls = new List<SVcontrol>();

        public void AddSink(SVcontrol svControl)
        {
            m_svControls.Add(svControl);
        }

        public void GetWorkspaceInformation(ISystemVue svCntl, String sPath)
        {
            if (!System.IO.File.Exists(sPath))
                throw (new Exception("Workspace does not exist: " + sPath));

            if (svCntl.StartSystemVue())
            {
                if(m_currentWorkspacePath != sPath)
                {
                    svCntl.CloseWorkspace();
                    if (!svCntl.OpenWorkspace(sPath))
                        return;

                    m_currentWorkspacePath = sPath;
                }

                Dictionary<String, String> analyses = null;
                Dictionary<String, String> designs = null;
                Dictionary<String, String> datasets = null;
                svCntl.TraverseWorkspace(out analyses, out designs, out datasets);
                Analyses = analyses;
                Designs = designs;
                DataSets = datasets;
            } 
        }

        public void OnWorkspaceClosed()
        {
            m_currentWorkspacePath = String.Empty;
        }

        public Dictionary<String, String> Analyses { get; private set; }
        public Dictionary<String, String> Designs { get; private set; }
        public Dictionary<String, String> DataSets { get; private set; }
        public Dictionary<String, ObservableCollection<Parameter>> ParameterSettings { get; set; }
        private void OnParameteriesChanged()
        {
            foreach(SVcontrol control in m_svControls)
            {
                control.OnParameteriesChanged();
            }
        }
    }
}
