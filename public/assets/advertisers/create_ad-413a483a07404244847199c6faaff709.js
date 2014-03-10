(function() {
  var toogle_url;

  toogle_url = function(val) {
    var $create_ad_commit, $create_ad_form, $create_ad_url, $url_tr;
    $create_ad_url = $("#create_ad_url");
    $url_tr = $("#url_tr");
    $create_ad_commit = $("#create_ad_commit");
    $create_ad_form = $("#create_ad_form");
    if (val === "2") {
      $url_tr.addClass("nodisplay");
      return $create_ad_url.val("");
    } else {
      $url_tr.removeClass("nodisplay");
      return $create_ad_url.val("");
    }
  };

  $(document).ready(function() {
    var csrf_param, csrf_token;
    csrf_token = $("meta[name=csrf-token]").attr("content");
    csrf_param = $("meta[name=csrf-param]").attr("content");
    $(".delete").click(function(event) {
      var $id_form, id, url;
      event.preventDefault();
      event.stopPropagation();
      if (window.confirm("Are you sure to delete this advert?")) {
        id = $(this).attr("data-id");
        url = "/advertiser/destroy_ad/" + id;
        $id_form = $("#form");
        $id_form.attr("action", url).attr("method", "post");
        $id_form.html("<input type='hidden' name='" + csrf_param + "' value='" + csrf_token + "' />");
        return $id_form.submit();
      }
    });
    $("#create_ad_now_button").click(function() {
      $("#ad_count_num_div").addClass("nodisplay");
      return $("#create_ad_div").removeClass("nodisplay");
    });
    $("#create_ad_cancel_button").click(function(event) {
      event.preventDefault();
      $("#ad_count_num_div").removeClass("nodisplay");
      return $("#create_ad_div").addClass("nodisplay");
    });
    return $("#create_ad_type").change(function() {
      return toogle_url($(this).val());
    });
  });

  $(window).bind("load", function() {
    $("body").css("visibility", "visible");
    if ($(window).height() > 75 + 30 + $("#body").outerHeight() + 20 + 164) {
      return $("footer").height($(window).height() - (75 + 30 + $("#body").outerHeight() + 20));
    }
  });

}).call(this);
