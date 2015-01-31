package com.arturoherrero

class UserController {

    static allowedMethods = [save: 'POST']

    def save() {
        def userInstance = new User(params)
        if (userInstance.validate()) {
            UserRepository.save(userInstance)
            flash.message = message(code: 'user.created.message', args: [userInstance.username])
            redirect action: 'create'
        }
        else {
            render view: 'create', model: [userInstance: userInstance]
        }
    }
}
