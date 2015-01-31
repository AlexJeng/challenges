## Sysemag Grails Coding Exercise

### Constraints

The application should be written using Grails 1.3.7 or higher (preferably Grails 2.0+).

The default in-memory database that comes pre-configured with Grails should be used.

Artefacts should be contained within a package (e.g. sysemag.grailsexercise) and not use
the default package.

The application should run first time by using the grails run-app command.


### Specification

As a HR user, I'd like to be able to record a list of employees along with the start date of
their employment and their holiday allowance.

An employee will have the following attributes:

* a case-insensitive unique full name (for the purposes of this exercise there is only
one 'John Smith' in the world, and 'john smith' equals 'JOHN SMITH')

* a start date which cannot be in the future

* a holiday allowance with a minimum of 20 days and a maximum of 25 days for an
employee who's start date is less than a year ago, with a maximum of 30 days
otherwise


Only users with the HR role will be able to create and edit employees.

All users will be able to view a list of employees that can be filtered by start date using a to
and from date range.

Any user can view the details of an employee but only HR users will be able to see the
employee's holiday allowance.


### Guidelines

The following is a list of what we might expect to see in your solution:

* Use of a suitable Grails plugin to provide security functionality

* Creation of a default HR user and role, a standard user and role, and some dummy
employee data that are available on application start up

* Use of more advanced querying rather than using dynamic finders

* Test-driven development (does not need to be extensive)

* Implementation of services

* Use of custom taglibs


The following is a list of what might be a bonus in your application:

* Use of a command object

* Demonstration of creating rich UI interfaces (for example, implementing jQuery UI
datepicker in place of the standard Grails datepicker)

* Customisation of the URLs used within the application

* Timestamping of employee records

* Tests written using the Spock framework (if you have any previous experience of
this)
