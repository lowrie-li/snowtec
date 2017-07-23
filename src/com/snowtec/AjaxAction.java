package com.snowtec;

import java.util.*;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class AjaxAction implements Action{
	private String jsonresult;
	private String jsonsecond;
	
	public String add() throws Exception {
		
		String valStr = "";
		for(int i = 1; i < 7; i ++) {
			valStr += ServletActionContext.getRequest().getParameter("f2i" + i) + " ,";
		}

		valStr = valStr.substring(0, valStr.length() - 1);
		String addStr = "INSERT INTO Companies() VALUES (" + valStr + ");";

//		String specialist = ServletActionContext.getRequest().getParameter("specialist");
//		String cmnt = ServletActionContext.getRequest().getParameter("cmnt");
		DbConnection dbConn = new DbConnection();
		dbConn.ExecuteSQL(addStr);

		search();
		return Action.NONE;
	}

	public String delete() throws Exception {
		String keyVal = "compName = \"" + ServletActionContext.getRequest().getParameter("") + "\"";

		String delStr = "DELETE FROM Companies WHERE " + keyVal + ";";
		
//		String specialist = ServletActionContext.getRequest().getParameter("specialist");
//		String cmnt = ServletActionContext.getRequest().getParameter("cmnt");
		DbConnection dbConn = new DbConnection();
		dbConn.ExecuteSQL(delStr);

		search(); 
		return Action.NONE;
	}

	public String update() throws Exception {

		DbConnection dbConn = new DbConnection();
		String condition = "";
		
		if (condition != "") {
			condition = " where " + condition;
		}
		String rsJsonStr= dbConn.GetJsonResult("select * from Companies" + condition + ";");
		System.out.println(rsJsonStr);
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			ServletActionContext.getResponse().getWriter().println(rsJsonStr);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return Action.NONE;
	}

	public String search() throws Exception {

		DbConnection dbConn = new DbConnection();
		String condition = "";
		
		if (ServletActionContext.getRequest().getParameter("f1i" + 1).length() > 0) {
			condition = "compName = \"" + ServletActionContext.getRequest().getParameter("f1i" + 1) + "\"";
		}
		if (condition.length() > 0) {
			condition += " and ";
		}
		if (ServletActionContext.getRequest().getParameter("f1i" + 2).length() > 0) {
			condition += "shrtName = \"" + ServletActionContext.getRequest().getParameter("f1i" + 2) + "\"";
		}
		if (condition.length() > 0) {
			condition += " and ";
		}
		if (ServletActionContext.getRequest().getParameter("f1i" + 3).length() > 0) {
			condition += "specialist = \"" + ServletActionContext.getRequest().getParameter("f1i" + 3) + "\"";
		}
		
		if (condition != null && condition != "") {
			condition = " where " + condition;
		}
		String rsJsonStr= dbConn.GetJsonResult("SELECT * FROM Companies" + condition + ";");
		System.out.println(rsJsonStr);
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			ServletActionContext.getResponse().getWriter().println(rsJsonStr);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return Action.NONE;
	}
	
	public String json() throws Exception {
		ActionContext ctx=ActionContext.getContext();
		System.out.println("XXX");
		DbConnection dbConn = new DbConnection();
		System.out.println("YYY");
		String rsJsonStr= dbConn.GetJsonResult("select * from Companies;");
		System.out.println(rsJsonStr);
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			ServletActionContext.getResponse().getWriter().println(rsJsonStr);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return Action.NONE;
	}
	
	@Override
	public String execute() throws Exception {
		ActionContext ctx=ActionContext.getContext();
		
		DbConnection dbConn = new DbConnection();
		String rsJsonStr= dbConn.GetJsonResult("select compSno, shrtName, compName, homepage from Companies;");
		System.out.println(rsJsonStr);
		try {
			ServletActionContext.getResponse().getWriter().println(JSONArray.fromObject(rsJsonStr));
			ctx.put("json", rsJsonStr);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return "success";
	}
	
	public String getJsonsecond() {
		return jsonsecond;
	}
	public void setJsonsecond(String jsonsecond) {
		this.jsonsecond = jsonsecond;
	}
	public String getJsonresult() {
		return jsonresult;
	}
	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}
}