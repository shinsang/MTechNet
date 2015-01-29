<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  	<title>MOCOMSYS TECHNET</title>
  	<meta name="author" content="매력대리's">  

	<link rel="shortcut icon" href="img/logo/mLogo.png" />
	<script src="js/ajax.js" type="text/javascript" charset="utf-8"></script>
	
	<link href="css/jquery-ui-1.11.1.css" type="text/css" rel="stylesheet">
	<script src="js/jquery-1.11.1.js" type="text/javascript" charset="utf-8"></script>
			
	<script type="text/javascript" src="js/jquery-ui-1.11.1.js"></script>
	<link href="css/jquery-ui-1.11.1.css" type="text/css" rel="stylesheet">
	
	<script type="text/javascript" src="js/bootstrap-tokenfield.js"></script>
	<link href="css/bootstrap-tokenfield.css" type="text/css" rel="stylesheet">

	<script type="text/javascript" src="js/typeahead.bundle.js"></script>
	<link href="css/tokenfield-typeahead.css" type="text/css" rel="stylesheet">
	
	<!-- MTECH COMMON 자체 제작 JS 공통 -->
	<link rel="stylesheet" type="text/css" media="all" href="stylesheets/board/ContentsStyleSheet.css">
	<link href="css/newArticle.css" type="text/css" rel="stylesheet">
	
	<link rel="stylesheet" type="text/css" media="all" href="stylesheets/join/join_styleSheet.css">
	<link rel="stylesheet" type="text/css" media="all" href="stylesheets/join/join_responsive.css">

	<!-- BOOTSTAP 소스 -->
	<script src="js/bootstrap.js"></script>	
	<link rel="stylesheet" href="css/bootstrap.css">

	<script charset="utf-8">
	 		$(document).ready(function() {
	 			loadIndexBody();
	 			
	 			$('#manual').click(function() {
	 		 	 	$('#mainContent').load('pages/manual/manual.html');
	 		 	 	return false;
	 		 	});
	 			$('#newWrite').click(function() {
	 				var userId = document.getElementById("loginUserId").value;
	 				if(userId == "") {
	 					alert("글쓰기는 로그인 후 가능합니다.");
	 					$('#mainContent').load('pages/login/new_login.jsp');	
	 				}
	 				else {
	 					$('#mainContent').load('pages/Contents/newContent.jsp');	
	 				}		 		 	
		 		 	return false;
		 		});	 			
	 			$('#bt_search').click(function() {
					$('#mainContent').load('pages/search/searchMainBody.jsp');
	 		 	 	return false;
	 		 	 });
	 			
	 		});
	 		
	 		$(window).load( function() {	
	 			var userId = document.getElementById("loginUserId").value;
    			var userName = document.getElementById("loginUserName").value;    			
    			
	 			if(!userId) {	
	 				var userIdSlot = document.getElementById("userIdSlot");
		 			var topBarMenuList = document.getElementById("TopBarMenu");
		 			
	 				userIdSlot.innerText = " User ";
	 				topBarMenuList.innerHTML =  "<li><a href=\"#\" id=\"topBarLogin\">로그인</a></li>" +
	 											"<li><a href=\"#\" id=\"topBarSignIn\">회원가입</a></li>";
	 			}	 			
	 			
	 			$('#topBarLogin').click(function() {
					$('#mainContent').load('pages/login/new_login.jsp');					
	 		 	 	return false;
	 		 	 });
	 			$('#topBarSignIn').click(function() {
					$('#mainContent').load('pages/join/joinTechNet.jsp');					
	 		 	 	return false;
	 		 	 });
	 			
	 		/* 	$('#userIdSlot').click(function() {
	 				document.getElementById("userInfoCount").innerText = "";					
	 		 	 	return false;
	 		 	 }); */
	 			
	 			
	 		});	  	
	 		
	 		function appendTopBarLiNode(Text,Id,Href){
	 			var liNode = document.createElement("li");;
	 			var aNode = document.createElement("a");;
	 			
	 			var TextNode = document.createTextNode(Text);
	 			var hrefAttr = document.createAttribute("href");
 				var idAttr = document.createAttribute("id");
 				
 				hrefAttr.value = Href;	
	 			idAttr.value = Id;
 				
 				aNode.appendChild(TextNode);
 				aNode.setAttributeNode(hrefAttr);
  				aNode.setAttributeNode(idAttr);
 				
 				liNode.appendChild(aNode);	 			
	 			return liNode;
	 		}
	 		
	 		function trClickEvent(trObj) {
	 			var selectedContentId = trObj.id;
	 			if(typeof trContentId != "undefined") // 선택된 tr 값이 있고 해당 contentId 값이 정의되지 않은 값이라면
	 			{
	 				alert("해당 컨텐츠는 삭제되었습니다.");
	 				return false;
	 			}
	 			
	 			document.getElementById("currentContentId").value = selectedContentId;	
	 	 			
	 	 		$('#mainContent').load("pages/Contents/contentsMainBody.jsp");			
	 			return false;		
	 		}
	 		
	 		
	 		function loadIndexBody()
	 		{	
	 			$('#mainContent').load('pages/view/indexBody.html #indexBodyJumboTron');
	 			return true;
	 		}
	 		
	 		function get_text_val(id)
	 		{
	 			var res = "";
	 			var set_id = "#" + id; 
	 			res = $(set_id).val();
	 			return res;
	 		}
	 		
	 		function movePageDown()
	 		{
	 			$('html,body').stop().animate({
	 			    scrollLeft: '+=' + 0,
	 			    scrollTop: '+=' + document.body.scrollHeight
	 			  });
	 		}

	 		function movePageUp()
	 		{
	 			window.scrollTo(0, $("#mainContent").offset().top);
	 		}
	 		
	 		function SearchMyReceiveContentsList()
	 		{
	 			var ReadType = "R"; // 반환했다고 치고. A, R, U
	 			var rLength = document.getElementById("myReceiveContentStatusRaido").length;
	 			alert(rLength);
	 		}
