package posscard

class PageController {

    def index() {
//        params.Max=params.max?:2
//           //设置最大值，没有的话设置10
//       params.offset=params.offset?:0
//            //设置起始页，没有的话设置0
//        def dd=DD.list(max: Params.Max,offset: Params.offset)
//           //根据自己的属性Max、offset查询数据库
//        params.total=dd.totalCount
//           //TotalCount属性相当于DD.list()
//        [ddList:dd,params:params]
//          //给页面传值
//
//        SELECT * FROM student LIMIT (PageNo - 1) * PageSize,PageSize;
//
//
////        params.max = Math.min(params.max ? params.max.toInteger() : 15,  100)
////        params.offset = params.offset ? params.offset.toInteger() : 0;
////        def offsetAfter = params.offset + 15
////
////        //  2  对sql语句进行分页
////        def  rowsql="""SELECT * FROM (SELECT A.*,ROWNUM RN FROM("""+sql+""")A
////                       WHERE ROWNUM <= ${offsetAfter})WHERE RN> ${params.offset}""";
////
////        // 3.  计算sql语句执行的总数
////        def   sqlTotal=""" select count(*) total from ("""+sql+""")""";
////
////        [total:total]
//    }

    }
}
//<div class="paginateButtons">
//<g:paginate total="${total}" />
//</div>
//当然，如果你的list页面有查询条件，又想分页的时候点击下一页，查询条件仍然存在。你要做的事情有两个
//1.在controller中将值传给页面
//2 在页面的时候把值传给controller如：
//<div class="paginateButtons">
//<g:paginate total="${total}"  params="[lineId:lineId,choose:choose,addressCode:addressCode]" />
//</div>
