<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import="java.text.*" import="java.rmi.*" %>	
<%
	System.out.println("----------comment_delete-----------");
	request.setCharacterEncoding("UTF-8");
	
	String commentId = request.getParameter("commentId");
	
	String driverName = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		
	Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	
	PreparedStatement pstmt = null;
	try {
		Class.forName(driverName);
	 	System.out.println("DB Conn Success");
	 	//--------------------- comment delete
	 	String commentSql = "DELETE FROM COMMENT_INFO WHERE COMMENT_ID='"+commentId+"'";
	 			
	 	pstmt = con.prepareStatement(commentSql);
	 	
	 	pstmt.executeUpdate();
		
		System.out.println("contents Sql = "+commentSql);
		System.out.println("------- comment_delete end -------");
	}catch (SQLException e) {
		System.out.println(e.toString());
		out.print("fail:3040");
	}finally{
		try{
			if(pstmt!=null)pstmt.close();
			if(con!=null)con.close();
		}catch(SQLException e){
			System.out.println(e.toString());	
		}
	}
%>