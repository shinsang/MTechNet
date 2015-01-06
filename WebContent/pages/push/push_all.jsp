<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.android.gcm.server.*" %>
<%
	ArrayList<String> regid = new ArrayList<String>();	
	String MESSAGE_ID = String.valueOf(Math.random() % 100 + 1);	
	boolean SHOW_ON_IDLE = true;	
	int LIVE_TIME = 1;	
	int RETRY = 2;	
	
	System.out.println("Push.jsp");
	String simpleApiKey = "AIzaSyA9KCDlqQWWkpuX33tzjr2Mlizm-XTPblE";	
	String gcmURL = "https://android.googleapis.com/gcm/send";		
	try {
		String driverName = "oracle.jdbc.driver.OracleDriver";	
		String url = "jdbc:oracle:thin:@10.10.11.139:1521:orcl";	
		ResultSet rs = null;
	 
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");
	 
		Statement stmt = con.createStatement();			
		String sql = "select * from gcm";
		rs = stmt.executeQuery(sql);
		
		
		while(rs.next()){
			String temp=rs.getString("regid");
			regid.add(temp);
			System.out.println(temp);
		}
		con.close();
		
		Sender sender = new Sender(simpleApiKey);
		Message message = new Message.Builder()
		.collapseKey(MESSAGE_ID)
		.delayWhileIdle(SHOW_ON_IDLE)
		.timeToLive(LIVE_TIME)
		.addData("test","PUSH!!!!")
		.build();
		MulticastResult result = sender.send(message,regid,RETRY);
	}catch (Exception e) {
	}
%>