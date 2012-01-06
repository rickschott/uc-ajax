using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace ucajax.web
{
    public partial class LoadViaClientWebMethod : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string RenderUserControl(ucajax.AjaxControlViewModel ajaxControlViewModel)
        {
            return RenderHelpers.RenderUserControl(ajaxControlViewModel.ControlPath, ajaxControlViewModel.UseFormLess, ajaxControlViewModel.ControlParams, ajaxControlViewModel.ControlAssembly, ajaxControlViewModel.ControlName, HttpContext.Current);
        }
    }
}