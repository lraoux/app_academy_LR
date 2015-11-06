var readline = require('readline');

var reader = readline.createInterface({

  input: process.stdin,
  output: process.stdout
});

var addNumbers = function (sum, numsLeft, completionCallback) {

  if (numsLeft === 0) {
    completionCallback(sum);
  } else {
    reader.question("What number?", function (input) {
      sum += parseInt(input);
      numsLeft -= 1;
      console.log("Sum so far: " + sum);
      addNumbers(sum, numsLeft, completionCallback);
    });
  }
};

var completionCallback = function(sum) {
  console.log("Total sum was:" + sum);
  reader.close();
};

addNumbers(0, 3, completionCallback);


//callbacks are references to the function not the executions

// reader.question("What is your name?", function (answer) {
//   console.log("Hello " + answer + "!");
// });
//
// console.log("Last program line");
