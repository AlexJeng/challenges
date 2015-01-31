package blagger

import spock.lang.Shared
import spock.lang.Specification
import spock.lang.Unroll

@TestFor(Post)
class PostSpec extends Specification {

    @Shared postData = [
        title: 'test',
        email: 'test@test.com',
        content: 'test'
    ]

    @Unroll
    def 'the title has at least 3 characters'() {
        when:
            def post = new Post(postData << [title: title])

        then:
            validate == post.validate()
            errorCode == post.errors['title']?.code

        where:
            title  | validate | errorCode
            null   | false    | 'nullable'
            ''     | false    | 'blank'
            '12'   | false    | 'minSize.notmet'
            '123'  | true     | null
            '1234' | true     | null
    }

    @Unroll
    def 'the email is a valid email address'() {
        when:
            def post = new Post(postData << [email: email])

        then:
            validate == post.validate()
            errorCode == post.errors['email']?.code

        where:
            email                      | validate | errorCode
            null                       | false    | 'nullable'
            ''                         | false    | 'blank'
            'arturo'                   | false    | 'email.invalid'
            'arturo.herrero@gmail.com' | true     | null
    }

    @Unroll
    def 'there is some content'() {
        when:
            def post = new Post(postData << [content: content])

        then:
            validate == post.validate()
            errorCode == post.errors['content']?.code

        where:
            content   | validate | errorCode
            null      | false    | 'nullable'
            ''        | false    | 'blank'
            'content' | true     | null
    }
}
