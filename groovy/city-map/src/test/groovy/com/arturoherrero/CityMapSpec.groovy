package com.arturoherrero

import spock.lang.Specification

class CityMapSpec extends Specification {

    def 'empty route string yields an empty city map'() {
        when:
        def map = new CityMap('')

        then:
        map.cityGraph.isEmpty()
    }

    def 'one-way route traveled on foot'() {
        when:
        def map = new CityMap('a-b')

        then:
        !map.cityGraph.isEmpty()
        journeyPossible == map.isJourneyPossible(start, destination, onFoot)

        where:
        journeyPossible | start | destination | onFoot
        true            | 'a'   | 'b'         | true
        false           | 'a'   | 'b'         | false
        false           | 'b'   | 'a'         | true
        false           | 'b'   | 'a'         | false
    }

    def 'one-way route traveled on foot and by car'() {
        when:
        def map = new CityMap('a=b')

        then:
        !map.cityGraph.isEmpty()
        journeyPossible == map.isJourneyPossible(start, destination, onFoot)

        where:
        journeyPossible | start | destination | onFoot
        true            | 'a'   | 'b'         | true
        true            | 'a'   | 'b'         | false
        false           | 'b'   | 'a'         | true
        false           | 'b'   | 'a'         | false
    }

    def 'route traveled in both directions on foot'() {
        when:
        def map = new CityMap('a-b,b-a')

        then:
        journeyPossible == map.isJourneyPossible(start, destination, onFoot)

        where:
        journeyPossible | start | destination | onFoot
        true            | 'a'   | 'b'         | true
        false           | 'a'   | 'b'         | false
        true            | 'b'   | 'a'         | true
        false           | 'b'   | 'a'         | false
    }

    def 'one-way route traveled on foot and come back on foot and by car'() {
        when:
        def map = new CityMap('a-b,b=a')

        then:
        journeyPossible == map.isJourneyPossible(start, destination, onFoot)

        where:
        journeyPossible | start | destination | onFoot
        true            | 'a'   | 'b'         | true
        false           | 'a'   | 'b'         | false
        true            | 'b'   | 'a'         | true
        true            | 'b'   | 'a'         | false
    }

    def 'route traveled through different locations'() {
        when:
        def map = new CityMap('a-b,b-c')

        then:
        journeyPossible == map.isJourneyPossible(start, destination, onFoot)

        where:
        journeyPossible | start | destination | onFoot
        true            | 'a'   | 'b'         | true
        true            | 'a'   | 'c'         | true
    }

    def 'triangular one-way route traveled through different locations'() {
        when:
        def map = new CityMap('a=b,b=c,c=a')

        then:
        journeyPossible == map.isJourneyPossible(start, destination, onFoot)

        where:
        journeyPossible | start | destination | onFoot
        true            | 'a'   | 'b'         | false
        true            | 'a'   | 'b'         | false
        true            | 'a'   | 'c'         | false
        true            | 'a'   | 'a'         | false
        true            | 'b'   | 'c'         | false
        true            | 'b'   | 'a'         | false
    }
}
