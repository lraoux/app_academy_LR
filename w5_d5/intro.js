function Clock () {
  // var time = new Date();
  // this.time = new Date();
  this.int = 1000;
}

// var clock = new Clock();
// what is this?
// this is a new object whose prototype is Clock.prototype

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
// new Date(year, month[, day[, hour[, minutes[, seconds[, milliseconds]]]]])
  var hours = this.time.getHours();
  var minutes = this.time.getMinutes();
  var seconds = this.time.getSeconds();
  var time = hours.toString() + ":" + minutes.toString() + ":" + seconds.toString();
  console.log(time);
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  // 2. Call printTime.
  // 3. Schedule the tick interval.
  // console.log(this.printTime());
  this.time = new Date();
  setInterval(this._tick.bind(this), this.int);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // 2. Call printTime.
  this.time.setSeconds(this.time.getSeconds() + (this.int / 1000));
  this.printTime();
};

var clock = new Clock();
clock.run();
