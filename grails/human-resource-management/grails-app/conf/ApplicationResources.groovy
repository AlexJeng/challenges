modules = {
    application {
        dependsOn 'jquery'
        resource url: 'js/application.js'
        resource url: 'css/main.css'
        resource url: 'css/mobile.css'
    }

    login {
        resource url: 'css/login.css'
    }

    datepicker {
        resource url: 'css/smoothness/jquery-ui-1.10.0.custom.css'
        resource url: 'js/jquery-ui-1.10.0.custom.js'
    }
}
