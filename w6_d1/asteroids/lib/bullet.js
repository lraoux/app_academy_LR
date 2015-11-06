(function () {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  };

  var Bullet = window.Asteroids.Bullet = function (pos, vel, radius, color, game) {
    Asteroids.MovingObject.call(this, pos, vel, radius, color, game);
  };

  window.Asteroids.Util.inherits(Bullet, window.Asteroids.MovingObject);

  Bullet.prototype.collideWith = function (asteroid) {
    if (asteroid instanceof Asteroids.Asteroid) {
      this.remove();
      asteroid.remove();
    }
  };



})();
