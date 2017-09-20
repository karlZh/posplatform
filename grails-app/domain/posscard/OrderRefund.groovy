package posscard

class OrderRefund {
    String cardNum
    Float amount //退款金额
    Integer cardPlatformId //商户id
    Integer supplierId //供应商id
    Date  dateCreated //创建时间
    String orderSn //订单号
    Integer num //张数
    String refundOrderSn //需退款订单号
    String serialNum //流水号D
    Short orderStatus //订单状态0未成功，1已成功
    String transId = '' //卡平台流水号
    static constraints = {
        cardNum()
        amount() //应扣订单总金额
        cardPlatformId() //商户id
        supplierId() //供应商id
        dateCreated(display:false)//创建时间
        orderSn(nullable: false) //订单号
        num() //张数
        refundOrderSn(nullable: false)
        serialNum() //流水号D
        orderStatus(nullable: false)
        transId(nullable: false)
    }
}
