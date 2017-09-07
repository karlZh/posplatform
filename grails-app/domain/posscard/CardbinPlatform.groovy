package posscard

class CardbinPlatform {//卡bin 商户表
    Integer cardbinId //卡bin id
    Integer cardPlatformId //商户id
    Integer createTime //创建时间

    static constraints = {
        cardbinId()
        cardPlatformId()
        createTime(display:false)
    }
}
