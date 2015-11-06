(function (root) {
  var _keys = [];

  root.KeyStore = $.extend({}, root.EventEmitter.prototype, {
    all: function() {
      return _keys.slice();
    },
    changed: function() {
      root.KeyStore.emit(root.KeyConstants.CHANGE_EVENT);
    },
    addChangeHandler: function(handler) {
      root.KeyStore.on(root.KeyConstants.CHANGE_EVENT, handler);
    }


  });

  var addKey = function(noteName) {
    _keys.push(noteName);
    root.KeyStore.changed();
  };

  var removeKey = function(noteName) {
    var idx = _keys.indexOf(noteName);
    _keys.splice(idx, 1);
    root.KeyStore.changed();
  };

  var resetKeys = function(noteNames) {


  };

  root.AppDispatcher.register(function(action){
    switch(action.actionType) {
      case root.KeyConstants.ADD_KEY:
        addKey(action.noteName);
        break;
      case root.KeyConstants.REMOVE_KEY:
        removeKey(action.noteName);
        break;
      case root.KeyConstants.RESET_KEYS:
        resetKeys(action.noteName);
        break;
    }
  });



})(this);
