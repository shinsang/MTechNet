<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script src="js/dropkick.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/ajax.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/jquery-1.11.1.js" type="text/javascript" charset="utf-8"></script>
	<script charset="utf-8">
			function eventonclick() {
	    		window.open('html/result.html','검색결과',width='500px',height='400px');
	  		}
	  		 function clickWrite() {
		 		alert("clicked");	       		
		     	return false;
	 		};
	 		function join_alert(){
	 			alert("clicked"); 
	 		}
	 		$(document).ready(function() {
	 			 $('#manual').click(function() {
		 		 	 	$('#mainContent').load('index.jsp');
		 		 	 	return false;
		 		 	 });
	 		 	 $('#writeBoard').click(function() {
	 		 	 	$('#mainContent').load('pages/board/newWrite.jsp');
	 		 	 	return false;
	 		 	 });
	 		 	 $('#Login').click(function() {
	 		 	 	$('#mainContent').load('pages/login/login.jsp');
	 		 	 	return false;
	 		 	 });
	 		 	 $('#joinTechNet').click(function() {
	 		 	 	$('#mainContent').load('pages/join/JoinTechNet.html');
	 		 	 	return false;
	 		 	 });
	 		 	 $('#bt_search').click(function() {
	 		 		var param=$('#search').val();
					params='search='+encodeURI(encodeURIComponent(param)); 
					$('#mainContent').load('pages/search/searchList.jsp', params);
	 		 	 	return false;
	 		 	 });
	 		 	 
	 		});
	</script>
	<link rel="shortcut icon" href="img/logo/mLogo.png" />
	<!-- Header CSS -->
	<link rel="stylesheet" href="stylesheets/main.css">
	<link rel="stylesheet" href="stylesheets/style.css">
	<link rel="stylesheet" href="stylesheets/search.css">
	<link rel="stylesheet" href="stylesheets/dropdown/dropkick.css">
</head>
<header>
	<div id="topBar">
		<img src="img/logo/RandWLog.png" style="margin-left:20px;margin-right: 20px;float:left;width: 80px;height: 80px"/>
		<form action="pages/search/searchList.jsp" name="searchList" class="search-wrapper cf" accept-charset="utf-8">
	        <input type="search" name="search" id="search" placeholder="Search here..." required="" >
	        <button type="submit" id="bt_search">검색</button>
	    </form>   
		<ul class="menu" >
			<li><a href="#" id="manual">메뉴얼</a></li>
			<li><a href="#" id="writeBoard">신규 작성</a></li>
			<li><a href="#">My 페이지</a>
				<ul>
					<li><a href="#" class="documents">내가 쓴 글</a></li>
					<li><a href="#" class="documents">내가 쓴 댓글</a></li>
					<li><a href="#" class="messages">내가 받은 글</a></li>
					<li><a href="#" class="messages">내가 받은 댓글</a></li>
				</ul>
			</li>
			<%
				String loginURL = "";
				String loginTextValue = "";
				
				 session = request.getSession(true);
				 
				 if( session.getAttribute("id") != null)
				 {
					 loginTextValue = (String)session.getAttribute("id");
					 loginURL = "pages/login/logout.jsp"; 
					 System.out.println("session 로그 아웃 id = "+session.getAttribute("id"));
				 }else{
					 loginTextValue = "로그인";
					 loginURL = "pages/login/login.jsp";
					 System.out.println("session 로그인 id = "+session.getAttribute("id"));
				 }
			 %>
			<li><a id=login href="<%=loginURL%>"><%=loginTextValue %></a></li>
		</ul>
    </div>
</header>
<body>
	<br>
	<br>
	<br>
	<br>
	<hr style="width: 90%;float:left;margin-bottom: 0.5%"/>
	<hr style="width: 90%;float:right"/>
	
    <div class="content" id="mainContent"><p>
    <p>Main Page 입니다.</p><br> 
    <p>location : /MTechNet/index4.jsp</p><br> 		
	
    </div>
   <!-- <span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span><span><a>a</a></p></span>-->

<!-- <div id="mainContent"><p></p></div> -->
</body>
<jsp:include page="pages/mtech/footer.jsp" flush="false"/>
</html>
