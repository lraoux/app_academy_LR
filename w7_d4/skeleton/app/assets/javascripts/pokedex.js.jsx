/* global React, PokemonsIndex, ReactRouter, PokemonDetail, Index */
var Router = ReactRouter.Router;
var Route = ReactRouter.Route;

var route = (
  <Route path="/" component={Index}>
    <Route path="pokemon/:pokemonId" component={PokemonDetail}/>
    <Route path="/pokemon/:pokemonId/toys/:toyId" component={ToysIndexItem}/>
  </Route>
);
// <Route path="pokemon/:pokemonId" component={PokemonDetail}/>

$(document).ready(function () {
  React.render(
    <Router>
      {route}
    </Router>,
    document.getElementById("pokedex")
  );
});
