<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.snowtec.*" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>深圳市欣诺泰电子有限公司</title>
    <meta name="Author" content="深圳市欣诺泰电子有限公司（总部）" />
    <meta name="Keywords" content="深圳市欣诺泰电子有限公司" />
    <meta name="Description" content="深圳市欣诺泰电子有限公司" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<script type="text/javascript" src="WEB-INF/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="WEB-INF/easyui/jquery.min.js"></script>
    
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/datagrid.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/linkbutton.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/dialog.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
	<script>
	function validateInput() {
		var id=this.userid.value;
		var pwd=this.userpwd.value;
		var empty=true;
		if(id && pwd) {
			empty=false;
		}
		if(empty) {
			alert("账号／密码不能为空，请重新输入");
			return false;
		}
	}
	
	function init() {
		var id_pwd_err = request.getSession.getAttribute("id_pwd_err");
		var bg_db_err = request.getSession.getAttribute("bg_db_err");
		alert("xxx");
		if (id_pwd_err == "true") {
			alert("账号／密码错误，请重新输入");
			return false;
		}
		if (bg_pwd_err == "true") {
			alert("后台数据库错误，请联系管理员解决！");
			return false;
		}
	}
	</script>
</head>

<body onload="init()">
<div class="header">
    <div class="headerco">
        <div class="logo" align="left">
            <a href="index.jsp">
                <img src="./images/logo.jpg" alt="深圳市欣诺泰电子有限公司 （总部）"></a>
        </div>
    </div>
</div>
<div style="background-color:lightblue;" align="center">
  <br>
  <span style="font-size:20px">Failed!</span>
  <br>
  <br>
</div>

</body>
</html>