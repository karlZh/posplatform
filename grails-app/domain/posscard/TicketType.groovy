package posscard

class TicketType {//按电影票不同的类型选择扣点数
    String name //类型名称
    Integer supplierId //供应商id
    Float point //扣点数
    Float accountPoint //结算点数
    Float accountRatio //结算比例
    Integer createTime //创建时间
    static constraints = {
    }
}
