<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import="java.text.*" import="java.rmi.*" import="org.json.simple.*"%>	
<%
	System.out.println("----------tag_select-----------");
	request.setCharacterEncoding("UTF-8");
	
	String driverName = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		
	Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	PreparedStatement pstmt = null;
	ResultSet rs = null; 
	
	StringBuilder sb = new StringBuilder();
	
	try {
		Class.forName(driverName);
	 	System.out.println("DB Conn Success");
	 	//--------------------- contents delete
	 	String tagSql = "SELECT distinct TAG_NAME FROM TAG_INFO";
	 			
	 	pstmt = con.prepareStatement(tagSql);
	 	rs = pstmt.executeQuery();
	 	System.out.println("tag Sql = "+tagSql);
		
		int i = 0;
	 	while(rs.next()){
	 		String name = rs.getString("TAG_NAME");
	 		if(i!=0){
	 			sb.append(",");
	 		}
	 		sb.append(name);
	 		i++;
	 	}

	 	
		System.out.println("------- tag_select end -------");
		
		
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
