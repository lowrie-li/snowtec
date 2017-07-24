package com.snowtec;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;
//import com.opensymphony.xwork2.ModelDriven;  implements ModelDriven<Company>

public class AjaxAction extends ActionSupport{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 
	 */
	private DbConnection dbConn = new DbConnection();
	
	private String cId;
	private String cName;
	private String sMan;
	
    private String compName;  
    private String shrtName;  
    private String compTel;
    private String compAddr;
    private String cnntName;
    private String cnntPhone;
    private String position;
    private String specialist;
    private String cmnt;
    
    public void setCId(String id) {
    	this.cId = id;
    }
    
    public String getCId() {
    	return this.cId;
    }
    
    public void setCName(String name) {
    	this.cName = name;
    }
    
    public String getCName() {
    	return this.cName;
    }
    
    public String getSMan() {
    	return this.sMan;
    }
    
    public void setSMan(String name) {
    	this.sMan = name;
    }
    
    
    
    public void setCompName(String name) {
    	this.compName = name;
    }
    
    public String getCompName() {
    	return this.compName;
    }
    
    public void setShrtName(String name) {
    	this.shrtName = name;
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

//	private Company company = new Company();
//	
//	public void setCompany(Company company) {
//		this.company = company;
//	}
//	
//	public Company getCompany() {
//		return this.company;
//	}
//	
//    public Company getModel() {  
//        return this.company;
//    }
    
	public String add() throws Exception {

		String colStr = "isCustomer, compName, shrtName, compTel, compAddr, cnntName, cnntPhone, position";
		String valStr = "1," + "'" + compName + "', '" + shrtName + "', '" + compTel + "', '" + compAddr + "', '" 
						+ cnntName + "', '" + cnntPhone + "', '" + position + "'";
		String addStr = "INSERT INTO Companies(" + colStr + ") VALUES (" + valStr + ");";
		System.out.println(addStr);
		if (dbConn.UpdateSQL(addStr) == 1) {
			System.out.println("成功插入数据！");
		} else {
			System.out.println("插入数据失败！");
		}

		search();
		return Action.NONE;
	}

	public String delete() throws Exception {
		String keyVal = "compName = \"" + ServletActionContext.getRequest().getParameter("") + "\"";

		String delStr = "DELETE FROM Companies WHERE " + keyVal + ";";
		
//		String specialist = ServletActionContext.getRequest().getParameter("specialist");
//		String cmnt = ServletActionContext.getRequest().getParameter("cmnt");
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
//		String rsJsonStr= dbConn.GetJsonResult("update from Companies" + condition + ";");
		
		search();
		return Action.NONE;
	}

	public String search() throws Exception {

		String condition = "";
		
		if (cName != null && cName.length() > 0) {
			condition = "compName = '" + cName + "'";
		} else {
			System.out.println("->" + cName + "<-");
		}
		if (condition.length() > 0) {
			condition += " and ";
		}
		if (cId != null && cId.length() > 0) {
			condition += "shrtName = '" + cId + "'";
		}else {
			System.out.println("->" + cName + "<-");
		}
		if (condition.length() > 0) {
			condition += " and ";
		}
		if (sMan != null && sMan.length() > 0) {
			condition += "specialist = '" + sMan + "'";
		}else {
			System.out.println("->" + cName + "<-");
		}
		
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
	
	public String json() throws Exception {
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
		return "success";
	}
	
}