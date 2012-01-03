<%@ Page Title="Load via Client" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoadViaClient.aspx.cs" Inherits="ucajax.web.LoadViaClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<script>
    var baseUrl = "<%= ResolveUrl("~/") %>";
    $(document).ready(function () {
           $().ucajax({ contentId: 'AJAXContent', 
                        postData: { "ajaxControlViewModel": { "ControlName": "", 
                                                              "ControlAssembly": "", 
                                                              "ControlPath": baseUrl + "Controls/UserControlSimple.ascx", 
                                                              "ControlParams": [{ "Key": "TextProperty1", "Value": "Set via JavaScript, rendered via WCF!" }, 
                                                                                { "Key": "AjaxAutoRefresh", "Value": "True"}]} }, 
                        RESTUrl: baseUrl + 'Service/AjaxContent.svc/GetAJAXControl', 
                        ajaxSpinnerId: 'ajaxifyspinner', 
                        autoRefresh: true, 
                        refreshInterval: 0, 
                        pauseInterval: 1500
                      });
    });   
</script>
<h2>
        Load Via Client
    </h2>
    <p>
        This example uses the $().ucajax(); jQuery plug-in directly, 
        then loads the control via WCF. This example is also using the AjaxAutoRefresh feature, 
        you can find more details <a href="#todo">here</a>.
    </p>  
    <h2>Code for this page:</h2>
    <h4>HTML Markup:</h4>
    <br>
    <pre class="brush: html;">
        &lt;div id="ajaxifyspinner" class="ajaxifyspinner"&gt;
            &lt;asp:Image ID="Image1" ImageAlign="Middle" runat="server"
              ImageUrl="~/Images/ajax-loader.gif" /&gt;
        &lt;/div&gt;
        &lt;div id="AJAXContent"&lt;/div&gt;
    </pre>
    <br> 
    <h4>JavaScript:</h4>
    <br>
    <pre class="brush: js;">
        var baseUrl = "&lt;%= ResolveUrl("~/") %&gt;";
        $(document).ready(function () {
           $().ucajax({ contentId: 'AJAXContent', 
                        postData: { "ajaxControlViewModel": { "ControlName": "", 
                                                              "ControlAssembly": "", 
                                                              "ControlPath": baseUrl + "Controls/UserControlSimple.ascx", 
                                                              "ControlParams": [{ "Key": "TextProperty1", "Value": "Set via JavaScript, rendered via WCF!" }, 
                                                                                { "Key": "AjaxAutoRefresh", "Value": "True"}]} }, 
                        RESTUrl: baseUrl + 'Service/AjaxContent.svc/GetAJAXControl', 
                        ajaxSpinnerId: 'ajaxifyspinner', 
                        autoRefresh: true, 
                        refreshInterval: 0, 
                        pauseInterval: 1500
                      });
        });  
    </pre>
    <h2>Result:</h2>               
    <p>
    <div id="ajaxifyspinner" class="ajaxifyspinner">
        <asp:Image ID="imgResultsProgress" ImageAlign="Middle" runat="server"
              ImageUrl="~/Images/ajax-loader.gif" /></div>
    <div id="AJAXContent"></div>  
    </p>         

</asp:Content>
