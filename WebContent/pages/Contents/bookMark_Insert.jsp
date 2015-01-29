<%@page import="java.rmi.dgc.VMID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" 
	 import="java.util.*"
	 import="java.text.*" 
	 import="java.rmi.*" %>	
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String RequestContentId = request.getParameter("contentId");
	String RequestUserId = request.getParameter("userId");
	
	String driverName = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
 //	System.out.println("DB Conn Success");
	Statement stmt = con.createStatement();
	
	ResultSet rs = null;
%>
<%
	try {		
		String sql = "insert into bookmark_info values('"+RequestUserId+"','"+RequestContentId+"')";
		
//		System.out.println("BOOKMARK_INFO Insert Sql = "+sql);		
		rs = stmt.executeQuery(sql);
		
	}catch (Exception e) {
		System.out.println(e.toString());	
	}	
	finally {
		try {if(stmt!=null){stmt.close();	}} catch (SQLException ee) {	}
		try {if(rs!=null){rs.close();}} catch (SQLException ee) { }
		try {if(con!=null){con.close(); System.out.println("BookMarkInsert conn Disconnect!!");}} catch (SQLException ee) { }
	}
%>