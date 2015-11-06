/* global React, AppDispatcher, PokemonConstants */
(function(root) {
  'use strict';
  if (root.ToysIndexItem === "undefined") {
    root.ToysIndexItem = {};
  }

  root.ToysIndexItem = React.createClass({
    render: function () {
      console.log(this.props.toy);
      // var toyDiv;
      // if (typeof this.props.toy === "undefined") {
      //   toyDiv = <li></li>;
      // } else {
      //   toyDiv = <li className="toy-list-item">{this.props.toy}</li>;
      // }
      return (
        <li className="toy-list-item">{this.props.toy}</li>
      );
    }
  });

}(this));
