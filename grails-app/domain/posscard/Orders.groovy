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
    }
}
