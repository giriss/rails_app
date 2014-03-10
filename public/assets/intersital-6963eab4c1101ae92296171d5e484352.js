(function() {
  jQuery(function() {
    var apprise_options, csrf_param, csrf_token;
    csrf_token = $("meta[name=csrf-token]").attr("content");
    csrf_param = $("meta[name=csrf-param]").attr("content");
    $("[data-url]:not(.selected)").click(function() {
      var url;
      url = $(this).attr("data-url");
      return window.location = url;
    });
    apprise_options = {
      buttons: {
        confirm: {
          text: '<span class="ubuntu normal_size">Okie</span>',
          action: function() {
            return Apprise('close');
          }
        }
      }
    };
    if (window.alert_any) {
      Apprise("<span class=\"ubuntu black large\">" + window.alert_desc + "</span>", apprise_options);
    }
    return $("[data-method=post]").click(function(event) {
      var $id_form, url;
      event.preventDefault();
      url = $(this).attr("href");
      $id_form = $("#form");
      $id_form.attr("action", url).attr("method", "post");
      $id_form.html("<input type='hidden' name='" + csrf_param + "' value='" + csrf_token + "' />");
      return $id_form.submit();
    });
  });

}).call(this);
