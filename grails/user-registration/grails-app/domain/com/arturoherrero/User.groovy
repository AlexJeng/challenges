package com.arturoherrero

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import org.springframework.context.i18n.LocaleContextHolder

@EqualsAndHashCode
@ToString
class User {
    String username
    String postalCode
    String email

    static constraints = {
        username blank: false, unique: true
        postalCode blank: false
        email blank: false, validator: emailValidator
    }

    static emailValidator = { email ->
        switch(LocaleContextHolder.locale) {
            case new Locale('en', 'EN'):
                email ==~ /.*(.org.uk|.co.uk|.biz)$/
            break
            case new Locale('pt', 'BR'):
                email ==~ /.*(.org.br|.info)$/
            break
            case new Locale('es', 'ES'):
                email ==~ /.*(.acrede-es|.acrede)$/
            break
            default:
                false
        }
    }
}
