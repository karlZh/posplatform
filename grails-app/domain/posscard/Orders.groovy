package posscard

class Orders {
    String cardNum
    String password
    Float amount //应扣订单总金额
    Float actualAmount //实扣总金额
    Integer cardPlatformId //商户id 
    Integer supplierId //供应商id
    Date  dateCreated //创建时间
    Integer orderType //订单类型，消费或退款
    Integer num //张数
    Integer ticketTypeId //票消费类型
    Integer validity //有效期
    String orderSn //订单号
    String serialNum //流水号D
    Short orderStatus //订单状态0未成功，1已成功
    String transId = '' //卡平台流水号
    static constraints = {
        cardNum()
        password(password:true, nullable: true)
        amount() //应扣订单总金额
        actualAmount(nullable: true) //实扣总金额
        cardPlatformId() //商户id
        supplierId() //供应商id
        dateCreated(display:false)//创建时间
        orderType(inList: [1,2]) //订单类型，消费1或退款2
        num() //张数
        ticketTypeId() //票消费类型
        validity() //有效期
        orderSn() //订单号
        serialNum() //流水号D
    }
}
