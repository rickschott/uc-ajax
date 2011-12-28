using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;
using System.Runtime.Serialization;

namespace ucajax
{
    [DataContract]
    public class AjaxControlViewModel
    {
        [DataMember]
        public string ControlPath { get; set; }

        [DataMember]
        public string ControlAssembly { get; set; }

        [DataMember]
        public bool UseFormLess { get; set; }

        [DataMember]
        public string ControlName { get; set; }

        [DataMember]
        public Dictionary<string, string> ControlParams { get; set; }

    }
}
