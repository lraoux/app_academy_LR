(function(React) {
  var Header = React.createClass({

    myFun: function(idx) {
      console.log(this.props.titles[idx]);
    },

    render: function(){
      var that = this;

      return (
        <ul> {
          this.props.titles.map(function(title, idx) {
            if (idx === this.props.chosen) {
              var bold = {fontWeight:'bold'};
            } else {
              var bold = {};
            }
            return(
              <li
                style={bold}
                onClick={ that.props.onTabSelected.bind(null, idx) }
                key={title}>
                {title}
              </li>
            );
          }.bind(this))
        } </ul>
      );
    }
  });

var Tab = React.createClass({
  getInitialState: function(){
    return ({ chosen: 0 });
  },

  selectTab: function(idx) {
    this.setState({chosen: idx});
  },

  render: function(){
    var chosenContent = this.props.tabs[this.state.chosen].content;
    var titles = this.props.tabs.map(function(obj) {return obj.title;});
    return (
      <div className = "Tabs">
        <Header
          chosen={ this.state.chosen }
          titles={ titles }
          onTabSelected={ this.selectTab }/>
        <article>
          {this.props.tabs[this.state.chosen].content}
        </article>
      </div>);
  }
});
var tabs = [
  {title: "Corgi", content: "Corgis are cute"},
  {title: "Meow", content: "I am cat."},
  {title: "Moo", content: "Cows are cute too."}
];

React.render(
  <Tab tabs={ tabs }/>,
  document.getElementById('tabs')
);
})(window.React);
