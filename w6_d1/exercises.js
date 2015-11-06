var sum = function () {
  var args = Array.prototype.slice.call(arguments);
  var sum = 0;
  args.forEach(function(i) {
    sum += i;
  });
  return sum;
};

Function.prototype.myBind = function(context) {
  var fn = this;

  var args = Array.prototype.slice.call(arguments, 1);

  return function() {
    var args2 = Array.prototype.slice.call(arguments);
    fn.apply(context, args.concat(args2));
  };
};

function Cat(name) {
  this.name = name;
}

var curriedSum = function(numArgs) {
  var numbers = [];
  var sum = 0;

  var _curriedSum = function(num) {
    numbers.push(num);

    if (numbers.length === numArgs) {
      numbers.forEach(function(i) {
        sum += i;
      });

      return sum;
    } else {
      return _curriedSum;
    }
  };

  return _curriedSum;
};

Function.prototype.curry = function (numArgs) {
  var elements = [];
  var result = 0;

  var that = this;
  var _curriedResult = function(element) {
    elements.push(element);

    if (elements.length === numArgs) {
      return that.apply(that, elements);
    } else {
      return _curriedResult;
    }
  };

  return _curriedResult;
};

Function.prototype.inherits = function (superClass) {
  function Surrogate() {}

  Surrogate.prototype = superClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
};
