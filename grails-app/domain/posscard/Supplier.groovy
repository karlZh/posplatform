package posscard

class Supplier {
    String name
    Float ratio //结算比例
    Float price //结算价格
    String address //地址
    String phone //电话
    String remark //备注
    Integer parentId //父供应商id
    Integer createTime //创建时间

    static constraints = {
    }
}
