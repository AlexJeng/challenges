## City Map

The problem is to provide an algorithm to calculate if a journey is possible for a series of
locations in a city, connected by roads. You need to write an implementation for a class as
follows:

    interface CityMap {

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
        CityMap(String routesAndLocations);

        /**
         * Determine whether a journey from the startLocation to the
         * destinationLocation can be made, based on the available routes
         * and whether on foot (onFoot=true), or by car (onFoot=false)
         */
        boolean isJourneyPossible(
            String startLocation,
            String destinationLocation,
            boolean onFoot
        );

    }

No additional public methods are required in the CityMap class, but the creation of
additional classes may be necessary to solve the problem.
