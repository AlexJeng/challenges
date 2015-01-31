package com.arturoherrero

class ProjectController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect action: 'list'
    }

    def list() {
        params.sort = 'priority'
        params.order = 'asc'
        render view: 'list', model: [projectInstanceList: Project.list(params)]
    }

    def create() {
        render view: 'create', model: [projectInstance: new Project()]
    }

    def save() {
        def projectInstance = new Project(params)
        if (projectInstance.validate()) {
            projectInstance.save(flush: true)
            flash.message = message(code: 'default.created.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])
            redirect action: 'show', id: projectInstance.id
        }
        else {
            render view: 'create', model: [projectInstance: projectInstance]
        }
    }

    def show(Long id) {
        def projectInstance = Project.get(id)
        if (projectInstance) {
            render view: 'show', model: [projectInstance: projectInstance]
        }
        else {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect action: 'list'
        }
    }

    def edit(Long id) {
        def projectInstance = Project.get(id)
        if (projectInstance) {
            render view: 'edit', model: [projectInstance: projectInstance]
        }
        else {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect action: 'list'
        }
    }

    def update(Long id, Long version) {
        def projectInstance = Project.get(id)
        if (projectInstance) {
            projectInstance.properties = params
            if (projectInstance.validate()) {
                projectInstance.save(flush: true)
                flash.message = message(code: 'default.updated.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])
                redirect action: 'show', id: projectInstance.id
            }
            else {
                render view: 'edit', model: [projectInstance: projectInstance]
            }
        }
        else {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
            redirect action: 'list'
        }
    }

    def delete(Long id) {
        def projectInstance = Project.get(id)
        if (projectInstance) {
            projectInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'project.label', default: 'Project'), id])
        }
        else {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), id])
        }
        redirect action: 'list'
    }
}
