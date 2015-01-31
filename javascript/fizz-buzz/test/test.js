var assert = require('assert')
var fizzbuzz = require('../lib/fizzbuzz')

describe('multiples of three', function() {
  it('should be Fizz', function() {
    assert.equal(true, fizzbuzz.isFizz(3));
    assert.equal(true, fizzbuzz.isFizz(6));
  })
})

describe('multiples of five', function() {
  it('should be Buzz', function() {
    assert.equal(true, fizzbuzz.isBuzz(5));
    assert.equal(true, fizzbuzz.isBuzz(10));
  })
})

describe('multiples of three and five', function() {
  it('should be FizzBuzz', function() {
    assert.equal(true, fizzbuzz.isBuzz(10));
    assert.equal(true, fizzbuzz.isBuzz(15));
  })
})
