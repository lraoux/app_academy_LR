/* global ApiActions */
(function(root) {
  'use strict';
  if (root.ApiUtil  === "undefined") {
    root.ApiUtil = {};
  }

  root.ApiUtil = {
    fetchAllPokemons: function() {
      $.ajax({
        url: 'api/pokemon',
        type: "GET",
        dataType: 'json',
        success: function(result) {
          ApiActions.receiveAllPokemons(result);
        }
      });
    },
    fetchSinglePokemon: function(id) {
      $.ajax({
        url: 'api/pokemon/' + id,
        type: "GET",
        dataType: 'json',
        success: function(result) {
          ApiActions.receiveSinglePokemon(result);
        }
      });

    }
  };



}(this));
