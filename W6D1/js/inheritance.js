Function.prototype.inherits = function(parent){
  this.prototype = Object.create(parent.prototype);
  this.prototype.constructor = this;
};
// Function.prototype.inherits = function inherits1(BaseClass) {
//   function Surrogate() {}
//   Surrogate.prototype = BaseClass.prototype;
//   this.prototype = new Surrogate();
//   this.prototype.constructor = this;
// };
function MovingObject () {}
MovingObject.prototype.log = function log()
{
  console.log("hello");
};

function Ship () {}
Ship.inherits(MovingObject);

function Asteroid () {}
Asteroid.inherits(MovingObject);

let a = new Asteroid();
a.log();
