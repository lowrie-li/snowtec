<%@ page language="java" import="java.sql.*,java.io.*,java.util.*, com.snowtec.*"%>
<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE HTML>
<html>
<head>
<style type="text/css">
table {
	border: 2px #CCCCCC solid;
	width: 360px;
}

td,th {
	height: 30px;
	border: #CCCCCC 1px solid;
}
</style>
</head>
<body>
	<%
		//驱动程序名 
		String sql_str = "select * from UserRole";
		DbConnection dbconn = new DbConnection();
		ResultSet rs = dbconn.ExecuteSQL(sql_str);
	%>
	<br>
	<br>
	<table align="center">
		<tr>
			<th>
				<%
					out.print("编号");
				%>
			</th>
			<th>
				<%
					out.print("用户名");
				%>
			</th>
			<th>
				<%
					out.print("密码");
				%>
			</th>
		</tr>

		<%
			while (rs.next()) {
		%>
		<tr>
			<td>
				<%
					out.print(rs.getInt(1));
				%>
			</td>
			<td>
				<%
					out.print(rs.getString(2));
				%>
			</td>
			<td>
				<%
					out.print(rs.getString(3));
				%>
			</td>
		</tr>
		<%
			}
		%>
	</table>
	<div align="center">
		<br> <br> <br>
		<%
			out.print("数据查询成功，恭喜你");
		%>
	</div>
	<%
		rs.close();
	%>
</body>
</html>