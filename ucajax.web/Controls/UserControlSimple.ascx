<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserControlSimple.ascx.cs" Inherits="ucajax.web.Controls.UserControlSimple" %>

<asp:label ID="lblTitle" Text="I am a simple UserControl using asp:label" runat="server"/><br>
<asp:label ID="lblTextProperty1Title" Text="TextProperty1 = " runat="server"/><asp:label ID="lblTextProperty1" Text="" runat="server"/>
<!--and some html--><br>
<asp:hyperlink ID="hlLinkToMe" Text="I am also using asp:hyperlink" NavigateUrl="https://github.com/rickschott/uc-ajax" runat="server"/><br>
Wait 30 seconds and I will reload myself using all the sever-side parameters originally used.<br>
<asp:label ID="lblDateTime" Text="" runat="server"/><br>
<asp:label ID="lblTextProperty2Title" Text="TextProperty2 = " runat="server"/><asp:label ID="lblTextProperty2" Text="" runat="server"/>