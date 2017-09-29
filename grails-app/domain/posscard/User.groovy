package posscard

class User {
    String username
    String password
    String phone = ''
    Integer accountType //用户类型pos机，商户，供应商
    Long uTypeId //对应用户类型的pos机，商户，供应商的id
    Short   isdelete = 0 //删除状态 0，未删 1：删除
    Date  dateCreated//创建时间
    Integer isLeader=0//是否是主管登陆是 1，是 0.不是


    static constraints = {
        username(blank:false, size: 2..10, nullable: false)
        password(password: true, blank:false, size: 6..20, nullable: false)
        phone(nullable: false, matches: "0?(13|14|15|18)[0-9]{9}", minSize: 11)
        accountType(nullable: false)//1.pos机2.自己平台3.商户4.供应商
        uTypeId(nullable: false)
        isdelete(nullable: false)
        dateCreated(display:false)
        isLeader(nullable: false,inList: [1,0])
    }

}
