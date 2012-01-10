; (function ($) {
    
    $.ucajax = {};
    $.ucajax.DICTIONARY_TYPE = {
            WCF: { value: 0, name: "Wcf", code: "WCF" },
            WEBMETHOD: { value: 1, name: "WebMethod", code: "WEBMETHOD" }
    };
    $.ucajax.viewModel = function (type) {
       
        var __type = type

        //this is the only param sent  the same c# object on the server-side
        this.ajaxControlViewModel =
        {
            "ControName": "",
            "ControlAssembly": "",
            "ControlPath": "",
            "ControlParams": createControlParams(type)
            
        };

        function createControlParams(type)
        {
            if (type == $.ucajax.DICTIONARY_TYPE.WCF)
            {
                return [];
            }
            else
            {
                return {};
            }
            
        }

        //shield consumer from differences in default WCF and WebMethod deserialization formats
        this.keyValuePair = function ( key, value) {
            if (type == $.ucajax.DICTIONARY_TYPE.WCF) {
                this.Key = key;
                this.Value = value;
            }
            else if (type == $.ucajax.DICTIONARY_TYPE.WEBMETHOD) {
                this[key] = value;
            }
            else {//default WCF
                this.Key = key;
                this.Value = value;
            }
        };



    };

    $.fn.ucajax = function (settings) {
        // Create some defaults, extending them with any options that were provided
        var options = {
            'contentId': '',
            'postData': {},
            'RESTUrl': '/Service/AjaxContent.svc/GetAJAXControl',
            'ajaxSpinnerId': '',
            'autoRefresh': false,
            'refreshInterval': 30000,
            'pauseInterval': 1500

        };

        $.extend(options, settings);

        function getQueryString() {
            var result = {};
            var queryString = location.search.substring(1);
            var re = /([^&=]+)=([^&]*)/g;
            var m;

            while (m = re.exec(queryString)) {
                result[decodeURIComponent(m[1])] = decodeURIComponent(m[2]);
            }

            return result;
        };
        function includeArrayObject(arr, obj) {
            return (arr.indexOf(obj) != -1);
        };

        function init(options) {
           
            //todo: doesn't work with webmethods yet, array vs property bag
             var qsParams = getQueryString();
            if (options.postData.ajaxControlViewModel.ControlParams instanceof Array) {  
               
                jQuery.each(qsParams, function (name, value) {
                    var newObject = { Key: name, Value: value };
                    if (!includeArrayObject(options.postData.ajaxControlViewModel.ControlParams, newObject)) {
                        options.postData.ajaxControlViewModel.ControlParams.push(newObject);
                    }
                });     
            }
            else
            {
                jQuery.each(qsParams, function (name, value) {
                    options.postData.ajaxControlViewModel.ControlParams[name] = value;                   
                }); 
            }

            //if params overridden but still 0, use defaults
            var __pause = 1500;
            var __refreshInterval = 30000;
            if (options.pauseInterval == 0) { options.pauseInterval = __pause; }
            if (options.refreshInterval == 0) { options.refreshInterval = __refreshInterval; }

            setTimeout(function () {
                $.ajax({
                    type: "POST",
                    url: options.RESTUrl,                    
                    data: JSON.stringify(options.postData),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.hasOwnProperty('d')) {
                            msg = msg.d;
                        }
                        setTimeout(function () {
                           
                            $('#' + options.ajaxSpinnerId).hide();
                            $('#' + options.contentId).html(msg).fadeTo('slow', 1);

                            if (options.autoRefresh) {
                                setInterval(function () {
                                    $('#' + options.ajaxSpinnerId).show();
                                    $('#' + options.contentId).fadeTo("slow", 0.4);
                                   
                                    reload(options);

                                }, options.refreshInterval);
                            }

                        }, options.pauseInterval); //can adjust if web service returns too fast


                    }
                });
            }, 0); //force browser async threading
        };

        function reload(options) {
            $.ajax({
                type: "POST",
                url: options.RESTUrl,                 
                data: JSON.stringify(options.postData),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.hasOwnProperty('d')) {
                        msg = msg.d;
                    }
                    setTimeout(function () {
                        $('#' + options.ajaxSpinnerId).hide();
                        $('#' + options.contentId).html(msg).fadeTo('slow', 1);                           

                    }, options.pauseInterval); //can adjust if web service returns too fast


                }
            });
        };

        init(options);
    };

})(jQuery);