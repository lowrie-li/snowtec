<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript">
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
 			alert(xmlhttp.status);
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
<body>
<!-- <body onload="loadXMLDoc();loadXMLDoc2()"> -->
<button onclick="loadXMLDoc();">ajax</button>
<div id="showview">
</div>
</body>
</html>