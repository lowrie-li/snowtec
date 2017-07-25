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
 	
 	var url;
 	
	function InitGrid(queryData) {
	    $('#grid').datagrid({   //定位到Table标签，Table标签的ID是grid
	        url: 'searchCustomer',   //指向后台的Action来获取当前菜单的信息的Json格式的数据
/* 	        contentType: "application/json", */
	        title: '客户列表',
	        iconCls: 'icon-view',
	        nowrap: true,
	        autoRowHeight: false,
	        fitColumns:false,
	        striped: true,
	        collapsible: true,
	        pagination: true,
	        pageSize: 20,
	        pageList: [20,50,100],
	        rownumbers: true,
	        sortName: 'shrtName',    //根据某个字段给easyUI排序
	        sortOrder: 'asc',
	        remoteSort: false,
 	        idField: 'shrtName',
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
	            	$("#btnAdd").click(function () {
	            		url = 'addCustomer';
		            	$('#grid').datagrid('uncheckAll');
	        		    $('#form').form('clear');
	        		    $('#cusDlg').dialog({title:"添加新客户",iconCls:"icon-add"}).dialog('open');
	        		});
	            	delete url;
	            }
	        }, '-', {
	            id: 'btnEdit',
	            text: '修改',
	            iconCls: 'icon-edit',
	            handler: function () {
	        		$("#btnEdit").click(function () {
	        			var rows = $('#grid').datagrid('getSelections');
	        	        if (rows.length < 1) {
	        	        	$.messager.alert("提示", "请选中一行进行编辑！")
	        	        } else if (rows.length == 1) {
	        	        	url = 'updateCustomer';
	        	        	var row = rows[0];
	        	            $('#cusDlg').dialog({title:"编辑客户信息", iconCls:"icon-edit"}).dialog('open');
	        	            $('#form').form("load", row);
	        	        }
	        		});
	        		delete row;
	        		delete rows;
	        		delete url;
	            }
	        }, '-', {
	            id: 'btnDelete',
	            text: '删除',
	            iconCls: 'icon-remove',
	            handler: function () {
	            	deleteCustomer();
	            	$("#grid").datagrid("reload");
	            }
	        }, '-', {
	            id: 'btnReload',
	            text: '刷新',
	            iconCls: 'icon-reload',
	            handler: function () {
	                $("#grid").datagrid("reload");
	            }
	        }, '-', {
	            id: 'btnSearch',
	            text: '查询',
	            iconCls: 'icon-search',
	            handler: function () {
	                $('#query').window('open');
	            }
	        }],
	        onDblClickRow: function () {
	            //实现双击修改数据
	        }
	    });
	};
	
	
	function saveCustomer() {
	    $('#form').form('submit', {
	            url:url,
	            onSubmit: function() {
	        		if ($('#compName').val() == null || $('#compName').val() == "") {
	        			alert("请填写客户名！");
	        			return false;
	        		}
	         		if ($('#shrtName').val() == null || $('#shrtName').val() == "") {
	        			alert("请填写客户编码！");
	        			return false;
	        		}
	        		if ($('#compTel').val() == null || $('#compTel').val() == "") {
	        			alert("请填写客户电话！");
	        			return false;
	        		}
	        		if ($('#compAddr').val() == null || $('#compAddr').val() == "") {
	        			alert("请填写客户地址！");
	        			return false;
	        		}
	        		if ($('#cnntName').val() == null || $('#cnntName').val() == "") {
	        			alert("请填写联系人！");
	        			return false;
	        		}
	        		if ($('#cnntPhone').val() == null || $('#cnntPhone').val() == "") {
	        			alert("请填写联系人电话！");
	        			return false;
	        		}
	        		if ($('#position').val() == null || $('#position').val() == "") {
	        			alert("请填写联系人职务！");
	        			return false;
	        		}
	            },
	            success: function(result) {
	            	$('#grid').datagrid('reload');
	            	$('#cusDlg').dialog('close');
	                var result = eval('(' + result + ')');
	                if (result.errorMsg) {
	                    $.messager.show({
	                        title: 'Error',
	                        msg: result.errorMsg
	                    });
	                } else {
	                    $('#cusDlg').dialog('close');
	                    $('#grid').datagrid('reload');
	                }
	            }
	    });
	}
	
	function deleteCustomer() {
		var row = $('#grid').datagrid('getSelected');
		$('#grid').datagrid('uncheckAll');
		if (row) {
			$.messager.confirm('Confirm', '是否确定删除该客户信息',
				function(r) {
	                if (r) {
	                    $.post('deleteCustomer', 
	                    	   {
	                 			shrtName: row.shrtName
	                    	   },
	                    	   function(result) {
	                    		   alert("XXXX");
	                    		   $('#grid').datagrid('reload');
	                    		   var result = eval('(' + result + ')');
	                        		if (result.success) {
	                        			alert("YYYY");
	                           			$('#grid').datagrid('reload');
	                       			} else {
	                       				alert("ZZZZ");
	                           			$.messager.show({
	                               						 title: 'Error',
	                               						 msg: result.errorMsg
	                            		});
	                        		}
	                    	   },
	                    	   'json'
						);
					}
			});
		} else {
			$.messager.alert("提示", "请选中需要删除的客户！")
		}
	}
	
	function searchCustomer() {
		InitGrid({qtype: $('#qtype').val(), qword: $('#qword').val()});
	}
