
(function($) {

  $.FollowToggle = function(el, options) {
    this.$button = $(el);
    this.userId = options.userId || this.$button.data('user-id');
    this.followState = options.followState || this.$button.data('initial-follow-state');
    this.render();
    this.$button.on("click", this.handleClick.bind(this));
    //try without this
  };

  $.FollowToggle.prototype.render = function() {
    if (this.followState === 'following' ) {
      this.$button.prop('disabled', true);
      this.$button.html("Following");
    } else if(this.followState ==='unfollowing') {
      this.$button.prop('disabled', true);
      this.$button.html("Unfollowing");
    } else if (this.followState === 'unfollowed') {
      this.$button.prop('disabled', false);
      this.$button.html("Follow!");
    } else if(this.followState === 'followed') {
      this.$button.prop('disabled', false);
      this.$button.html("Unfollow!");
    }
  };

  $.FollowToggle.prototype.handleClick = function(event) {
      event.preventDefault();
      var method = (this.followState === "unfollowed") ? "POST" : "DELETE";
      var targetUrl = "/users/" + this.userId + "/follow";
      if (method === "POST") {
        this.followState = 'following';
      } else {
        this.followState = 'unfollowing';
      }
      this.render();
      $.ajax({
        type: method,
        url: targetUrl,
        dataType: 'json',
        success: function(response) {
          this.toggleFollowState();
          this.render();
        }.bind(this)

      });
  };

  $.FollowToggle.prototype.toggleFollowState = function() {
    if (this.followState === 'unfollowing') {
      this.followState = "unfollowed";
    } else if (this.followState === 'following') {
      this.followState = "followed";
    }

  };


  $.fn.followToggle = function(options) {
    this.each(function() {
      new $.FollowToggle(this, options);
    });
    return this;
  };

$(function() {
  $("button.follow-toggle").followToggle();
});
}(jQuery));
