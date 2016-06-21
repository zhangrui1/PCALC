<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="lockscreen">
<head>
    <meta charset="UTF-8">
    <title>PCALC</title>
    <link rel="shortcut icon" href="/PCALC/img/valdac32.ico" type="image/vnd.microsoft.icon">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="/PCALC/css/main.css" rel="stylesheet" type="text/css" />
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>

</head>

<style type="text/css">
    .footer{
        background-color: #D3EBD7;
    }
</style>

<body class="">
<div class="form-box" id="login-box">
    <c:if test="${message != null}">
        <div class="row">
            <div id="errorMessage" style="color:#ff0000; text-align: center;font-size: 15pt;">${message}</div><br>
        </div>
    </c:if>
    <div class="header">Welcome to PCALC</div>
    <form action="/PCALC/login" method="post" id="UserForm" name="UserForm" onsubmit="return checkLogin()">
        <div class="body bg-gray">
            <div class="form-group">
                <input type="text" name="userid" class="form-control" placeholder="ユーザー名"/>
            </div>
            <div class="form-group">
                <input type="password" name="password" class="form-control" placeholder="パスワード"/>
            </div>
        </div>
        <div class="footer">
            <button type="submit" class="btn bg-olive btn-block">ログイン</button>

        </div>
    </form>
    <div align="center">version 1.0.0 released on Jun 21, 2016</div>
</div>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js" type="text/javascript"></script>

<script type="text/javascript">
    //loginの必須項目チェック
    function checkLogin(){
        var flag=0;
        var msg=document.getElementById("errorMessage");
        msg.innerHTML="";
        //必須項目設定
        if(document.UserForm.userid.value==""){flag=1;}
        if(document.UserForm.password.value==""){flag=1;}

        if(flag){
            msg.innerHTML="ユーザ名とパスワードを両方入力ください";
            return false;
        }else{
            return true;
        }
    }
</script>
</body>
</html>
