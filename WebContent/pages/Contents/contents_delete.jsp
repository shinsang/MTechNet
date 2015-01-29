<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import="java.text.*" import="java.rmi.*" %>	
<%
	System.out.println("----------contents_delete-----------");
	request.setCharacterEncoding("UTF-8");
	
	String contentsId = request.getParameter("contentsId");
	
	String driverName = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		
	Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	
	PreparedStatement pstmt = null;
	try {
		Class.forName(driverName);
	 	System.out.println("DB Conn Success");
	 	//--------------------- contents delete
	 	String contentsSql = "DELETE FROM CONTENTS_INFO WHERE CONTENTS_ID='"+contentsId+"'";
	 			
	 	pstmt = con.prepareStatement(contentsSql);
	 	
	 	pstmt.executeQuery();
		
		System.out.println("contents Sql = "+contentsSql);
		
		//--------------------- comment delete
		String commentSql = "DELETE FROM COMMENT_INFO WHERE COMMENT_PARENTS_CONTENTS_ID='"+contentsId+"'";
		pstmt= null;
	 	pstmt = con.prepareStatement(commentSql);
	 	
	 	pstmt.executeQuery();
		
		System.out.println("comment Sql = "+commentSql);
		
		
		System.out.println("------- contents_delete end -------");
	}catch (SQLException e) {
		System.out.println(e.toString());
	}finally{
		try{
			if(pstmt!=null)pstmt.close();
			if(con!=null){
				con.close();
				System.out.println("contents_delete end conn disconnect SUCCESS!!");
			}
		}catch(SQLException e){
			System.out.println(e.toString());	
		}
	}
%>