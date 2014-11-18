<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.database.ContentsInfoVO,com.mocomsys.mtech.database.MtechInfoResult"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <%
    request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String title = new String(request.getParameter("title").getBytes("8859_1"),"KSC5601");;
	System.out.println("ID = "+id);
	System.out.println("제목 = "+title);
    %>
    <title><%=title %> - MTechNet 검색</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" href="../../img/logo/mLogo.png" />
	
    <!-- START 필요 스타일 -->
    <link rel="stylesheet" href="../../stylesheets/main.css"/>
    <link rel="stylesheet" href="../../stylesheets/search.css">
    <link rel="stylesheet" href="../../stylesheets/dropdown/dropkick.css">
	<link rel="stylesheet" href="../../stylesheets/style.css">
	
	<link rel="stylesheet" type="text/css" media="all" href="../../stylesheets/board/board_styleSheet.css">
    <link rel="stylesheet" type="text/css" media="all" href="../../stylesheets/board/board_responsive.css">
    
    <!-- //END 필요 스타일 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="../../js/dropkick.js" type="text/javascript" charset="utf-8"></script>
	<script>

		function eventonclick() {
    	window.open('test.html','검색결과',width='500px',height='400px');
  		}
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
<br>
<br>
<br>
<br>
<br>
<br>
<%
DataAccess da = new DataAccess();
da.setDBProperty("ORACLE", "orcl", "10.10.11.139", "1521", "mocomsys", "mocomsys");
da.connectionJDBC();

ContentsInfoVO cvo = new ContentsInfoVO();
MtechInfoResult mir = new MtechInfoResult(da.getConnection());
cvo = mir.getSearchResultByID(id);
%>

	<section id="container">
		<form name="join_techNet" id="join_techNet-form" >
			<div id="wrapping" class="clearfix">
				<section id="aligned">
				
				<input type="text" name="title" id="title" autocomplete="off" tabindex="1" class="txtinput" value=<%=cvo.getTitle() %>>
				<input type="text" name="engineer" id="engineer" autocomplete="off" tabindex="1" class="txtinput" value=<%=cvo.getReceive_user_id() %>>
				<input type="text" name="cc" id="cc" autocomplete="off" tabindex="1" class="txtinput" value=<%=cvo.getRegist_user_id() %>>
				<input type="text" name="tag" id="tag" autocomplete="off" tabindex="1" class="txtinput" value=<%=cvo.getTag() %>>
				<input type="text" name="file" id="file" autocomplete="off" tabindex="1" class="txtinput" readonly="true" value="없음">
				<textarea  class="txtblock" rows="5" placeholder="Write Contents" name="contents"><%=cvo.getBody() %> </textarea>
				</section>
			</div>
		</form>
	</section>
	
	
	<section id="container">
	<h1>댓글 :</h1>
	<br>
	<form name="searchList" id="comment-form">
		<div id="wrapping" class="clearfix">
			<section id="aligned">
        		<textarea  class="txtblock" rows="2" cols="40" placeholder="Write Comment" name="comment"> </textarea>
        		<button type="submit" id='search_btn' class="commentbtn">올 리 기</button>
        	</section>
        </div>
	</form>  
	</section>
	
	<form name="searchList" id="comment-form">
		<div id="wrapping" class="clearfix">
			<section id="aligned">
        		
        	</section>
        </div>
	</form>  
	</section>
	
</body>
</html>