package com.arturoherrero

import spock.lang.Specification

class UserRepositorySpec extends Specification {

    private user = new User(
        username: 'arturoherrero',
        postalCode: '28025',
        email: 'arturo@herrero.acrede'
    )

    def "user as XML"() {
        when:
        def userXml = UserRepository.userAsXML(user)

        then:
        assert userXml == '<user><email>arturo@herrero.acrede</email><id/><postalCode>28025</postalCode><username>arturoherrero</username><version/></user>'
    }

    def "save a user in a empty repository"() {
        setup:
        def file = UserRepository.repository

        when:
        UserRepository.save(user)

        then:
        file.exists() == true
        file.readLines().first() == '<user><email>arturo@herrero.acrede</email><id/><postalCode>28025</postalCode><username>arturoherrero</username><version/></user>'

        cleanup:
        file.delete()
    }

    def "list the users of the repository"() {
        setup:
        def file = UserRepository.repository
        file.write('<users><user><email>arturo@herrero.acrede</email><id/><postalCode>28025</postalCode><username>arturoherrero</username><version/></user></users>')

        when:
        def userList = UserRepository.list()

        then:
        userList == [user]

        cleanup:
        file.delete()
    }
}