</script>

</head>

<body  onload="InitGrid()">

<div style="overflow:scroll">
	<table id="grid" style=" style="width:100%;height:100%;"></table>
	<div id="query" class="easyui-window" title="查询" style="padding: 10px;width: 320px;height:100;"
    iconCls="icon-search" closed="true" maximizable="false" minimizable="false" collapsible="false">
        <div>
            <table>
                <tr>
                    <td>
                        <select name="qtype" id="qtype">
                            <option value="compName">公司名称</option>
                            <option value="shrtName">客户代码</option>
                            <option value="specialist">客户专员</option>
                        </select>
                    </td>
                    <td><input type="text" name="qword" id="qword"  required="true"></td>
                    <td><a class="easyui-linkbutton" iconCls="icon-search" href="javascript:void(0);" onclick="searchCustomer()">查询</a></td>
                </tr>
            </table>
        </div>
    </div>
    <div id="cusDlg" class="easyui-dialog" style="width:330px;height:320px;padding:10px" closed="true" buttons="#dlg-buttons">  
	   	<div class="ftitle" class="easyui-div" style="width:340px;height:20px;align:center">客户信息</div>
	    <form id="form" method="post" onsubmit="return checkCustomInfo()">
			<table>
				<tr>
					<td><label>公司名称：</label></td>
					<td><input name="compName" id="compName" maxlength="50" class="easyui-textbox" style="width:200px;"></td>
				</tr>
				<tr>
				<td><label>公司编号：</label></td>
					<td><input name="shrtName" id="shrtName" maxlength="10" class="easyui-textbox" style="width:200px;"></td>
				</tr>
				<tr>
					<td><label>公司电话：</label></td>
					<td><input name="compTel" id="compTel" maxlength="16" class="easyui-textbox" style="width:200px;"></td>
				</tr>
				<tr>
					<td><label>公司地址：</label></td>
					<td><input name="compAddr" id="compAddr" maxlength="100" class="easyui-textbox" style="width:200px;"></td>
				</tr>
				<tr>
				<td><label>联络人:</label></td>
					<td><input name="cnntName" id="cnntName" maxlength="10" class="easyui-textbox" style="width:200px;"></td>
				</tr>
				<tr>
					<td><label>联络电话:</label></td>
					<td><input name="cnntPhone" id="cnntPhone" maxlength="16" class="easyui-textbox" style="width:200px;"></td>
				</tr>
				<tr>
					<td><label>联络人职务:</label></td>
					<td><input name="position" id="position" maxlength="20" class="easyui-textbox" style="width:200px;"></td>
				</tr>
				<tr>
					<td><label>客户专员:</label></td>
					<td><input name="specialist" id="specialist" maxlength="10" class="easyui-textbox" style="width:200px;"></td>
				</tr>
				<tr>
					<td><label>备注:</label></td>
					<td><input name="cmnt" id="cmnt" maxlength="100" class="easyui-textbox" style="width:200px;"></td>
				</tr>
			</table>
	   </form>
   	</div>
	<div id="dlg-buttons">
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveCustomer()" style="width:90px">完成</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#cusDlg').dialog('close')" style="width:90px">取消</a>
	</div>
</div>
</body>