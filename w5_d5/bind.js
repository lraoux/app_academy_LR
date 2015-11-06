//cat = {
//  ageOneyear: function...
//  }
//cat.ageOneyear
//times(5, cat.ageOneyear.bind(cat))


Function.prototype.myBind = function(context) {
  var fn = this;

  return function () {
    fn.apply(context);
  };
};
