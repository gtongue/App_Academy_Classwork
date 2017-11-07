const Util = require('./util');
const MovingObject = require('./movingObject.js');
const Ship = require('./ship');

const Asteroid = function Asteroid(pos){
  this.COLOR = 'red';
  this.RADIUS = 10;
  let randVel = Util.randomVec(2);
  MovingObject.call(this, pos, randVel, this.RADIUS, this.COLOR);
};

Asteroid.prototype.collideWith = function collideWith(obj, game) {
  if(obj instanceof Ship)
  {
    obj.pos = [200,300];
    obj.vel = [0,0];
  }
};

Util.inherits(Asteroid, MovingObject);

module.exports = Asteroid;
