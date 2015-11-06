/* global EventEmitter */
(function(root) {
  'use strict';
  if (typeof root.PokemonStore === "undefined") {
    root.PokemonStore = {};
  }

  var _pokemons = [],
      resetPokemons = function(pokemons) {
        _pokemons = pokemons;
      },
      resetSinglePokemon = function(pokemon) {
        for (var i = 0; i < _pokemons.length; i++) {
          if (_pokemons[i].id === pokemon.id) {
            _pokemons.splice(i, 1, pokemon);
          }
        }
      };

  root.PokemonStore = $.extend( {}, EventEmitter.prototype , {
    all: function () {
      return _pokemons.slice();
    },
    addPokemonsIndexChangeListener: function (callback) {
      this.on(
        root.PokemonConstants.POKEMONS_INDEX_CHANGE_EVENT,
        callback
      );
    },
    addPokemonDetailChangeListener: function (callback) {
      this.on(
        root.PokemonConstants.POKEMONS_DETAIL_CHANGE_EVENT,
        callback
      );
    },
    find: function(id) {
      for (var i = 0; i < _pokemons.length; i++) {
        if (id === _pokemons[i].id) {
          return _pokemons[i];
        }
      }
    },
    removePokemonsIndexChangeListener: function (callback) {
      this.removeListener(
        root.PokemonConstants.POKEMONS_INDEX_CHANGE_EVENT,
        callback
      );
    }
  });

  root.AppDispatcher.register(function(action){
    switch(action.actionType){
      case root.PokemonConstants.POKEMONS_RECEIVED:
        resetPokemons(action.pokemons);
        root.PokemonStore.emit(root.PokemonConstants.POKEMONS_INDEX_CHANGE_EVENT);
        break;
      case root.PokemonConstants.POKEMON_RECEIVED:
        resetSinglePokemon(action.pokemon);
        root.PokemonStore.emit(root.PokemonConstants.POKEMONS_DETAIL_CHANGE_EVENT);
        break;
    }
  });


}(this));
