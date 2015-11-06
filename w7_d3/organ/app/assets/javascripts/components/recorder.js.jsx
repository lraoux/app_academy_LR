/* global React */
(function(root) {
  'use strict';

  var Recorder = root.Recorder = React.createClass({
    getInitialState: function () {
      return({isRecording: false, track: new root.Track()});
    },
    handleClick: function (e) {
      e.preventDefault();
      if (this.state.isRecording) {
        console.log(this.state.track);
        this.state.track.stopRecording();
        this.setState({isRecording: false});
      } else {
        this.state.track.startRecording();
        this.setState({isRecording: true});
      }
    },
    updateTrack: function () {
      var notes = root.KeyStore.all();
      this.state.track.addNotes(notes);
    },
    componentDidMount: function () {
      root.KeyStore.addChangeHandler(this.updateTrack);
    },
    render: function () {
      var buttonVal = this.state.isRecording ? "Stop" : "Start";
      return(
        <button onClick={this.handleClick}>{buttonVal}</button>
      );
    }
  });
}(this));
