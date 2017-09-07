package posscard

class User {
    String username
    String password
    String phone = ''
    Integer supplierId = 0
    Integer accountType
    Integer createTime //创建时间

    static constraints = {
        username(blank:false, nullable: false, unique: true)
        password(blank:false, nullable: false)
        phone(nullable: false, matches: "0?(13|14|15|18)[0-9]{9}", minSize: 11)
        supplierId(nullable: false)
        accountType(nullable: false)
    }
}
