using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace ucajax.web.Controls
{
    public partial class AJAXLoader : System.Web.UI.UserControl
    {
        public string RESTUrl
        {
            get
            {
                if (ViewState["RESTUrl"] != null)
                    return (string)ViewState["RESTUrl"];
                return "/Service/AjaxContent.svc/GetAJAXControl";
            }
            set
            {
                ViewState["RESTUrl"] = value;
            }
        }

        public string ControlAssembly { get; set; }

        public string ControlName { get; set; }

        public string ControlPath { get; set; }

        public Dictionary<string, string> ControlParams { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            Dictionary<string, string> parsedParms = new Dictionary<string, string>();
            if (this.ControlParams != null) parsedParms = this.ControlParams;

            string jsonData = string.Empty;

            //JavaScriptSerilizer doesn't serialize Dictionary, so doing it by hand
            string viewModelShell = @"{{ ""ajaxControlViewModel"":{{""ControlName"":""{0}"",""ControlAssembly"":""{2}"",""ControlPath"":""{3}"",""ControlParams"":[{1}]}} }}";

            StringBuilder sb = new StringBuilder();


            foreach (var item in parsedParms)
            {
                sb.Append(string.Format(@"{{ ""Key"":""{0}"", ""Value"":""{1}"" }},", item.Key, item.Value));

            }
            string controlParams = sb.ToString();
            jsonData = string.Format(viewModelShell,
                                        this.ControlName,
                                        !string.IsNullOrEmpty(controlParams) ? controlParams.Remove(controlParams.Length - 1, 1) : controlParams,
                                        this.ControlAssembly,
                                        this.ControlPath
                                    );  //remove last comma from params

            String csname1 = "AJAXViewModel" + AJAXContent.ClientID;
            Type cstype = this.GetType();
            ClientScriptManager cs = Page.ClientScript;

            // Check to see if the startup script is already registered.
            if (!cs.IsStartupScriptRegistered(cstype, csname1))
            {

                bool autoRefresh = false;
                int autoRefreshInterval = 0;
                int pauseInterval = 0;
                int defaultHeight = 0;

                if (this.ControlParams != null && this.ControlParams.ContainsKey("AjaxAutoRefresh"))
                {
                    autoRefresh = bool.Parse(this.ControlParams["AjaxAutoRefresh"]);
                }

                if (this.ControlParams != null && this.ControlParams.ContainsKey("AjaxAutoRefreshInterval"))
                {
                    autoRefreshInterval = Int32.Parse(this.ControlParams["AjaxAutoRefreshInterval"]);
                }

                if (this.ControlParams != null && this.ControlParams.ContainsKey("AjaxPauseInterval"))
                {
                    pauseInterval = Int32.Parse(this.ControlParams["AjaxPauseInterval"]);
                }

                if (this.ControlParams != null && this.ControlParams.ContainsKey("AjaxDefaultContentHeight"))
                {
                    defaultHeight = Int32.Parse(this.ControlParams["AjaxDefaultContentHeight"]);
                    defaultWhiteSpace.Attributes.Add("style", string.Format("height:{0}px;", defaultHeight));
                }

                string js = "$().ucajax({{contentId: '{0}',postData: {1},RESTUrl: '{2}',ajaxSpinnerId: '{3}',autoRefresh: {4},refreshInterval: {5},pauseInterval: {6},recursed: false }});";
                cs.RegisterStartupScript(cstype, csname1,
                            string.Format(js, AJAXContent.ClientID,
                                                jsonData,
                                                RESTUrl,
                                                ajaxifyspinner.ClientID,
                                                autoRefresh.ToString().ToLower(),
                                                autoRefreshInterval,
                                                pauseInterval), true);
            }
        }
    }
}