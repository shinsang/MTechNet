<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.google.android.gcm.server.*" %>

<%
Sender    gcmSender;    //GCM Sender
Message    gcmMessage;   //GCM Message
Result     gcmResult;    //GCM  Result(단일 전송)
MulticastResult  gcmMultiResult;  //GCM Multi  Result(일괄 전송)

String userid = request.getParameter("userid");
String count = request.getParameter("count");

//단일전송에 필요한 변수
String regid = request.getParameter("regid");

System.out.println("push.jsp : "+userid+"//"+count+"//"+regid);

gcmResult=null;
//일괄전송에 필요한 List 변수
List<String>  regids = new ArrayList<String>();

//파싱하기 위해 데이터를 담을 변수
String JSON = null;
//개발자 콘솔에서 발급받은 API Key
String   API_KEY = "AIzaSyA9KCDlqQWWkpuX33tzjr2Mlizm-XTPblE";
//메세지의 고유 ID(?)정도로 생각하면 됩니다. 메세지의 중복수신을 막기 위해 랜덤값을 지정합니다
String   COLLAPSE_KEY = String.valueOf(Math.random() % 100 + 1);
//기기가 활성화 상태일 때  보여줄 것인지. 
boolean  DELAY_WHILE_IDLE = true;
//기기가 비활성화  상태일 때 GCM Storage에 보관되는 시간
int   TIME_TO_LIVE = 3;
//메세지  전송 실패시 재시도할 횟수
int    RETRY = 3;
String msg="미확인 [ "+count+" ] 건.";


//Set Message
 gcmSender = new  Sender(API_KEY);
 gcmMessage = new Message.Builder()
     .collapseKey(COLLAPSE_KEY)
    .delayWhileIdle(DELAY_WHILE_IDLE)
    .timeToLive(TIME_TO_LIVE)
    .addData("msg",msg)
    .build();

//Send Message : 단일전송시에 사용
try  {
  gcmResult = gcmSender.send(gcmMessage, regid, RETRY);
 }  catch(IOException e) {
  System.out.println("IOException " +  e.getMessage());
  System.out.println("getCanonicalIds : " +  gcmResult.getCanonicalRegistrationId() + "\n" + 
		   "getMessageId : " +  gcmResult.getMessageId());
 }
 

%>