package com.yks.detector

import java.util.concurrent.ConcurrentHashMap
import spock.lang.*


class HackerDetectorSystemSpec extends Specification {
    def hackerDetector = new HackerDetectorSystem()

    def "sucessful login returns blank"() {
        expect:
        '' == hackerDetector.parseLine('80.238.9.179,133612947,SIGNIN_SUCCESS,Dave.Branning')
    }

    def "5 or more consecutive failure logins returns ip address"() {
        def logLine = '80.238.9.179,133612947,SIGNIN_FAILURE,Dave.Branning'

        expect:
        4.times { assert '' == hackerDetector.parseLine(logLine) }
        '80.238.9.179' == hackerDetector.parseLine(logLine)
        '80.238.9.179' == hackerDetector.parseLine(logLine)
    }

    def "5 or more failure logins within a 5 minutes period returns ip address"() {
        def logLine = '80.238.9.179,133612947,SIGNIN_FAILURE,Dave.Branning'
        def logLineSixMinutesAfter = '80.238.9.179,133613307,SIGNIN_FAILURE,Dave.Branning'

        expect:
        4.times { assert '' == hackerDetector.parseLine(logLine) }
        4.times { assert '' == hackerDetector.parseLine(logLineSixMinutesAfter) }
        '80.238.9.179' == hackerDetector.parseLine(logLineSixMinutesAfter)
        '80.238.9.179' == hackerDetector.parseLine(logLineSixMinutesAfter)
    }
}


class FailedLoginRepositorySpec extends Specification {
    def failedLoginRepository = new FailedLoginRepository()

    def "record one failed login"() {
        when:
        failedLoginRepository.recordFailedLogin('80.238.9.179', '1336129471')

        then:
        failedLoginRepository.failedLoginsPerIP == ['80.238.9.179': ['1336129471']]
    }

    def "record failed logins with the same ip"() {
        when:
        failedLoginRepository.recordFailedLogin('80.238.9.179', '1336129471')
        failedLoginRepository.recordFailedLogin('80.238.9.179', '1336129472')

        then:
        failedLoginRepository.failedLoginsPerIP == ['80.238.9.179': ['1336129471', '1336129472']]
    }

    def "record failed logins with differents ip"() {
        when:
        failedLoginRepository.recordFailedLogin('80.238.9.179', '1336129471')
        failedLoginRepository.recordFailedLogin('80.238.9.179', '1336129472')
        failedLoginRepository.recordFailedLogin('180.238.9.179', '1336129473')

        then:
        failedLoginRepository.failedLoginsPerIP == [
            '80.238.9.179': ['1336129471', '1336129472'],
            '180.238.9.179': ['1336129473']
        ]
    }

    def "delete for an ip the epoch dates greater than five minutes"() {
        setup:
        failedLoginRepository.recordFailedLogin('80.238.9.179', '1357938730')
        failedLoginRepository.recordFailedLogin('80.238.9.179', '1357938731')
        failedLoginRepository.recordFailedLogin('80.238.9.179', '1357938732')
        failedLoginRepository.recordFailedLogin('80.238.9.179', '1357938733')

        when:
        failedLoginRepository.deleteLoginDatesGreaterThanFiveMinutes('80.238.9.179', '1357939032')

        then:
        failedLoginRepository.failedLoginsPerIP == ['80.238.9.179': ['1357938732', '1357938733']]
    }

    def "delete the epoch dates greater than five minutes"() {
        setup:
        4.times { failedLoginRepository.recordFailedLogin('80.238.9.179', '1357938731') }
        4.times { failedLoginRepository.recordFailedLogin('180.238.9.179', '1357938731') }
        failedLoginRepository.recordFailedLogin('220.238.9.179', '1357938733')

        when:
        failedLoginRepository.deleteLoginDatesGreaterThanFiveMinutes('1357939032')

        then:
        failedLoginRepository.failedLoginsPerIP == [
            '80.238.9.179': [],
            '180.238.9.179': [],
            '220.238.9.179': ['1357938733']
        ]
    }
}


class FailedLoginCounterSpec extends Specification {
    def failedLoginCounter = new FailedLoginCounter()

    def "do and action each 1000 failed login count"() {
        def count = 0

        when:
        2000.times {
            failedLoginCounter.incrementFailedLoginCount()
            failedLoginCounter.doEach1000FailedLoginCount { count++ }
        }

        then:
        2 == count
    }
}


class EpochTimerSpec extends Specification {
    def epochTimer = new EpochTimer()

    def "five minutes ago for an epoch date"() {
        expect:
        '1357938731' == epochTimer.fiveMinutesAgo('1357939031')
    }
}
