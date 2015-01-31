import sysemag.grailsexercise.*

class BootStrap {

    def init = { servletContext ->

        def hrRole = new Role(authority: 'ROLE_HR').save(flush: true)
        def standardRole = new Role(authority: 'ROLE_STANDARD').save(flush: true)

        def hrUser = new User(username: 'hr', enabled: true, password: 'hr').save(flush: true)
        UserRole.create hrUser, hrRole, true
        UserRole.create hrUser, standardRole, true

        def standardUser = new User(username: 'standard', enabled: true, password: 'standard').save(flush: true)
        UserRole.create standardUser, standardRole, true

        20.times {
            new Employee(
                fullName: "$it. Arturo Herrero",
                startDate: new Date() - it,
                holidayAllowance: 20
            ).save(flush: true)
        }

        assert User.count() == 2
        assert Role.count() == 2
        assert UserRole.count() == 3
    }

    def destroy = {
    }
}
