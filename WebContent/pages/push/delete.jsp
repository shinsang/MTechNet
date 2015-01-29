<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>	
<%
	String regid = request.getParameter("regid");
	System.out.println("regid = "+regid);
	try {
		String driverName = "oracle.jdbc.driver.OracleDriver";	
		String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";	
		ResultSet rs = null;
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	 	System.out.println("DB Conn Success");
		Statement stmt = con.createStatement();			
		String sql = "delete gcm where regid = '" + regid+"'" ;
		System.out.println("Sql = "+sql);
		rs = stmt.executeQuery(sql);
		out.print("delete success");
		con.close();
	}catch (Exception e) {
		System.out.println(e.toString());
		out.print("delete fail");		
	}
%>