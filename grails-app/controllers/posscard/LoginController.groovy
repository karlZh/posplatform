package posscard



class LoginController {
    def index = {
        redirect(controller:'Login', action: 'login')
    }

    def login = {

    }

    def doLogin = {
        def a = params
        def user = User.findWhere(username:params['username'], password:params['password'])
        //session.setAttribute("user","user")
       session.user = user
        if (user)
            redirect(controller: 'User', action: 'list')
        else
            redirect(controller: 'Login', action: 'login')
    }
}