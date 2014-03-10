(function() {
  var adjust_image_height, adjust_image_upload, remove_img, show_image, show_preview, temp_save;

  adjust_image_height = function() {
    var $image, height, width;
    $image = $("#image_div > div > img:last-child");
    if ($image.height() > 400) {
      $image.height(400);
      width = $image.width();
      if (width > 800) {
        $image.width(800);
      }
      if (width > 800) {
        return $image.css("height", "auto");
      }
    } else if ($image.width > 800) {
      $image.width(800);
      height = $image.height();
      if (height > 400) {
        $image.height(400);
      }
      if (height > 400) {
        return $image.css("width", "auto");
      }
    }
  };

  show_image = function(event) {
    var height, margin_left, margin_up, self, width;
    self = event.currentTarget;
    $("#image_div > div > img:last-child").attr("src", "/images/uploads/" + $(self).attr("data-value"));
    $("#image_div > div").css({
      "height": $(window).height() - 100 + "px",
      "width": $(window).width() - 100 + "px"
    });
    height = $("#image_div > div").height();
    width = $("#image_div > div").width();
    margin_up = (height - 20) / 2;
    margin_left = (width - 160) / 2;
    $("#image_div > div > img:first-child").css("margin", margin_up + "px 0 0 " + margin_left + "px");
    $("#image_div > div > img:last-child").bind('load', function() {
      var image_height, image_width;
      adjust_image_height();
      $("#image_div > div > img:first-child").addClass("nodisplay");
      $("#image_div > div > img:last-child").css("display", "block");
      image_height = $("#image_div > div > img:last-child").height();
      image_width = $("#image_div > div > img:last-child").width();
      margin_up = (height - image_height) / 2;
      margin_left = (width - image_width) / 2;
      return $("#image_div > div > img:last-child").css("margin", margin_up + "px 0 0 " + margin_left + "px");
    });
    $("#image_div").css("display", "block");
    return $("#image_div_close").css("display", "block");
  };

  show_preview = function() {
    var height, margin_left, margin_up, width;
    $("#ad_iframe").attr("src", window.preview_link);
    $("#preview_div > div").css({
      "height": $(window).height() - 100 + "px",
      "width": $(window).width() - 100 + "px"
    });
    height = $("#preview_div > div").height();
    width = $("#preview_div > div").width();
    margin_up = (height - 20) / 2;
    margin_left = (width - 160) / 2;
    $("#preview_div > div > img").css("margin", margin_up + "px 0 0 " + margin_left + "px");
    $("#ad_iframe").bind('load', function() {
      $("#preview_div > div > img").addClass("nodisplay");
      return $("#ad_iframe").css("display", "block");
    });
    $("#preview_div").css("display", "block");
    return $("#preview_div_close").css("display", "block");
  };

  temp_save = function() {
    $("#design_ad_form").attr("action", "/advertiser/create_ad_preview");
    return $("#design_ad_form").submit();
  };

  adjust_image_upload = function() {
    var $file_input, $tr, filename, images, images_array, num, path, remove_1, remove_2, uploaded_images, _i, _len, _ref;
    images = {
      "_0": "",
      "_1": "",
      "_2": "",
      "_3": "",
      "_4": "",
      "_5": ""
    };
    uploaded_images = [];
    _ref = $("#design_ad_form tr[data-num]");
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      $tr = _ref[_i];
      $file_input = $($tr).children("td").children("div").children("input[type=file]");
      if ($file_input.val() !== "" || ($file_input.attr("data-value") !== void 0 && $file_input.attr("data-value") !== "")) {
        if ($file_input.attr("data-value") !== void 0 && $file_input.attr("data-value") !== "") {
          num = $file_input.attr('data-num');
          filename = $file_input.attr("data-value");
          images['_'.concat(num)] = "<span class=\"green uploaded_image\" data-value=\"" + filename + "\">&rarr;&nbsp;" + filename + "</span>";
          $($tr).addClass("nodisplay");
          uploaded_images.push("<input type=\"hidden\" name=\"design_ad[uploaded_image[" + num + "]]\" value=\"" + filename + "\" />");
        } else {
          num = $file_input.attr('data-num');
          path = $file_input.val();
          filename = path.split("\\")[path.split("\\").length - 1];
          images['_'.concat(num)] = filename;
          $($tr).addClass("nodisplay");
        }
      } else {
        $("#design_ad_form tr[data-num]").addClass("nodisplay");
        $($tr).removeClass("nodisplay");
      }
    }
    $("#design_ad_form #hidden_input_div").html(uploaded_images.join(" "));
    remove_1 = "&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"remove_img\" data-num=\"";
    remove_2 = "\">remove</span>";
    images_array = $.map(images, function(value, index) {
      if (value !== "") {
        return [value + remove_1 + index.substring(1, 2) + remove_2];
      }
    });
    $("#image_list_div").html(images_array.join("<br />"));
    if ($("#image_list_div").html() === "") {
      $("#image_list_div").addClass("nodisplay");
    }
    if ($("#image_list_div").html() !== "") {
      $("#image_list_div").removeClass("nodisplay");
    }
    return $(".remove_img").on("click", function(event) {
      return remove_img(event);
    });
  };

  remove_img = function(event) {
    var num, self;
    self = event.currentTarget;
    num = $(self).attr("data-num");
    $("input[type=file][data-num=" + num + "]").val("");
    $("input[type=file][data-num=" + num + "]").removeAttr("data-value");
    return adjust_image_upload();
  };

  $(function() {
    $("body").css("visibility", "visible");
    adjust_image_upload();
    $("#discard_button").click(function(event) {
      event.preventDefault();
      return location.reload();
    });
    $("#design_ad_form input[type=file]").change(function() {
      return adjust_image_upload();
    });
    $(".remove_img").click(function(event) {
      return remove_img(event);
    });
    $("#design_ad_description").keyup(function() {
      var length, num_remaining;
      length = $(this).val().length;
      num_remaining = 255 - length;
      $("#num_remaining > span").html(num_remaining);
      if (num_remaining < 0) {
        $(this).val($(this).val().substring(0, 255));
        return $("#num_remaining > span").html(0);
      }
    });
    $("#preview_div_close").click(function() {
      $(this).css("display", "none");
      $("#preview_div").css("display", "none");
      return $("#preview_div").remove();
    });
    $("#image_div_close").click(function() {
      $(this).css("display", "none");
      $("#image_div").css("display", "none");
      $("#image_div > div > img:last-child").attr("src", "");
      $("#image_div > div > img:last-child").css("height", "auto");
      return $("#image_div > div > img:last-child").css("width", "auto");
    });
    $("#preview_button").click(function(event) {
      event.preventDefault();
      return temp_save();
    });
    $(".uploaded_image").click(function(event) {
      return show_image(event);
    });
    if ($("#preview_div").length === 1) {
      return show_preview();
    }
  });

  $(window).bind("load", function() {
    if ($(window).height() > 75 + 30 + $("#body").outerHeight() + 20 + 164) {
      return $("footer").height($(window).height() - (75 + 30 + $("#body").outerHeight() + 20));
    }
  });

}).call(this);
