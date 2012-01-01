<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoadViaClient.aspx.cs" Inherits="ucajax.web.LoadViaClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<script>
    $(document).ready(function () {
        $().ucajax({ contentId: 'AJAXContent', postData: { "ajaxControlViewModel": { "ControlName": "", "ControlAssembly": "", "ControlPath": "/Controls/UserControlSimple.ascx", "ControlParams": [{ "Key": "TextProperty1", "Value": "Set via AJAXLoader, rendered via WCF!" }, { "Key": "AjaxAutoRefresh", "Value": "True"}]} }, RESTUrl: '/Service/AjaxContent.svc/GetAJAXControl', ajaxSpinnerId: 'ajaxifyspinner', autoRefresh: true, refreshInterval: 0, pauseInterval: 1500, recursed: false });
    });
    
    
</script>
<div id="ajaxifyspinner" class="ajaxifyspinner"><asp:Image ID="imgResultsProgress" ImageAlign="Middle" runat="server"
    ImageUrl="~/Images/ajax-loader.gif" /></div>
<div id="AJAXContent"></div>
</asp:Content>
