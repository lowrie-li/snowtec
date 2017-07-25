package com.snowtec;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;

public class CustomerAction extends ActionSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 
	 */
	private static DbConnection dbConn = new DbConnection();

    private String order;
    private int page;
    private int rows;
    private String sort;

/*	private String cId;
	private String cName;
	private String sMan;
*/	
    private String qtype;
    private String qword;
    
    private String compName;  
    private String shrtName;  
    private String compTel;
    private String compAddr;
    private String cnntName;
    private String cnntPhone;
    private String position;
    private String specialist;
    private String cmnt;

	public void setOrder(String order) {
    	this.order=order;
    }
    
    public String getOrder() {
    	return this.order;
    }
    
    public void setPage(String page) throws Exception {
    	try {
    	    this.page = Integer.parseInt(page);
    	} catch (NumberFormatException e) {
    	    e.printStackTrace();
    	}
    }
    
    public int getPage() {
    	return this.page;
    }
    
    public void setRows(String rows) {
    	try {
    	    this.rows = Integer.parseInt(rows);
    	} catch (NumberFormatException e) {
    	    e.printStackTrace();
    	}
    }
    
    public int getRows() {
    	return this.rows;
    }
    
    public String getSort() {
		return this.sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
    
	public void setQtype(String type){
		this.qtype = type;
	}
	
	public String getQtype() {
		return this.qtype;
	}
	
	public void setQword(String word) {
		this.qword = word;
	}
	
	public String getQword() {
		return this.qword;
	}
    
    public void setCompName(String name) {
    	this.compName = name;
    }
    
    public String getCompName() {
    	return this.compName;
    }
    
    public void setShrtName(String name) {
    	this.shrtName = name.toUpperCase();
    }
    
    public String getShrtName() {
    	return this.shrtName;
    }
    
    public void setCompTel(String name) {
    	this.compTel = name;
    }
    
    public String getCompTel() {
    	return this.compTel;
    }
    
    public void setCompAddr(String name) {
    	this.compAddr = name;
    }
    
    public String getCompAddr() {
    	return this.compAddr;
    }
    
    public void setCnntName(String name) {
    	this.cnntName = name;
    }
    
    public String getCnntName() {
    	return this.cnntName;
    }
    
    public void setCnntPhone(String name) {
    	this.cnntPhone = name;
    }
    
    public String getCnntPhone() {
    	return this.cnntPhone;
    }
    
    public void setPosition(String name) {
    	this.position = name;
    }
    
    public String getPosition() {
    	return this.position;
    }
    
    public void setSpecialist(String name) {
    	this.specialist = name;
    }
    
    public String getSpecialist() {
    	return this.specialist;
    }
    
    public void setCmnt(String name) {
    	this.cmnt = name;
    }
    
    public String getCmnt() {
    	return this.cmnt;
    }
    
	public String add() throws Exception {

		String chkExist = "SELECT * FROM Companies WHERE compName = '" + compName + "' or shrtName = '" + shrtName +"';";
		if(dbConn.RunQuery(chkExist).first()) {
			System.out.println("客户名（编号）重复！");
			return Action.ERROR;
		}
		
		String colStr = "isCustomer, compName, shrtName, compTel, compAddr, cnntName, cnntPhone, position";
		String valStr = "1," + "'" + compName + "', '" + shrtName + "', '" + compTel + "', '" + compAddr + "', '" 
						+ cnntName + "', '" + cnntPhone + "', '" + position + "'";
		String addStr = "INSERT INTO Companies(" + colStr + ") VALUES (" + valStr + ");";
		System.out.println(addStr);
		if (dbConn.RunUpdate(addStr) == 1) {
			System.out.println("成功插入数据！");
			return Action.SUCCESS;
		} else {
			System.out.println("插入数据失败！");
			return Action.ERROR;
		}

	}

	public String delete() throws Exception {
		shrtName = ServletActionContext.getRequest().getParameter("shrtName");
		String chkExist = "SELECT * FROM Companies WHERE shrtName = '" + shrtName +"';";
		System.out.println(chkExist);
		if(dbConn.RunQuery(chkExist).first()) {
			String delStr = "DELETE FROM Companies WHERE shrtName = '" + shrtName +"';";
			int rs = dbConn.RunUpdate(delStr);
			if (rs == 0) {
				System.out.println("No row delete!");
			} else {
				System.out.println("Delete successed!");
			}
			return Action.SUCCESS;
		} else {
			System.out.println("客户不存在！");
			return Action.ERROR;
		}
	}

	public String update() throws Exception {

		String chkExist = "SELECT * FROM Companies WHERE shrtName = '" + shrtName +"';";
		System.out.println(chkExist);
		if(dbConn.RunQuery(chkExist).first()) {
			String setStr = "compTel='" + compTel + "', compAddr='" + compAddr + "', cnntName='" 
					+ cnntName + "', cnntPhone='" + cnntPhone + "', position='" + position + "'";
			String updateStr = "UPDATE Companies SET " + setStr + " WHERE shrtName = '" + shrtName +"';";
			dbConn.RunUpdate(updateStr);
			return Action.SUCCESS;
		} else {
			System.out.println("客户不存在！");
			return Action.ERROR;
		}
	}

	public String search(String condition) throws Exception {

		if (condition.length() > 0) {
			condition = " where " + condition;
		}
		String qStr = "SELECT * FROM Companies" + condition + ";";
		String rsJsonStr= dbConn.GetJsonResult(qStr);
		System.out.println(rsJsonStr);
		try {
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			ServletActionContext.getResponse().getWriter().println(rsJsonStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Action.NONE;
	}
	
	public String search() throws Exception {

		String condition = "";
		
		qtype = ServletActionContext.getRequest().getParameter("qtype");
		qword = ServletActionContext.getRequest().getParameter("qword");

		if (qtype != null && qword != null && qword.length() > 0) {
			condition = qtype + " = '" + qword + "' or " + 
					qtype + " like '%" + qword + "' or " +
					qtype + " like '%" + qword + "%' or " +
					qtype + " like '" + qword + "%'";
		}
		
		return search(condition);
	}
	
	@Override
	public String execute() throws Exception {
		return "success";
	}

}