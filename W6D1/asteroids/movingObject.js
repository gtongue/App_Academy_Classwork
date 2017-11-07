const Util = require('./util');
const Game = require('./game');

let MovingObject = function MovingObject(pos, velocity, radius, color){
  this.pos = pos;
  this.velocity = velocity;
  this.radius = radius;
  this.color = color;
};

MovingObject.prototype.draw = function draw(ctx){

  ctx.beginPath();
  ctx.arc(this.pos[0],this.pos[1], this.radius, 0, 2* Math.PI, false);
  ctx.fillStyle = this.color;
  ctx.fill();
  ctx.lineWidth = 1;
  ctx.strokeStyle = 'white';
  ctx.stroke();
};

MovingObject.prototype.move = function move(){
  this.pos[0] += this.velocity[0];
  this.pos[1] += this.velocity[1];
  if(this.pos[0] > 650)
  {
    this.pos[0] = -50;
  }
  else if (this.pos[0] < -50) {
    this.pos[0] = 650;
  }

  if(this.pos[1] > 650)
  {
    this.pos[1] = -50;
  }
  else if (this.pos[1] < -50) {
    this.pos[1] = 650;
  }
};

MovingObject.prototype.isCollidedWith = function isCollidedWith(obj) {
  let xDiff = this.pos[0] - obj.pos[0];
  let yDiff = this.pos[1] - obj.pos[1];
  let difference = Util.toDistance(xDiff, yDiff);
  if (difference <= (this.radius + obj.radius)) {
    return true;
  }
  return false;
};

MovingObject.prototype.collideWith = function collideWith(obj, game){

};

module.exports = MovingObject;
