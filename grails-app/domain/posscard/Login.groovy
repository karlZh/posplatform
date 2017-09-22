package posscard

class Login {
    String username
    String password
    static constraints = {
        username(nullable: false)
        password(password:true)
    }
}
