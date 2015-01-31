
def commonEnglishWords = findCommonEnglishWords()
def htmlTags = ['<a', '<p']

def atom = 'http://blog.xxx.com/feed/atom'.toURL()
def feed = new XmlSlurper().parseText(atom.text)
feed.entry.each { entry ->
    def content = entry.content as String
    def words = wordCounter(content)
    words = removeHTMLTags(words, htmlTags)
    words = removeCommonEnglishWords(words, commonEnglishWords)
    println "Title: $entry.title"
    println "Most common word: ${findMostCommonWord(words)}"
    println '-----------'
}

private findCommonEnglishWords() {
    'http://www.textfixer.com/resources/common-english-words.txt'.toURL().text.tokenize(',')
}

private wordCounter(text) {
    text.tokenize().groupBy { it }.collectEntries { k, v -> [ k.toLowerCase(), v.size() ] }
}

private removeCommonEnglishWords(words, commonEnglishWords) {
    removeWords(words, commonEnglishWords)
}

private removeHTMLTags(words, htmlTags) {
    removeWords(words, htmlTags)
}

private removeWords(words, wordsToRemove) {
    wordsToRemove.each { word ->
        words.remove(word)
    }
    return words
}

private findMostCommonWord(words) {
    words.sort { -it.value }.keySet().first()
}
