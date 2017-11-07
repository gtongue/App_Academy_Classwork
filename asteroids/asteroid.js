const Util = require('./util');
const MovingObject = require('./movingObject.js');

const Asteroid = function Asteroid(pos){
  this.COLOR = 'red';
  this.RADIUS = 10;
  let randVel = Util.randomVec(2);
  MovingObject.call(this, pos, randVel, this.RADIUS, this.COLOR);
};

Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;
