package com.arturoherrero

import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode
class Project {
    String name
    String code
    String techLead
    String manager
    Date delivery
    Phase phase = Phase.briefing
    Integer priority

    static constraints = {
        name blank: false
        code blank: false, unique: true
        techLead blank: false
        manager blank: false
        priority min: 1
    }
}
