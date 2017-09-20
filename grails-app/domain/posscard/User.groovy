package posscard

class User {
    String username
    String password
    String phone = ''
    Integer accountType //用户类型pos机，商户，供应商
    Integer uTypeId = 0 //对应用户类型的pos机，商户，供应商的id
    Date  dateCreated//创建时间


    static constraints = {
        username(blank:false, size: 2..10, nullable: false, unique: true)
        password(password: true, blank:false, size: 6..20, nullable: false)
        phone(nullable: false, matches: "0?(13|14|15|18)[0-9]{9}", minSize: 11)
        accountType(nullable: true)//1.pos机2.自己平台3.商户4.供应商
        uTypeId(nullable: false, display:false)
        dateCreated(display:false)

    }

}
