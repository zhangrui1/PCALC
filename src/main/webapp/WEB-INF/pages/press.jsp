<%@ page import="com.pcalc.entity.User" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:import url="htmlframe/headFrame.jsp" />
<body class="skin-blue">
<!-- header logo: style can be found in header.less -->
<c:import url="htmlframe/headerFrame.jsp"/>
<div class="wrapper row-offcanvas row-offcanvas-center">
    <!-- Right side column. Contains the navbar and content of the page -->
    <%--<aside class="right-side">--%>
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <%--<h1>--%>
                <%--弁の油圧--%>
            <%--</h1>--%>
        </section>
    <!-- Main content -->
    <section class="content">
        <div class="row">
            <!-- collection -->
            <div class="col-md-2 pull-left">
                <form  action="/PCALC/"  method="GET">
                    <input type="submit" class="btn btn-default" onclick="submitPrintForm()" value="弁履歴"/>
                </form>
            </div>
            <div class="col-md-2 pull-right">
                <form  action="/PCALC/logout"  method="GET">
                    <input type="submit" class="btn btn-default"  value="ログアウト"/>
                </form>
            </div>
        </div></br>

        <c:if test="${message != null}">
            <div class="row">
                <div class="col-md-12">
                    <div class="alert alert-success alert-dismissable">${message}</div>
                </div>
            </div>
        </c:if>
        <hr/>
        <div class="row">
            <div class="panel panel-default">
                <form id="ValveForm" name="ValveForm"  method="post" action="/PCALC/valve/edit" onsubmit="return checkValve()">
                    <input type="hidden" name="valveId" id="valveId" class="valve-form" value="${valve.valveId}"/>
                    <div class="box box-solid box-primary">
                        <div class="box-header box-panel">
                            <h3 class="box-title">弁情報</h3>
                        </div>
                        <div class="box-body">
                            <div class="form-group">
                                <div class="col-md-1">
                                    弁番号
                                </div>
                                <div class="col-md-2">
                                    <input type="text" name="valdacNo" id="valdacNo" class="form-control" value="${valve.valdacNo}"/>
                                </div>
                                <div class="col-md-1">
                                    備考
                                </div>
                                <div class="col-md-2">
                                    <input type="text" name="biko" id="biko" class="form-control" value="${valve.biko}"/>
                                </div>
                            </div>
                        </div></br></br>

                        <div class="box box-solid">
                            <div class="box-body clearfix">
                                <div class="form-group">

                                    <a class="btn btn-danger" href="/PCALC/valve/${valve.valveId}/deleteValve">
                                        <i class="fa fa-trash-o"></i> 削除
                                    </a>

                                    <button class="btn btn-success pull-right">
                                        <i class="fa fa-save"></i> 更新
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="row">
            <div class="box">
            <div class="box-header box-panel btn-info">
                <h3 class="box-title">圧力一覧</h3>
            </div>
            <div class="box-body">
                <div class="col-md-1">
                    <button class="btn btn-default btn-user" onclick="addPress()">新規油力行追加</button>
                </div>
            </div>


            <div class="panel-body">
                <table class="table table-hover" id="press-table">
                    <thead>
                    <tr>
                        <th>番号(<span id="press_num" class="press_num">${pressListNum}</span>)</th>
                        <th>係数(K)</th>
                        <th>ベース</th>
                        <th>油圧(G)</th>
                        <th>高低差(H)</th>
                        <th>調整</th>
                        <th>結果</th>
                        <th>更新日</th>
                        <th>詳細</th>
                    </tr>
                    </thead>
                    <tbody id="pressListTbody">
                    <c:forEach items="${pressList}" var="press">
                        <tr class="data-tr" id="${press.pressId}">
                            <%--<td class="data-td"></td>--%>
                            <td class="data-td">${press.pressNum}</td>
                            <td class="data-td">
                                <div>
                                    <input type="text" name="press-keisu-${press.pressId}" id="press-keisu-${press.pressId}" class="form-control" value="${press.keisu}" />
                                </div>
                            </td>
                            <td class="data-td">
                                <div>
                                    <input type="text" name="press-base-${press.pressId}" id="press-base-${press.pressId}" class="form-control " value="${press.base}" />
                                </div>
                            </td>
                            <td class="data-td">
                                <div>
                                    <input type="text" name="press-pressG-${press.pressId}" id="press-pressG-${press.pressId}" class="form-control" value="${press.pressG}" />
                                </div>
                            </td>
                            <td class="data-td">
                                <div>
                                    <input type="text" name="press-pressHigh-${press.pressId}" id="press-pressHigh-${press.pressId}" class="form-control" value="${press.pressHigh}" />
                                </div>
                            </td>
                            <td class="data-td">
                                <div>
                                    <input type="text" name="press-adjust-${press.pressId}" id="press-adjust-${press.pressId}" class="form-control" value="${press.adjust}" />
                                </div>
                            </td>
                            <td class="data-td">
                                <div>
                                    <input type="text" name="press-pressResult-${press.pressId}" id="press-pressResult-${press.pressId}" class="form-control" value="${press.pressResult}" />
                                </div>
                            </td>
                            <td class="data-td">
                                <div>
                                   ${press.updDate}
                                </div>
                            </td>
                            <td id="${press.pressId}">
                                <%--<a class="btn btn-primary operation-button-btn" href="#">計算</a>--%>
                                <button onclick="calculatePress(${press.pressId})" class="btn btn-primary operation-button-btn">計算</button>
                                <button onclick="reCalculatePress(${press.pressId})" class="btn btn-warning operation-button-btn">逆計算</button>
                                <button onclick="deletePress(${press.pressId})" class="btn btn-danger operation-button-btn">削除</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            </div>
        </div>
    </section><!-- /.content -->
    <%--</aside><!-- /.right-side -->--%>
