package posscard

class CardBin {//卡bin
    String cardbin //卡bin,卡号前6位
    Date dateCreated//创建时间

    static constraints = {
        cardbin(blank: false, nullable: false)
        dateCreated(display: false)
    }

    static hasMany = [cardbinPlatform: CardbinPlatform]
}
