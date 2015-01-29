<%@page import="java.rmi.dgc.VMID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" 
	 import="java.util.*"
	 import="java.text.*" 
	 import="java.rmi.*" %>	
		<script src="../../js/ajax.js" type="text/javascript"></script>
		<script src="../../js/jquery-1.11.1.js"></script>
<%@ page language="java" import="com.fasterxml.jackson.databind.JsonNode" %>
<%@ page language="java" import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page language="java" import="com.fasterxml.jackson.databind.ObjectReader" %>
</head>
<body>
<%
	System.out.println("----------modifyArticle_update-----------");
	request.setCharacterEncoding("UTF-8");
	
	String userId = "shinsang";
	String contentsId = request.getParameter("contentsId");
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
// 	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd-HH:mm:ss:SSS");
	
	String StrDT = dayTime.format(new java.util.Date(time));	
	
	String ContentsUid = new VMID().toString();
	ContentsUid = StrDT + ContentsUid.replaceAll(":|-", "");
	
	String driverName = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		
	Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	
	PreparedStatement pstmt = null;
	try {
		Class.forName(driverName);
	 	System.out.println("DB Conn Success");
	 	
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
		
		System.out.println("CONTENTS_INFO Update Sql = "+sql);		
		
		if(engineer.length() >0) { // Reference
			
			String engineerSql = "insert into NEW_CONTENTS_QUEUE values(?, ?, 2, 'N')";
			pstmt = null;
			pstmt = con.prepareStatement(engineerSql);
			pstmt.setString(1, ContentsUid);
			pstmt.setString(2, engineer);
			pstmt.executeUpdate();			
			System.out.println("NEW_CONTENTS_QUEUE Insert Sql = "+engineerSql);
			
		}
		
		if(cc.length() > 0) { // CC
			
			String ccSql = "insert into NEW_CONTENTS_QUEUE values(?, ?, 4, 'N')";
			pstmt = null;
			pstmt = con.prepareStatement(ccSql);
			pstmt.setString(1, ContentsUid);
			pstmt.setString(2, cc);
			pstmt.executeUpdate();			
			System.out.println("NEW_CONTENTS_QUEUE Insert Sql = "+ccSql);
			
			
		}		
		System.out.println("newArticle_update end");
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