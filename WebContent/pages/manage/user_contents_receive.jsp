<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import="java.text.*" import="java.rmi.*" import="org.json.simple.*"%>	
<%
	System.out.println("----------user_contents_receive start -----------");
	request.setCharacterEncoding("UTF-8");
	
	String userId = request.getParameter("userId");
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	
	String driverName = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		
	Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	PreparedStatement pstmt = null;
	ResultSet rs = null; 
	
	StringBuilder sb = new StringBuilder();
	
	try {
		Class.forName(driverName);
	 	System.out.println("DB Conn Success");
	 	
	 	String sql = "SELECT count(*) FROM CONTENTS_INFO WHERE CONTENTS_REGIST_USER_ID="+userId
	 			+" and TO_TIMESTAMP(CONTENTS_REGIST_DATE, 'YYYYMMDDHH24MISSFF3')"
	 			+"BETWEEN TO_TIMESTAMP("+startDate+", 'YYYYMMDD') AND TO_TIMESTAMP("+endDate+", 'YYYYMMDD')+0.99999421";
	 			
	 	pstmt = con.prepareStatement(sql);
	 	rs = pstmt.executeQuery();
	 	System.out.println("sql = "+sql);
		
	 	rs.next();
	 	int rowCount = rs.getInt(1);
	 	System.out.println("rowCount = "+rowCount);
	 	
		System.out.println("-------user_contents_receive end -------");
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
<%=sb %>
