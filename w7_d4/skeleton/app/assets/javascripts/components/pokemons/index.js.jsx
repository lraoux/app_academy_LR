/* global React, PokemonsIndex, PokemonsIndexItem */

(function(root) {
  'use strict';
  if (typeof root.PokemonsIndex === "undefined") {
    root.PokemonsIndex = {};
  }

  root.PokemonsIndex = React.createClass({
    getInitialState: function() {
      return ({pokemons: []});
    },
    componentDidMount: function () {
      root.ApiUtil.fetchAllPokemons();
      root.PokemonStore.addPokemonsIndexChangeListener(
        this._onChange
      );
    },
    componentWillUnmount: function () {
      root.PokemonStore.removePokemonsIndexChangeListener(
        this._onChange
      );
    },
    _onChange: function () {
      var pokemons = root.PokemonStore.all();
      this.setState({pokemons: pokemons});
    },
    render: function () {
      return (
        <ul>
          {this.state.pokemons.map(function(pokemon){
            return(<PokemonsIndexItem key={pokemon.id} pokemon={pokemon} />);
          })}
        </ul>
      );
    }

  });

  root.Index = React.createClass({
    render: function(){
      return(
        <div>
          <div className="pokemon-index">
            <PokemonsIndex />
          </div>
          {this.props.children}
        </div>
      );

    }

  });

}(this));
              // <PokemonsIndex />
