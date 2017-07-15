package com.snowtec;

import java.util.*;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;

public class AjaxAction implements Action{
	private String jsonresult;
	public String getJsonresult() {
		return jsonresult;
	}
	public void setJsonresult(String jsonresult) {
		this.jsonresult = jsonresult;
	}
	public String ajax() throws Exception {
		System.out.println("action execute");
		Map<String,String> map = new HashMap<String,String>();
		map.put("b","b");
		System.out.println("XXX");
		System.out.println(map);
		System.out.println("YYY");
		ServletActionContext.getResponse().getWriter().println("struts data response to ajax");
		return Action.NONE;
	}
	@Override
	public String execute() throws Exception {
		return null;
	}
}