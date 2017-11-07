/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const GameView = __webpack_require__(1);

addEventListener("DOMContentLoaded", () => {
  let canvas = document.getElementById("canvas");
  let ctx = canvas.getContext("2d");
  let view = new GameView(ctx);
  view.start();
});


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const Game = __webpack_require__(2);
const GameView = function GameView(ctx) {
  this.game = new Game();
  this.ctx = ctx;

};

GameView.prototype.start = function start() {
  setInterval(()=> {
    this.game.step();
    this.game.draw(this.ctx);
  }, 20);
};

module.exports = GameView;


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const Asteroid = __webpack_require__(3);
const Ship = __webpack_require__(6);

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


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(4);
const MovingObject = __webpack_require__(5);
const Ship = __webpack_require__(6);

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


/***/ }),
/* 4 */
/***/ (function(module, exports) {

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


/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

const Util = __webpack_require__(4);
const Game = __webpack_require__(2);

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


/***/ }),
/* 6 */
/***/ (function(module, exports, __webpack_require__) {

const MovingObject = __webpack_require__(5);
const Util = __webpack_require__(4);

const Ship = function Ship()
{
  Ship.RADIUS = 10;
  Ship.COLOR = 'blue';

  MovingObject.call(this,[300,300],[0,0],Ship.RADIUS, Ship.COLOR);
};

Util.inherits(Ship, MovingObject);
module.exports = Ship;


/***/ })
/******/ ]);