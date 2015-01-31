package sysemag.grailsexercise

import groovy.time.TimeCategory
import groovy.transform.EqualsAndHashCode


@EqualsAndHashCode
class Employee {

    String fullName
    Date startDate
    Integer holidayAllowance

    static constraints = {
        fullName unique: true, blank: false, validator: caseInsensitiveValidator
        startDate validator: beforeOrEqualTodayValidator
        holidayAllowance min: 20, validator: maxStartDateValidator
    }

    static caseInsensitiveValidator = { val, obj ->
        !Employee.findByFullNameIlikeAndIdNotEqual(val, obj.id)
    }

    static beforeOrEqualTodayValidator = { val ->
        val <= new Date()
    }

    static maxStartDateValidator = { val, obj ->
        use(TimeCategory) {
            obj.startDate?.after(1.year.ago) ?
            val <= 25 :
            val <= 30
        }
    }

    void setStartDate(Date startDate) {
        this.startDate = startDate?.clearTime()
    }
}
