<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
	Connection conn = null;
	String jdbc_driver = "oracle.jdbc.OracleDriver";
	String jdbc_url = "jdbc:oracle:thin:@//localhost:1521/xe";
	
	try{
		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(jdbc_url, "system", "1234");
	}catch(Exception e){
		System.out.println("DB CONN FAIL");
		System.out.println("SQL Exception:" + e.getMessage());
	}
%>
