package blagger

import spock.lang.Shared
import spock.lang.Specification

@TestFor(BlogController)
@Mock([Post, Category])
class BlogControllerSpec extends Specification {

    @Shared postData = [
        title: 'test',
        email: 'test@test.com',
        content: 'test'
    ]

    def 'List returns the blag posts'() {
        given:
            new Post(postData).save()

        when:
            controller.list()

        then:
            controller.modelAndView.model.posts.first().title == 'test'
    }

    def 'List returns the blag posts in the correct order'() {
        given:
            new Post(postData << [title: 'test1']).save()
            new Post(postData << [title: 'test2']).save()

        when:
            controller.list()

        then:
            controller.modelAndView.model.posts.first().title == 'test2'
    }

    def 'List returns at most 5 posts'() {
        setup:
            6.times { new Post(postData).save() }

        when:
            controller.list()

        then:
            controller.modelAndView.model.posts.size() == 5
            controller.modelAndView.model.postsCount == 6
    }

    def 'Create post adds a new blag post and redirects'() {
        given:
            controller.params.title = 'title'
            controller.params.email = 'test@test.com'
            controller.params.content = 'content'
            controller.params.tagName = 'tag'

        when:
            controller.createPost()
            def posts = Post.first()

        then:
            posts.title == 'title'
            posts.email == 'test@test.com'
            posts.content == 'content'
            posts.category.tagName == 'tag'
            response.redirectUrl.endsWith('/list')
    }

    def 'Create post with errors renders create page'() {
        given:
            controller.params.title = 'title'

        when:
            controller.createPost()

        then:
            view.endsWith('/create')
    }
}
