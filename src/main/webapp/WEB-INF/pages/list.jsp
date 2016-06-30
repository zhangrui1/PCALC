<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="htmlframe/headFrame.jsp" />
<body class="skin-blue">
<!-- header logo: style can be found in header.less -->
<c:import url="htmlframe/headerFrame.jsp"/>
<div class="wrapper row-offcanvas row-offcanvas-left">
    <!-- Right side column. Contains the navbar and content of the page -->
    <%--<aside class="right-side">--%>
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <%--<h1>--%>
                <%--弁リスト--%>
            <%--</h1>--%>
        </section>
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <!-- collection -->
                <div class="col-md-1">
                    <form  action="/PCALC/"  method="GET">
                        <input type="submit" class="btn btn-default" onclick="submitPrintForm()" value="弁履歴"/>
                    </form>
                </div>
                <div class="col-md-2">
                    <form  action="/PCALC/logout"  method="GET">
                        <input type="submit" class="btn btn-default"  value="ログアウト"/>
                    </form>
                </div>
        </div></br>

        <div class="row">
            <div class="col-md-12">
                <div class="box box-primary">
                    <div class="box-header">

                        <div class="row">
                            <div class="col-md-1"><div class="box-title"><button class="btn btn-default btn-user" onclick="addMaster()">新規弁</button></div></div>
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
                        <table class="table table-hover" id="list-table">
                            <thead>
                            <tr>
                                <th>弁番号<span id="valve_num" class="valve_num">(${valveListNum})</span></th>
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
                                        <a class="btn btn-primary operation-button-btn" href="/PCALC/valve/${valve.valveId}">詳細</a>
                                        <%--<button onclick="deleteValve(this)" class="btn btn-danger operation-button-btn">削除</button>--%>
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
                                        <%--<div class="col-md-4">--%>
                                            <%--※：重複登録できません--%>
                                        <%--</div>--%>
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

<c:import url="htmlframe/footerFrame.jsp" />

</body>
</html>

