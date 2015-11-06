(function($) {

  $.TweetCompose = function(form) {
    this.$form = $(form);
    this.$form.on("submit", this.submit.bind(this));

  };

  $.TweetCompose.prototype.submit = function(event) {
    event.preventDefault();
    var formData = this.$form.serializeJSON();
    this.$form.find(":input").prop('disabled', true);
    $.ajax({
      type: "POST",
      url: "/tweets",
      data: formData,
      dataType: 'json',
      success: function(response) {
        this.clearInput();
        console.log(response);
        this.$form.find(":input").prop('disabled', false);
      }.bind(this)
    });
  };

  $.TweetCompose.prototype.handleSuccess = function(tweet) {
    var tweetFeed = this.$form.data("tweet-ul");
    var userLink = $('<a></a>');
    var tweetLi = $('<li>'+ tweet.content + '--</li>');


  };

  $.TweetCompose.prototype.clearInput = function() {
    this.$form.find("textarea").val("");
    this.$form.find("option").prop('selected', false);
  };

  $.fn.tweetCompose = function() {
    this.each(function() {
      new $.TweetCompose(this);
    });
  };

  $(function() {
    $('form.tweet-compose').tweetCompose();
  });
}(jQuery));
