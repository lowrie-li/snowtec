package com.snowtec;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;

public class AjaxAction implements Action{
	public String ajax() throws Exception {
		System.out.println("action execute");
		ServletActionContext.getResponse().getWriter().println("struts data response to ajax");
		return SUCCESS;  //返回success，struts将根据配置文件，对页面进行重定向。
//		return Action.NONE;  //返回空值，页面将在函数结束后不进行定向。
	}
	@Override
	public String execute() throws Exception {
		return null;
	}
}