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
	
 	<script type="text/javascript">
 	
	function InitGrid(queryData) {
	    $('#grid').datagrid({   //定位到Table标签，Table标签的ID是grid
	        url: 'ajaxAction',   //指向后台的Action来获取当前菜单的信息的Json格式的数据
	        contentType: "application/json",
	        title: '银行账户列表',
	        iconCls: 'icon-view',
	        height: 650,
	        width: function () { return document.body.clientWidth * 0.9 },
	        nowrap: true,
	        autoRowHeight: false,
	        fitColumns:true,
	        striped: true,
	        collapsible: true,
	        pagination: true,
	        pageSize: 20,
	        pageList: [20,50,100],
	        rownumbers: true,
	        sortName: 'acntName',    //根据某个字段给easyUI排序
	        sortOrder: 'asc',
	        remoteSort: false,
	        idField: 'acntName',
	        queryParams: queryData,  //异步查询的参数
	        columns: [[
	             { field: 'ck', checkbox: true },   //选择
	             { title: '公司名称', field: 'compSno', width: 80, align:'center', sortable: true},
	             { title: '账户名称', field: 'shrtName', width: 100, align:'left', sortable: true },
	             { title: '开户行', field: 'compName', width: 300, align:'left', sortable: true },
	             { title: '开户网点', field: 'homepage', width: 200, align:'left', sortable: true },
	             { title: '账户号码', field: 'homepage', width: 200, align:'left', sortable: true }
	        ]],
	        toolbar: [{
	            id: 'btnAdd',
	            text: '添加',
	            iconCls: 'icon-add',
	            handler: function () {
	            	$('#grid').datagrid('uncheckAll');
	                ShowAddCustomerDlg();//实现添加记录的页面
	            }
	        }, '-', {
	            id: 'btnEdit',
	            text: '修改',
	            iconCls: 'icon-edit',
	            handler: function () {
	                ShowEditCustomerDlg();//实现修改记录的方法
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
	                ShowEditCustomerDlg("view");//实现查看记录详细信息的方法
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
	            ShowEditOrViewDialog(rowIndex);
	        }
	    })
	};
	
	function ShowAddCustomerDlg(){
		$("#btnAdd").click(function () {  
		    $('#cusDlg').dialog('open');   
		});
	};
	
	function ShowEditCustomerDlg(){
		$("#btnEdit").click(function () {  
	        var row = $('#grid').datagrid('getSelected');  
	        if (row) {
		        $('#f2i1').val(row.compName);  
		        $('#f2i2').val(row.acntName);     
                $('#f2i3').val(row.bankName);
		        $('#f2i4').val(row.openBranch);
		        $('#f2i5').val(row.acntNo);
		        $('#f2i5').val(row.currency);
	            $('#cusDlg').dialog('open');   
	        } else {  
	            $.messager.alert("提示", "请选中要编辑的行! 或者双击该行进行编辑！");  
	        }
		});
	};
</script>

</head>

<body>

<div>
	<form method="post">
	<fieldset>
	<legend>客户信息检索 🔍</legend>
		<table class="datagrid">
			<tr>
				<td>客户编号:</td>
				<td><input class="easyui-validatebox" type="text" id="compSno" name="cId"/></td>
				<td>客户名称：</td>
				<td><input class="easyui-validatebox" type="text" id="compName" name="cName"/></td>
				<td>业务员：</td>
				<td><input class="easyui-validatebox" type="text" id="saleMan" name="sMan"/></td>
				<td><input class="easyui-validatebox" type="button" id="" value=" 搜 索 " onclick="InitGrid()"/></td>
			</tr>
		</table>
	</fieldset>
	</form>
	<table id="grid"></table>
	<div id="cusDlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<fieldset>
		<legend>客户信息</legend>
		<form id="fm" onsubmit="return checkCustomInfo()" method="post" action="addCustomerAction">
			<table>
				<tr>
					<td><label>客户名：</label></td>
					<td><input name="compName" id="compName" maxlength="50" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>客户编号：</label></td>
					<td><input name="compName" id="shrtName" maxlength="10" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>客户地址：</label></td>
					<td><input name="compAddr" id="compAddr" maxlength="100" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>联系电话：</label></td>
					<td><input name="tel" id="compTel" maxlength="16" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>联络人:</label></td>
					<td><input name="usher" id="usher" maxlength="10" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>业务员:</label></td>
					<td><input name="specilist" id="specilist" maxlength="10" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><input type="submit" id="submit" value=" 添 加 "></td>
					<td><input type="button" id="cancel" value=" 取 消 "></td>
				</tr>
			</table>
		</form>
		</fieldset>
	</div>
</div>
</body>