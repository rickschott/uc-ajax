<%@ Page Title="ucajax - Load via Client WCF" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="LoadViaClient.aspx.cs" Inherits="ucajax.web.LoadViaClient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script>
    var baseUrl = "<%= ResolveUrl("~/") %>";
    $(document).ready(function () {
        $(function() {
		    $( "#tabs" ).tabs();
	    });

        var model = new $.ucajax.viewModel($.ucajax.DICTIONARY_TYPE.WCF);
        model.ajaxControlViewModel.ControlPath = baseUrl + "Controls/UserControlSimple.ascx";
        model.ajaxControlViewModel.ControlParams.push(new model.keyValuePair("TextProperty1", "Set via JavaScript, rendered via WCF!"));
        model.ajaxControlViewModel.ControlParams.push(new model.keyValuePair("TextProperty2", "True"));
        model.ajaxControlViewModel.ControlParams.push(new model.keyValuePair("AjaxAutoRefresh", "True"));
        
                                   
        $().ucajax({ contentId: 'AJAXContent',
            postData: model, 
            RESTUrl:  baseUrl + 'Service/AjaxContent.svc/GetAJAXControl',
            ajaxSpinnerId: 'ajaxifyspinner',
            autoRefresh: true
        });

    });   
    </script>
    <h2>
        Load Via Client WCF
    </h2>
    <p>
        This example uses the $().ucajax(); jQuery plug-in directly, then loads the control
        via WCF. This example is also using the AjaxAutoRefresh feature, you can find more
        details <a href="#todo">here</a>. One last thing, querystring params also get included
        in the ControlParams.
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
        </ul>
        <div id="tabs-1">
            <br>
            <pre class="brush: html;">
        &lt;div id="ajaxifyspinner" class="ajaxifyspinner"&gt;
            &lt;asp:Image ID="Image1" ImageAlign="Middle" runat="server"
              ImageUrl="~/Images/ajax-loader.gif" /&gt;
        &lt;/div&gt;
        &lt;div id="AJAXContent"&lt;/div&gt;
    </pre>
            <br>
        </div>
        <div id="tabs-2">
            <pre class="brush: js;">
                var model = new $.ucajax.viewModel($.ucajax.DICTIONARY_TYPE.WCF);
                model.ajaxControlViewModel.ControlPath = baseUrl + "Controls/UserControlSimple.ascx";
                model.ajaxControlViewModel.ControlParams.push(new model.keyValuePair("TextProperty1", "Set via JavaScript, rendered via WCF!"));
                model.ajaxControlViewModel.ControlParams.push(new model.keyValuePair("TextProperty2", "True"));
                model.ajaxControlViewModel.ControlParams.push(new model.keyValuePair("AjaxAutoRefresh", "True"));
                                   
                $().ucajax({ contentId: 'AJAXContent',
                    postData: model, 
                    RESTUrl:  baseUrl + 'Service/AjaxContent.svc/GetAJAXControl',
                    ajaxSpinnerId: 'ajaxifyspinner',
                    autoRefresh: true
                });
            </pre>
        </div>
    </div>
    <br>
</asp:Content>
