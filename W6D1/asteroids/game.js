const Asteroid = require('./asteroid');
const Ship = require('./ship');

const Game = function Game() {
  this.DIM_X = 600;
  this.DIM_Y = 600;
  this.NUM_ASTEROIDS = 100;
  this.addAsteroids();
  this.ship = new Ship();
};

Game.prototype.addAsteroids = function addAsteroids(){
  this.asteroids = [];
  for (let i = 0; i < this.NUM_ASTEROIDS; i++) {
    let randomX = Math.random() * this.DIM_X;
    let randomY = Math.random() * this.DIM_Y;
    this.asteroids.push(new Asteroid([randomX, randomY]));
  }
};

Game.prototype.draw = function draw(ctx) {
  ctx.fillStyle = 'black';
  ctx.clearRect(0,0, this.DIM_X, this.DIM_Y);
  ctx.fillRect(0,0, this.DIM_X, this.DIM_Y);
  this.allObjects().forEach(asteroid => asteroid.draw(ctx));
};

Game.prototype.moveObjects = function moveObjects() {
  this.asteroids.forEach(asteroid => asteroid.move());
};

Game.prototype.remove = function remove(asteroid)
{
  let index = this.asteroids.indexOf(asteroid);
  this.asteroids.splice(index, 1);
};

Game.prototype.checkCollisions = function checkCollisions() {
  let allObjects = this.allObjects();
  for (let i = 0; i < allObjects.length; i++) {
    let object1 = allObjects[i];
    for (let j = 0; j < allObjects.length; j++) {
      if (i === j) {
        continue;
      }
      let object2 = allObjects[j];
      if (object1.isCollidedWith(object2)) {
        object1.collideWith(object2, this);
        object2.collideWith(object1, this);
      }
    }
  }
};

Game.prototype.allObjects = function allObjects()
{
  return this.asteroids.concat(this.ship);
};

Game.prototype.step = function step() {
  this.moveObjects();
  this.checkCollisions();
};

module.exports = Game;
