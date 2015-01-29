<%@page import="java.rmi.dgc.VMID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" import="java.util.*" import="java.text.*" import="java.rmi.*" %>	
<script src="../../js/ajax.js" type="text/javascript"></script>
<script src="../../js/jquery-1.11.1.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	
	String userId = request.getParameter("userId");
	String contentsId = request.getParameter("contentId");
	String title = request.getParameter("title");
	String engineer = request.getParameter("engineer");
	String cc = request.getParameter("cc");
	String tag = request.getParameter("tag");
	String file = request.getParameter("file");
	String contentBody = request.getParameter("contentBody");
	
	System.out.println("contentsId = " + contentsId);	
	System.out.println("userId = " + userId);	
	System.out.println("title = " + title);
	System.out.println("engineer = " + engineer);
	System.out.println("cc = " + cc);
	System.out.println("tag = " + tag);
	System.out.println("file = " + file);
	System.out.println("contentBody = " + contentBody);
	
	long time = System.currentTimeMillis();
 	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS");

	String StrDT = dayTime.format(new java.util.Date(time));	
	
	String ContentsUid = new VMID().toString();
	ContentsUid = StrDT + ContentsUid.replaceAll(":|-", "");
	
	String driverName = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		
	Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	
	PreparedStatement pstmt = null;
	try {
		Class.forName(driverName);
	 	//System.out.println("DB Conn Success");
	 	
	 	String sql = "update CONTENTS_INFO set CONTENTS_TITLE=?, CONTENTS_REGIST_USER_ID=?, CONTENTS_REGIST_DATE=?, CONTENTS_RECEIVE_USER_ID=?,"
	 			+"CONTENTS_REFRENCE_USER_ID=?, CONTENTS_TAG=?, CONTENTS_BODY=?, CONTENTS_ATTACH_FILE=? WHERE CONTENTS_ID=?";
	 	pstmt = con.prepareStatement(sql);
	 	pstmt.setString(1, title);
	 	pstmt.setString(2, userId);
	 	pstmt.setString(3, StrDT);
	 	pstmt.setString(4, engineer);
	 	pstmt.setString(5, cc);
	 	pstmt.setString(6, tag);
	 	pstmt.setString(7, contentBody);
	 	pstmt.setString(8, file);
	 	pstmt.setString(9, contentsId);
	 	
	 	pstmt.executeUpdate();
		
	}catch (SQLException e) {
		System.out.println(e.toString());
	}finally{
		try{
			//if(pstmt!=null)pstmt.close();
			if(con!=null){
				con.close();
				System.out.println("modifyContents_update con Close success!!");
			}
		}catch(SQLException e){
			System.out.println(e.toString());	
		}
	}
%>