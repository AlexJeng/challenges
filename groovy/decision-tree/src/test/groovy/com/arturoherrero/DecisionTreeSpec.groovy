package com.arturoherrero

import spock.lang.Specification

class DecisionTreeSpec extends Specification {

    def "a decision tree is able to ask a question"() {
        given:
        def node = new Node(question: "tea or beer", answers: ["tea": "square", "beer": "circle"])
        def tree = new DecisionTree(node: node)

        when:
        def question = tree.ask()

        then:
        "tea or beer" == question
    }

    def "a decision tree gives a correctly result for an answer"() {
        given:
        def node = new Node(question: "tea or beer", answers: ["tea": "square", "beer": "circle"])
        def tree = new DecisionTree(node: node)

        when:
        def returnResult = tree.answer(selection)

        then:
        result == returnResult

        where:
        result          | selection
        "square"        | "tea"
        "circle"        | "beer"
        "please select" | null
    }

    def "a decision tree ask another question after getting an answer"() {
        given:
        def sugarNode = new Node(question: "sugar or honey", answers: ["sugar": "square", "honey": "triangle"])
        def beerNode = new Node(question: "lager or ipa", answers: ["lager": "circle", "ipa": "hexagon"])
        def startNode = new Node(question: "tea or beer", answers: ["tea": sugarNode, "beer": beerNode])
        def tree = new DecisionTree(node: startNode)

        when:
        tree.answer("tea")
        def question = tree.ask()

        then:
        question == "sugar or honey"
    }
}

