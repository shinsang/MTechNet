<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>	

<%

	String id = request.getParameter("id");
	if(id!=null){
		try {
	
			String driverName = "oracle.jdbc.driver.OracleDriver";	
			String url = "jdbc:oracle:thin:@10.10.11.139:1521:orcl";	
			ResultSet rs = null;
		 
			Class.forName(driverName);
			Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
		 
			Statement stmt = con.createStatement();	
			id=id.replace("'", "");
			String sql = "select count(*) as count from NEW_CONTENTS_QUEUE where USER_ID='"+id+"'";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			
			int count=0;
			while(rs.next()){
				count=rs.getInt("count");
			}
			con.close();
			out.print(count);
	
		}catch (Exception e) {
			
			System.out.println(e.toString());
			out.print("fail");		
	
		}
	}
%>