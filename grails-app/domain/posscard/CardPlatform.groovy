package posscard

class CardPlatform {//商户数据表
    String name
    String address
    Integer createTime //创建时间

    static constraints = {
        name()
        address()
        createTime()
    }
}
