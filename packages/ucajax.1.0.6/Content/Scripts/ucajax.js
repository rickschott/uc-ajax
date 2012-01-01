
; (function ($) {
    // Create some defaults, extending them with any options that were provided
    var options = $.extend({
        'contentId': '',
        'postData': {},
        'RESTUrl': '/Service/AjaxContent.svc/GetAJAXControl',
        'ajaxSpinnerId': '',
        'autoRefresh': false,
        'refreshInterval': 30000,
        'pauseInterval': 1500,
        'recursed': false

    }, options);

    $.fn.ucajax = function (options) {

        function init(options) {
            if (!options.recursed) {
                var qsParams = getQueryString();
                jQuery.each(qsParams, function (name, value) {
                    var newObject = { Key: name, Value: value };
                    if (!includeArrayObject(options.postData.ajaxControlViewModel.ControlParams, newObject)) {
                        options.postData.ajaxControlViewModel.ControlParams.push(newObject);
                    }
                });
            }

            //if params overridden but still 0, use defaults
            var __pause = 1500;
            var __refreshInterval = 30000;
            if (options.pauseInterval > 0) { _pause = options.pauseInterval; }
            if (options.refreshInterval > 0) { _refreshInterval = options.refreshInterval; }

            setTimeout(function () {
                $.ajax({
                    type: "POST",
                    url: options.RESTUrl,
                    //data: '{"ajaxControlViewModel":' + JSON.stringify(postData) + '}',
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
                                setTimeout(function () {

                                    $('#' + options.ajaxSpinnerId).show();
                                    $('#' + options.contentId).fadeTo("slow", 0.4);
                                    options.recursed = true;
                                    reload(options);

                                }, __refreshInterval);
                            }

                        }, __pause); //can adjust if web service returns too fast

                    }
                });
            }, 0); //force browser async threading
        };
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
        function reload(options) {
            init(options);
        };

        init(options);
    };


})(jQuery);