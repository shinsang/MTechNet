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
	String getRequestString = request.getParameter("post_val");
%>

<%	
	ObjectMapper mapper = new ObjectMapper();
	JsonNode node = mapper.readTree(getRequestString);

	String strUserId = node.path("userId").asText();
	String strTitle = node.path("title").asText();
	String strEngineer = node.path("engineer").asText();
	String strCc =node.path("cc").asText();
	String strTag = node.path("tag").asText();
	String strFile = node.path("file").asText();
	String strContentsBody = node.path("contentBody").asText();
	
	long time = System.currentTimeMillis();
	SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	
	String StrDT = dayTime.format(new java.util.Date(time));	
	
	String ContentsUid = new VMID().toString();
	ContentsUid = StrDT + ContentsUid.replaceAll(":|-", "");
	
	System.out.println("UID = " + ContentsUid);	
	System.out.println("CurrentTime = " + StrDT);
	System.out.println("UserId = " + strUserId);
	System.out.println("title = " + strTitle);
	System.out.println("engineer = " + strEngineer);
	System.out.println("cc = " + strCc);
	System.out.println("tag = " + strTag);
	System.out.println("file = " + strFile);
	System.out.println("contents = " + strContentsBody);	
	
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
				+strTitle+"','"
				+strUserId+"','"
				+StrDT+"','"
				+strEngineer+"','"
				+strCc+"','"
				+strTag+"','"
				+strContentsBody+"','"
				+strFile+
				"',0,0,0)";
		
		System.out.println("CONTENTS_INFO Insert Sql = "+sql);		
		stmt.executeQuery(sql);
		
	
		if(strEngineer.length() >0) { // Reference
			sql = "insert into NEW_CONTENTS_QUEUE values('"+ContentsUid+"','"+strEngineer+"',2,'N')";
			System.out.println("NEW_CONTENTS_QUEUE Insert Sql = "+sql);
			stmt.executeQuery(sql);			
		}
		
		
		if(strCc.length() > 0) { // CC
			sql = "insert into NEW_CONTENTS_QUEUE values('"+ContentsUid+"','"+strCc+"',4,'N')";
			System.out.println("NEW_CONTENTS_QUEUE Insert Sql = "+sql);
			stmt.executeQuery(sql);			
		}		
		
		stmt.close();
		con.close();
	}catch (Exception e) {
		System.out.println(e.toString());
		out.print("fail:3040");
	}	
%>