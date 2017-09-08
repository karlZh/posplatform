package posscard

class PosMachine {
    Integer userId
    Date  dateCreated //创建时间

    static constraints = {
        supplierId()
        userId()


        dateCreated(display:false)


    }
    static belongsTo = [supplierId: Supplier]
}
