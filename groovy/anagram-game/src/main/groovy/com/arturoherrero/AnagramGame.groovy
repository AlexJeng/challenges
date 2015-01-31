package com.arturoherrero

class AnagramGame {

    private final static resource = 'http://www.xxx.com/codetest/wordlist.txt'
    private String baseString
    private List dictionary
    private TreeMap highScore = [:]

    AnagramGame(String baseString) {
        this.baseString = baseString
        dictionary = retrieveWordList()
        highScore.sort { a, b -> a.value <=> b.value }
    }

    private retrieveWordList() {
        resource.toURL().text.tokenize()
    }

    /**
     * Submit a word on behalf of a user. A word is accepted if its letters are
     * contained in the original string submitted in the constructor, and if it
     * is in the word list at http://www.xxx.com/codetest/wordlist.txt.
     * If the word is accepted and its score is high enough, the submission
     * should be added to the high score list. If there are multiple submissions
     * with the same score, all are accepted, but the first submission with that
     * score should rank higher.
     *
     * @parameter word User's submission. All submissions may be assumed to be
     *      lowercase and containing no whitespace or special
     *      characters.
     */
    def submitWord(String word) {
        if (isInDictionary(word) && isContainedInBaseString(word)) {
            def score = word.size
            if (highScore.size <= 9) {
                highScore[word] = score
            }
            else {
                def lowestScore = highScore.lastKey()
                if (highScore[lowestScore] < score) {
                    highScore.remove(lowestScore)
                    highScore[word] = score
                }
            }
        }
    }

    private isInDictionary(word) {
        word in dictionary
    }

    private isContainedInBaseString(word) {
        def baseString = baseString
        word.every { letter ->
            baseString.contains(letter) &&
            (baseString = baseString.replaceFirst(letter, ''))
        }
    }

    /**
     * Return word entry at given position in the high score list, 0 being the
     * highest (best score) and 9 the lowest. You may assume that this method
     * will never be called with position > 9.
     *
     * @parameter position Index on high score list
     * @return word entry at given position in the high score list, or null if
     *      there is no entry at that position
     */
    String getWordEntryAtPosition(Integer position) {
        highScore.keySet()[position]
    }

    /**
     * Return score at given position in the high score list, 0 being the
     * highest (best score) and 9 the lowest. You may assume that this method
     * will never be called with position > 9.
     *
     * @parameter position Index on high score list
     * @return score at given position in the high score list, or null if there
     *      is no entry at that position
     */
    Integer getScoreAtPosition(Integer position) {
        highScore.values()[position]
    }
}
