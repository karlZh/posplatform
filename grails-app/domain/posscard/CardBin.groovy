package posscard

class CardBin {//卡bin
    Integer cardPlatformId //商户id（卡平台id）
    Date  dateCreated//创建时间

    static constraints = {
        cardPlatformId()
        dateCreated(display:false)
    }
}
