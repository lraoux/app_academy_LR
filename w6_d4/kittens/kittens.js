$.Carousel = function(el) {
  this.$el = $(el);
  this.activeIdx = 0;
  var that = this;
  // this.transitioning = false;
  // only manipulate DOM inside $el
  this.$el.on("click", "button", function(e) {
    that.slide(e);
  });

  // make a function on the Carousel prototype to slide
};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};

$.Carousel.prototype.slide = function(e) {
  var $currentPhoto = this.$el.find('.active');
  if (this.transitioning) {
    return;
  }

  this.transitioning = true;
  // $currentPhoto.removeClass("left");
  // $currentPhoto.removeClass("right");
  // var $newPhoto = null;
  // $currentPhoto.removeClass("active");

  // right         active
// 1.                A
// 2. AR             AL
// 3. settimeout
//    A             L



  if (e.currentTarget.className === "slide-right") {
    $currentPhoto.addClass("left");
    var that = this;
    $currentPhoto.one("transitionend", function() {
      $currentPhoto.removeClass("left");
      $currentPhoto.removeClass("active");
      that.transitioning = false;
    });
    if (this.activeIdx === 0) {
      this.activeIdx = $('.items').children().length - 1;
    } else {
      this.activeIdx -= 1;
    }
    var $newPhoto = $('ul').children().eq(this.activeIdx);
    $newPhoto.addClass("active");
    $newPhoto.addClass("right");
  } else {
    $currentPhoto.addClass("right");
    var that = this;
    $currentPhoto.one("transitionend", function() {
      $currentPhoto.removeClass("right");
      $currentPhoto.removeClass("active");
      that.transitioning = false;
    });
    if (this.activeIdx === $('.items').children().length - 1)
    {
      this.activeIdx = 0;
    } else
    {
      this.activeIdx += 1;
    }
    var $newPhoto = $('ul').children().eq(this.activeIdx);
    $newPhoto.addClass("active");
    $newPhoto.addClass("left");
  }

  // must move this to the transitionend callback to make this work properly 
  window.setTimeout(function() {
    $newPhoto.removeClass("left");
    $newPhoto.removeClass("right");
  } ,0);

};
