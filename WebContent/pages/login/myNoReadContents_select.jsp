<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import="java.text.*" import="java.rmi.*" import="org.json.simple.*"%>	
<%
	request.setCharacterEncoding("UTF-8");
	String userId = request.getParameter("userId");
	
	String driverName = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		
	Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	PreparedStatement pstmt = null;
	ResultSet rs = null; 
	
	int noReadCount = 0;
	try {
		Class.forName(driverName);
	 	System.out.println("DB Conn Success");
	 	String sql = "select count(*) as count "
	 				 + "from contents_info A " 
		 		     + "LEFT JOIN new_CONTENTS_QUEUE B "
		 		     + "ON A.CONTENTS_ID=B.CONTENTS_ID AND A.CONTENTS_RECEIVE_USER_ID = B.USER_ID "
	 				 + "where A.CONTENTS_RECEIVE_USER_ID = '"+userId+"' and b.message_type = 2 and b.read_status='N'";
	 	System.out.println("sql = "+sql);
	 	
	 	pstmt = con.prepareStatement(sql);
	 	rs = pstmt.executeQuery();
	 	
	 	
	 	while(rs.next()){
	 		noReadCount = rs.getInt("COUNT");		
		}

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
<%=noReadCount%>