package com.arturoherrero

class DecisionTree {
    def node

    def ask() {
        node.question
    }

    def answer(selection) {
        if (selection) {
            def answerForSelection = node.answers[selection]
            if (answerForSelection instanceof Node) {
                node = answerForSelection
            }
            else {
                answerForSelection
            }
        }
        else {
            "please select"
        }
    }
}

class Node {
    def question
    def answers
}
