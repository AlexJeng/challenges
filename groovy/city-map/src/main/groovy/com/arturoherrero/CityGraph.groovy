package com.arturoherrero

class CityGraph extends LinkedHashMap {
    CityGraph(routesAndLocations) {
        routesAndLocations.tokenize(',').each { routeBetweenTwoLocations ->
            def vertex = Parser.parseLocations(routeBetweenTwoLocations)
            add(vertex)
        }
    }

    def add(vertex) {
        this[vertex.start] = (this[vertex.start] ?: []) << [vertex.destination, vertex.onFoot]
    }

    def findDestination(start, end) {
        def destination = this[start].find { it.first() == end }
        if (destination) return destination
        if (!this[start]) return null
        for (location in this[start]*.first()) {
            def destinationFounded = findDestination(location, end)
            if (destinationFounded) return destinationFounded
        }
        return null
    }
}
