package posscard

class TicketType {//按电影票不同的类型选择扣点数
    String name //类型名称
    Float point //扣点数
    Float accountPoint //结算点数
    Float accountRatio //结算比例
    Date  dateCreated //创建时间
    static constraints = {
        name() //类型名称
        point() //扣点数
        accountPoint() //结算点数
        accountRatio() //结算比例
        dateCreated() //创建时间
    }
    static belongsTo = [supplier: Supplier]
}