</div><!-- ./wrapper -->


<script type="text/javascript">

    //新規追加する
    function addPress() {
        var valveId=$("#valveId").val();
        $.get("/PCALC/press/addPress",{"valveId":valveId},function(data){
            console.log("data="+data);
            var pressList = JSON.parse(data);
            $("#pressListTbody").html("");
            var tmpHTML = "";
            for(var i = 0; i < pressList.length;i++){
                var press=pressList[i];
                var StrId=press.pressId;
                var StrBaseId="press-base-"+press.pressId;
                var StrPressId="press-pressG-"+press.pressId;
                var StrHighId="press-pressHigh-"+press.pressId;
                var StrKeisuId="press-keisu-"+press.pressId;
                var StrAdjustId="press-adjust-"+press.pressId;
                var StrResultId="press-pressResult-"+press.pressId;

                tmpHTML =tmpHTML+'<tr class="data-tr" id="'+press.pressId+'">'+
                        '<td class="data-td" id="'+press.pressNum+'">' +press.pressNum+'</td>'+
                        '<td class="data-td">' +
                        '<div>' +
                        '<input type="text" name="'+StrKeisuId+'"  id="'+StrKeisuId+'"  class="form-control " value="'+press.keisu+'"/>'+
                        '</div>' +
                        '</td>' +
                        '<td class="data-td">' +
                        '<div>' +
                        '<input type="text" name="'+StrBaseId+'"  id="'+StrBaseId+'" class="form-control " value="'+press.base+'"/>'+
                        '</div>' +
                        '</td>'+
                        '<td class="data-td">' +
                        '<div>' +
                        '<input type="text" name="'+StrPressId+'"  id="'+StrPressId+'"  class="form-control " value="'+press.pressG+'"/>'+
                        '</div>' +
                        '</td>'+
                        '<td class="data-td">' +
                        '<div>' +
                        '<input type="text" name="'+StrHighId+'"  id="'+StrHighId+'"  class="form-control " value="'+press.pressHigh+'"/>'+
                        '</div>' +
                        '</td>'+
                        '<td class="data-td">' +
                        '<div>' +
                        '<input type="text" name="'+StrAdjustId+'"  id="'+StrAdjustId+'"  class="form-control " value="'+press.adjust+'"/>'+
                        '</div>' +
                        '</td>'+
                        '<td class="data-td">' +
                        '<div>' +
                        '<input type="text" name="'+StrResultId+'"  id="'+StrResultId+'"  class="form-control " value="'+press.pressResult+'"/>'+
                        '</div>' +
                        '</td>'+
                        '<td class="data-td">' +
                        '<div>' +
                          press.updDate+
                        '</div>' +
                        '</td>'+
                        '<td id="'+press.pressId+'">' +
                        '<button onclick="calculatePress('+press.pressId+')" class="btn btn-primary operation-button-btn">計算</button>' +
                        '<button onclick="reCalculatePress('+press.pressId+')" class="btn btn-warning operation-button-btn">逆計算</button>' +
                        '<button onclick="deletePress('+press.pressId+')" class="btn btn-danger operation-button-btn">削除</button>' +
                        '</td>'+
                        '</tr>';
            }
            $('#pressListTbody').html(tmpHTML);
//            document.getElementById("press_num").innerHTML="("+pressList.length+")";
            document.getElementById("press_num").innerHTML=pressList.length;
            console.log("length="+pressList.length);
        });
    }
    function checkPress(obj) {
        //必須項目設定
        var tmpValdacNo=$("#valdacNo").val();
        if(tmpValdacNo==""){
            window.alert("「弁番号」を入力ください");
            return false;
        }else if(tmpValdacNo.length>255){
            window.alert("「弁番号」に最大255文字を入力ください");
            return false;
        }else{}

        return true;

    }
    //press 計算する
    function calculatePress(obj) {
        console.log("press  Id="+ obj);
//        var pressTr = $(obj).parent().parent();
//        var pressId = pressTr[0].id;
        var pressId=obj;
        var tmpBase=document.getElementById("press-base-"+pressId).value;
        var tmpPressG=document.getElementById("press-pressG-"+pressId).value;
        var tmpHith=document.getElementById("press-pressHigh-"+pressId).value;
        var tmpKeisu=document.getElementById("press-keisu-"+pressId).value;
        var tmpAdjust=document.getElementById("press-adjust-"+pressId).value;
        console.log("tmpBase    "+tmpBase);
        console.log("tmpPressG    "+tmpPressG);
        //データチェック
        //isNaN();   数字場合⇒false  その以外⇒true
        if((isNaN(tmpBase) || tmpBase.length<1)){
            window.alert("ベースに半角数字のみを入力してください");
            return false;
        }else if((isNaN(tmpPressG)  || tmpPressG.length<1)){
            window.alert("ユアツに半角数字のみを入力してください");
            return false;
        }else if((isNaN(tmpHith)  || tmpHith.length<1)){
            window.alert("高さに半角数字のみを入力してください");
            return false;
        }else if((isNaN(tmpKeisu)  || tmpKeisu.length<1)){
            window.alert("係数に半角数字のみを入力してください");
            return false;
        }else{
            $.get("/PCALC/press/calculatePress",{"pressId":pressId,"base":tmpBase,"pressG":tmpPressG,"pressHigh":tmpHith,"keisu":tmpKeisu,"adjust":tmpAdjust},function(data){
                console.log("tmpResult    "+data);
                document.getElementById("press-pressResult-"+pressId).value=data;
            });
        }
    }

    //press 油圧　逆計算する
    function reCalculatePress(obj) {
        console.log("press  Id="+ obj);
        var pressId=obj;
        var tmpBase=document.getElementById("press-base-"+pressId).value;
        var tmpPressG=document.getElementById("press-pressG-"+pressId).value;
        var tmpHith=document.getElementById("press-pressHigh-"+pressId).value;
        var tmpKeisu=document.getElementById("press-keisu-"+pressId).value;
        var tmpAdjust=document.getElementById("press-adjust-"+pressId).value;
        var tmpPressResult=document.getElementById("press-pressResult-"+pressId).value;
        console.log("tmpBase    "+tmpBase);
        console.log("tmpPressG    "+tmpPressG);
        //データチェック
        //isNaN();   数字場合⇒false  その以外⇒true
        if((isNaN(tmpBase) || tmpBase.length<1)){
            window.alert("ベースに半角数字のみを入力してください");
            return false;
        }else if((isNaN(tmpHith)  || tmpHith.length<1)){
            window.alert("高さに半角数字のみを入力してください");
            return false;
        }else if((isNaN(tmpPressResult)  || tmpPressResult.length<1)){
            window.alert("結果に半角数字のみを入力してください");
            return false;
        }else if((isNaN(tmpKeisu)  || tmpKeisu.length<1)){
            window.alert("係数に半角数字のみを入力してください");
            return false;
        }else{
            $.get("/PCALC/press/reCalculatePress",{"pressId":pressId,"base":tmpBase,"pressResult":tmpPressResult,"pressHigh":tmpHith,"keisu":tmpKeisu,"adjust":tmpAdjust},function(data){
                console.log("tmpPressG    "+data);
                document.getElementById("press-pressG-"+pressId).value=data;
            });
        }
    }

    //弁長さ判断
    function checkValve() {
        //tmpBase　長さ判断
        var tmpBase=document.getElementById("valdacNo").value;
        if(tmpBase.length<1 ){
            window.alert("弁番号を255文字以内にしてください。");
            return false;
        }else if(tmpBase.length>255 ){
            window.alert("弁番号を255文字以内にしてください。");
            return false;
        }
        //tmpPressG　長さ判断
        var tmpPressG=document.getElementById("biko").value;
        if(tmpPressG.length<1 ){
            window.alert("備考を255文字以内にしてください。");
            return false;
        }else if(tmpPressG.length>255 ){
            window.alert("備考を255文字以内にしてください。");
            return false;
        }

        return true;
    }

    //press 削除する
    function deletePress(obj) {
        var pressId=obj;
        console.log("delete pressId="+pressId);
        if (!confirm("この行を削除しますか？"))
            return;

        $.get("/PCALC/press/deletePressByPressId",{"pressId":pressId},function(data){
            document.getElementById(obj).style.display="none";
            var pressNum = parseInt(document.getElementById("press_num").innerHTML);
            document.getElementById("press_num").innerHTML=pressNum-1;
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

