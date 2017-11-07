const MovingObject = require('./movingObject');
const Util = require('./util');

const Ship = function Ship()
{
  Ship.RADIUS = 500;
  Ship.COLOR = 'blue';

  MovingObject.call(this,[300,300],[0,0],Ship.RADIUS, Ship.COLOR);
};

Util.inherits(Ship, MovingObject);
module.exports = Ship;
