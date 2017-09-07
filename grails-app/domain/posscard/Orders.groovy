package posscard

class Orders {
    String cardNum
    String password
    Float amount //应扣订单总金额
    Float actualAmount //实扣总金额
    Integer cardPlatformId //商户id
    Integer supplierId //供应商id
    Integer createTime //创建时间
    Integer orderType //订单类型，消费或退款
    Integer count //张数
    Integer ticketTypeId //票消费类型
    Integer validity //有效期
    String orderSn //订单号
    String serialNum //流水号D
    static constraints = {
         cardNum()
         password(password:true)
         amount() //应扣订单总金额
         actualAmount() //实扣总金额
         cardPlatformId() //商户id
         supplierId() //供应商id
         createTime() //创建时间
         orderType(inList: ["1","2"]) //订单类型，消费1或退款2
         count() //张数
         ticketTypeId() //票消费类型
         validity() //有效期
         orderSn() //订单号
         serialNum() //流水号D
    }
}