</script>
</head>
<header>
	<div id="topBar">
	<nav class="navbar navbar-default navbar-static-top" role="navigation">
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>      
    </button>
    <a class="navbar-brand" href="#" onclick="loadIndexBody();"><strong>MTechNet</strong></a>    
  </div>
 
  <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse navbar-ex1-collapse">
    <form class="navbar-form navbar-left" role="search" id="globalform">
      <div class="form-group">
        <input type="text" class="form-control" placeholder="Search" id="search">
        <input type="hidden" name="contentId" id="currentContentId">					 <!-- 현재 선택한 컨텐츠 아이디 -->
        <input type="hidden" name="contentText" id="currentContentText">				 <!-- 현재 선택한 컨텐츠 텍스트-->
        <input type="hidden" name="loginUserId" id="loginUserId" value="">				 <!-- 현재 선택한 컨텐츠 텍스트-->
        <input type="hidden" name="loginUserName" id="loginUserName" value="">			 <!-- 현재 선택한 컨텐츠 텍스트-->
      </div>
      <button type="submit" class="btn btn-danger" id="bt_search">Search</button>      <!-- 검색 버튼 -->
    </form>
    <ul class="nav navbar-nav">
      <li id="manual"><a href="#">Product Manual</a></li>
      <li id="newWrite"><a href="#">NewWrite</a></li>
      <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
        	<span class="glyphicon glyphicon-user">
        		<span id="userIdSlot"></span><b class="caret"></b><span class="badge" id="userInfoCount"></span>
        	</span>
        </a>
        <ul class="dropdown-menu" id="TopBarMenu"></ul>
      </li>      
    </ul>    
  </div><!-- /.navbar-collapse -->
</nav>
</div>
</header>
<body>
<div id="mainContent"></div> <!-- 이하 페이지들은 모두 mainContent에 로드되며 각자의 cantainer를 가지고 로드되야 한다. -->    
</body>
</html>
