var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame () {
  this.stacks = [[3,2,1], [], []];
}

HanoiGame.prototype.isWon = function () {
  if (this.stacks[0].length === 0 && (this.stacks[1].length === 3 || this.stacks[2].length === 3)){
    return true;
  }
  else if (this.stacks[0].length > 0) {
    return false;
  }
};

HanoiGame.prototype.isValidMove = function (startTower, endTower) {
  if (this.stacks[startTower].length === 0) {
    return false;
  }
  else if  (this.stacks[endTower].length === 0 || (this.stacks[startTower][startTower.length - 1] < this.stacks[endTower][endTower.length -1])) {
    return true;
  }
  else {
    return false;
  }
};

HanoiGame.prototype.move = function (startTower, endTower) {
  if (this.isValidMove(startTower, endTower)) {
    this.stacks[endTower].push(this.stacks[startTower].pop());
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function() {
  console.log("stacks:" + JSON.stringify(this.stacks));
};

HanoiGame.prototype.promptMove = function(reader, callback) {
  this.print();

  reader.question("What stack to move from?", function (startmove) {
    reader.question("What stack to move to?", function (endmove) {
      callback(parseInt(startmove), parseInt(endmove));
     });
  });
};

HanoiGame.prototype.run = function (reader, completionCallback) {
  // this.promptMove(reader, (function (startmove, endmove) {
  //   if (!this.move(startmove, endmove)) {
  //     console.log("Invalid move!");
  //   }

  if (this.promptMove(reader, this.move) === false) {
    console.log("ERROR!");
  }
  if (this.isWon) {
    console.log("YOU HAVE WON!");
    this.completionCallback();
  } else {
    this.run(reader, completionCallback);
  }
};

HanoiGame.prototype.completionCallback = function () {
  reader.close();
};

var hanoi = new HanoiGame();
hanoi.run(reader, this.completionCallback);

module.exports = HanoiGame;
