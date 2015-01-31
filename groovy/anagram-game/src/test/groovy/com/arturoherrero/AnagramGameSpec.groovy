package com.arturoherrero

import spock.lang.Specification

class AnagramGameSpec extends Specification {

    def 'retrieves the word list from external resource'() {
        given:
        def anagramGame = new AnagramGame()

        expect:
        'aa' == anagramGame.dictionary.first()
        'zyzzyvas' == anagramGame.dictionary.last()
    }

    def 'checks if a submitted word is a in the word list'() {
        given:
        def anagramGame = new AnagramGame('areallylongword')

        expect:
        founded == anagramGame.isInDictionary(word)

        where:
        founded | word
        true    | 'no'
        true    | 'grow'
        false   | 'glly'
    }

    def 'checks if a submitted word its contained in the base string'() {
        given:
        def anagramGame = new AnagramGame('areallylongword')

        expect:
        founded == anagramGame.isContainedInBaseString(word)

        where:
        founded | word
        true    | 'no'
        true    | 'noo'
        true    | 'grow'
        false   | 'nooo'
    }

    def 'get word from the high score list given a position'() {
        given:
        def anagramGame = new AnagramGame('areallylongword')

        when:
        anagramGame.submitWord('no')
        anagramGame.submitWord('grow')
        anagramGame.submitWord('bold')
        anagramGame.submitWord('glly')
        anagramGame.submitWord('woolly')

        then:
        word == anagramGame.getWordEntryAtPosition(position)

        where:
        word     | position
        'woolly' | 0
        'grow'   | 1
        'no'     | 2
    }
}
