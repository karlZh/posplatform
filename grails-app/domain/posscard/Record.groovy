package posscard

class Record {
    String user
    Date loginTime//登录时间
    Integer  accountType//用户类型



    static constraints = {
        user(blank:false, size: 2..10, nullable: false)

        loginTime()

        accountType()
    }
}
