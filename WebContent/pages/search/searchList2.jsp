<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.database.ContentsInfoVO,com.mocomsys.mtech.database.MtechInfoResult"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>MTechNet Search List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" href="../../img/logo/mLogo.png" />
	
    <!-- START 필요 스타일 -->
    <link rel="stylesheet" href="../../stylesheets/main.css"/>
    <link rel="stylesheet" href="../../stylesheets/search.css">
    <link rel="stylesheet" href="../../stylesheets/dropdown/dropkick.css">
	<link rel="stylesheet" href="../../stylesheets/style.css">
		
    <!-- //END 필요 스타일 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="../../js/dropkick.js" type="text/javascript" charset="utf-8"></script>
	<script>

		function eventonclick() {
    	window.open('test.html','검색결과',width='500px',height='400px');
  		}
		function clickWrite() {
	 		alert("clicked");	       		
	     	return false;
 		};
 		function join_alert(){
 			alert("clicked");
 		}
 		$(document).ready(function() {
 		 	 $('#writeBoard').click(function() {
 		 	 	$('#mainContent').load('../../html/board/newWrite.html');
 		 	 	return false;
 		 	 });
 		 	 $('#joinTechNet').click(function() {
 		 	 	$('#mainContent').load('../../html/join/joinTechNet.html');
 		 	 	return false;
 		 	 });
 		 	 $('#bt_search').click(function() {
 		 	 	$('#mainContent').load('../../html/result.html');
 		 	 	return false;
 		 	 });
 		 });
    </script>
		
</head>
<header>
		<div id="topBar">
			<img src="../../img/logo/RandWLog.png" style="margin-left:5%;margin-right: 5%;float:left;width: 10%;height: 100%"/>
			<form action="searchList2.jsp" name="searchList" class="search-wrapper cf">
		        <input type="search" name="search" placeholder="Search here..." required="">
		        <!-- <button type="submit" onclick="eventonclick()">Search</button> -->
		        <button type="submit" >Search</button>
		    </form>   
			<ul class="menu" >
			<li><a href="#">간편 메뉴</a>
			<ul>
					<li><a href="#" class="documents">새글 알림</a></li>
					<li><a href="#" class="messages">게시글 확인</a></li>
				</ul>
			</li>
			<li><a href="#" id="writeBoard">신규 게시글 작성</a></li>
			<li><a href="#">로그인</a>
				<ul>
					<li><a href="#" id='joinTechNet' class="documents">회원가입</a></li>
					<li><a href="#" class="messages">로그인</a></li>
					<li><a href="#" class="signout">로그 아웃</a></li>
				</ul>
			</ul>
 <!-- end .menu -->
			    
        </div>

</header>	
<body>
<br>
<br>
<%
	request.setCharacterEncoding("utf-8");
String search = request.getParameter("search");
%>

<%
	DataAccess da = new DataAccess();
		da.setDBProperty("ORACLE", "orcl", "10.10.11.139", "1521", "mocomsys", "mocomsys");
		da.connectionJDBC();

		ArrayList<ContentsInfoVO> civoList = new ArrayList<ContentsInfoVO>();
		MtechInfoResult uir = new MtechInfoResult(da.getConnection());
		civoList = uir.getSeachList(search);

	int count = 1;
	for (ContentsInfoVO cvo : civoList)
	{
		String title = cvo.getContents_title();
		String body = cvo.getContents_body();
	    System.out.println("제목 = "+title);
	    System.out.println("본문 = "+body);
%>
<br>
 <a href="searchResult.jsp?title=<%=cvo.getContents_title() %>&id=<%=cvo.getContents_id() %>" target="_blank"><%=cvo.getContents_title() %></a><br>
 <%=cvo.getContents_body() %><br>

<%
 	count++;
	}

	da.closeConnection();
%>
git Test2
</body>
</html>