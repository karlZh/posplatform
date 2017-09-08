package posscard

class CardbinPlatform {//卡bin 商户表
    Integer cardbinId //卡bin id
    Integer cardPlatformId //商户id
    Date  dateCreated //创建时间

    static constraints = {
        cardbinId()
        cardPlatformId()
        dateCreated(display:false)
    }
}
