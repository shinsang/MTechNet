<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>	

<%
	String userid=request.getParameter("userid");
	String regid = request.getParameter("regid");

	try {

		String driverName = "oracle.jdbc.driver.OracleDriver";	

		String url = "jdbc:oracle:thin:@localhost:1521:ORCL";	

		ResultSet rs = null;

	 

		Class.forName(driverName);

		Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");

	 

		Statement stmt = con.createStatement();			

		String sql = "insert into gcm (userid,regid) values ('"userid+"','" + regid + "')";

		rs = stmt.executeQuery(sql);

		out.print("success");

		con.close();

	}catch (Exception e) {

		out.print("fail");		

	}

%>