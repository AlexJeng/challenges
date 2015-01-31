package sysemag.grailsexercise

import spock.lang.Specification
import spock.lang.Unroll


@TestFor(EmployeeController)
@Mock(Employee)
class EmployeeControllerSpec extends Specification {

    def "index action redirects to list action"() {
        when:
        controller.index()

        then:
        response.redirectedUrl == '/employee/list'
    }

    def "test list action"() {
        when:
        controller.list()

        then:
        view == '/employee/list'
        model.employeeInstanceList.size() == 0
        model.tab == 'list'
    }

    def "test create action"() {
        when:
        controller.create()

        then:
        model.employeeInstance != null
        model.tab == 'create'
    }

    def "save an employee without params"() {
        when:
        controller.save()

        then:
        model.employeeInstance != null
        view == '/employee/create'
    }

    def "save an employee"() {
        given:
        populateValidParams(params)
        assert Employee.count() == 0

        when:
        controller.save()

        then:
        Employee.count() == 1
        response.redirectedUrl == '/employee/list'
        flash.message != null
    }

    def "edit an employee not founded"() {
        when:
        controller.edit()

        then:
        flash.message != null
        response.redirectedUrl == '/employee/list'
    }

    def "edit an employee"() {
        given:
        def employee = new Employee(employeeValidProperties).save()

        when:
        params.id = employee.id
        controller.edit()

        then:
        view == '/employee/edit'
        model.employeeInstance == employee
        model.tab == 'edit'
    }

    def "update an employee successfully"() {
        given:
        def employee = new Employee(employeeValidProperties).save()
        assert employee.fullName == 'Arturo Herrero'

        when:
        params.id = employee.id
        params.fullName = 'Arturo'
        controller.update()

        then:
        employee.fullName == 'Arturo'
    }

    def "delete an employee"() {
        given:
        def employee = new Employee(employeeValidProperties).save()
        assert Employee.count() == 1

        when:
        params.id = employee.id
        controller.delete()

        then:
        Employee.count() == 0
        response.redirectedUrl == '/employee/list'
    }


    @Unroll
    def "FilterDateCommand with fromDate: #fromDate and toDate: #toDate validate as #validate"() {
        given:
        def filterDateCommand = mockCommandObject(FilterDateCommand)
        filterDateCommand.fromDate = fromDate
        filterDateCommand.toDate = toDate

        expect:
        filterDateCommand.validate() == validate

        where:
        fromDate       | toDate     | validate
        new Date() - 1 | new Date() | true
        new Date()     | new Date() | true
        new Date() + 1 | new Date() | false
    }


    private populateValidParams(params) {
        params.fullName = 'Arturo Herrero'
        params.startDate = new Date().format('yyyy-MM-dd')
        params.holidayAllowance = '20'
    }

    private employeeValidProperties = [
        fullName: 'Arturo Herrero',
        startDate: new Date(),
        holidayAllowance: 20
    ]

}
