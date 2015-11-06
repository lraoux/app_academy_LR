(function(root) {
  'use strict';
  if (typeof root.PokemonConstants === "undefined") {
    root.PokemonConstants = {};
  }

  root.PokemonConstants = {
    POKEMONS_RECEIVED: "POKEMONS_RECEIVED",
    POKEMONS_INDEX_CHANGE_EVENT: "POKEMONS_INDEX_CHANGE_EVENT",
    POKEMON_RECEIVED: "POKEMON_RECEIVED",
    POKEMONS_DETAIL_CHANGE_EVENT: "POKEMONS_DETAIL_CHANGE_EVENT"
   };

}(this));
