package com.yks.detector

import groovy.time.TimeCategory
import java.util.concurrent.ConcurrentHashMap


class HackerDetectorSystem implements HackerDetector {
    private logParser = new LogParser()
    private failedLoginRepository = new FailedLoginRepository()

    String parseLine(String line) {
        def (ip, date, action) = logParser.readLine(line)

        if (action.failure) {
            failedLoginRepository.recordFailedLogin(ip, date)
            failedLoginRepository.deleteLoginDatesGreaterThanFiveMinutes(ip, date)
            failedLoginRepository.fiveOrMoreFailedLogins(ip) ? ip : ''
        }
        else {
            ''
        }
    }
}


class LogParser {
    String ip
    String date
    LogAction action
    String username

    def readLine(String line) {
        (ip, date, action, username) = line.tokenize(/,/)
        return [ip, date, action]
    }
}


class FailedLoginRepository {
    /*  Map that save all failed logins by IP and its dates.
     *  [IP: [date, date, ...]]
     */
    private failedLoginsPerIP = new ConcurrentHashMap()
    private failedLoginCounter = new FailedLoginCounter()
    private epochTimer = new EpochTimer()

    def recordFailedLogin(String ip, String date) {
        failedLoginsPerIP[ip] = (failedLoginsPerIP[ip] ?: []) + [date]
        failedLoginCounter.incrementFailedLoginCount()
    }

    def deleteLoginDatesGreaterThanFiveMinutes(String ip, String date) {
        failedLoginsPerIP[ip] = failedLoginsPerIP[ip].findAll { failedDate ->
            failedDate >= epochTimer.fiveMinutesAgo(date)
        }
        failedLoginCounter.doEach1000FailedLoginCount() {
            deleteLoginDatesGreaterThanFiveMinutes(date)
        }
    }

    def deleteLoginDatesGreaterThanFiveMinutes(String date) {
        failedLoginsPerIP.each { entry ->
            deleteLoginDatesGreaterThanFiveMinutes(entry.key, date)
        }
    }

    def fiveOrMoreFailedLogins(String ip) {
        failedLoginsPerIP[ip].size() >= 5
    }
}


class FailedLoginCounter {
    private failedLoginCount = 0

    def incrementFailedLoginCount() {
        failedLoginCount++
    }

    def doEach1000FailedLoginCount = { closure ->
        if (failedLoginCount % 1000 == 0) closure()
    }
}


class EpochTimer {
    def fiveMinutesAgo(String epochDate) {
        use (TimeCategory) {
            Date date = new Date(0) + epochDate.toInteger().seconds
            Date fiveMinutesAgo = date - 5.minute
            millisecondsToSeconds(fiveMinutesAgo.time) as String
        }
    }

    private millisecondsToSeconds(milliseconds) {
        milliseconds / 1000
    }
}


enum LogAction {
    SIGNIN_SUCCESS,
    SIGNIN_FAILURE

    boolean isFailure() {
        this == SIGNIN_FAILURE
    }
}
