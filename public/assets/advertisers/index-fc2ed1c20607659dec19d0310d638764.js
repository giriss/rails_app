(function() {
  $(function() {});

  $(window).bind("load", function() {
    $("body").css("visibility", "visible");
    if ($(window).height() > 75 + 30 + $("#body").outerHeight() + 20 + 164) {
      return $("footer").height($(window).height() - (75 + 30 + $("#body").outerHeight() + 20));
    }
  });

}).call(this);
