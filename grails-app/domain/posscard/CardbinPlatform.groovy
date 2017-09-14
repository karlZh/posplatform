package posscard

class CardbinPlatform {//卡bin 商户表
    Date dateCreated//创建时间
//    String cardbinId
//   String  cardPlatformId

    static constraints = {
        cardbinId()
        cardPlatformId()
        dateCreated(display:false)
    }
    static belongsTo = [cardbinId: CardBin, cardPlatformId: CardPlatform]
}
