class Clock {
  constructor() {
    const date = new Date();
    this.hours = date.getHours();
    this.minutes = date.getMinutes();
    this.seconds = date.getSeconds();
    this.printTime();
    setInterval(this._tick.bind(this), 1000);
  }

  printTime() {
    const secondsStrings = ('0' + this.seconds).slice(-2);
    const minutesStrings = ('0' + this.minutes).slice(-2);
    const hoursStrings = ('0' + this.hours).slice(-2);
    console.log(`${hoursStrings}:${minutesStrings}:${secondsStrings}`);
  }

  _tick() {
    this.seconds += 1;
    if (this.seconds >= 60) {
      this.seconds = 0;
      this.minutes += 1;
      if (this.minutes >= 60) {
        this.minutes = 0;
        this.hours += 1;
        if (this.hours >= 24) {
          this.hours = 0;
        }
      }
    }
    this.printTime();
  }
}

// const clock = new Clock();
var readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback){
  if(numsLeft > 0){
    reader.question('Enter a number:', (res) =>{
      let num = parseInt(res);
      sum+=num;
      console.log(sum);
      addNumbers(sum, numsLeft-1, completionCallback);
    });
  }
  else{
    completionCallback(sum);
  }
}


// addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));

function absurdBubbleSort(arr, sortCompletionCallback){
  function outerBubbleSortLoop(madeAnySwaps)
  {
    if(!madeAnySwaps){
      sortCompletionCallback(arr);
    }else {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }
  }
  innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
}

function askIfGreaterThan(el1, el2, callback){
  // let readerCallback = (result) => {
  //   if(result !== "yes" && result !== "no"){
  //     reader.question(`Is ${el1} greater than ${el2}\n`, readerCallback);
  //   }else if(result === 'yes'){
  //     callback(true);
  //   }else {
  //     callback(false);
  //   }
  // };
  // readerCallback();

  reader.question(`Is ${el1} greater than ${el2}\n`, (result) => {
    console.log('here');
    if(result === 'yes'){
      callback(true);
    }else{
      callback(false);
    }
  });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop){
  console.log(i);

  if ( i < arr.length - 1)
  {
    askIfGreaterThan(arr[i], arr[i+1],(isGreaterThan)=>{
      if (isGreaterThan)
      {
        let temp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = temp;
        madeAnySwaps = true;
      }
      i++;
      innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop);
    });

  }else{
    outerBubbleSortLoop(madeAnySwaps);
  }
}

// absurdBubbleSort([3, 2, 1], function (arr) {
//   console.log("Sorted array: " + JSON.stringify(arr));
//   reader.close();
// });


Function.prototype.myBind = function (context) {
  return () => {
    this.apply(context);
  };
};

class Lamp {
  constructor() {
    this.name = "a lamp";
  }
}

const turnOn = function() {
   console.log("Turning on " + this.name);
};

const lamp = new Lamp();

turnOn(); // should not work the way we want it to

const boundTurnOn = turnOn.bind(lamp);
const myBoundTurnOn = turnOn.myBind(lamp);

boundTurnOn(); // should say "Turning on a lamp"
myBoundTurnOn(); // should say "Turning on a lamp"








//,
