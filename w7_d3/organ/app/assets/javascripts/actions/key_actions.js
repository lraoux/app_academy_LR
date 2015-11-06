(function(root) {
  'use strict';

  var KeyActions = root.KeyActions = {
    addKey: function(noteName) {
      root.AppDispatcher.dispatch({
        actionType: root.KeyConstants.ADD_KEY,
        noteName: noteName
      });
    },
    removeKey: function(noteName) {
      root.AppDispatcher.dispatch({
        actionType: root.KeyConstants.REMOVE_KEY,
        noteName: noteName
      });
    },
    resetKeys: function(noteNames) {
      root.AppDispatcher.dispatch({
        actionType: root.KeyConstants.RESET_KEYS,
        noteNames: noteNames
      });

    }
  };

}(this));
