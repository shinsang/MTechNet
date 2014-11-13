<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<%@ page import="java.util.ArrayList" %>

<%@ page import="com.google.android.gcm.server.*" %>

<%

	ArrayList<String> regid = new ArrayList<String>();	//메시지를 보낼 대상들

	String MESSAGE_ID = String.valueOf(Math.random() % 100 + 1);	//메시지 고유 ID

	boolean SHOW_ON_IDLE = true;	//기기가 활성화 상태일때 보여줄것인지

	int LIVE_TIME = 1;	//기기가 비활성화 상태일때 GCM가 메시지를 유효화하는 시간

	int RETRY = 2;	//메시지 전송실패시 재시도 횟수

	

	String simpleApiKey = "AIzaSyA9KCDlqQWWkpuX33tzjr2Mlizm-XTPblE";	//가이드 1때 받은 키

	String gcmURL = "https://android.googleapis.com/gcm/send";		//푸쉬를 요청할 구글 주소

	try {

		String driverName = "oracle.jdbc.driver.OracleDriver";	

		String url = "jdbc:oracle:thin:@localhost:1521:ORCL";	

		ResultSet rs = null;

	 

		Class.forName(driverName);

		Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");

	 

		Statement stmt = con.createStatement();			

		String sql = "select * from gcm";

		rs = stmt.executeQuery(sql);

		

		//모든 등록ID를 리스트로 묶음

		while(rs.next()){

			regid.add(rs.getString("regid"));

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