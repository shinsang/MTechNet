<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<%@ page import="java.util.ArrayList" %>

<%@ page import="com.google.android.gcm.server.*" %>

<%

	ArrayList<String> regid = new ArrayList<String>();	//�޽����� ���� ����

	String MESSAGE_ID = String.valueOf(Math.random() % 100 + 1);	//�޽��� ���� ID

	boolean SHOW_ON_IDLE = true;	//��Ⱑ Ȱ��ȭ �����϶� �����ٰ�����

	int LIVE_TIME = 1;	//��Ⱑ ��Ȱ��ȭ �����϶� GCM�� �޽����� ��ȿȭ�ϴ� �ð�

	int RETRY = 2;	//�޽��� ���۽��н� ��õ� Ƚ��

	

	String simpleApiKey = "AIzaSyA9KCDlqQWWkpuX33tzjr2Mlizm-XTPblE";	//���̵� 1�� ���� Ű

	String gcmURL = "https://android.googleapis.com/gcm/send";		//Ǫ���� ��û�� ���� �ּ�

	try {

		String driverName = "oracle.jdbc.driver.OracleDriver";	

		String url = "jdbc:oracle:thin:@localhost:1521:ORCL";	

		ResultSet rs = null;

	 

		Class.forName(driverName);

		Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");

	 

		Statement stmt = con.createStatement();			

		String sql = "select * from gcm";

		rs = stmt.executeQuery(sql);

		

		//��� ���ID�� ����Ʈ�� ����

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