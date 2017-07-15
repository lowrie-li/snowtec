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
	function init() {
		<% 
		String UID = (String)request.getSession().getAttribute("UID");
		String LOGGED = (String)request.getSession().getAttribute("LOGGED");
		%>

		var uid="<%=UID%>";
		var logged="<%=LOGGED%>";
		if(logged =="TRUE") {
			alert("欢迎登录Snowtec工作面板");
			return true;
		} else {
			alert("用户未登录，请登录后使用");
			window.location.href = "index.jsp"
		}
	}

	var xmlhttp = null;
	var url = "ajaxaction"
	function loadXMLDoc() {
		
		if (window.XMLHttpRequest) {// code for all new browsers
			xmlhttp = new XMLHttpRequest();
		} else if (window.ActiveXObject) {// code for IE5 and IE6
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if (xmlhttp != null) {
			xmlhttp.onreadystatechange = state_Change;
			xmlhttp.open("GET", url, true);
			xmlhttp.send(null);
		}
	}

	function state_Change() {
		if (xmlhttp.readyState == 4) {// 4 = "loaded"
 //			alert(xmlhttp.status);
			if (xmlhttp.status == 200) {// 200 = OK
			//	alert(xmlhttp.responseText);
				document.getElementById("showview").innerHTML=xmlhttp.responseText;
			} else {
				alert("Problem retrieving XML data"); 
			}
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
<div> 
<fieldset>
<legend>工作面板</legend>
<button onclick="loadXMLDoc();">ajax</button>
<div id="showview">
</div>
</fieldset>
</div>
</body>
</html>