<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserControlSimple.ascx.cs" Inherits="ucajax.web.Controls.UserControlSimple" %>

<asp:label ID="lblTitle" Text="I am a simple UserControl using asp:label" runat="server"/>
<asp:label ID="lblTextProperty1Title" Text="TextProperty1=" runat="server"/><asp:label ID="lblTextProperty1" Text="" runat="server"/>
<!--and some html--><br>&nbsp;
<asp:hyperlink ID="hlLinkToMe" Text="I am also using asp:hyperlink" NavigateUrl="https://github.com/rickschott/uc-ajax" runat="server"/>