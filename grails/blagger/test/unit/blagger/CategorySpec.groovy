package blagger

import spock.lang.Specification
import spock.lang.Unroll

@TestFor(Category)
class CategorySpec extends Specification {

    @Unroll
    def 'a category has tag name'() {
        when:
            def category = new Category(tagName: tagName)

        then:
            validate == category.validate()
            errorCode == category.errors['tagName']?.code

        where:
            tagName | validate | errorCode
            null    | false    | 'nullable'
            ''      | false    | 'blank'
            'tag'   | true     | null
    }

    def 'a category has a unique tag name'() {
        def tagName = 'tag'

        given:
            new Category(tagName: tagName).save()

        when:
            def category = new Category(tagName: tagName)

        then:
            false == category.validate()
            'unique' == category.errors['tagName'].code
    }

    def 'findAllTagNames retrieves tag names of all categories'() {
        given:
            new Category(tagName: 'abc').save()
            new Category(tagName: 'def').save()

        when:
            def tagNames = Category.findAllTagNames()

        then:
            ['abc', 'def'] == tagNames
    }
}
