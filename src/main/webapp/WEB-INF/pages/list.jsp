<%@ page import="com.pcalc.entity.User" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:import url="htmlframe/headFrame.jsp" />
<body class="skin-blue">
<!-- header logo: style can be found in header.less -->
<c:import url="htmlframe/headerFrame.jsp"/>
<div class="wrapper row-offcanvas row-offcanvas-left">
    <!-- Right side column. Contains the navbar and content of the page -->
    <%--<aside class="right-side">--%>
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                弁リスト
            </h1>
        </section>
    <!-- Main content -->
    <section class="content">
        <hr/>

        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header">

                        <div class="row">
                            <div class="col-md-1"><div class="box-title"><button class="btn btn-default btn-user" onclick="addMaster()"><i class="fa fa-plus"></i> </button></div></div>
                            <%--<div class="col-md-2">--%>
                                <%--<div class="box-title"><input type="text" placeholder="Filter" onclick="searchDataTd(this)" class="pull-right form-control" /></div>--%>
                            <%--</div>--%>
                            <div class="col-md-3">
                                <div class="box-title input-group">
                                    <input type="text" name="table_search" id="table_search" class="form-control input-sm" style="width: 150px;" placeholder="Filter">
                                    <div class="input-group-btn">
                                        <button class="btn btn-sm btn-default" id="table_search_btn" onclick="searchDataTd(this)"><i class="fa fa-search"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="panel-body">
                        <table class="table table-hover" id="user-table">
                            <thead>
                            <tr>
                                <th>弁番号</th>
                                <th>備考</th>
                                <th>更新日付</th>
                                <th>詳細</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${valveList}" var="valve">
                                <tr class="data-tr" id="${valve.valveId}">
                                    <td class="data-td">${valve.valdacNo}</td>
                                    <td class="data-td">${valve.biko}</td>
                                    <td class="data-td">${valve.updDate}</td>
                                    <td>
                                        <div class="operation-button">
                                            <%--<a class="btn btn-primary btn-sm operation-button-btn" href="/PCALC/valve/${valve.valveId}"><i class="fa fa-pencil"></i></a>--%>
                                            <a class="btn btn-primary" href="#"><i class="fa fa-pencil"></i></a>
                                        </div>
                                            <button onclick="deleteValve(this)" class="btn btn-xs btn-danger master-delete-btn"><i class="glyphicon glyphicon-trash"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

        </div>


        <!-- Modal -->
        <div class="modal fade content-modal" id="valveModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myModalLabel">弁</h4>
                    </div>
                    <div class="modal-body">
                        <form id="ValveForm" action="/PCALC/valve/add" name="ValveForm" method="post" onsubmit="return checkUser()">
                            <div class="panel panel-danger">
                                <div class="panel-heading">
                                    <h3 class="panel-title">弁情報</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="row form-group">
                                        <div class="col-md-2">
                                            弁番号(必須)
                                        </div>
                                        <div class="col-md-4">
                                            <input type="text" name="valdacNo" id="valdacNo" class="form-control valdacForm-input" value="" />
                                        </div>
                                        <div class="col-md-4">
                                            ※：重複登録できません
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-md-2">
                                            備考
                                        </div>
                                        <div class="col-md-4">
                                            <input type="text" name="biko" id="biko" class="form-control valdacForm-input" value="" />
                                        </div>
                                    </div>
                                </div>

                                <div class="panel-footer">
                                    <input type="submit" class="btn btn-success" value="登録" />
                                </div>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </section><!-- /.content -->
    <%--</aside><!-- /.right-side -->--%>
</div><!-- ./wrapper -->


<script type="text/javascript">

    function addMaster(){
        $(".valdacForm-input").val("");
        $("#valveModal").modal("show");
    }

    function deleteValve(obj) {
        var valveTr = $(obj).parent().parent();
        var valveId = valveTr[0].id;
        $("#userId").val(valveId);

        if (!confirm("この行を削除しますか？"))
            return;

        $.get("/PCALC/valve/deleteValve",{"valveId":valveId},function(data){
            var objTR=obj.parentNode.parentNode;
            var objTBL=objTR.parentNode;
            if(objTBL){
                objTBL.deleteRow(objTR.sectionRowIndex);
            }
        });
    }

    function searchDataTd(){
        var keyword = $("#table_search").val();
        keyword = keyword.toLowerCase();
        keyword=keyword.trim();
        console.log("keyword="+keyword);

        if(keyword.length < 1){
            $(".data-tr").show();
        }else{
            var dataTr = $(".data-tr");
            for(var i = 0;i<dataTr.length;i++){
                $(dataTr[i]).hide();
                var dataTd = $(dataTr[i]).find(".data-td");
                for(var j = 0;j<dataTd.length;j++){
                    var htmlData = new String(dataTd[j].innerHTML);
                    htmlData=htmlData.toLowerCase();
                    if(htmlData.indexOf(keyword) > -1){
                        $(dataTr[i]).show();
                        break;
                    }
                }
            }
        }

    }


    /**半角英数字チェック*/
    function  isHanAlpha(obj){
        var str=obj.value;
        for(var i=0;i<str.length;i++){
            var code=str.charCodeAt(i);
            if((65<=code && code<=90)||(97<=code && code<=122)|| (48<=code && code<=57)){
            }else{
                return false;
            }
        }
        return true;
    }

</script>

<script type="text/javascript">

//    $(document).ready(function(){
//
//        $(".user-table tr").mouseover(function(obj){
//            var tr = $(obj.currentTarget)[0];
//            $(tr).find(".operation-button").css("opacity","1");
//        });
//        $(".user-table tr").mouseout(function(obj){
//            var tr = $(obj.currentTarget)[0];
//            $(tr).find(".operation-button").css("opacity","0");
//        });
//
//        $("#table_search").keyup(function(){
//            var keyword = $("#table_search").val();
//            keyword = keyword.toLowerCase();
//            keyword=keyword.trim();
//            if(keyword.length > 0) {
//                var trs = $(".active .user-table tbody tr");
//                for (var i = 0; i < trs.length; i++) {
//                    $(trs[i]).hide();
//                    //是否是头
//                    var ths = $(trs[i]).find("th");
//                    if(ths.length > 0){
//                        $(trs[i]).show();
//                        continue;
//                    }
//                    //不是头的行
//                    var tds = $(trs[i]).find("td");
//
//                    for (var j = 0; j < tds.length; j++) {
//                        var tmpHtml = new String(tds[j].innerHTML);
//                        tmpHtml=tmpHtml.toLowerCase();
//                        if (tmpHtml.match(keyword)) {
//                            $(trs[i]).show();
//                            break;
//                        }
//                    }
//                }
//            } else {
//                var trs = $(".active .user-table tbody tr");
//                for (var i = 0; i < trs.length; i++) {
//                    $(trs[i]).show();
//                }
//            }
//        });
//
//    });

</script>

<c:import url="htmlframe/footerFrame.jsp" />

</body>
</html>

