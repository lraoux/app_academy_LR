/* global React */
(function(root) {
  'use strict';

  var Organ = root.Organ = React.createClass({
    render: function () {
      return(
        <div style={{height: '110px',
                     width: '280px',
                     backgroundColor:'darkgray',
                     borderRadius: '5px',
                     padding: '10px 10px 0px 10px'}}>
          {
            root.TONES_ARR.map(function (noteName) {
              return (
                <root.Key
                  key={noteName}
                  noteName={noteName} />
              );
            })
          }
          <root.Recorder />
        </div>
      );
    }
  });

}(this));
