<%@ Page Title="ucajax - Load via Server WebMethod" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="LoadViaServerWebMethod.aspx.cs" Inherits="ucajax.web.LoadViaServerWebMethod" %>

<%@ Register Src="Controls/AJAXLoader.ascx" TagName="AJAXLoader" TagPrefix="uc1" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Load Via Server WebMethod
    </h2>
    <p>
        This example uses a UserControl wrapper to pass server-side parameters to the $().ucajax(); jQuery plug-in, 
        then loading the control via a WebMethod. This allows the parameter generation to come from the
        server-side, whether they be dynamic or hard-coded. This example is also using the AjaxAutoRefresh feature, 
        you can find more details <a href="#todo">here</a>. One last thing, querystring params 
        also get included in the ControlParams.
    </p>  
    <h2>Code for this page:</h2>
    <h4>Control Markup:</h4>
    <br>
    <pre class="brush: html;">
        &lt;uc1:AJAXLoader ID="AJAXLoader1" runat="server" /&gt;
    </pre>
    <br> 
    <h4>Code-behind:</h4>
    <br>
    <pre class="brush: csharp;">
        AJAXLoader1.ControlPath = Page.ResolveUrl("~/Controls/UserControlSimple.ascx");
        AJAXLoader1.ControlParams = new Dictionary&lt;string, string&gt;();
        AJAXLoader1.ControlParams.Add("TextProperty1",
                                      "Set via AJAXLoader.ascx, rendered via WCF with AutoRefresh!");
        AJAXLoader1.ControlParams.Add("AjaxAutoRefresh", "True");
        AJAXLoader1.RESTUrl = Page.ResolveUrl("~/LoadViaClientWebMethod.aspx/RenderUserControl");
        AJAXLoader1.UseWCFFormat = false;
    </pre>
    <h2>Result:</h2>               
    <p>
    <uc1:AJAXLoader ID="AJAXLoader1" runat="server" />     
    </p>         
</asp:Content>
