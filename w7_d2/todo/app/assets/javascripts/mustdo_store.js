(function(mustdolist) {
  'use strict';

  var _mustdos = [];
  var _callbacks = [];

  mustdolist.MustdoStore = {
    changed: function() {
      _callbacks.forEach(function(callback){
        callback.call(this);
      });
    },
    addChangedHandler: function(callback) {
      _callbacks.push(callback);
    },
    removeChangedHandler: function(callback) {
      var idx = _callbacks.indexOf(callback);
      _callbacks.splice(idx, 1);
    },

    all: function() {
      return _mustdos.slice();
    },
    fetch: function() {
      $.getJSON("api/mustdos", function(mustdos){
        _mustdos = mustdos;
        mustdolist.MustdoStore.changed();
      });
    },
    create: function(mustdo) {

      $.post('api/mustdos', mustdo, function(mustdo) {
        _mustdos.push(mustdo);
        mustdolist.MustdoStore.changed();
      });
    },
    destroy: function(id) {
      var foundIdx = mustdolist.MustdoStore.find(id);

      if (foundIdx !== -1) {
        $.ajax({
              url: 'api/mustdos/' + id,
              method: 'delete',
              success: function() {
                _mustdos.splice(foundIdx, 1);
        }});
      }

      mustdolist.MustdoStore.changed();
    },
    find: function(id) {
      var foundIdx = -1;
      _mustdos.forEach(function(mustdo, idx)  {
        if (mustdo.id === id) { foundIdx = idx; }
      });
      return foundIdx;
    },
    toggleDone: function(id) {
      var found = "";
      _mustdos.forEach(function(mustdo) {
        if (mustdo.id === id) {
          found = mustdo;
        }
      });

      var changeData = {done: !found.done};
      $.ajax({
        url: 'api/mustdos/' + id,
        data: changeData,
        type: 'PATCH'
      });

      mustdolist.MustdoStore.changed();
    }
  };

}(this));
