package com.arturoherrero

import spock.lang.Specification

class ProjectSpec extends Specification {

    def projectData = [
        name: 'Test Project',
        code: '0001',
        techLead: 'Arturo Herrero',
        manager: 'Arturo Herrero',
        delivery: new Date(),
        priority: 1
    ]

    def "a project has a unique code"() {
        setup:
        def existingProject = new Project(projectData).save()

        when:
        def project = new Project(projectData)

        then:
        false == project.validate()
        'unique' == project.errors['code'].code
    }
}
