
(function($) {
  $.UsersSearch = function(el) {
    this.$el = $(el);
    this.$input = this.$el.find('input');
    this.$ul = this.$el.find('.users');
    this.$input.on("keyup", this.handleInput.bind(this));

  };

  $.UsersSearch.prototype.handleInput = function (event) {
    var method = "GET";
    var targetUrl = "/users/search";
    var searchString = this.$input.val();
    $.ajax ({
      type: method,
      url: targetUrl,
      dataType: 'json',
      data: { query: searchString },
      success: this.renderResults.bind(this)
    });
  };

  $.UsersSearch.prototype.renderResults = function(users) {
    this.$ul.empty();
    users.forEach(function(user) {
      var li = $('<li>');
      var button = $('<button class="follow-toggle"></button>');
      var followedState = (user.followed) ? "followed" : "unfollowed";
      var buttonOptions = { userId: user.id, followState: followedState };
      button.followToggle(buttonOptions);
      li.html(user.username);
      li.append(button);
      this.$ul.append(li);
    }.bind(this));

  };

  $.fn.usersSearch = function() {
    this.each(function() {
      new $.UsersSearch(this);
    });
    return this;
  };

  $(function() {
    $("div.users-search").usersSearch();
  });

}(jQuery));
