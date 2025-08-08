using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SystemVue.Plugins
{
    public class Parms
    {
        private static int _ebn0;
        public static int EbN0
        {
            get
            {
                return _ebn0;
            }
            set
            {
                _ebn0 = value;
            }
        }
    }
}
