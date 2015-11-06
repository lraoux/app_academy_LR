(function(root) {
  'use strict';

  var Track = root.Track = function(attributes) {
    attributes = attributes || {name: "", roll: []};
    this.name = attributes.name;
    this.roll = attributes.roll;
    this.interval = 0;
  };

  Track.prototype.startRecording = function () {
    this.roll = [];
    this.recordingStartTime = new Date();
  };

  Track.prototype.addNotes = function (notes) {
    this.roll.push({
      time: new Date() - this.recordingStartTime,
      notes: notes
    });
  };

  Track.prototype.stopRecording = function () {
    this.addNotes([]);
  };

  Track.prototype.play = function () {
    if (this.interval) {return;}
    var playbackStartTime = Date.now();
    var currentNote = 0;
    var playTick = function () {
      if (currentNote < this.state.roll.length) {
        var diff = Date.now() - playbackStartTime;
        if (diff > this.state.roll[currentNote].time) {
          
          currentNote += 1;
        }
      }

    };
    this.interval = setInterval(playTick, 50);
  };
}(this));
