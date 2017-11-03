Array.prototype.bubbleSort = function bubbleSort(){
  let sorted = false;
  let sortedArr = this.slice();
  while(!sorted){
    sorted = true;
    for(let i = 0; i < this.length-1; i++){
      let firstNum = sortedArr[i];
      let nextNum = sortedArr[i+1];
      if(nextNum < firstNum)
      {
        sortedArr[i] = nextNum;
        sortedArr[i+1] = firstNum;
        sorted = false;
      }
    }
  }
  return sortedArr;
};

String.prototype.substrings = function substrings(){
  let subs = [];
  for(let i = 0; i < this.length; i++){
    for(let j = i+1; j < this.length; j++){
      subs.push(this.slice(i,j));
    }
  }
  return subs;
};
