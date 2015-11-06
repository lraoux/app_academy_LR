$.Tabs = function (el) {
  this.$el = $(el);
  var selector = this.$el.data('content-tabs');
  this.$contentTabs = $(selector);
  this.$activeTab = this.$el.find(".active");
  var that = this;
  this.$el.on('click', 'a', function(e) {
    e.preventDefault();
    that.clickTab(e);
 });
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};

$.Tabs.prototype.clickTab = function(e){
  this.$activeTab.removeClass("active");
  var $oldArticle = $(this.$activeTab.attr('href'));
  $oldArticle.addClass("transitioning");
  $oldArticle.removeClass("active");
  var that = this;
  $oldArticle.one("transitionend", function() {
    $oldArticle.removeClass("transitioning");
    var $newTab = $(e.currentTarget);
    that.$activeTab = $newTab;
    that.$activeTab.addClass("active");

    var $newArticle = $($newTab.attr('href'));
    $newArticle.addClass("transitioning");
    $newArticle.addClass("active");

    window.setTimeout(function() {
      $newArticle.removeClass("transitioning");
    } ,0);
  });
};
