package com.arturoherrero

class Parser {
    private final static pathSymbol = '-'
    private final static roadSymbol = '='

    static parseLocations(routeBetweenTwoLocations) {
        if (routeBetweenTwoLocations.contains(pathSymbol)) {
            createVertex(routeBetweenTwoLocations, pathSymbol)
        }
        else if (routeBetweenTwoLocations.contains(roadSymbol)) {
            createVertex(routeBetweenTwoLocations, roadSymbol)
        }
    }

    private static createVertex(routeBetweenTwoLocations, symbol) {
        def (start, destination) = routeBetweenTwoLocations.tokenize(symbol)
        new Vertex(
            start: start,
            destination: destination,
            onFoot: symbol == pathSymbol
        )
    }
}
