import blagger.Post

class BootStrap {

    def init = { servletContext ->

        def content = """\
        <dl>
            <dt>Validate inputs for a new blag post</dt>
            <dd>
                <ol>
                    <li>For a new blag post, ensure the following are true</li>
                        <ol>
                            <li>There is a title of at least 3 characters</li>
                            <li>There is a valid email address</li>
                            <li>There is some content</li>
                        </ol>
                    <li>Display any relevant errors alongside the form controls</li>
                </ol>
            </dd>
            <dt>Paginate blag posts</dt>
            <dd>
                <ol>
                    <li>On the home page, paginate the blag posts, 5 at a time</li>
                </ol>
            </dd>
            <dt>Add the ability to create tags on new blag posts</dt>
            <dd>
                <ol>
                    <li>Add the ability to tag a new blag post with a (single) category</li>
                    <li>Use a typeahead control to suggest existing tags once at least 3 characters have been entered</li>
                    <li>Allow the filtering of blag posts by tag on the home page</li>
                </ol>
            </dd>
            <dt>Create and email a patch with your changes as specified in Git<dt>
        </dl>
        """

        Post post = new Post(title: 'Your challenge if you choose to accept it...', email: 'info@underwriteme.co.uk', content: content)
        post.save()

    }
    def destroy = {
    }
}
