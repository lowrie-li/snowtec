package com.snowtec;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.struts2.ServletActionContext;
import javax.servlet.http.HttpServletRequest;
import com.opensymphony.xwork2.Action;

public class LoginAction implements Action{
	public String ajax() throws Exception {
		System.out.println("action execute");
		ServletActionContext.getResponse().getWriter().println("struts data response to ajax");
		return SUCCESS;  //返回success，struts将根据配置文件，对页面进行重定向。
//		return Action.NONE;  //返回空值，页面将在函数结束后不进行定向。
	}
	
	
	@Override
	public String execute() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("userid");
		String pwd = request.getParameter("userpwd");
		
		try{
			DbConnection dbconn = new DbConnection();
			
			String sql_str = "select * from UserRole where userId = '" + id + "' and password = '" + pwd + "';";
			ResultSet rs = dbconn.RunQuery(sql_str);
			
			if(rs.next()) {
				request.getSession().setAttribute("errno","none");
				request.getSession().setAttribute("UID", id);
				request.getSession().setAttribute("LOGGED", "TRUE");
				request.getRequestDispatcher("workboard.jsp").forward(request, ServletActionContext.getResponse());
			} else {
				request.getSession().setAttribute("errno", "id_pwd_err");
				request.getRequestDispatcher("login.jsp").forward(request, ServletActionContext.getResponse());
			}
			
		} catch(SQLException sql_excp) {
			request.getSession().setAttribute("db_con_err", "true");
			sql_excp.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}