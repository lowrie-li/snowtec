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
	<script language="JavaScript">
		function addTab(title, url) {
			if ($('#home').tabs('exists', title)) {
				$('#home').tabs('select', title);
			} else {
				var content = '<iframe scrolling="auto" frameborder="0" src="'
						+ url + '" style="width:1200px;height:800px;"></iframe>';
				$('#home').tabs('add', {
					title : title,
					content : content,
					closable : true
				});
			}
		}
	
 		$(document).ready(function() {
	
		});
	</script>
	<style>
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
			window.location.href = "login.jsp"
		}
	}
	</script>
</head>

<body class="easyui-layout" onload="init()">
	<div region="north" border="true" split="true"
		style="overflow: hidden; height: 80px;">
		<div class="footer">
			<a href="index.jsp">
                <img src="./images/logo.jpg" alt="深圳市欣诺泰电子有限公司 （总部）"></a>
		</div>
	</div>

	<div region="south" border="true" split="true"
		style="overflow: hidden; height: 40px;">
		<div class="footer">
			版权所有：<a href="http://www.sznotec.com/">深圳市欣诺泰电子有限公司</a>
		</div>
	</div>

	<div region="west" split="true" title="工作面板" style="width: 150px;">

		<div id="menu" class="easyui-accordion"
			style="position: absolute; top: 27px; left: 0px; right: 0px; bottom: 0px;">

			<div title="个人事务" style="padding: 10px;">
				<ul class="easyui-tree">
					<li><a href="#" onclick="addTab('通知公告','success.jsp')">通知公告</a></li>
					<li><a href="#" onclick="addTab('备忘录','add')">备忘录</a></li>
					<li><a href="#" onclick="addTab('通讯簿','add')">通讯簿</a></li>
					<li><a href="#" onclick="addTab('其他','add')">其他</a></li>
				</ul>
			</div>

			<div title="销售管理" style="padding: 10px;">
				<ul class="easyui-tree">
					<li><a href="#" onclick="addTab('销售报表','SalesRpt')">销售报表</a></li>
					<li><a href="#" onclick="addTab('客户管理','CustomerCrud.jsp')">客户管理</a></li>
					<li><a href="#" onclick="addTab('订单管理','InIndentCrud')">订单管理</a></li>
				</ul>
			</div>

			<div title="库存管理" style="padding: 10px;">
				<ul class="easyui-tree">
					<li><a href="#" onclick="addTab('库存概览','WarehouseRpt')">库存概览</a></li>
					<li><a href="#" onclick="addTab('供应商管理','SupplierCrud')">供应商管理</a></li>
					<li><a href="#" onclick="addTab('产品管理','ProductCrud')">产品管理</a></li>
					<li><a href="#" onclick="addTab('采购订单','OutIndentCrud')">采购订单</a></li>
					<li><a href="#" onclick="addTab('库存管理','WarehourseCrud')">仓库管理</a></li>
				</ul>
			</div>
			<div title="人事管理" style="padding: 10px;">
				<ul class="easyui-tree">
					<li><a href="#" onclick="addTab('个人信息','PersonalInfo')">个人信息</a></li>
					<li><a href="#" onclick="addTab('团队建设','TeamCrud')">团队建设</a></li>
					<li><a href="#" onclick="addTab('考勤管理','AttendceCrud')">考勤管理</a></li>
					<li><a href="#" onclick="addTab('绩效考评','KPICrud')">绩效考评</a></li>
				</ul>
			</div>
			<div title="财务管理" style="padding: 10px;">
				<ul class="easyui-tree">
					<li><a href="#" onclick="addTab('费用报销','ExspenseCrud')">费用报销</a></li>
					<li><a href="#" onclick="addTab('应收账款','RecievalbeCrud')">应收账款</a></li>
					<li><a href="#" onclick="addTab('应付账款','PayableCrud')">应付账款</a></li>
					<li><a href="#" onclick="addTab('财务报表','FinancialRpt')">财务报表</a></li>
					<li><a href="#" onclick="addTab('账户管理','AccountCrud')">账户管理</a></li>
					<li><a href="#" onclick="addTab('流水管理','FundflowCrud')">流水管理</a></li>
					<li><a href="#" onclick="addTab('经费计划','PlanCrud')">经费计划</a></li>
				</ul>
			</div>
		</div>
	</div>

	<div id="mainPanle" region="center" style="overflow: scroll">

		<div id="home" class="easyui-tabs" style="width: 1300px; height: 800px;">
			<div title="Home">Hello,welcome to use this system.</div>
		</div>
	</div>
</body>
</html>