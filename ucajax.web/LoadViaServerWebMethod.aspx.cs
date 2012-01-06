using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ucajax.web
{
    public partial class LoadViaServerWebMethod : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {        
            AJAXLoader1.ControlPath = Page.ResolveUrl("~/Controls/UserControlSimple.ascx");
            AJAXLoader1.ControlParams = new Dictionary<string, string>();
            AJAXLoader1.ControlParams.Add("TextProperty1","Set via AJAXLoader, rendered via WCF!");
            AJAXLoader1.ControlParams.Add("AjaxAutoRefresh", "True");
            AJAXLoader1.RESTUrl = Page.ResolveUrl("~/LoadViaClientWebMethod.aspx/RenderUserControl");
            AJAXLoader1.UseWCFFormat = false;
        }
    }
}
