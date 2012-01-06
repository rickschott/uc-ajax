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
                return Page.ResolveUrl("~/Service/AjaxContent.svc/GetAJAXControl");
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

        public bool UseWCFFormat { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxControlViewModel model = new AjaxControlViewModel();

            model.ControlParams = this.ControlParams != null ? this.ControlParams : new Dictionary<string, string>();
            model.ControlName = this.ControlName;
            model.ControlAssembly = this.ControlAssembly;
            model.ControlPath = this.ControlPath;

            string jsonData = UseWCFFormat ? model.toWCFJsonString() : model.toWebMethodJsonString();         

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

                if (this.ControlParams != null && model.ControlParams.ContainsKey("AjaxAutoRefresh"))
                {
                    autoRefresh = bool.Parse(model.ControlParams["AjaxAutoRefresh"]);
                }

                if (this.ControlParams != null && model.ControlParams.ContainsKey("AjaxAutoRefreshInterval"))
                {
                    autoRefreshInterval = Int32.Parse(model.ControlParams["AjaxAutoRefreshInterval"]);
                }

                if (this.ControlParams != null && model.ControlParams.ContainsKey("AjaxPauseInterval"))
                {
                    pauseInterval = Int32.Parse(model.ControlParams["AjaxPauseInterval"]);
                }

                if (this.ControlParams != null && model.ControlParams.ContainsKey("AjaxDefaultContentHeight"))
                {
                    defaultHeight = Int32.Parse(model.ControlParams["AjaxDefaultContentHeight"]);
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