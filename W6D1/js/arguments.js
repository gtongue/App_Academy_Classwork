function sum() {
  const args = Array.from(arguments);
  let total = 0;
  args.forEach(el =>{
    total += el;
  });
  return total;
}

function sum2(...args) {
  let total = 0;
  args.forEach(el => {
    total += el;
  });
  return total;
}

Object.prototype.myBind = function (scope, ...args) {
  // if (args.length === 0) {
  //   return (...args2) => {
  //     this.apply(scope, args2);
  //   };
  // }
  return (...args2) => {
    this.apply(scope, args.concat(args2));
  };
};

// class Cat {
//   constructor(name) {
//     this.name = name;
//   }
//
//   says(sound, person) {
//     console.log(`${this.name} says ${sound} to ${person}!`);
//     return true;
//   }
// }
//
// const markov = new Cat("Markov");
// const breakfast = new Cat("Breakfast");
//
// markov.says.myBind(breakfast, "meow", "Kush")();
//
// const notMarkovSays = markov.says.myBind(breakfast);
// notMarkovSays("meow", "me");
Function.prototype.curry = function (num) {
  this.numsLeft = num;
  this.args = [];

  return function curryFunction (arg) {
    console.log(this);
    this.numsLeft--;
    this.args.push(arg);
    if (this.numsLeft === 0) {
      return this(...this.args);
    }else{
      return curryFunction.bind(this);
    }
  }.bind(this);
};

Function.prototype.curry2 = function (num) {
  this.numsLeft = num;
  this.args = [];

  return function curryFunction (arg) {
    this.numsLeft--;
    this.args.push(arg);
    console.log(this);
    if (this.numsLeft === 0) {
      return this.apply(this, this.args);
    }else{
      return curryFunction.bind(this);
    }
  }.bind(this);
};

function sumThree(num1, num2, num3) {
  console.log(num1);
  console.log(num2);
  console.log(num3);
  return num1 + num2 + num3;
}

console.log(sumThree.curry2(3)(3)(2)(1));
