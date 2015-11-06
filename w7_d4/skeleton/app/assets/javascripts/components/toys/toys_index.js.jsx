/* global React, AppDispatcher, PokemonConstants */
(function(root) {
  'use strict';
  if (root.ToysIndex === "undefined") {
    root.ToysIndex = {};
  }

  root.ToysIndex = React.createClass({
    // mixins: [ReactRouter.History],
    // showDetail: function () {
    //   this.history.pushState(null, "pokemon/" + this.props.pokemon.id)
    // },
    //
    // showToy: function() {
    //   this.history.pushState(null, )
    // },
    render: function () {
      if (typeof this.props.toys === "undefined") {
        return <ul></ul>;
      } else {
        return (
          <ul>
          {
            this.props.toys.map(function (toy) {
              return <ToysIndexItem key={toy.id} toy={toy}/>;
            })
          }
          </ul>
        );
      }
    }
  });

}(this));
