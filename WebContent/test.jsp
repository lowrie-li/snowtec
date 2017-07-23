<%-- <%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%> --%>
<%@ page language="java" import="java.sql.*,java.io.*,java.util.*, com.snowtec.*"%>
<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>LayOut</title>
<script src="easyui/jquery.min.js" type="text/javascript"></script>
<script src="easyui/jquery.easyui.min.js" type="text/javascript"></script>
<link href="easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<script language="JavaScript">

/* var obj = {'total':100,'rows':[{"cusSno":1,"shrtName":"sznotec","cusName":"深圳新诺泰电子有限公司","cMan":"李志奇","sMan":"李志奇","cC":"5C"},
                               {"cusSno":2,"shrtName":"oracle","cusName":"甲骨文研究开发有限公司","cMan":"李源涛","sMan":"李源涛","cC":"5C"}]};

//$('#dg').datagrid('loadData',obj);
 */
 
/* 	var xmlhttp = null;
	var url = "ajaxAction"
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
			//alert("4");
			if (xmlhttp.status == 200) {// 200 = OK
			//	alert(xmlhttp.responseText);
				document.getElementById("dg").innerHTML=xmlhttp.responseText;
			} else {
				alert("Problem retrieving XML data"); 
			}
		}
	}
*/
	function InitGrid() {
	    $('#grid').datagrid({   //定位到Table标签，Table标签的ID是grid
	        url: 'ajaxAction',   //指向后台的Action来获取当前菜单的信息的Json格式的数据
	        title: '客户列表',
	        iconCls: 'icon-view',
	        height: 650,
	        width: function () { return document.body.clientWidth * 0.9 },
	        nowrap: true,
	        autoRowHeight: false,
	        striped: true,
	        collapsible: true,
	        pagination: true,
	        pageSize: 100,
	        pageList: [50,100,200],
	        rownumbers: true,
	        sortName: 'compSno',    //根据某个字段给easyUI排序
	        sortOrder: 'asc',
	        remoteSort: false,
	        idField: 'compSno',
//	        queryParams: queryData,  //异步查询的参数
	        columns: [[
	             { field: 'ck', checkbox: true },   //选择
	             { title: '客户编号', field: 'compSno', width: 80, align:'center'},
	             { title: '客户代码', field: 'shrtName', width: 100, align:'center' },
	             { title: '客户名称', field: 'compName', width: 300, align:'center' },
	             { title: '客户主页', field: 'homepage', width: 200, align:'center' }
	        ]],
	        toolbar: [{
	            id: 'btnAdd',
	            text: '添加',
	            iconCls: 'icon-add',
	            handler: function () {
	                ShowAddDialog();//实现添加记录的页面
	            }
	        }, '-', {
	            id: 'btnEdit',
	            text: '修改',
	            iconCls: 'icon-edit',
	            handler: function () {
	                ShowEditOrViewDialog();//实现修改记录的方法
	            }
	        }, '-', {
	            id: 'btnDelete',
	            text: '删除',
	            iconCls: 'icon-remove',
	            handler: function () {
	                Delete();//实现直接删除数据的方法
	            }
	        }, '-', {
	            id: 'btnView',
	            text: '查看',
	            iconCls: 'icon-table',
	            handler: function () {
	                ShowEditOrViewDialog("view");//实现查看记录详细信息的方法
	            }
	        }, '-', {
	            id: 'btnReload',
	            text: '刷新',
	            iconCls: 'icon-reload',
	            handler: function () {
	                //实现刷新栏目中的数据
	                $("#grid").datagrid("reload");
	            }
	        }],
	        onDblClickRow: function (rowIndex, rowData) {
	            $('#grid').datagrid('uncheckAll');
	            $('#grid').datagrid('checkRow', rowIndex);
	            ShowEditOrViewDialog();
	        }
	    })
	};
</script>
<!-- <style>
.footer {
	width: 100%;
	text-align: center;
	line-height: 35px;
}

.top-bg {
	background-color: #d8e4fe;
	height: 80px;
}
</style>
</head> -->

<body class="easyui-layout">

<!-- 	<div>
		<table id="dg" title="客户列表" class="easyui-datagrid"
				style="width: 700px; height: 500px" url="json" toolbar="#toolbar"
				rownumbers="true" fitColumns="true"  >
			<thead>
				<tr>
				<th field="ck" checkbox="true"></th>
				<th data-options="field:'cusSno',width:'50px'">客户编号</th>
				<th data-options="field:'shrtName',width:'80px'">客户代码</th>
				<th data-options="field:'cusName',width:'200px'">客户名称</th>
				<th data-options="field:'cMan',width:'50px'">联络人</th>
				<th data-options="field:'sMan',width:'50px'">业务员</th>
				<th data-options="field:'cC',width:'80px', align:right">信誉度</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新增客户</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">修改客户</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除客户</a>
		</div>
	</div> -->
	
    <table id="grid" data-options="
		rownumbers:true,
		singleSelect:true,
		autoRowHeight:false,
		pagination:true,
		resizeHandle:'right'">
        <thead>
            <tr></tr>
        </thead>
    </table>
    
    <button onclick="InitGrid()">提交</button>

	<div id="diaAdd" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<div class="ftitle">User Information</div>
		<form id="fm" method="post" novalidate>
			<div class="fitem">
				<label>First Name:</label>
				<input name="firstname" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>Last Name:</label>
				<input name="lastname" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>Phone:</label>
				<input name="phone">
			</div>
			<div class="fitem">
				<label>Email:</label>
				<input name="email" class="easyui-validatebox" validType="email">
			</div>
		</form>
	</div>
	
</body>
</html>
