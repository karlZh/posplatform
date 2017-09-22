package posscard



class LoginController {
    def index = {

        def channel = '07'
        def product = '10'
        String keyStr = '+p!ZKg$?xFZ,dynZ';
        def urlK = "0710SM8lvuzBkGUo6Jm%2FGHC0%2FiI6OGnwtOn%2B1C3QDnCjYsY%3D".decodeURL()
        def encText = urlK.substring(urlK.indexOf(channel+product)+4)
        String decString = CryptAES.AES_Decrypt(keyStr, encText);
        def cardnum = decString.substring(0,decString.indexOf("="))
            System.out.println(encText);
            System.out.println(decString);

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