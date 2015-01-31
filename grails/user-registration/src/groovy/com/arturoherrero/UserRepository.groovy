package com.arturoherrero

import groovy.transform.WithWriteLock
import groovy.transform.WithReadLock
import groovy.xml.StreamingMarkupBuilder
import org.codehaus.groovy.grails.commons.DefaultGrailsDomainClass

class UserRepository {
    private final static repositoryXML = 'users.xml'
    private static repository = setupRepository()

    @WithWriteLock
    static save(user) {
        repository << "${userAsXML(user)}\n"
    }

    @WithReadLock
    static list() {
        def users = new XmlSlurper().parseText(repository.text)
        users.user.inject([]) { userList, user ->
            userList << new User(
                username: user.username.text(),
                postalCode: user.postalCode.text(),
                email: user.email.text()
            )
        }
    }

    private static setupRepository() {
        repository = new File(repositoryXML)
        if (!repository.exists()) repository.createNewFile()
        return repository
    }

    private static userAsXML(User userInstance) {
        def userDomain = new DefaultGrailsDomainClass(User)
        def xml = new StreamingMarkupBuilder().bind {
            user {
                userDomain.properties.each { property ->
                    def propertyName = property.name
                    "$propertyName"(userInstance."$propertyName")
                }
            }
        }
        xml as String
    }
}