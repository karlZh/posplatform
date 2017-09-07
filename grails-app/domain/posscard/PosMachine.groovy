package posscard

class PosMachine {
    Integer userId
    Integer createTime //创建时间

    static constraints = {
        supplierId()
        userId()


        createTime(blank:false, nullable: false, display:false)


    }
    static belongsTo = [supplierId: Supplier]
}
