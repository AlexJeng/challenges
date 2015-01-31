package blagger

class Post {

    String title
    String email
    String content
    Date dateCreated
    Date lastUpdated
    Category category

    static constraints = {
        title minSize: 3, blank: false
        email email: true, blank: false
        content blank: false
        category nullable: true
    }

    static mapping = {
        content type: 'text'
        category cascade: 'all-delete-orphan'
    }
}
