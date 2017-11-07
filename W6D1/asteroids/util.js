const Util = {
  inherits(childClass, parentClass)
  {
    childClass.prototype = Object.create(parentClass.prototype);
    childClass.prototype.constructor = childClass;
  },

  randomVec (length) {
    const deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },
  // Scale the length of a vector by the given amount.
  scale (vec, m) {
    return [vec[0] * m, vec[1] * m];
  },

  toDistance (x,y) {
    return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
  }
};

module.exports = Util;
