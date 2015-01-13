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
	 		 	 $('#userIdSlot').click(function() {
	 		 	 	$('#mainContent').load('pages/login/login.jsp');
	 		 	 	return false;
	 		 	 });
	 		 	 $('#topBarSignIn').click(function() {
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
	 		$(window).load( function() {
	 			var userId = "";
	 			var userName = "장승훈";
	 			var topBarMenuList = document.getElementById("TopBarMenu");
	 			
	 			if(userId.toString().length < 1) {
	 				var userIdSlot = document.getElementById("userIdSlot");
	 				userIdSlot.innerHTML = "로그인";
	 				
	 				topBarMenuList.appendChild(appendTopBarLiNode("회원 가입","signout","topBarSignIn"));
	 			}
	 			else {
	 				var userIdSlot = document.getElementById("userIdSlot");
	 				userIdSlot.innerHTML = userName + " 님";
	 				
	 				topBarMenuList.appendChild(appendTopBarLiNode("내 글 관리","messages","topBarMyWriteContents"));
	 				topBarMenuList.appendChild(appendTopBarLiNode("받은 글 관리","messages","topBarMyReferenceContents"));
	 				topBarMenuList.appendChild(appendTopBarLiNode("내정보 수정","documents","topBarMyInfoModify"));
	 				topBarMenuList.appendChild(appendTopBarLiNode("로그 아웃","signout","topBarLogout")); 			
	 			}
	 		});
	 		
	 		function appendTopBarLiNode(Text,Class,Id){
	 			var liNode = document.createElement("li");;
	 			var aNode = document.createElement("a");;
	 			
	 			var TextNode = document.createTextNode(Text);
	 			var hrefAttr = document.createAttribute("href");
	 			var ClassAttr = document.createAttribute("class");
 				var idAttr = document.createAttribute("id");
 				
 				hrefAttr.value = "#";	
 				ClassAttr.value = Class;
	 			idAttr.value = Id;
 				
 				aNode.appendChild(TextNode);
 				aNode.setAttributeNode(hrefAttr);
 				aNode.setAttributeNode(ClassAttr);
 				aNode.setAttributeNode(idAttr);
 				
 				liNode.appendChild(aNode);	 			
	 			return liNode;
	 		}
	 		
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
		<img src="img/logo/RandWLog.png" style="margin-left:5%;margin-right: 5%;float:left;width: 80px;height: 80px"/>
		<form action="pages/search/searchList.jsp" name="searchList" class="search-wrapper cf" accept-charset="utf-8">
	        <input type="search" name="search" id="search" placeholder="Search here..." required>
	        <button type="submit" id="bt_search">검색</button>
	    </form>   
		<ul class="menu" >
			<li><a href="#" id="manual">제품 메뉴얼</a></li>
			<li><a href="#" id="writeBoard">글쓰기</a></li>
			<li><a href="#" id="userIdSlot">로그인</a>
				<ul id="TopBarMenu">
				</ul>

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
