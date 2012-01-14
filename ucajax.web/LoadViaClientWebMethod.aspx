<%@ Page Language="C#" Title="ucajax - Load Via Client WebMethod" AutoEventWireup="true"
    MasterPageFile="~/Site.Master" CodeBehind="LoadViaClientWebMethod.aspx.cs" Inherits="ucajax.web.LoadViaClientWebMethod" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script>
    var baseUrl = "<%= ResolveUrl("~/") %>";
    $(document).ready(function () {            
        $(function() {
		    $( "#tabs" ).tabs();
	    });
        var model = new $.ucajax.viewModel($.ucajax.DICTIONARY_TYPE.WEBMETHOD);
        model.ajaxControlViewModel.ControlPath = baseUrl + "Controls/UserControlSimple.ascx";
        model.ajaxControlViewModel.ControlParams["TextProperty1"] = "Set via JavaScript, rendered via WebMethod!";
        model.ajaxControlViewModel.ControlParams["TextProperty2"] = "True";
        model.ajaxControlViewModel.ControlParams["AjaxAutoRefresh"] = "True";
                                   
        $().ucajax({ contentId: 'AJAXContent',
            postData: model, 
            RESTUrl:  baseUrl + 'LoadViaClientWebMethod.aspx/RenderUserControl',
            ajaxSpinnerId: 'ajaxifyspinner',
            autoRefresh: true
        });
    });   
    </script>
    <h2>
        Load Via Client WebMethod
    </h2>
    <p>
        This example uses the $().ucajax(); jQuery plug-in directly, then loads the control
        via a WebMethod. This example is also using the AjaxAutoRefresh feature, you can
        find more details <a href="#todo">here</a>. One last thing, querystring params also
        get included in the ControlParams.
    </p>
    <h2>
        Result:</h2>
    <p>
        <div id="ajaxifyspinner" class="ajaxifyspinner">
            <asp:Image ID="imgResultsProgress" ImageAlign="Middle" runat="server" ImageUrl="~/Images/ajax-loader.gif" /></div>
        <div id="AJAXContent">
        </div>
    </p>
    <h2>
        Code for this page:</h2>
    <div id="tabs">
        <ul>
            <li><a href="#tabs-1">HTML Markup</a></li>
            <li><a href="#tabs-2">JavaScript</a></li>
            <li><a href="#tabs-3">WebMethod</a></li>
        </ul>
        <div id="tabs-1">
            <pre class="brush: html;">
                &lt;div id="ajaxifyspinner" class="ajaxifyspinner"&gt;
                    &lt;asp:Image ID="Image1" ImageAlign="Middle" runat="server"
                      ImageUrl="~/Images/ajax-loader.gif" /&gt;
                &lt;/div&gt;
                &lt;div id="AJAXContent"&lt;/div&gt;
            </pre>
        </div>
        <div id="tabs-2">
            <pre class="brush: js;">
                var model = new $.ucajax.viewModel($.ucajax.DICTIONARY_TYPE.WEBMETHOD);
                model.ajaxControlViewModel.ControlPath = baseUrl + "Controls/UserControlSimple.ascx";
                model.ajaxControlViewModel.ControlParams["TextProperty1"] = "Set via JavaScript, rendered via WebMethod!";
                model.ajaxControlViewModel.ControlParams["TextProperty2"] = "True";
                model.ajaxControlViewModel.ControlParams["AjaxAutoRefresh"] = "True";
                                   
                $().ucajax({ contentId: 'AJAXContent',
                    postData: model, 
                    RESTUrl:  baseUrl + 'LoadViaClientWebMethod.aspx/RenderUserControl',
                    ajaxSpinnerId: 'ajaxifyspinner',
                    autoRefresh: true
                });
            </pre>
        </div>
        <div id="tabs-3">
            <pre class="brush: c#;">
                [WebMethod]
                public static string RenderUserControl(ucajax.AjaxControlViewModel ajaxControlViewModel)
                {
                    return RenderHelpers.RenderUserControl(ajaxControlViewModel.ControlPath, 
                                                           ajaxControlViewModel.UseFormLess, 
                                                           ajaxControlViewModel.ControlParams, 
                                                           ajaxControlViewModel.ControlAssembly,
                                                           ajaxControlViewModel.ControlName, 
                                                           HttpContext.Current);
                }
            </pre>
        </div>
</asp:Content>
