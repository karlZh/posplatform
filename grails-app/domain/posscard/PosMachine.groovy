package posscard

class PosMachine {
    Integer supplierId
    Integer userId
    Integer createTime //创建时间

    static constraints = {
        supplierId()
        userId()
        createTime(display:false)
    }
}
