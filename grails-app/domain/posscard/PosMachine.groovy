package posscard

class PosMachine {
    Integer userId
    Integer createTime //创建时间

    static constraints = {
        supplierId()
        userId()
<<<<<<< HEAD
        createTime(display:false)
=======
        createTime(blank:false, nullable: false, display:false)
>>>>>>> cb6f977e8cb707ad9d1e35fee36052ff4f7d32c9
    }
    static belongsTo = [supplierId: Supplier]
}
