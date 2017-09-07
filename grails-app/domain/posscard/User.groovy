package posscard

class User {
    String username
    String password
    String phone
    String accountType
    Integer createTime //创建时间

    static constraints = {
        username(blank: false,size: 2..10)
        password(password:true,size: 6..20,blank: false)
        phone(matches: /\d{7,11}/,blank: false)
        supplierId(blank:false)
        accountType(blank:false,inList: ["1","2","3","4"])
    }

    static belongsTo = [supplierId: Supplier]
}
