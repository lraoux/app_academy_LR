/* global React */
(function(root) {
  'use strict';

  var Key = root.Key = React.createClass({
    getInitialState: function() {
      return ({pressed: false});
    },
    render: function () {
      var bgColor = this.state.pressed ? "yellow" : "white";
      return(
        <div style={{float:'left',
                     margin:'10px',
                     backgroundColor: bgColor,
                     height:'100px',
                     width: '18px',
                     border: '1px solid black',
                     borderRadius: '4px 4px 0px 0px'}}>
          {this.props.noteName}
        </div>

      );
    },
    _keysChanged: function() {
      var keys = root.KeyStore.all();
      if (keys.indexOf(this.props.noteName) !== -1) {
        this.note.start();
        this.setState({pressed: true});
      }else {
        this.note.stop();
        this.setState({pressed: false});
      }
    },
    componentDidMount: function () {
      var freq = root.TONES[this.props.noteName];
      this.note = new root.Note(freq);
      root.KeyStore.addChangeHandler(this._keysChanged);
    }
  });

}(this));
