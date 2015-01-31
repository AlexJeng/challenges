package com.arturoherrero

class CityMap {
    CityGraph cityGraph

    /**
     * @param routesAndLocations A String specification of the
     * routes between locations. A comma-separated list
     * of roads and paths between locations defined as
     * [startLocation][type][endLocation] e.g.
     *
     * "a-b,b-a" represents two locations, where travel
     *      is possible in both directions on foot
     * "a=b,b=c,c=a" represents a triangular one-way road travelling
     *      from a, through b and c, and finally back to a.
     *
     * Routes can be of two types:
     * - Paths (accessible on foot only)
     * = Roads (accessible on foot & by car)
     */
    CityMap(String routesAndLocations) {
        cityGraph = new CityGraph(routesAndLocations)
    }

    /**
     * Determine whether a journey from the startLocation to the
     * destinationLocation can be made, based on the available routes
     * and whether on foot (onFoot=true), or by car (onFoot=false)
     */
    boolean isJourneyPossible(
        String startLocation,
        String destinationLocation,
        boolean onFoot
    ) {
        def cityGraphDestination = cityGraph.findDestination(startLocation, destinationLocation)
        def locationsConnected = cityGraphDestination ? true : false
        if (onFoot) locationsConnected
        else locationsConnected && cityGraphDestination.last() == false
    }
}
