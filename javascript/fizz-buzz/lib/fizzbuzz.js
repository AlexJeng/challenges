module.exports = FizzBuzz;

function FizzBuzz() {
};

FizzBuzz.isFizz = function(number) {
  return isDivisibleByThree(number);
}

FizzBuzz.isBuzz = function(number) {
  return isDivisibleByFive(number);
}

FizzBuzz.isFizzBuzz = function(number) {
  return isDivisibleByThree(number) && isDivisibleByFive(number);
}

FizzBuzz.run = function() {
  for (var i = 1; i <= 100; i++) {
    if (FizzBuzz.isFizz(i)){
      console.log("Fizz");
    }
    else if (FizzBuzz.isBuzz(i)) {
      console.log("Buzz");
    }
    else if (FizzBuzz.isFizzBuzz(i)) {
      console.log("FizzBuzz");
    }
    else {
      console.log(i);
    }
  }
}

var isDivisibleByThree = function(number) {
  return number % 3 === 0;
}

var isDivisibleByFive = function(number) {
  return number % 5 === 0;
}
