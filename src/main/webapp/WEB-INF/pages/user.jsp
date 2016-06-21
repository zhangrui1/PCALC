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
    <!-- Left side column. contains the logo and sidebar -->
    <c:import url="htmlframe/leftFrame.jsp" />

    <!-- Right side column. Contains the navbar and content of the page -->
    <aside class="right-side">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                ユーザ情報
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
                            <div class="col-md-7"><div class="box-title">ユーザ</div></div>
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
                                <th>ユーザID</th>
                                <th>ユーザ名</th>
                                <th>権限</th>
                                <th>部署</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${userList}" var="user">
                                <tr class="data-tr" id="${user.userid}">
                                    <td class="data-td">${user.userid}</td>
                                    <td class="data-td">${user.username}</td>
                                    <td class="data-td">${user.kengen}</td>
                                    <td class="data-td">${user.department}</td>
                                    <%--<td>--%>
                                        <%--<button onclick="editUser(this)" class="btn btn-xs btn-warning"><i class="fa fa-edit"></i></button>--%>
                                        <%--<button onclick="deleteUser(this)" class="btn btn-xs btn-danger master-delete-btn"><i class="glyphicon glyphicon-trash"></i></button>--%>
                                    <%--</td>--%>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

        </div>


        <!-- Modal -->
        <div class="modal fade content-modal" id="userModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" id="myModalLabel">ユーザ詳細</h4>
                    </div>
                    <div class="modal-body">
                        <form id="UserForm" action="/ValdacBeta/profile/add" name="UserForm" method="post" onsubmit="return checkUser()">
                            <div class="panel panel-danger">
                                <div class="panel-heading">
                                    <h3 class="panel-title">ユーザ情報</h3>
                                </div>
                                <div class="panel-body">
                                    <div class="row form-group">
                                        <div class="col-md-2">
                                            ユーザID(必須)
                                        </div>
                                        <div class="col-md-4">
                                            <input type="text" name="userid" id="userid" class="form-control UserForm-input" value="" />
                                        </div>
                                        <div class="col-md-6">
                                            ※：重複登録できません
                                        </div>
                                    </div>

                                    <div class="row form-group">
                                        <div class="col-md-2">
                                            パスワード(必須)
                                        </div>
                                        <div class="col-md-4">
                                            <input type="password" name="password" id="password" class="form-control UserForm-input" value=""/>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-md-2">
                                            パスワード　再確認(必須)
                                        </div>
                                        <div class="col-md-4">
                                            <input type="password" name="passwordSecond" id="passwordSecond" class="form-control UserForm-input" value=""/>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-md-2">
                                            ユーザ名(必須)
                                        </div>
                                        <div class="col-md-4">
                                            <input type="text" name="username" id="username" class="form-control UserForm-input" value="" />
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-md-2">
                                            権限(必須)
                                        </div>
                                        <div class="col-md-4">
                                            <input type="text" name="kengen" id="kengen" class="form-control UserForm-input" value="" />
                                        </div>
                                        <div class="col-md-6">
                                            ※：6→全て機能使える<br>
                                            ※：5→編集不可、全て工事確認できる<br>
                                            ※：1→編集不可、担当する工事だけ確認できる<br>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <div class="col-md-2">
                                            部署
                                        </div>
                                        <div class="col-md-4">
                                            <input type="text" name="department" id="department" class="form-control UserForm-input" value="" />
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
    </aside><!-- /.right-side -->
</div><!-- ./wrapper -->

<form name="hogeForm">
    <input type="hidden" name="hoge" value="<%=(List<User>) session.getAttribute("userList")%>">
