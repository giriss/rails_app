(function() {
  var adjustSizes, coutdownDone, isGreater, returnGreater;

  isGreater = function(num1, num2) {
    return num1 > num2;
  };

  returnGreater = function(num1, num2) {
    if (num1 >= num2) {
      return num1;
    } else {
      return num2;
    }
  };

  adjustSizes = function() {
    var $ad_div, window_height, window_width;
    window_width = $(window).innerWidth();
    $("#publisher_ad_div").innerWidth(window_width - 300);
    $ad_div = $("#publisher_ad_div");
    window_height = $(window).height();
    $ad_div.height(window_height - 75);
    $("#ad_iframe").width(window_width - 300).height(window_height - 75);
    return $("#official_sponsors_div").css({
      "max-height": window_height - 75 + "px"
    });
  };

  $(window).bind("load", function() {
    adjustSizes();
    window.setTimeout(adjustSizes, 1);
    return window.setTimeout(adjustSizes, 2);
  });

  coutdownDone = function() {
    $("#goto_site").removeAttr("disabled");
    $("#countdown_div").html("");
    return $.post("/intersital/request_campaign", {
      authenticity_token: window._csrf_token_
    }, function(json) {
      $("#question_div").html(json.question + "?");
      $("#answers_div").html("");
      return $.each(json.options, function(key, value) {
        var color, i;
        i = key + 1;
        color = function(num) {
          if (num % 2 === 0) {
            return "_cyan";
          } else {
            return "_blue";
          }
        };
        return $("#answers_div").append("<div class=\"answer_div\"><a data-number=\"" + i + "\" class=\"answer_a " + color(i) + " elevated_button\">" + i + ". " + value + "</a></div>");
      });
    });
  };

  jQuery(function() {
    var csrf_param, csrf_token, decrement_time;
    window._csrf_token_ = $("meta[name=csrf-token]").attr("content");
    window._csrf_param_ = $("meta[name=csrf-param]").attr("content");
    csrf_token = $("meta[name=csrf-token]").attr("content");
    csrf_param = $("meta[name=csrf-param]").attr("content");
    adjustSizes();
    $("body").css("visibility", "visible");
    $(window).resize(function() {
      return adjustSizes();
    });
    $("#goto_site").click(function(event) {
      $("#question_answer_outer_div").css("display", "block");
      return $("#question_answer_div_close").css("display", "block");
    });
    $("#question_answer_div_close").click(function(event) {
      $("#question_answer_outer_div").css("display", "none");
      return $(this).css("display", "none");
    });
    $("#question_answer_inner_div").height($(window).innerHeight() - 100);
    $("#question_answer_inner_inner_div").height($(window).innerHeight() - 120);
    decrement_time = window.setInterval(function() {
      $("#countdown_span").html(parseInt($("#countdown_span").html()) - 1);
      if ($("#countdown_span").html() === "0") {
        window.clearInterval(decrement_time);
      }
      if ($("#countdown_span").html() === "0") {
        return coutdownDone();
      }
    }, 1000);
    return window.setTimeout(function() {
      return $.post("/intersital/request_campaign", {
        authenticity_token: csrf_token
      }, function(json) {
        return $.each(json, function(key, value) {
          return console.log("Key: " + key + "; Value: " + value);
        });
      });
    }, 29000);
  });

}).call(this);
