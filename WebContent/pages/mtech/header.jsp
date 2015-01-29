<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script src="../../../js/dropkick.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../../js/ajax.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../../js/jquery-1.11.1.js" type="text/javascript" charset="utf-8"></script>
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
		 		 	 	$('#mainContent').load('/index.jsp');
		 		 	 	return false;
		 		 	 });
	 		 	 $('#writeBoard').click(function() {
	 		 	 	$('#mainContent').load('../board/newWrite.jsp');
	 		 	 	return false;
	 		 	 });
	 		 	 $('#Login').click(function() {
	 		 	 	$('#mainContent').load('../login/login.jsp');
	 		 	 	return false;
	 		 	 });
	 		 	 $('#joinTechNet').click(function() {
	 		 	 	$('#mainContent').load('../join/JoinTechNet.html');
	 		 	 	return false;
	 		 	 });
	 		 	 $('#bt_search').click(function() {
	 		 		var param=$('#search').val();
					params='search='+encodeURI(encodeURIComponent(param)); 
					$('#mainContent').load('../search/searchList.jsp', params);
	 		 	 	return false;
	 		 	 });
	 		 	 
	 		});
	</script>
	<link rel="shortcut icon" href="img/logo/mLogo.png" />
	<!-- Header CSS -->
	<link rel="stylesheet" href="../../stylesheets/main.css">
	<link rel="stylesheet" href="../../stylesheets/style.css">
	<link rel="stylesheet" href="../../stylesheets/search.css">
	<link rel="stylesheet" href="../../stylesheets/dropdown/dropkick.css">
</head>
<header>
	<div id="topBar">
		<img src="../../img/logo/RandWLog.png" style="margin-left:5%;margin-right: 5%;float:left;width: 10%;height: 100%"/>
		<form action="pages/search/searchList.jsp" name="searchList" class="search-wrapper cf" accept-charset="utf-8">
	        <input type="search" name="search" id="search" placeholder="Search here..." required="">
	        <!-- <button type="submit" onclick="eventonclick()">Search</button> -->
	        <button type="submit" id="bt_search">Search</button>
	    </form>   
		<ul class="menu" >
		<li><a href="#" id="manual">메뉴얼</a></li>
		<li><a href="#" id="writeBoard">신규 게시글 작성</a></li>
		<li><a href="#">My 페이지</a>
		<ul>
				<li><a href="#" class="documents">내가 쓴 글</a></li>
				<li><a href="#" class="documents">내가 쓴 댓글</a></li>
				<li><a href="#" class="messages">내가 받은 글</a></li>
				<li><a href="#" class="messages">내가 받은 댓글</a></li>
			</ul>
		</li>

       </div>
</header>	
</html>