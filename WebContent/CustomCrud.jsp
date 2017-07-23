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
	        title: '客户列表',
	        iconCls: 'icon-view',
/* 	        height: 650,
	        width: function () { return document.body.clientWidth * 0.9 }, */
	        nowrap: true,
	        autoRowHeight: false,
	        fitColumns:false,
	        striped: true,
	        collapsible: true,
	        pagination: true,
	        pageSize: 20,
	        pageList: [20,50,100],
	        rownumbers: true,
	        sortName: 'compSno',    //根据某个字段给easyUI排序
	        sortOrder: 'asc',
	        remoteSort: false,
	        idField: 'compSno',
	        queryParams: queryData,  //异步查询的参数
	        singleSelect:true,
	        columns: [[
	             { field: 'ck', checkbox: true },   //选择
	             { title: '客户代码', field: 'shrtName', width: 100, align:'left', sortable: true, fitColumns:false},
	             { title: '公司名称', field: 'compName', width: 150, align:'left', sortable: true, fitColumns:false},
	             { title: '公司电话', field: 'compTel', width: 100, align:'left', sortable: true, fitColumns:false},
	             { title: '公司地址', field: 'compAddr', width: 150, align:'left', sortable: true, fitColumns:false},
	             { title: '联系人', field: 'cnntName', width: 60, align:'left', sortable: true, fitColumns:false},
	             { title: '联系电话', field: 'cnntPhone', width: 100, align:'left', sortable: true, fitColumns:false},
	             { title: '职务', field: 'position', width: 100, align:'left', sortable: true, fitColumns:false},
	             { title: '客户代表', field: 'specialistName', width: 60, align:'left', sortable: true, fitColumns:false},
	             { title: '备注', field: 'cmnt', width: 500, align:'left', sortable: true, fitColumns:false}
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
	            	ConfirmDeleteDlg();//实现直接删除数据的方法
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
	            ShowEditCustomerDlg(rowIndex);
	        }
	    })
	};
	
	function ShowAddCustomerDlg(){
		$("#btnAdd").click(function () {  
		    $('#cusDlg').dialog({title:"添加新客户"}).dialog('open');
		});
	};
	
	function ConfirmDeleteDlg(){
		$("#btnAdd").click(function () {  
		    $('#cusDlg').dialog({title:"删除客户"}).dialog('open');
		});
	};
	
	function ShowEditCustomerDlg(){
		$("#btnEdit").click(function () {  
	        var rows = $('#grid').datagrid('getSelections');
	        if (rows.length < 1) {
	        	$.messager.alert("提示", "请选中一行进行编辑！")
	        } else if (rows.length == 1) {
		        var row = rows[0];
		        $('#f2i1').val(row.compName);
		        $('#f2i1').attr("readOnly", "true");  
		        $('#f2i2').val(row.shrtName);
 		        $('#f2i2').attr("readOnly", "true");   
		        $('#f2i3').val(row.compTel);
		        $('#f2i4').val(row.compAddr);
		        $('#f2i5').val(row.cnntName);
		        $('#f2i6').val(row.cnntPhone);
		        $('#f2i7').val(row.position);
		        $('#f2i8').val(row.specialist);
		        $('#f2i9').val(row.cmnt);
	            $('#cusDlg').dialog({title:"编辑客户信息"}).dialog('open');
	        } else {  
	            $.messager.alert("提示", "请选中要编辑的行! 或者双击该行进行编辑！");  
	        }
		});
	};
	
	function checkCustomInfo() {
		if ($('#f2i1').val() == null || $('#f2i1').val() == "") {
			alert("请填写客户名！");
			return false;
		}
 		if ($('#f2i2').val() == null || $('#f2i2').val() == "") {
			alert("请填写客户编码！");
			return false;
		}
		if ($('#f2i3').val() == null || $('#f2i3').val() == "") {
			alert("请填写客户电话！");
			return false;
		}
		if ($('#f2i4').val() == null || $('#f2i4').val() == "") {
			alert("请填写客户地址！");
			return false;
		}
		if ($('#f2i5').val() == null || $('#f2i5').val() == "") {
			alert("请填写联系人！");
			return false;
		}
		if ($('#f2i6').val() == null || $('#f2i6').val() == "") {
			alert("请填写联系人电话！");
			return false;
		}
		if ($('#f2i7').val() == null || $('#f2i7').val() == "") {
			alert("请填写联系人职务！");
			return false;
		}
		
		return true;
	}
</script>

</head>

<body  onload="InitGrid()">

<div style="overflow:scroll">
	<form method="post" action="searchCustomer">
	<fieldset>
	<legend>客户信息检索 🔍</legend>
		<table>
			<tr>
				<td>客户编码:</td>
				<td><input class="easyui-validatebox" type="text" id=“f1i1” name="cId"/></td>
				<td>客户名称：</td>
				<td><input class="easyui-validatebox" type="text" id="f1i2" name="cName"/></td>
				<td>业务员：</td>
				<td><input class="easyui-validatebox" type="text" id="f1i3" name="sMan"/></td>
				<td><input class="easyui-validatebox" type="submit" id="f1b1" value=" 搜 索 "/></td>
			</tr>
		</table>
	</fieldset>
	</form>
	<table id="grid" style=" style="width:100%;height:100%;"></table>
	<div id="cusDlg" class="easyui-dialog" style="width:400px;height:400px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<fieldset>
		<legend>客户信息</legend>
		<form id="fm" onsubmit="return checkCustomInfo()" method="post" action="addCustomer">
			<table>
				<tr>
					<td><label>客户名：</label></td>
					<td><input name="compName" id="f2i1" maxlength="50" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>客户编号：</label></td>
					<td><input name="shrtName" id="f2i2" maxlength="10" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>客户电话：</label></td>
					<td><input name="tel" id="f2i3" maxlength="16" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>客户地址：</label></td>
					<td><input name="compAddr" id="f2i4" maxlength="100" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>联络人:</label></td>
					<td><input name="usher" id="f2i5" maxlength="10" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>联络人电话:</label></td>
					<td><input name="usher" id="f2i6" maxlength="16" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>联络人职务:</label></td>
					<td><input name="position" id="f2i7" maxlength="20" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td><label>业务员:</label></td>
					<td><input name="specialist" id="f2i8" maxlength="10" class="easyui-validatebox"></td>
				</tr>
				<tr>
					<td><label>备注:</label></td>
					<td><input name="cmnt" id="f2i9" maxlength="100" class="easyui-validatebox"></td>
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