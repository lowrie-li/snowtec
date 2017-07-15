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
		<% String errno = (String)request.getSession().getAttribute("errno"); %>
		var errno="<%=errno%>";
	     if("<%=errno%>" == "id_pwd_err"){
	    	 alert("账号／密码错误，请重新登录");
	     }else if ("<%=errno%>" == "db_con_err"){
	    	 alert("后台服务器错误，请联系管理员解决");
	     }
	}
	</script>
</head>

<body onload="init()">
<div class="header">
    <div class="headerco">
        <div class="logo" align="left">
            <a href="www.sznotec.com">
                <img src="./images/logo.jpg" alt="深圳市欣诺泰电子有限公司 （总部）"></a>
        </div>
    </div>
</div>
<div style="background-color:lightblue;" align="center">
  <br>
  <p> 用户登录 </p>
  <form name="loginForm" onsubmit="return validateInput()" action="loginAction" method="post">
  	账号：<input type="text" name="userid" id="userid" maxlength="10" placeholder="用户账号"/><span id="idhint"></span><br>
  	密码：<input type="password" name="userpwd" id="userpwd" maxlength="10" placeholder="6-10位密码" /><span id="pwdhint"></span><br>
  	<input type="submit" name="submit" value=" 登 录 "/><br>
  	<span>新用户请<a href="register.jsp">注册</a>后登录</span>
  </form>
</div>

</body>
</html>