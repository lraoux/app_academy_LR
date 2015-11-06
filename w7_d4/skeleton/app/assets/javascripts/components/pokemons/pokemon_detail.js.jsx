/* global React */

(function(root) {
  'use strict';
  if (typeof root.PokemonDetail === "undefined") {
    root.PokemonDetail = {};
  }

  root.PokemonDetail = React.createClass({
    getInitialState: function() {
      return this.getStateFromStore();
    },
    getStateFromStore: function() {
      var id = parseInt(this.props.params.pokemonId);
      var pokemon = root.PokemonStore.find(id);
      return {pokemon: pokemon};
    },
    setNewState: function () {
      var newPokemon = this.getStateFromStore();
      this.setState(newPokemon);
    },
    componentDidMount: function () {
      root.PokemonStore.addPokemonDetailChangeListener(
        this.setNewState
      );
    },
    componentWillReceiveProps: function() {
      var newId = this.props.params.pokemonId;
      root.ApiUtil.fetchSinglePokemon(newId);
    },
    render: function () {
      var pokemonDetail;
      if (typeof this.state.pokemon === "undefined") {
        pokemonDetail = <div></div>;
      } else {
        pokemonDetail=(
          <div className="detail">
            <img src={this.state.pokemon.image_url}></img>
            <br/>Name: {this.state.pokemon.name}
            <br/>Type: s{this.state.pokemon.poke_type}
            <br/>Attack: {this.state.pokemon.attack}
            <br/>Defense: {this.state.pokemon.defense}
            <br/>Moves: <ul>{
                this.state.pokemon.moves.map(function (move) {
                  return (
                    <li>{move}</li>
                  );
                })
              }
              </ul>
              <ToysIndex toys={this.state.pokemon.toys}/>
          </div>
        );
      }
      return (
        <div>
          {pokemonDetail}
        </div>
       );
    }
  });

}(this));
