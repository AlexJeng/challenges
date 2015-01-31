package com.arturoherrero

class SunspotAnalyser {
   
    def analyse(list) {
        def t = list.first()
        def grid = new Grid(list.tail())

        def analysis = grid.fold([:]) {
            [(grid.getLocation(it)): grid.calculateScore(it)]
        }

        def results = analysis.sort { a, b -> b.value <=> a.value }.take(t)
        prettyOutput(results)
    }

    private prettyOutput(results) {
        results.inject('') { output, result ->
            output << "(${result.key.first()},${result.key.last()} score:${result.value})"
        }.toString()
    }
}

class Grid {

    private static Integer n
    private static List grid

    Grid(List list) {
        n = list.first()
        grid = list.tail()
    }

    def fold(Object initval, Closure closure) {
        (0..grid.size() - 1).inject(initval) { accumulator, item ->
            accumulator << closure(item)
        }
    }

    def getLocation(Integer x) {
        [x.intdiv(n), x % n]
    }

    def calculateScore(Integer x) {
        getAboveLeft(x) + getAbove(x) + getAboveRight(x) +
        getLeft(x) + getCurrent(x) + getRight(x) +
        getBelowLeft(x) + getBelow(x) + getBelowRight(x)
    }

    private getAboveLeft(x) {
        outLeft(x) || outTop(x) ? 0 : grid[x - n - 1]
    }

    private getAbove(x) {
        outTop(x) ? 0 : grid[x - n]
    }

    private getAboveRight(x) {
        outTop(x) || outRight(x) ? 0 : grid[x - n + 1]
    }

    private getLeft(x) {
        outLeft(x) ? 0 : grid[x - 1]
    }

    private getCurrent(x) {
        grid[x]
    }

    private getRight(x) {
        outRight(x) ? 0 : grid[x + 1]
    }

    private getBelowLeft(x) {
        outLeft(x) || outDown(x) ? 0 : grid[x + n - 1]
    }

    private getBelow(x) {
        outDown(x) ? 0 : grid[x + n]
    }

    private getBelowRight(x) {
        outDown(x) || outRight(x) ? 0 : grid[x + n + 1]
    }

    private outTop(x) { x < n }
    private outDown(x) { x > n * n - 1 - n }
    private outLeft(x) { x % n == 0 }
    private outRight(x) { x % n == n - 1 }
}
