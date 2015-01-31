package com.arturoherrero

import groovy.transform.Canonical

@Canonical
class Journal {
    String name
    BigDecimal score
    Boolean review = false
}
