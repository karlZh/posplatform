package posscard

class User {
    String username
    String password
    String phone = ''
    String  accountType
    Date  dateCreated//创建时间


    static constraints = {
        username(blank:false, size: 4..10, nullable: false, unique: true)
        password(password: true, blank:false, size: 6..20, nullable: false)
        phone(nullable: false, matches: "0?(13|14|15|18)[0-9]{9}", minSize: 11)
        accountType(nullable: true,inList: ["pos机","总后台","商户","供应商"])//1.pos机2.自己平台3.商户4.供应商
        dateCreated(display:false)
        supplier(nullable: true)
    }

    static belongsTo = [supplier: Supplier]

}
