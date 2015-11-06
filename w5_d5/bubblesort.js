var readline = require("readline");

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function askIfGreaterThan(el1, el2, callback) {
  // Prompt user to tell us whether el1 > el2; pass true back to the
  // callback if true; else false.
  console.log("el1 is" + el1);
  console.log("el2 is" + el2);
  reader.question("If el1>el2, type yes. Otherwise, type no", function (bool) {
    if (bool === "yes") {
      callback(true);
    } else {
      callback(false);
    }
  });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  // Do an "async loop":
  // 1. If (i == arr.length - 1), call outerBubbleSortLoop, letting it
  //    know whether any swap was made.
  // 2. Else, use `askIfGreaterThan` to compare `arr[i]` and `arr[i +
  //    1]`. Swap if necessary. Call `innerBubbleSortLoop` again to
  //    continue the inner loop. You'll want to increment i for the
  //    next call, and possibly switch madeAnySwaps if you did swap.
    var made = madeAnySwaps;
    if (i < arr.length -1) {
      askIfGreaterThan(arr[i], arr[i+1], function (isGreaterThan) {
        if(isGreaterThan) {
          var temp = arr[i+1];
          arr[i + 1] = arr[i];
          arr[i] = temp;
          made = true;
        }
        innerBubbleSortLoop(arr, i + 1, made, outerBubbleSortLoop);
      });
    } else {
      outerBubbleSortLoop(made);
    }
}

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    // Begin an inner loop if `madeAnySwaps` is true, else call
    // `sortCompletionCallback`.
    if (madeAnySwaps){
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }
  outerBubbleSortLoop(true);
  // Kick the first outer loop off, starting `madeAnySwaps` as true.
}

var sortCompletionCallback = function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
};



absurdBubbleSort([3, 2, 1], sortCompletionCallback);
