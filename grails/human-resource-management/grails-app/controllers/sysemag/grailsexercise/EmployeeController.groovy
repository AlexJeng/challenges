package sysemag.grailsexercise

import grails.plugins.springsecurity.Secured


@Secured(['ROLE_HR'])
class EmployeeController {

    def grailsApplication
    def employeeService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    @Secured(['ROLE_STANDARD'])
    def index() {
        redirect action: 'list'
    }

    @Secured(['ROLE_STANDARD'])
    def list() {
        render view: 'list', model:[
            employeeInstanceList: chainModel?.employeeInstanceList ?: Employee.list(params),
            tab: 'list'
        ]
    }

    @Secured(['ROLE_STANDARD'])
    def filter(FilterDateCommand filterDateCommand) {
        params.fromDate = params.date('fromDate', grailsApplication.config.datePattern)
        params.toDate = params.date('toDate', grailsApplication.config.datePattern)
        filterDateCommand.properties = params

        if (filterDateCommand.validate()) {
            def employeeInstanceList = employeeService.filterByDates(filterDateCommand)
            chain action: 'list', model: [employeeInstanceList: employeeInstanceList]
        }
        else {
            flash.message = message(code: 'filter.date.error')
            redirect action: 'list'
        }
    }

    def create() {
        render view: 'create', model: [
            employeeInstance: new Employee(),
            tab: 'create'
        ]
    }

    def save() {
        params.startDate = params.date('startDate', grailsApplication.config.datePattern)
        def employeeInstance = new Employee(params)

        if (employeeInstance.validate()) {
            employeeInstance.save(flush: true)
            flash.message = message(code: 'employee.created.message', args: [employeeInstance.fullName])
            redirect action: 'list'
        }
        else {
            render view: 'create', model: [employeeInstance: employeeInstance]
        }
    }

    def edit(Long id) {
        def employeeInstance = Employee.get(id)

        if (employeeInstance) {
            render view: 'edit', model: [
                employeeInstance: employeeInstance,
                tab: 'edit'
            ]
        }
        else {
            flash.message = message(code: 'employee.not.found.message', args: [id])
            redirect action: 'list'
        }
    }

    def update(Long id) {
        def employeeInstance = Employee.get(id)

        if (employeeInstance) {
            params.startDate = params.date('startDate', grailsApplication.config.datePattern)
            employeeInstance.properties = params

            if (employeeInstance.validate()) {
                employeeInstance.save(flush: true)
                flash.message = message(code: 'employee.updated.message', args: [employeeInstance.fullName])
                redirect action: 'list'
            }
            else {
                render view: 'edit', model: [employeeInstance: employeeInstance]
            }
        }
        else {
            flash.message = message(code: 'employee.not.found.message', args: [id])
            redirect action: 'list'
        }
    }

    def delete(Long id) {
        def employeeInstance = Employee.get(id)

        if (employeeInstance) {
            employeeInstance.delete(flush: true)
            flash.message = message(code: 'employee.deleted.message', args: [id])
        }
        else {
            flash.message = message(code: 'employee.not.found.message', args: [id])
        }

        redirect action: "list"
    }

}


class FilterDateCommand {

    Date fromDate
    Date toDate

    static constraints = {
        fromDate validator: { val, obj -> val <= obj.toDate }
        toDate validator: { val, obj -> val >= obj.toDate }
    }

}