</form>
<script type="text/javascript">

    function addMaster(){
        $(".UserForm-input").val("");
        $("#userModal").modal("show");
    }

    function editUser(obj){
        var userTr = $(obj).parent().parent();
        var userId = userTr[0].id;
        $.get("/ValdacBeta/profile/getUserByIdFormSession",{"id":userId},function(data){
            var UserData = JSON.parse(data);
            $(".UserForm-input").val("");
            $("#userid").val(UserData.userid);
            $("#password").val(UserData.password);
            $("#passwordSecond").val(UserData.password);
            $("#username").val(UserData.username);
            $("#kengen").val(UserData.kengen);
            $("#department").val(UserData.department);
            $("#userModal").modal("show");
        })
    }

    function deleteUser(obj) {
        var userTr = $(obj).parent().parent();
        var userId = userTr[0].id;
        $("#userId").val(userId);

        if (!confirm("この行を削除しますか？"))
            return;

        $.get("/ValdacBeta/profile/deleteUser",{"id":userId},function(data){
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

    function updateUser(obj){
        $("#UserForm").submit();
    }

    //Userの必須項目チェック
    function checkUser(){
        var flag=0;
        var numFlg=0;
        var isHave=0;
        var passwordFlg=0;

        //必須項目設定
        if(document.UserForm.userid.value==""){flag=1;}
        if(document.UserForm.password.value==""){flag=1;}
        if(document.UserForm.passwordSecond.value==""){flag=1;}
        if(document.UserForm.username.value==""){flag=1;}
        if(document.UserForm.kengen.value==""){flag=1;}

        if(flag){
            window.alert("必須項目を入力ください");
            return false;
        }
        if(document.UserForm.password.value==document.UserForm.passwordSecond.value){
            return true;
        }else{
            window.alert("2回のパスワードは一致しません");
            return false;
        }

        //半角英数字チェック
//        if(!chkRegEmail(document.UserForm.userid)){numFlg=1;}
//        if(!isHanAlpha(document.UserForm.password)){numFlg=1;}
//        if(!isHanAlpha(document.UserForm.kengen)){numFlg=1;}

//        if(numFlg){
//            window.alert("ユーザID,パスワード,権限は英数字で入力ください");
//            return false;
//        }

        //存在してるかどうかチェック
//        $.get("/ValdacBeta/profile/getUserByIdFormSession",{"id":document.UserForm.userid.value},function(data){
//            var UserData = JSON.parse(data);
//            if(UserData.userid.length>0){
//                isHave=1;
//            }
//        });

//        if(isHave){
//            window.alert("該ユーザはすでに存在しています");
//            return false;
//        }else{
//            return true;
//        }
        return true;

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

    $(document).ready(function(){
        //left menu status
        document.getElementById('left-menu-search').className="";
        document.getElementById('left-menu-master').className="kengen-operation selected";
        //left menu end -------

        $(".user-table tr").mouseover(function(obj){
            var tr = $(obj.currentTarget)[0];
            $(tr).find(".operation-button").css("opacity","1");
        });
        $(".user-table tr").mouseout(function(obj){
            var tr = $(obj.currentTarget)[0];
            $(tr).find(".operation-button").css("opacity","0");
        });

        $("#table_search").keyup(function(){
            var keyword = $("#table_search").val();
            keyword = keyword.toLowerCase();
            keyword=keyword.trim();
            if(keyword.length > 0) {
                var trs = $(".active .user-table tbody tr");
                for (var i = 0; i < trs.length; i++) {
                    $(trs[i]).hide();
                    //是否是头
                    var ths = $(trs[i]).find("th");
                    if(ths.length > 0){
                        $(trs[i]).show();
                        continue;
                    }
                    //不是头的行
                    var tds = $(trs[i]).find("td");

                    for (var j = 0; j < tds.length; j++) {
                        var tmpHtml = new String(tds[j].innerHTML);
                        tmpHtml=tmpHtml.toLowerCase();
                        if (tmpHtml.match(keyword)) {
                            $(trs[i]).show();
                            break;
                        }
                    }
                }
            } else {
                var trs = $(".active .user-table tbody tr");
                for (var i = 0; i < trs.length; i++) {
                    $(trs[i]).show();
                }
            }
        });

    });

</script>

<c:import url="htmlframe/footerFrame.jsp" />

</body>
</html>

