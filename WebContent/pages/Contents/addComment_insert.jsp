<%@page import="java.rmi.dgc.VMID"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" import="java.util.*" import="java.text.*" import="java.rmi.*" %>	
<script src="../../js/ajax.js" type="text/javascript"></script>
<script src="../../js/jquery-1.11.1.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	
	String userId = request.getParameter("userId");
	String contentsId = request.getParameter("contentsId");
	String title = request.getParameter("title");
	String engineer = request.getParameter("engineer");
	String cc = request.getParameter("cc");
	String tag = request.getParameter("tag");
	String file = request.getParameter("file");
	String message = request.getParameter("message");
	
//	System.out.println("contentsId = " + contentsId);	
//	System.out.println("userId = " + userId);	
//	System.out.println("title = " + title);
//	System.out.println("engineer = " + engineer);
//	System.out.println("cc = " + cc);
//	System.out.println("tag = " + tag);
//	System.out.println("file = " + file);
//	System.out.println("message = " + message);
	
	
	long time = System.currentTimeMillis();
 	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	
	String StrDT = dayTime.format(new java.util.Date(time));	
	
	String commentUid = new VMID().toString();
	commentUid = StrDT + commentUid.replaceAll(":|-", "");
	
	String driverName = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		
	Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	
	PreparedStatement pstmt = null;
	try {
		Class.forName(driverName);
	 	System.out.println("DB Conn Success");
	 	
	 	String sql = "insert into COMMENT_INFO (COMMENT_PARENTS_CONTENTS_ID, COMMENT_ID, COMMENT_TITLE, COMMENT_REGIST_USER_ID,"
	 			+"COMMENT_REGIST_DATE, COMMENT_RECEIVE_USER_ID, COMMENT_REFRENCE_USER_ID, COMMENT_BODY, COMMENT_ATTACH_FILE,"
	 			+"COMMENT_SEQUENCE_NUM) VALUES('"+contentsId+"','"+commentUid+"','"+title+"','"+userId+"','"+StrDT+"','"+engineer+"','"+cc+"','"+message+"','"+file+"',0)";
	 	
		pstmt = con.prepareStatement(sql);
	 	System.out.println("1"+contentsId);
	 	System.out.println("2"+commentUid);
	 	System.out.println("3"+title);
	 	System.out.println("4"+userId);
	 	System.out.println("5"+StrDT);
	 	System.out.println("6"+engineer);
	 	System.out.println("7"+cc);
	 	System.out.println("8"+message);
	 	System.out.println("9"+file);
	 	
	 	pstmt.executeQuery();

		// 담당자 queue 테이블 입력
		for(String engineerId : engineer.split(",")) {
			sql = "insert into NEW_CONTENTS_QUEUE values('"+contentsId+"','"+engineerId.trim()+"',3,'N','N')";
			pstmt.executeQuery(sql);	
		}
			
		// 참조자 queue 테이블 입력
		for(String refererId : cc.split(",")) {
			sql = "insert into NEW_CONTENTS_QUEUE values('"+contentsId+"','"+refererId.trim()+"',5,'N','N')";
			pstmt.executeQuery(sql);	
		}	
		
//		System.out.println("addComment_insert end");
	}catch (SQLException e) {
		System.out.println(e.toString());
//		out.print("fail:3040");
	}finally{
		try{
			if(pstmt!=null)pstmt.close();
			if(con!=null)con.close();
		}catch(SQLException e){
			System.out.println(e.toString());	
		}
	}
%>