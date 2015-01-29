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
	request.setCharacterEncoding("UTF-8");

	String userId = request.getParameter("userId");
	String title = request.getParameter("title");
	String engineer = request.getParameter("engineer");
	String cc = request.getParameter("cc");
	String tag = request.getParameter("tag");
	String file = request.getParameter("file");
	String contentBody = request.getParameter("contentBody");
	String contentStatus = request.getParameter("contentStatus");
/*	
	System.out.println("userId = " + userId);	
	System.out.println("title = " + title);
	System.out.println("engineer = " + engineer);
	System.out.println("cc = " + cc);
	System.out.println("tag = " + tag);
	System.out.println("file = " + file);

	// newline 개행은 <br>로 변경해서 디비에 넣는다.
	if(contentBody.contains("\r")) {
		contentBody = contentBody.replace("\r", ""); 	
	}	
	contentBody = contentBody.replace("\n", "<br>");	
*/	
	System.out.println("contentBody = " + contentBody);
	System.out.println("contentStatus = " + contentStatus);
	
	long time = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	
	String StrDT = dayTime.format(new java.util.Date(time));	
	
	String ContentsUid = new VMID().toString();
	ContentsUid = StrDT + ContentsUid.replaceAll(":|-", "");
	
	String driverName = "oracle.jdbc.driver.OracleDriver";	
	String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
// 	System.out.println("NewWrite_insert.jsp DB Conn Success");
	Statement stmt = con.createStatement();	
	
	try {		
		String sql = 
				"insert into CONTENTS_INFO values('"
				+ContentsUid+"','"
				+title+"','"
				+userId+"','"
				+StrDT+"','"
				+engineer+"','"
				+cc+"','"
				+tag+"','"
				+contentBody+"','"
				+file+"','"
				+contentStatus+
				"',0,0)";
		
		System.out.println("CONTENTS_INFO CONTENTS BODY Insert Sql = "+sql);		
		stmt.executeQuery(sql);
		
		ArrayList<String> engineerList = new ArrayList<String>();
		ArrayList<String> ccList = new ArrayList<String>();
		ArrayList<String> tagList = new ArrayList<String>();	
			
		// 담당자 queue 테이블 입력
		for(String engineerId : engineer.split(",")) {
			sql = "insert into NEW_CONTENTS_QUEUE values('"+ContentsUid+"','"+engineerId.trim()+"',2,'N','N')";
			System.out.println("NEW_CONTENTS_QUEUE TO ENGINEER Insert Sql = "+sql);
			stmt.executeQuery(sql);	
		}
			
		// 참조자 queue 테이블 입력
		for(String refererId : cc.split(",")) {
			sql = "insert into NEW_CONTENTS_QUEUE values('"+ContentsUid+"','"+refererId.trim()+"',4,'N','N')";
			System.out.println("NEW_CONTENTS_QUEUE TO CC Insert Sql = "+sql);
			stmt.executeQuery(sql);	
		}
			
		// TAG 정보 테이블 입력
		for(String tagginName : tag.split(",")) {
			sql = "insert into TAG_INFO values('"+tagginName.trim()+"','"+StrDT+"')";
			System.out.println("TAG_INFO Insert Sql = "+sql);
			stmt.executeQuery(sql);	
		}	
		
		stmt.close();
		con.close();
//		System.out.println("newArticle_insert end");
	}catch (Exception e) {
		System.out.println(e.toString());
	}finally {
		try{
			if(stmt!=null)stmt.close();
			if(con!=null){
				con.close();
				System.out.println("newContents Conn Close Success!!");
			}
		}catch(SQLException e){
			System.out.println(e.toString());	
		}
	}
%>