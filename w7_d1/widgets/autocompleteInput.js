var React = window.React;
var ReturnClass = React.createClass({
  render: function () {
    return (
      <ul>
      {
        this.props.matches.map(function(name) {
          return <li key={name}>{name}</li>;
        })
      }
      </ul>
    );
  }
});

var Autocomplete = React.createClass({

  getInitialState: function() {
    return {names: ["bob", "susie", "barry", "schmidt", "minh", "akansh"], matchesAry: []};
  },

  handleUserInput: function(e){
    var searchString = e.currentTarget.value;
    var matches = [];
    this.state.names.forEach (function(name) {
      var endIdx = searchString.length;
      if ((searchString.length !== 0) && (name.slice(0, endIdx) === searchString)) {
        matches.push(name);
      }
    });
    this.setState({matchesAry: matches});
  },

  render: function () {
    return (
      <div>
        <input id="input"
               type="text"
               name="user-input"
               onInput={this.handleUserInput}/>
        <ReturnClass matches={this.state.matchesAry}/>
      </div>
    );
  }
});

React.render(
  <Autocomplete/>,
  document.getElementById('autocomplete-input')
);
