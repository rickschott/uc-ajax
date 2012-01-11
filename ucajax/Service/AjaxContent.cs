using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.ServiceModel.Activation;
using System.Runtime.Serialization;
using System.Web;

namespace ucajax
{
    [ServiceContract]
    [DataContract]
    [ServiceBehavior]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class AjaxContent
    {

        public AjaxContent()
        {

        }

        [OperationContract]
        [WebInvoke(Method = "POST", BodyStyle = WebMessageBodyStyle.WrappedRequest, RequestFormat = WebMessageFormat.Json, ResponseFormat = WebMessageFormat.Json)]
        public string GetAJAXControl(AjaxControlViewModel ajaxControlViewModel)
        {
            return RenderHelpers.RenderUserControl(ajaxControlViewModel.ControlPath, ajaxControlViewModel.UseFormLess, ajaxControlViewModel.ControlParams, ajaxControlViewModel.ControlAssembly, ajaxControlViewModel.ControlName, HttpContext.Current);
        }      

    }
}
