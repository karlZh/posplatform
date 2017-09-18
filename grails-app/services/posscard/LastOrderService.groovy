package posscard

class LastOrderService {
    def result=[status: 200,message: "",data:[:]]

    def last(data) {
        def last=Orders.findByDateCreatedGreaterThanAndDateCreated(da)


    }
}
//def result = [status: 200,message: "",data:[:]]
//def signIn(data) {
//    def user = User.findByUsernameAndPassword(data.username,data.password)
//
//    if(user){
//        getSession().user = user
//    }else{
//        result.status = 301
//        result.message = "用户不存在或密码错误！"
//        return result
//    }
//    result.message = "签到成功！"
//    return result
//}
