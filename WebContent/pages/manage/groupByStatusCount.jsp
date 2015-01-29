<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*" import="java.text.*" import="java.rmi.*" import="org.json.simple.*"%>	
<%
	System.out.println("----------groupByStatusCount start -----------");
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
	 	String sql = "SELECT CONTENTS_STATUS, count(*) FROM CONTENTS_INFO WHERE TO_TIMESTAMP(CONTENTS_REGIST_DATE, 'YYYYMMDDHH24MISSFF3') "
	 			+"BETWEEN TO_TIMESTAMP("+startDate+", 'YYYYMMDD') AND TO_TIMESTAMP("+endDate+", 'YYYYMMDD')+0.99999421 GROUP BY CONTENTS_STATUS";
	 	
	 	HashMap<String, String> map = new HashMap<String, String>();
	 	
	 	pstmt = con.prepareStatement(sql);
	 	rs = pstmt.executeQuery();
	 	System.out.println("sql = "+sql);
	 	
	 	while(rs.next()){
			String rowValue = rs.getString("CONTENTS_STATUS");
			int rowCount = rs.getInt(2);
			map.put(rowValue, rowCount+"");
			System.out.println("row key["+rowValue+"] value["+rowCount+"]");
		}
	 	
		System.out.println("-------groupByStatusCount end -------");
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