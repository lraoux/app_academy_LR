/* global AppDispatcher, PokemonConstants */
(function(root) {
  'use strict';
  if (root.ApiActions === "undefined") {
    root.ApiActions = {};
  }

  root.ApiActions = {
    receiveAllPokemons: function (pokemon) {
      AppDispatcher.dispatch({
        actionType: PokemonConstants.POKEMONS_RECEIVED,
        pokemons: pokemon
      });
    },
    receiveSinglePokemon: function(pokemon) {
      AppDispatcher.dispatch({
        actionType: PokemonConstants.POKEMON_RECEIVED,
        pokemon: pokemon
      });
    }
  };

}(this));
