package posscard

class CardBin {//卡bin
    Integer cardPlatformId //商户id（卡平台id）
    Integer createTime //创建时间

    static constraints = {
        cardPlatformId()
        createTime()
    }
}
