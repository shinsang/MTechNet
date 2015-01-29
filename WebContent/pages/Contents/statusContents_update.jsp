<%@page import="java.rmi.dgc.VMID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" import="java.util.*" import="java.text.*" import="java.rmi.*" %>	
<script src="../../js/ajax.js" type="text/javascript"></script>
<script src="../../js/jquery-1.11.1.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	
	String contentsId = request.getParameter("contentId");
	String changeStatus = request.getParameter("changeStatus");

	System.out.println("contentsId="+contentsId+", changeStatus="+changeStatus);
	
	String driverName = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		
	Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	
	PreparedStatement pstmt = null;
	try {
		Class.forName(driverName);	 	
	 	String sql = "update CONTENTS_INFO set CONTENTS_STATUS='"+changeStatus+"' WHERE CONTENTS_ID='"+contentsId+"'";
	 	System.out.println("confirm contents Update Sql = "+sql);

	 	pstmt = con.prepareStatement(sql);
	 	pstmt.executeUpdate();
	}catch (SQLException e) {
		System.out.println(e.toString());
	}finally{
		try{
			if(pstmt!=null)pstmt.close();
			if(con!=null) {
				con.close();
				System.out.println("statusContent_update conn close Success!!");
			}
		}catch(SQLException e){
			System.out.println(e.toString());	
		}
	}
%>