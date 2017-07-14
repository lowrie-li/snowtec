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
		var pwd2=this.userpwd2.value;
		var name=this.username.value;
		var phone=this.telephone.value;
		var email=this.email.value;
		var empty_el;
		if (id == "" || id == null) {
			alert("用户名不能为空");
			return false;
		}
		if (pwd == "" || pwd == null) {
		  	alert("密码不能为空");
		  	return false;
		}
		if (pwd != pwd2) {
			alter("两次输入密码不一致");
			return false;
		}
		if (name == "" || name == null) {
			alert("必须填写用户名");
			return false;
		}
		if (phone == "" || phone == null) {
		  	alert("电话号码不能为空");
		  	return false;
		}
		if (email == "" || email == null) {
		  	alert("邮箱不能为空");
		  	return false;
		}
	  }
	</script>
</head>

<body>
<div class="header">
    <div class="headerco">
        <div class="logo" align="left">
            <a href="index.jsp">
                <img src="./images/logo.jpg" alt="深圳市欣诺泰电子有限公司 （总部）"></a>
        </div>
    </div>
</div>
<div style="background-color:lightblue;" align="center">
  <p> 新用户注册 </p>
  <span id="hint"></span>
  <form name="loginForm" onsubmit="return validateInput()" action="index.jsp">
  	注册账号：<input type="text" name="userid" id="userid" maxlength="10" placeholder="10个以内英文字符"/><br>
  	用户密码：<input type="password" name="userpwd" id="userpwd" placeholder="6-8位密码"/><br>
  	确认密码：<input type="password" name="userpwd2" id="userpwd2" placeholder="6-8位密码"/><hr/>
  	真实姓名：<input type="text" name="username" id="username" maxlength="10"/><br>
  	联系电话：<input type="text" name="telephone" id="telephone" maxlength="11"/><br>
  	注册邮箱：<input type="email" name="email" id="email" placeholder="注册邮箱"/><br>
  	<input type="submit" id="submit" value=" 注 册 ">
  	<span>已注册账户，<a href="index.jsp">登录</a></span>
  </form>
</div>
	
</body>
</html>