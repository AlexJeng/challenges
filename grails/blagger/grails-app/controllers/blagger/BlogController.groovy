package blagger

import grails.converters.JSON

class BlogController {

    static defaultAction = 'list'

    def list() {
        def posts = Post.list(defaultQueryParams())
        def postsCount = Post.count()
        renderPosts(posts, postsCount)
    }

    def listByTagName() {
        def posts = Post.findAll(defaultQueryParams()) {
            category.tagName == this.params.tagName
        }
        def postsCount = Post.createCriteria().count {
            category {
                eq 'tagName', this.params.tagName
            }
        }
        renderPosts(posts, postsCount)
    }

    def create() {
        [
            post: new Post(params),
            tagNames: Category.findAllTagNames() as JSON,
        ]
    }

    def createPost() {
        def post = createPostFromParams()

        if (post.validate()) {
            post.save(flush: true)
            redirect(action: 'list')
        }
        else {
            render(view: 'create', model: [post: post])
        }
    }

    private defaultQueryParams() {
        [max: 5, offset: params.int('offset'), sort: 'id', order: 'desc']
    }

    private renderPosts(posts, postsCount) {
        render(
            view: 'list',
            model: [
                posts: posts,
                postsCount: postsCount,
                tagNames: Category.findAllTagNames() as JSON,
            ]
        )
    }

    private createPostFromParams() {
        def post = new Post(params)
        if (params.tagName) {
            post.category = Category.findOrCreateByTagName(params.tagName)
        }
        post
    }
}
