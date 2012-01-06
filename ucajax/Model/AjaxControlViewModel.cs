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
        public AjaxControlViewModel() { }

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

        public string toWCFJsonString()
        {
            string result = string.Empty;

            Dictionary<string, string> parsedParms = new Dictionary<string, string>();
            if (this.ControlParams != null) parsedParms = this.ControlParams;

            string jsonData = string.Empty;

            string viewModelShell = @"{{ ""ajaxControlViewModel"":{{""ControlName"":""{0}"",""ControlAssembly"":""{2}"",""ControlPath"":""{3}"",""ControlParams"":[{1}]}} }}";

            StringBuilder sb = new StringBuilder();

            foreach (var item in parsedParms)
            {
                sb.Append(string.Format(@"{{ ""Key"":""{0}"", ""Value"":""{1}"" }},", item.Key, item.Value));

            }
            string controlParams = sb.ToString();
            result = string.Format(viewModelShell,
                                        this.ControlName,
                                        !string.IsNullOrEmpty(controlParams) ? controlParams.Remove(controlParams.Length - 1, 1) : controlParams,
                                        this.ControlAssembly,
                                        this.ControlPath
                                    );  //remove last comma from params

            return result;
        }

        public string toWebMethodJsonString()
        {
            string result = string.Empty;

            Dictionary<string, string> parsedParms = new Dictionary<string, string>();
            if (this.ControlParams != null) parsedParms = this.ControlParams;

            string jsonData = string.Empty;

            string viewModelShell = @"{{ ""ajaxControlViewModel"":
                                            {{ 
                                                ""ControlName"":""{0}"",""ControlAssembly"":""{2}"",""ControlPath"":""{3}"",""ControlParams"":{{{1}}} 
                                            }} 
                                        }}";

            StringBuilder sb = new StringBuilder();

            foreach (var item in parsedParms)
            {
                sb.Append(string.Format(@"""{0}"":""{1}"",", item.Key, item.Value));

            }
            string controlParams = sb.ToString();
            result = string.Format(viewModelShell,
                                        this.ControlName,
                                        !string.IsNullOrEmpty(controlParams) ? controlParams.Remove(controlParams.Length - 1, 1) : controlParams,
                                        this.ControlAssembly,
                                        this.ControlPath
                                    );  //remove last comma from params

            return result;
        }

    }
}
