const range = function range(start, end) {
  if(start === end) {
    return [start];
  }
  return [start].concat(range(start+1, end));
};

const sumRec = function sumRec(arr) {
  if(arr.length === 1) {
    return arr[0];
  }
  let num = arr.pop();
  return sumRec(arr) + num;
};

const exponent = function exponent(base, exp) {
  if(exp === 0) {
    return 1;
  }
  else if(exp === 1) {
    return base;
  }

  return exponent(base, exp-1) * base;
};


const fibonacci = function fibonacci(n) {
  if(n === 1) {
    return 1;
  }
  else if(n === 2) {
    return [1, 1];
  }
  let fib = fibonacci(n-1);
  return fib.concat(fib[fib.length - 1] + fib[fib.length - 2]);
};

const bsearch = function bsearch(arr, target) {
  if(arr.length === 1 && arr[0] === target) {
    return 0;
  } else if (arr.length === 1 && arr[0] !== target) {
    return -1;
  }

  let mid = parseInt(arr.length/2);
  let midNum = arr[mid];
  if(midNum === target) {
    return mid;
  } else if (midNum < target) {
    let result = bsearch(arr.slice(mid), target);
    if(result === -1)
    {
      return -1;
    } else {
      return mid + result;
    }
  } else if (midNum > target) {
    return bsearch(arr.slice(0, mid), target);
  }

}
const merge = function merge(arr1, arr2){
  let sortedArr = [];
  while(arr1.length !== 0 && arr2.length !== 0){
    let num1 = arr1[0];
    let num2 = arr2[0];
    if(num1 > num2){
      sortedArr.push(arr2.shift());
    }
    else if(num1 < num2){
      sortedArr.push(arr1.shift());
    }else{
      sortedArr.push(arr1.shift());
      sortedArr.push(arr2.shift());
    }
  }
  sortedArr = sortedArr.concat(arr1);
  sortedArr = sortedArr.concat(arr2);
  return sortedArr;
};


const mergesort = function mergesort(arr) {
  if(arr.length <= 1){
    return arr;
  }
  let mid = parseInt(arr.length/2);
  let leftHalf = arr.slice(0,mid);
  let rightHalf = arr.slice(mid);
  let sortedLeft = mergesort(leftHalf);
  let sortedRight = mergesort(rightHalf);
  return merge(sortedLeft, sortedRight);
};

// const subsets = function subsets(arr){
//   if (arr.length === 0) {
//     return arr;
//   }
//   let first = arr[0];
//
//   let subs = arr.slice(1).map( function (el) {
//     console.log(el);
//     return [first].concat(el);
//   });
//   subs = subs.concat([arr]);
//   return subs.concat(subsets(arr.slice(1)));
// };

const subsets = function subsets(arr) {
  if (arr.length === 0) {
    return [arr];
  }
  let subset = subsets(arr.slice(0,arr.length - 1));
  let last = arr[arr.length - 1];
  const mapFunc = function mapFunc(el) {
    return el.concat(last);
  }
  let mapped = subset.map(mapFunc);
  return subset.concat(mapped);
}
