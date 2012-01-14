<%@ Page Title="ucajax - Load via Client WCF using SignalR" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="LoadViaClientSignalR.aspx.cs" Inherits="ucajax.web.LoadViaClientSignalR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/jquery.signalR.min.js" type="text/javascript"></script>
    <script type="text/javascript">
     $(document).ready(function () {
         $(function() {
		    $( "#tabs" ).tabs();
	    });
        
        try{
            var connection = $.connection('echo');

            connection.received(function (data) {
                $('#messages').append('<li>received SignalR data...reloading control: ' + new Date().toString() + '</li>');
                ReloadControl()
            });

            connection.start();
        }
        catch(msg){alert(msg);}

        $("#broadcast").click(function () {          
            connection.send('time to reload');
        });
    });

    function ReloadControl()
    {
        $('#ajaxifyspinner').show();
        var baseUrl = "<%= ResolveUrl("~/") %>";
        $(document).ready(function () {

            var model = new $.ucajax.viewModel($.ucajax.DICTIONARY_TYPE.WCF);
            model.ajaxControlViewModel.ControlPath = baseUrl + "Controls/UserControlSimple.ascx";
            model.ajaxControlViewModel.ControlParams.push(new model.keyValuePair("TextProperty1", "Set via JavaScript, rendered via WCF!"));
            model.ajaxControlViewModel.ControlParams.push(new model.keyValuePair("TextProperty2", "True"));
                                   
            $().ucajax({ contentId: 'AJAXContent',
                postData: model, 
                RESTUrl:  baseUrl + 'Service/AjaxContent.svc/GetAJAXControl',
                ajaxSpinnerId: 'ajaxifyspinner',
                autoRefresh: false
            });

        });   
    }
    </script>
    <h2>
        Load Via Client WCF using <a href="https://github.com/SignalR/SignalR" target="_blank">
            SignalR</a> PersistentConnection
    </h2>
    <p>
        This example uses the $().ucajax(); jQuery plug-in directly, then loads the control
        via WCF when receiving a SignalR message. Open this page on multiple browsers and
        click, "CLICK TO BROADCAST CONTROL RELOAD", to see it in action.
    </p>
    <div>
        <h1>
            <a href="javascript:void(0);" id="broadcast">CLICK TO BROADCAST CONTROL RELOAD</a></h1>
    </div>
    <ul id="messages">
    </ul>
    <h2>
        Result:</h2>
    <p>
        <div id="ajaxifyspinner" class="ajaxifyspinner" style="display: none;">
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
            <pre class="brush: html;">
            &lt;div id="ajaxifyspinner" class="ajaxifyspinner" style="cursor:pointer"&gt;
                &lt;asp:Image ID="Image1" ImageAlign="Middle" runat="server"
                  ImageUrl="~/Images/ajax-loader.gif" /&gt;
            &lt;/div&gt;
            &lt;div id="AJAXContent"&lt;/div&gt;
        </pre>
        </div>
        <div id="tabs-2">
            <pre class="brush: js;">
            $(function () {
                var connection = $.connection('echo');

                connection.received(function (data) {              
                    $('#messages').append('&lt;li&gt;received SignalR data...reloading control&lt;/li&gt;');
                    ReloadControl()
                });

                connection.start();

                $("#broadcast").click(function () {               
                    connection.send('time to reload');
                });
            });

            function ReloadControl()
            {
                $('#ajaxifyspinner').show();
                var baseUrl = "<%= ResolveUrl("~/") %>";
                $(document).ready(function () {

                    var model = new $.ucajax.viewModel($.ucajax.DICTIONARY_TYPE.WCF);
                    model.ajaxControlViewModel.ControlPath = baseUrl + "Controls/UserControlSimple.ascx";
                    model.ajaxControlViewModel.ControlParams.push(new model.keyValuePair("TextProperty1", "Set via JavaScript, rendered via WCF!"));
                    model.ajaxControlViewModel.ControlParams.push(new model.keyValuePair("TextProperty2", "True"));
                                   
                    $().ucajax({ contentId: 'AJAXContent',
                        postData: model, 
                        RESTUrl:  baseUrl + 'Service/AjaxContent.svc/GetAJAXControl',
                        ajaxSpinnerId: 'ajaxifyspinner',
                        autoRefresh: false
                    });

                });   
            }
        </pre>
        </div>
    </div>
</asp:Content>
