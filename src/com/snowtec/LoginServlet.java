package com.snowtec;

import java.sql.*;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(description = "Process the Login request", urlPatterns = { "/LoginServlet" })
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String id = request.getParameter("userid");
		String pwd = request.getParameter("userpwd");
		
		try{
			String con_str="jdbc:mysql://localhost:3306/sinotech?characterEncoding=utf8&useSSL=false";
			String dbuser="sinotech";
			String dbpwd="sinotech";
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(con_str, dbuser, dbpwd);
			Statement stmt = conn.createStatement();
			
			String sql_str = "select * from UserRole where username = '" + id + "' and password = '" + pwd + "';";
			ResultSet rs = stmt.executeQuery(sql_str);
			
			if(rs.next()) {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
				out.println("<HTML>");
				out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
				out.println("  <BODY>");
				out.print("    This is ");
				out.print(this.getClass());
				out.println(", using the GET method " + rs.getString(2) + " | " + rs.getString(3));
				out.println("  </BODY>");
				out.println("</HTML>");
				out.flush();
				out.close();
			} else {
				request.getSession().setAttribute("errno", "id_pwd_err");
				request.getRequestDispatcher("index.jsp").forward(request, response);
			}
			
		} catch(SQLException sql_excp) {
			request.getSession().setAttribute("db_con_err", "true");
			sql_excp.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
