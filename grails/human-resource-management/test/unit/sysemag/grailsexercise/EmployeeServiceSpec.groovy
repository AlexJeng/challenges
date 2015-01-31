package sysemag.grailsexercise

import spock.lang.Specification


@TestFor(EmployeeService)
@Mock(Employee)
class EmployeeServiceSpec extends Specification {

    def "get a list of employees filter by dates"() {
        setup:
        def service = new EmployeeService()

        and:
        5.times {
            new Employee(
                fullName: "$it. Arturo Herrero",
                startDate: new Date() - it,
                holidayAllowance: 20
            ).save(flush: true)
        }

        expect:
        service.filterByDates([fromDate: fromDate, toDate: toDate]).size() == employees

        where:
        fromDate                   | toDate                     | employees
        new Date().clearTime()     | new Date().clearTime()     | 1
        new Date().clearTime() - 2 | new Date().clearTime() - 1 | 2
        new Date().clearTime() - 1 | new Date().clearTime()     | 2
        new Date().clearTime() - 9 | new Date().clearTime()     | 5
    }

}
