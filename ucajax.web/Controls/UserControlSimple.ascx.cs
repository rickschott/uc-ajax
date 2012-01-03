using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ucajax.web.Controls
{
   
    public partial class UserControlSimple : System.Web.UI.UserControl
    {
        public string TextProperty1 { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblTextProperty1.Text = TextProperty1;
            lblDateTime.Text = "Oh, look at the time: " + DateTime.Now.ToString();
        }
    }
}