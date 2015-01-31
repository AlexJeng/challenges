package sysemag.grailsexercise

import groovy.time.TimeCategory
import spock.lang.Specification


class EmployeeSpec extends Specification {

    def userData = [
        fullName: 'Arturo Herrero',
        startDate: new Date(),
        holidayAllowance: 20
    ]

    def "an employee has a unique full name"() {
        setup:
        def existingEmployee = new Employee(userData).save()

        when:
        def employee = new Employee(userData)

        then:
        false == employee.validate()
        "unique" == employee.errors["fullName"].code
    }

    def "an employee has a case-insensitive unique full name"() {
        setup:
        def existingEmployee = new Employee(userData).save()

        when:
        def employee = new Employee(userData + [fullName: userData.fullName.toUpperCase()])

        then:
        false == employee.validate()
        "validator.invalid" == employee.errors["fullName"].code
    }

    def "update an employee full name works with custom validator"() {
        given:
        def existingEmployee = new Employee(userData).save()

        when:
        existingEmployee.fullName = "Arturo"
        existingEmployee.save()

        then:
        true == existingEmployee.validate()
    }

    def "an employee has a start date which cannot be in the future"() {
        when:
        def employee = new Employee(userData + [startDate: startDate])

        then:
        validate == employee.validate()
        errorCode == employee.errors["startDate"]?.code

        where:
        startDate      | validate | errorCode
        new Date() - 1 | true     | null
        new Date()     | true     | null
        new Date() + 1 | false    | 'validator.invalid'
    }

    def "an employee has a holiday allowance with a minimum of 20 days"() {
        when:
        def employee = new Employee(userData + [holidayAllowance: holidayAllowance])

        then:
        validate == employee.validate()
        errorCode == employee.errors["holidayAllowance"]?.code

        where:
        holidayAllowance | validate | errorCode
        19               | false    | 'min.notmet'
        20               | true     | null
        21               | true     | null
    }

    def "an employee has a holiday allowance with a maximum of 25 days who's start date is less than a year ago"() {
        when:
        def employee = new Employee(userData + [holidayAllowance: holidayAllowance])

        then:
        validate == employee.validate()
        errorCode == employee.errors["holidayAllowance"]?.code

        where:
        holidayAllowance | validate | errorCode
        24               | true     | null
        25               | true     | null
        26               | false    | 'validator.invalid'
    }

    def "an employee has a holiday allowance with a maximum of 30 days who's start date is a year ago or more"() {
        def startDate
        use(TimeCategory) {
            startDate = 1.year.ago
        }

        when:
        def employee = new Employee(userData + [startDate: startDate, holidayAllowance: holidayAllowance])

        then:
        validate == employee.validate()
        errorCode == employee.errors["holidayAllowance"]?.code

        where:
        holidayAllowance | validate | errorCode
        29               | true     | null
        30               | true     | null
        31               | false    | 'validator.invalid'
    }
}
