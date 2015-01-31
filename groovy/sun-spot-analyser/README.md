## Sun Spot Analyser

### Introduction

In this test you are free to use any mechanism to provide input into your solution such as hard
coding test data within a unit test. You will need to provide sufficient evidence that your code solves
the requests listed in the test data section.


### Problem

NASA wishes to analyse areas of the Sun for thermal activity. Their sensors provide raw data which
can visualised as a n by n grid of raw heat measurements that represent the Sun's surface, i.e.

        0   1   2   3   4
      ---------------------
    0 | 5 | 3 | 1 | 2 | 0 |
      ---------------------
    1 | 4 | 1 | 1 | 3 | 2 |
      ---------------------
    2 | 2 | 3 | 2 | 4 | 3 |
      ---------------------
    3 | 0 | 2 | 3 | 3 | 2 |
      ---------------------
    4 | 1 | 0 | 2 | 4 | 3 |
      ---------------------

In the raw data the range of measurements will always range from 0 (low heat) to 5 (high heat).

This data needs to be analysed to find likely areas of increased solar activity. The analysis consists of
generating an Solar Activity Score for each location on the grid. The score is determined by adding
the location's own raw heat value to its surrounding raw heat values. For instance, the score of
location (1,1) is as follows:

    5 + 3 + 1 + 4 + 1 + 1 + 2 + 3 + 2 = 22

When dealing with locations around the edge of the grid the score should ignore values outside the
grid. For instance the score of location (0,0) is as follows:

    5 + 3 + 4 + 1 = 13

The required output of the analysis is to provide an ordered list of locations containing the t number
of highest rated locations and their respective scores.


### Input and Output

The input provided to the analyser will be in the form of a list of numbers:

    t | n | Grid
    1 | 3 | 4 2 3 2 2 1 3 2 1

Where t is the number of results requested, n is the size of the grid and grid is a space delimited list
of numbers that form the grid, starting with row 0.

The list of numbers above therefore represent a request for the single top score from a 3x3 grid that
looks like so:

    4 | 2 | 3
    2 | 2 | 1
    3 | 2 | 1

Output should be a list of locations and their scores in the following form:

    (x,y score:score)

i.e. the result that should be returned for the above input is:

    (1,1 score:20)


### Test data

#### Test 1

Input:

    1 5 5 3 1 2 0 4 1 1 3 2 2 3 2 4 3 0 2 3 3 2 1 0 2 4 3

Expected output:

    (3,3 score:26)

#### Test 2

Input:

    3 4 2 3 2 1 4 4 2 0 3 4 1 1 2 3 4 4

Expected output:

    (2,1 score:27)(1,1 score:25)(2,2 score:23)
