(function() {
  var adjustImgHeight, adjustImgMargin, goto_image, toogleImage;

  adjustImgHeight = function() {
    var height, image, imgs, width, _i, _len, _results;
    imgs = $("#img_div > img");
    _results = [];
    for (_i = 0, _len = imgs.length; _i < _len; _i++) {
      image = imgs[_i];
      if ($(image).height() > 400) {
        $(image).height(400);
        width = $(image).width();
        if (width > 800) {
          $(image).width(800);
        }
        if (width > 800) {
          _results.push($(image).css("height", "auto"));
        } else {
          _results.push(void 0);
        }
      } else if ($(image).width > 800) {
        $(image).width(800);
        height = $(image).height();
        if (height > 400) {
          $(image).height(400);
        }
        if (height > 400) {
          _results.push($(image).css("width", "auto"));
        } else {
          _results.push(void 0);
        }
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  adjustImgMargin = function() {
    var height, image, imgs, margin_top, _i, _len, _results;
    imgs = $("#img_div > img");
    _results = [];
    for (_i = 0, _len = imgs.length; _i < _len; _i++) {
      image = imgs[_i];
      height = $(image).height();
      margin_top = (400 - height) / 2;
      _results.push($(image).css("margin-top", margin_top + "px"));
    }
    return _results;
  };

  window.count = 0;

  toogleImage = function() {
    if (window.count === window.num_imgs - 2) {
      clearInterval(window.hide);
      setTimeout(function() {
        return $("#goto_div").animate({
          "opacity": "1"
        }, 1000);
      }, 1000);
    }
    return $($("#img_div > img")[window.count]).animate({
      "opacity": "0"
    }, 500, function() {
      $($("#img_div > img")[window.count]).addClass("nodisplay");
      $($("#img_div > img")[window.count]).removeClass("current");
      $($("#img_div > img")[window.count + 1]).removeClass("nodisplay");
      $($("#img_div > img")[window.count + 1]).addClass("current");
      $($("#img_div > img")[window.count + 1]).animate({
        "opacity": "1"
      }, 500);
      return window.count = window.count + 1;
    });
  };

  goto_image = function(event) {
    var num, self;
    self = event.currentTarget;
    num = $(self).attr("data-num");
    console.log(num);
    return $("#img_div > img.current").animate({
      "opacity": "0"
    }, 1000, function() {
      $("#img_div > img.current").addClass("nodisplay");
      $("#img_div > img.current").removeClass("current");
      $($("#img_div > img")[num - 1]).removeClass("nodisplay");
      $($("#img_div > img")[num - 1]).addClass("current");
      $("#goto_div > span.current").removeClass("current");
      $(self).addClass("current");
      return $($("#img_div > img")[num - 1]).animate({
        "opacity": "1"
      }, 1000);
    });
  };

  jQuery(function() {
    var $imgs, interval;
    $imgs = $("#img_div > img");
    window.num_imgs = $imgs.length;
    interval = 30000 / num_imgs;
    window.hide = setInterval(toogleImage, interval);
    $imgs.on('load', function() {
      adjustImgHeight();
      return adjustImgMargin();
    });
    return $("#goto_div > span").click(function(event) {
      return goto_image(event);
    });
  });

}).call(this);
