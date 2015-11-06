(function(root) {
  'use strict';

  var KEYS = {
    65: "C4",
    83: "D4",
    68: "E4",
    70: "F4",
    71: "G4",
    72: "A4",
    74: "B4"
  };

  var KeyListener = root.KeyListener = {
    keyPressed: function (noteName) {
      root.KeyActions.addKey(noteName);
    },
    keyReleased: function (noteName) {
      root.KeyActions.removeKey(noteName);
    }
  };

  document.addEventListener('keydown', function(e){
    console.log("KEYINGDOWN!");
    e.preventDefault();
    var asciiKey = e.keyCode;
    KeyListener.keyPressed(KEYS[asciiKey]);
  });

  document.addEventListener('keyup', function(e){
    console.log("KEYINGUP!");
    e.preventDefault();
    var asciiKey = e.keyCode;
    KeyListener.keyReleased(KEYS[asciiKey]);
  });

}(this));
