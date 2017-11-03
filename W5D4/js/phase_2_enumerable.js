Array.prototype.myEach = function myEach(callback) {
  for(let i = 0; i < this.length; i++) {
    callback(this[i]);
  }
};

Array.prototype.myMap = function myMap(callback) {
  let mapped = [];
  for(let i = 0; i < this.length; i++) {
    mapped.push(callback(this[i]));
  }
  return mapped;
};

Array.prototype.myReduce = function myReduce(callback, initialValue) {
  let i = 0;
  if(initialValue === undefined) {
    initialValue = this[0];
    i++;
  }
  while(i < this.length) {
    initialValue += callback(this[i]);
    i++;
  }
  return initialValue;
};
