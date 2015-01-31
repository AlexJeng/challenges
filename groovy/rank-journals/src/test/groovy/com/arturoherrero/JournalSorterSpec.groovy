package com.arturoherrero

import spock.lang.Specification

class JournalSorterSpec extends Specification {
    def journalSorter = new JournalSorter()

    def "journals are ranked by theirs score"() {
        def journalA = new Journal(name: 'Journal A', score: 5.6)
        def journalB = new Journal(name: 'Journal B', score: 2.4)
        def journalC = new Journal(name: 'Journal C', score: 3.1)

        given:
        def journals = [
            journalA,
            journalB,
            journalC,
        ]

        when:
        def rankedJournals = journalSorter.rank(journals)

        then:
        rankedJournals == [
            1: journalA,
            2: journalC,
            3: journalB,
        ]
    }

    def "if some journals have the same rank, they are ordered by name"() {
        def journalA = new Journal(name: 'Journal A', score: 2.2)
        def journalB = new Journal(name: 'Journal B', score: 6.2)
        def journalC = new Journal(name: 'Journal C', score: 6.2)

        given:
        def journals = [
            journalA,
            journalB,
            journalC,
        ]

        when:
        def rankedJournals = journalSorter.rank(journals)

        then:
        rankedJournals == [
            1: journalB,
            2: journalC,
            3: journalA,
        ]
    }

    def "reviewed journals are excluded from ranking"() {
        def journalA = new Journal(name: 'Journal A', score: 5.6, review: true)
        def journalB = new Journal(name: 'Journal B', score: 2.4)
        def journalC = new Journal(name: 'Journal C', score: 3.1)

        given:
        def journals = [
            journalA,
            journalB,
            journalC,
        ]

        when:
        def rankedJournals = journalSorter.rank(journals)

        then:
        rankedJournals == [
            1: journalC,
            2: journalB,
        ]
    }
}
