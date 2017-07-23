package com.snowtec;

import java.io.*;
import java.sql.*;
import java.util.Properties;

import javax.naming.NamingException;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class DbConnection {

	private transient String driverCls = null;
	private transient String connStr = null;
	private transient String user = null;
	private transient String pwd = null;
	private transient Connection dbConn = null;
	private transient Statement stmt = null;
	private transient ResultSet resultSet = null;
	private transient PreparedStatement PrepStmt = null;

	public DbConnection() {
		//Read the Database configurations.
		InputStream in = getClass().getClassLoader().getResourceAsStream("jdbc.properties");
		Properties prop = new Properties();
		try {
			prop.load(in);
		  
			driverCls = prop.getProperty("driver");
			connStr = prop.getProperty("jdbcurl") + prop.getProperty("database");
			if (prop.getProperty("encode") != null) {
				connStr += "?characterEncoding=" + prop.getProperty("encode");
				if (prop.getProperty("ssl") != null) {
					connStr += "&&useSSL=" + prop.getProperty("ssl");
				}
			} else if (prop.getProperty("ssl") != null) {
				connStr += "?useSSL=" + prop.getProperty("ssl");
			}
			
			user = prop.getProperty("user");
			pwd = prop.getProperty("password");
		} catch(IOException ioe) {
			ioe.printStackTrace();
		}

		try {
			Class.forName(driverCls);
			dbConn = DriverManager.getConnection(connStr, user, pwd);
			stmt = dbConn.createStatement();
			System.out.println("Create DB Connection OK!");
		} catch(SQLException sql_excp) {
			sql_excp.printStackTrace();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
 
	public PreparedStatement getPrepStmt(String StrSql) throws SQLException {
		PrepStmt = dbConn.prepareStatement(StrSql);
		return PrepStmt;
	}
 
	public void SetMaxTime(Statement stmt, int times) throws SQLException {
		stmt.setQueryTimeout(times);
	}
  
	public ResultSet ExecuteSQL(String sqlSentence) throws SQLException {
		resultSet = stmt.executeQuery(sqlSentence);
		return resultSet;
	}
	
	public String GetJsonResult(String sqlSentence) throws SQLException {
		resultSet = stmt.executeQuery(sqlSentence);
		
		System.out.println("Fetch results from table OK!");
		
		JSONArray array= new JSONArray();
		
		ResultSetMetaData metaData = resultSet.getMetaData();
		
		int colCount = metaData.getColumnCount();
//		resultSet.last();
//		int rowCount = resultSet.getRow();
//		System.out.println("colCount: " + colCount  + "\nrowCount: " + rowCount);
//		for (int i = 0; i < colCount; i ++) {
//			System.out.println(metaData.getColumnName(i+1));
//		}
		
		if (resultSet.first()) {
		    do {
				JSONObject jsonObj = new JSONObject();
				for(int i = 1; i < colCount + 1; i++) {
					if (null != resultSet.getObject(i)) {
						System.out.println(metaData.getColumnLabel(i) + " | " + resultSet.getObject(i).toString());
						jsonObj.put(metaData.getColumnLabel(i), resultSet.getObject(i).toString());
					}
				}
				array.add(jsonObj);
			}while(resultSet.next());
		}
//		System.out.println("Transfor to String OK: " + array.toString());
		return array.toString();
	}
  
	public void AddBatch(String StrSql) throws SQLException {
		stmt.addBatch(StrSql);
	}

	public int UpdateSQL(String sqlSentence) throws SQLException,NamingException {
		int i=-1;
		i=stmt.executeUpdate(sqlSentence);
		return i;
	}
  
	public void Close() {
		CloseStmt();
		CloseRs();
		CloseCon();
		ClosePrepStmt();
	}

  
	public void CloseRs() {
		try {
			if (resultSet != null) {
				resultSet.close();
			}
		} catch (Exception ex) {}
  }

	/**
	* 关闭数据库连接
	*/
	public void CloseCon() {
		try {
			if (dbConn != null) {
				dbConn.close();
			}
		}catch (Exception ex) {}
	}

	/**
	* 关闭Statement
	*/
	public void CloseStmt() {
		try {
			if (stmt != null) {
				stmt.close();
			}
		}catch (Exception ex) {}
	}

	/**
	* 关闭预处理语句
	*/
	public void ClosePrepStmt() {
		try {
			if (PrepStmt != null) {
				PrepStmt.close();
			}
		}catch (Exception ex) {}
	}

	public void setAutoCommit(boolean isAutoCommit){
		try {
			dbConn.setAutoCommit(isAutoCommit);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
  
	public void commit(){
		try {
			dbConn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
  
	public void rollback(){
		try {
			dbConn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}