<%@ Page Title="ucajax - Load via Server WCF" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="LoadViaServer.aspx.cs" Inherits="ucajax.web.LoadViaServer" %>

<%@ Register Src="Controls/AJAXLoader.ascx" TagName="AJAXLoader" TagPrefix="uc1" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <script>
        $(document).ready(function () {
            $(function() {
		        $( "#tabs" ).tabs();
	        });        
   
        });
    </script>
    <h2>
        Load Via Server WCF
    </h2>
    <p>
        This example uses a UserControl wrapper to pass server-side parameters to the $().ucajax(); jQuery plug-in, 
        then loading the control via WCF. This allows the parameter generation to come from the
        server-side, whether they be dynamic or hard-coded. This example is also using the AjaxAutoRefresh feature, 
        you can find more details <a href="#todo">here</a>.
    </p>  
    <h2>Result:</h2>               
    <p>
    <uc1:AJAXLoader ID="AJAXLoader1" runat="server" />     
    </p>  
    <h2>
        Code for this page:</h2>
    <div id="tabs">
        <ul>
            <li><a href="#tabs-1">Control Markup</a></li>
            <li><a href="#tabs-2">Code-behind</a></li>
        </ul>
        <div id="tabs-1"> 
            <pre class="brush: html;">
                &lt;uc1:AJAXLoader ID="AJAXLoader1" runat="server" /&gt;
            </pre>
        </div>
        <div id="tabs-2">
            <pre class="brush: csharp;">
                AJAXLoader1.ControlPath = Page.ResolveUrl("~/Controls/UserControlSimple.ascx");
                AJAXLoader1.ControlParams = new Dictionary&lt;string, string&gt;();
                AJAXLoader1.ControlParams.Add("TextProperty1",
                                              "Set via AJAXLoader.ascx, rendered via WCF with AutoRefresh!");
                AJAXLoader1.ControlParams.Add("AjaxAutoRefresh", "True");
                AJAXLoader1.UseWCFFormat = true;
            </pre>
        </div>
    </div>
   
</asp:Content>
