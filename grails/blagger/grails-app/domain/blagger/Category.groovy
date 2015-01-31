package blagger

class Category {

    String tagName

    static belongsTo = Post

    static constraints = {
        tagName blank: false, unique: true
    }

    static findAllTagNames() {
        findAll().collect { it.tagName }
    }
}
