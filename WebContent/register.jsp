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

    <script src="easyui/jquery.min.js" type="text/javascript"></script>
	<script src="easyui/jquery.easyui.min.js" type="text/javascript"></script>
	<link href="easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
	<link href="easyui/themes/icon.css" rel="stylesheet" type="text/css" />
	
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
            <a href="http://www.sznotec.com">
                <img src="./images/logo.jpg" alt="深圳市欣诺泰电子有限公司 （总部）"></a>
        </div>
    </div>
</div>
<div style="background-color:lightblue;" align="center">
  <p> 新用户注册 </p>
  <span id="hint"></span>
  <form name="loginForm" onsubmit="return validateInput()" action="registerAction">
  	注册账号：<input type="text" name="userid" id="userid" maxlength="10" placeholder="10个以内英文字符"  class="easyui-validatebox" required="true"/><br>
  	用户密码：<input type="password" name="userpwd" id="userpwd" placeholder="6-8位密码"  class="easyui-validatebox" required="true"/><br>
  	确认密码：<input type="password" name="userpwd2" id="userpwd2" placeholder="6-8位密码"  class="easyui-validatebox" required="true"/><hr/>
  	真实姓名：<input type="text" name="username" id="username" maxlength="10"  class="easyui-validatebox" required="true"/><br>
  	联系电话：<input type="text" name="telephone" id="telephone" maxlength="11"  class="easyui-validatebox" required="true"/><br>
  	注册邮箱：<input type="email" name="email" id="email" placeholder="注册邮箱"  class="easyui-validatebox" required="true" validType="email"/><br>
  	<input type="submit" id="submit" value=" 注 册 ">
  	<span>已注册账户，<a href="login.jsp">登录</a></span>
  </form>
</div>
	
</body>
</html>