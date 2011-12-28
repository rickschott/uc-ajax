<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="LoadViaServer.aspx.cs" Inherits="ucajax.web.LoadViaServer" %>

<%@ Register src="Controls/AJAXLoader.ascx" tagname="AJAXLoader" tagprefix="uc1" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Load Via Server
    </h2>
    <p> 
       UserControl wrapper to pass server-side params to the client, then letting ucajax load the control via WCF.
       This allows the parameter generation to come from the server-side, whether it be dynamic or hard-coded
       <uc1:AJAXLoader ID="AJAXLoader1" runat="server" /> 
    </asp:Content>
