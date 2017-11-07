const Asteroid = require('./asteroid');

const Game = function Game() {
  this.DIM_X = 600;
  this.DIM_Y = 600;
  this.NUM_ASTEROIDS = 100;
  this.addAsteroids();
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
  // ctx.clearRect(0,0, this.DIM_X, this.DIM_Y);
  ctx.fillRect(0,0, this.DIM_X, this.DIM_Y);
  this.asteroids.forEach(asteroid => asteroid.draw(ctx));
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
  for (let i = 0; i < this.asteroids.length; i++) {
    let object1 = this.asteroids[i];
    for (let j = 0; j < this.asteroids.length; j++) {
      if (i === j) {
        continue;
      }
      let object2 = this.asteroids[j];
      if (object1.isCollidedWith(object2)) {
        object1.collideWith(object2, this);
      }
    }
  }
};

Game.prototype.step = function step() {
  this.moveObjects();
  this.checkCollisions();
};

module.exports = Game;
