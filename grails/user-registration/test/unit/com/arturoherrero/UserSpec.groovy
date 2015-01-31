package com.arturoherrero

import org.springframework.context.i18n.LocaleContextHolder
import spock.lang.Specification
import spock.lang.Unroll

class UserSpec extends Specification {

    private userData = [
        username: 'arturoherrero',
        postalCode: '28025',
        email: 'arturo@herrero.acrede'
    ]

    def "an user has a unique username"() {
        setup:
        def existingUser = new User(userData).save()

        when:
        def user = new User(userData)

        then:
        !user.validate()
        user.errors["username"].code == 'unique'
    }

    @Unroll
    def "an English user with email: #email validate as #validate"() {
        setup:
        LocaleContextHolder.locale = new Locale('en', 'EN')

        when:
        def user = new User(userData + [email: email])

        then:
        user.validate() == validate

        where:
        email                      | validate
        'arturo@herrero.org.uk'    | true
        'arturo@herrero.co.uk'     | true
        'arturo@herrero.biz'       | true
        'arturo@herrero.org.br'    | false
        'arturo@herrero.info'      | false
        'arturo@herrero.acrede'    | false
        'arturo@herrero.acrede-es' | false
        'arturo@herrero.com'       | false
    }

    @Unroll
    def "a Brazilean user with email: #email validate as #validate"() {
        setup:
        LocaleContextHolder.locale = new Locale('pt', 'BR')

        when:
        def user = new User(userData + [email: email])

        then:
        user.validate() == validate

        where:
        email                      | validate
        'arturo@herrero.org.uk'    | false
        'arturo@herrero.co.uk'     | false
        'arturo@herrero.biz'       | false
        'arturo@herrero.org.br'    | true
        'arturo@herrero.info'      | true
        'arturo@herrero.acrede'    | false
        'arturo@herrero.acrede-es' | false
        'arturo@herrero.com'       | false
    }

    @Unroll
    def "a Spanish user with email: #email validate as #validate"() {
        setup:
        LocaleContextHolder.locale = new Locale('es', 'ES')

        when:
        def user = new User(userData + [email: email])

        then:
        user.validate() == validate

        where:
        email                      | validate
        'arturo@herrero.org.uk'    | false
        'arturo@herrero.co.uk'     | false
        'arturo@herrero.biz'       | false
        'arturo@herrero.org.br'    | false
        'arturo@herrero.info'      | false
        'arturo@herrero.acrede'    | true
        'arturo@herrero.acrede-es' | true
        'arturo@herrero.com'       | false
    }
}
