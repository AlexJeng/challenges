package com.arturoherrero

import spock.lang.Specification

class GridSpec extends Specification {

    def grid = new Grid([3, 1, 2, 3, 4 ,5, 6, 7, 8, 9])

    def "find neighbor values for position"() {
        expect:
        0 == grid.getAboveLeft(0)
        0 == grid.getAbove(0)
        0 == grid.getAboveRight(0)
        0 == grid.getLeft(0)
        1 == grid.getCurrent(0)
        2 == grid.getRight(0)
        0 == grid.getBelowLeft(0)
        4 == grid.getBelow(0)
        5 == grid.getBelowRight(0)

        1 == grid.getAboveLeft(4)
        2 == grid.getAbove(4)
        3 == grid.getAboveRight(4)
        4 == grid.getLeft(4)
        5 == grid.getCurrent(4)
        6 == grid.getRight(4)
        7 == grid.getBelowLeft(4)
        8 == grid.getBelow(4)
        9 == grid.getBelowRight(4)

        5 == grid.getAboveLeft(8)
        6 == grid.getAbove(8)
        0 == grid.getAboveRight(8)
        8 == grid.getLeft(8)
        9 == grid.getCurrent(8)
        0 == grid.getRight(8)
        0 == grid.getBelowLeft(8)
        0 == grid.getBelow(8)
        0 == grid.getBelowRight(8)
    }

    def "get location (coordinates) for position"() {
        expect:
        location == grid.getLocation(position)

        where:
        location | position
        [0, 0]   | 0
        [0, 2]   | 2
        [1, 1]   | 4
        [2, 1]   | 7
    }

    def "calculate score for position"() {
        expect:
        score == grid.calculateScore(position)

        where:
        score | position
        12    | 0
        39    | 7
    }
}

class SunspotAnalyserSpec extends Specification {

    def "analyse input data"() {
        setup:
        def sunspotAnalyser = new SunspotAnalyser()

        expect:
        output == sunspotAnalyser.analyse(input)

        where:
        output                                       | input
        '(1,1 score:45)(2,1 score:39)'               | [2, 3, 1, 2, 3, 4 ,5, 6, 7, 8, 9]
        '(2,1 score:27)(1,1 score:25)(2,2 score:23)' | [3, 4, 2, 3, 2, 1, 4, 4, 2, 0, 3, 4, 1, 1, 2, 3, 4, 4]
        '(3,3 score:26)'                             | [1, 5, 5, 3, 1, 2, 0, 4, 1, 1, 3, 2, 2, 3, 2, 4, 3, 0, 2, 3, 3, 2, 1, 0, 2, 4, 3]
    }
}
