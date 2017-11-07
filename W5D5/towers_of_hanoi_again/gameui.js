// var readline = require('readline');
// const reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });

const canvas = document.getElementById("canvas");
const ctx = canvas.getContext("2d");
const mousetext = document.getElementById("mouse-pos");
let clicked = false;
let towerIdx = 0;

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
  towerIdx = Math.floor((mousePos.x/(canvas.width/3)));
  mousetext.innerHTML = `x: ${mousePos.x}, y: ${mousePos.y}`;
});




class Game {


  constructor() {
    this.stacks = [[3,2,1],[],[]];
    this.selectedTowers = [];
    canvas.addEventListener('click', this.click.bind(this));
    this.render();
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
        canvas.removeEventListener('click', this.click.bind(this));
        return true;
      }
    }
    return false;
  }

  click() {
    this.render();
    this.selectedTowers.push(towerIdx);
    console.log(this.selectedTowers);
    if (this.selectedTowers.length === 2) {
      const [start, end] = this.selectedTowers;
      if(this.isValidMove(start, end)) {
        this.stacks[end].push(this.stacks[start].pop());
      }
      this.render();
      this.selectedTowers = [];
    }
    if(this.isWon()) {
      console.log('win');
    }
  }

  promptMove(gameLoop) {
    // reader.question('What move do you want to make? ( 0,1 )\n', (result) => {
    //   let [start, end] = result.split(',').map(i => parseInt(i));
    //   if(this.isValidMove(start, end)) {
    //     this.stacks[end].push(this.stacks[start].pop());
    //   } else {
    //     console.log('invalid move!');
    //   }
    //   gameLoop(this.isWon());
    // });


    gameLoop(this.isWon());
  }
  render(){
    ctx.fillStyle = 'rgb(200,200,200)';
    ctx.fillRect(0,0, canvas.width, canvas.height);
    ctx.fillStyle = 'rgb(200,0,0)';
    for(let i = 0; i < 3; i++)
    {
      let y = 0;
      this.stacks[i].forEach((el)=>{
        ctx.fillRect(i*100-(el*5)+20, 250-(y*50), 40+(el*10), 30);
        y+=1;
      });
    }
  }

  run(completionCallback) {
    const game = this;
    function gameLoop(won) {
      if (won) {
        completionCallback();
      } else {
        game.promptMove(gameLoop);
      }
    }
    gameLoop(false);
  }
}

let g = new Game();
// g.run();
// console.log("hello");
// function render(){
//   ctx.fillStyle = 'rgb(200,0,0)';
//   ctx.fillRect(0,0,150, 80);
// }
// render();

//
// const g = new Game();
// g.run(()=>{console.log("Won!");});
