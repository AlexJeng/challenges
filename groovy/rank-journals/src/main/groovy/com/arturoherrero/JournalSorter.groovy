package com.arturoherrero

class JournalSorter {
    def rank(journals) {
        use(ListEnhancements) {
            journals.sort(orderByScoreAndName)
                    .findAll(notReviewed)
                    .collectToMapWithIndex()
        }
    }

    private orderByScoreAndName = { a, b ->
        b.score <=> a.score ?: a.name <=> b.name
    }

    private notReviewed = { item ->
        !item.review
    }
}

@Category(List)
class ListEnhancements {
    Map collectToMapWithIndex() {
        [(1..this.size()), this].transpose().collectEntries { it }
    }
}
