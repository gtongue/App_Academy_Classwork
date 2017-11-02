
Array.prototype.uniq = function uniq(){
  const uniqArr = [];
  for(let i = 0; i < this.length; i++){
    let el = this[i];
    if(!uniqArr.includes(el)){
      uniqArr.push(el);
    }
  }
  return uniqArr;
};

Array.prototype.twoSum = function twoSum(){
  const twoSumArr = [];
  for(let i = 0; i < this.length; i++){
    for(let j = i+1; j < this.length; j++)
    {
      if(this[i]+this[j] === 0){
        twoSumArr.push([i,j]);
      }
    }
  }
  return twoSumArr;
};

Array.prototype.transpose = function transpose(){
  let transposedArr = [];
  for(let j = 0; j < this[0].length; j++){
    transposedArr[j] = [];
    for(let i = 0; i < this.length; i++)
    {
      let el = this[i][j];
      transposedArr[j][i] = el;
    }
  }
  return transposedArr;
};
