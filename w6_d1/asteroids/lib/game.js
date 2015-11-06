(function () {
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Game = window.Asteroids.Game = function (x, y, numAsteroids) {
    this.x = x;
    this.y = y;
    this.numAsteroids = numAsteroids;
    this.asteroids = [];
    this.addAsteroids(numAsteroids);
    this.ship = new window.Asteroids.Ship(this);
    this.asteroids.push(this.ship);
    // this.bullets = [];
    // this.asteroids.concat(this.bullets);
  };

  Game.WIDTH = 500;
  Game.HEIGHT = 500;

  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < this.numAsteroids; i++) {
      var pos = [ Math.floor(Math.random()*Game.WIDTH), Math.floor(Math.random()*Game.HEIGHT) ];
      this.asteroids.push(new window.Asteroids.Asteroid(pos, this));
    }
  };

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, Game.WIDTH, Game.WIDTH);

    this.asteroids.forEach(function(asteroid) {
       asteroid.draw(ctx);
    });
    // this.ship.draw(ctx);

  };

  Game.prototype.moveObjects = function () {
    this.asteroids.forEach(function(asteroid) {
      asteroid.move();
    });
  };

  Game.prototype.wrap = function (pos) {
    if (pos[0] > Game.WIDTH) {
      return [0, pos[1]];
    } else if (pos[1] > Game.HEIGHT){
      return [pos[0], 0];
    } else {
      return pos;
    }
  };

  Game.prototype.checkCollisions = function () {
    for (var i = 0; i < this.asteroids.length; i++) {
      for (var j = i + 1; j < this.asteroids.length; j++) {
        if (this.asteroids[i].isCollidedWith(this.asteroids[j])) {
          this.asteroids[i].collideWith(this.asteroids[j]);
        }
      }
    }
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.remove = function (asteroid) {
    var indexAst = this.asteroids.indexOf(asteroid);
    this.asteroids.splice(indexAst, indexAst + 1);
  };

  Game.prototype.allObjects = function() {
    var everyThing = [];
    everyThing.concat(this.asteroids);
    everyThing.push(this.ship);
    return everyThing;
  };

  Game.prototype.addBullet = function(bullet) {
    this.asteroids.unshift(bullet);
  }
 })();
