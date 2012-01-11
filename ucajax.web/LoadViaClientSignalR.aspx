<%@ Page Title="ucajax - Load via Client WCF" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoadViaClientSignalR.aspx.cs" Inherits="ucajax.web.LoadViaClientSignalR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<script src="Scripts/jquery.signalR.min.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        var connection = $.connection('echo');

        connection.received(function (data) {
            $('#messages').append('<li>received SingalR data...reloading control</li>');
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
</script>
 <h2><span id="broadcast" value="broadcast" style='cursor:pointer;' >CLICK TO BROADCAST CONTROL RELOAD</span></h2>
<ul id="messages">
</ul>
    <h2>
        Load Via Client WCF using SingalR PersistentConnection
    </h2>
    <p>
        This example uses the $().ucajax(); jQuery plug-in directly, 
        then loads the control via WCF when receiving a SingalR message.
    </p>  
    <h2>Result:</h2>               
    <p>
    <div id="ajaxifyspinner" class="ajaxifyspinner" style="display:none;">
        <asp:Image ID="imgResultsProgress" ImageAlign="Middle" runat="server"
              ImageUrl="~/Images/ajax-loader.gif" /></div>
    <div id="AJAXContent"></div>  
    </p>         
    <h2>Code for this page:</h2>
    <h4>HTML Markup:</h4>
    <br>
    <pre class="brush: html;">
        &lt;div id="ajaxifyspinner" class="ajaxifyspinner" style="cursor:pointer"&gt;
            &lt;asp:Image ID="Image1" ImageAlign="Middle" runat="server"
              ImageUrl="~/Images/ajax-loader.gif" /&gt;
        &lt;/div&gt;
        &lt;div id="AJAXContent"&lt;/div&gt;
    </pre>
    <br> 
    <h4>JavaScript:</h4>
    <br>
    <pre class="brush: js;">
        $(function () {
            var connection = $.connection('echo');

            connection.received(function (data) {              
                $('#messages').append('<li>received SingalR data...reloading control</li>');
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
   

</asp:Content>
