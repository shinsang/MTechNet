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

	String userId = "shinsang";
	String title = request.getParameter("title");
	String engineer = request.getParameter("engineer");
	String cc = request.getParameter("cc");
	String tag = request.getParameter("tag");
	String file = request.getParameter("file");
	String contentBody = request.getParameter("contentBody");
	
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
	
	try {
		String driverName = "oracle.jdbc.driver.OracleDriver";	
		String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";		

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	 	System.out.println("DB Conn Success");
		Statement stmt = con.createStatement();	
		
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
				+file+
				"',0,0,0)";
		
		System.out.println("CONTENTS_INFO Insert Sql = "+sql);		
		stmt.executeQuery(sql);
		
	
		if(engineer.length() >0) { // Reference
			sql = "insert into NEW_CONTENTS_QUEUE values('"+ContentsUid+"','"+engineer+"',2,'N')";
			System.out.println("NEW_CONTENTS_QUEUE Insert Sql = "+sql);
			stmt.executeQuery(sql);			
		}
		
		
		if(cc.length() > 0) { // CC
			sql = "insert into NEW_CONTENTS_QUEUE values('"+ContentsUid+"','"+cc+"',4,'N')";
			System.out.println("NEW_CONTENTS_QUEUE Insert Sql = "+sql);
			stmt.executeQuery(sql);			
		}		
		
		stmt.close();
		con.close();
		System.out.println("newArticle_insert end");
	}catch (Exception e) {
		System.out.println(e.toString());
		out.print("fail:3040");
	}	
%>