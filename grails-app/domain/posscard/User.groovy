package posscard

class User {
    String username
    String password
    String phone = ''
    Integer accountType
    Integer createTime //创建时间

    static constraints = {
        username(blank:false, size: 4..10, nullable: false, unique: true)
        password(password: true, blank:false, size: 6..20, nullable: false)
        phone(nullable: false, matches: "0?(13|14|15|18)[0-9]{9}", minSize: 11)
        accountType(nullable: false, inList: ["1","2","3","4"])
        createTime(display:false)
    }

    static belongsTo = [supplierId: Supplier]
}
