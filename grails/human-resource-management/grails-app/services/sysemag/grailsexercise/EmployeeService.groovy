package sysemag.grailsexercise


class EmployeeService {

    def filterByDates(filterDateCommand) {
        Employee.withCriteria {
            between('startDate', filterDateCommand.fromDate, filterDateCommand.toDate)
        }
    }

}
