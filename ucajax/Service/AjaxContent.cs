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

        //private static string RenderUserControl(string path, bool useFormLess,
        //     Dictionary<string, string> controlParams, string assemblyName, string controlName)
        //{

        //    System.Web.UI.Page pageHolder = null;
        //    if (useFormLess)
        //    {
        //        pageHolder = new FormlessPage() { AppRelativeTemplateSourceDirectory = HttpRuntime.AppDomainAppVirtualPath }; //needed to resolve "~/"
        //    }
        //    else
        //    {
        //        pageHolder = new System.Web.UI.Page() { AppRelativeTemplateSourceDirectory = HttpRuntime.AppDomainAppVirtualPath };
        //    }

        //    System.Web.UI.UserControl viewControl = null;

        //    //use path by default
        //    if (String.IsNullOrEmpty(path))
        //    {
        //        //load assembly and usercontrol when .ascx is compiled into a .dll                 
        //        string controlAssemblyName = string.Format("{0}.{1},{0}", assemblyName, controlName);

        //        Type type = Type.GetType(controlAssemblyName);
        //        viewControl = (System.Web.UI.UserControl)pageHolder.LoadControl(type, null);
        //    }
        //    else
        //    {
        //        viewControl = (System.Web.UI.UserControl)pageHolder.LoadControl(path);

        //    }

        //    pageHolder.EnableViewState = false;
        //    viewControl.EnableViewState = false;

        //    if (controlParams != null && controlParams.Count > 0)
        //    {
        //        foreach (var keyValuePair in controlParams)
        //        {
        //            Type viewControlType = viewControl.GetType();
        //            System.Reflection.PropertyInfo property =
        //               viewControlType.GetProperty(keyValuePair.Key);

        //            if (property != null)
        //            {

        //                object value;
        //                DateTime date;
        //                if (property.PropertyType == typeof(bool))
        //                    value = bool.Parse(keyValuePair.Value);
        //                else if (property.PropertyType == typeof(Int32))
        //                    value = Int32.Parse(keyValuePair.Value);
        //                else if (property.PropertyType == typeof(Guid))
        //                    value = new Guid(keyValuePair.Value);
        //                else if (property.PropertyType == typeof(DateTime) && DateTime.TryParse(keyValuePair.Value, out date))
        //                    value = date;
        //                else
        //                    value = keyValuePair.Value;

        //                try
        //                {
        //                    property.SetValue(viewControl, value, null);
        //                }
        //                catch (Exception ex)
        //                {
        //                    //need to hook into external logger, throw?
        //                }

        //            }

        //        }
        //    }

        //    string parseIndex = System.Guid.NewGuid().ToString();
        //    if (useFormLess)
        //    {
        //        pageHolder.Controls.Add(viewControl);
        //    }
        //    else
        //    {
        //        System.Web.UI.HtmlControls.HtmlForm form = new System.Web.UI.HtmlControls.HtmlForm();
        //        System.Web.UI.ScriptManager sm = new System.Web.UI.ScriptManager();
        //        sm.EnableCdn = true;
        //        sm.AjaxFrameworkMode = System.Web.UI.AjaxFrameworkMode.Disabled;
        //        System.Web.UI.WebControls.Literal litParseIndex = new System.Web.UI.WebControls.Literal();
        //        litParseIndex.Text = parseIndex;
        //        form.Controls.Add(sm);
        //        form.Controls.Add(litParseIndex);
        //        form.Controls.Add(viewControl);
        //        pageHolder.Controls.Add(form);
        //    }
        //    System.IO.StringWriter output = new System.IO.StringWriter();
        //    HttpContext.Current.Server.Execute(pageHolder, output, false);

        //    string renderedContent = output.ToString();

        //    if (renderedContent.Contains("<form method=")) //have to have a form and scriptmananger to render sometimes but we don't want it on the client
        //    {
        //        renderedContent = renderedContent.Substring(renderedContent.IndexOf(parseIndex) + parseIndex.Length);
        //        renderedContent = renderedContent.Replace(renderedContent.Substring(renderedContent.LastIndexOf("</form>"), 7), "");
        //    }
        //    return renderedContent;

        //}

    }
}
