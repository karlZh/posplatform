package posscard

class HelloController {

    def index() {
        def ap = grailsApplication.config.grails.views.gsp.encoding
        render "charset ${ap}"
    }
}
