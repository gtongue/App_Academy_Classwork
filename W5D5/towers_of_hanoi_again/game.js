// var readline = require('readline');
// const reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });

const canvas = document.getElementById("canvas");
const ctx = canvas.getContext("2d");
const mousetext = document.getElementById("mouse-pos");

function getMousePos(canv, evt)
{
  var rect = canvas.getBoundingClientRect();
  return {
    x: evt.clientX - rect.left,
    y: evt.clientY - rect.top
  };
}

canvas.addEventListener('mousemove', (evt)=>{
  let mousePos = getMousePos(canvas, evt);
  mousetext.innerHTML = `x: ${mousePos.x}, y: ${mousePos.y}`;
});

canvas.addEventListener('click', (evt)=>{

});

class Game {
  constructor() {
    this.stacks = [[3,2,1],[],[]];
  }

  isValidMove(start, end) {
    const towerStart = this.stacks[start][this.stacks[start].length-1];
    const towerEnd = this.stacks[end][this.stacks[end].length-1];
    if (towerEnd === undefined ) {
      return true;
    }
    else if (towerStart === undefined) {
      return false;
    }

    return (towerStart < towerEnd);
  }

  isWon() {
    for (let i = 1; i < this.stacks.length; i++) {
      if (this.stacks[i].length === 3)
      {
        return true;
      }
    }
    return false;
  }

  promptMove(gameLoop) {
    reader.question('What move do you want to make? ( 0,1 )\n', (result) => {
      let [start, end] = result.split(',').map(i => parseInt(i));
      if(this.isValidMove(start, end)) {
        this.stacks[end].push(this.stacks[start].pop());
      } else {
        console.log('invalid move!');
      }
      gameLoop(this.isWon());
    });
  }
  render(){
    ctx.fillStyle = 'rgb(200,0,0)';
    ctx.fillRect(0,0,150, 80);
  }

  run(completionCallback) {
    const game = this;
    function gameLoop(won) {
      if (won) {
        completionCallback();
        reader.close();
      } else {
        game.promptMove(gameLoop);
      }
    }

    gameLoop(false);
  }
}
// console.log("hello");
// function render(){
//   ctx.fillStyle = 'rgb(200,0,0)';
//   ctx.fillRect(0,0,150, 80);
// }
// render();

//
// const g = new Game();
// g.run(()=>{console.log("Won!");});
