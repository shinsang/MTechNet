<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder, java.net.URLEncoder"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.ContentsVO,com.mocomsys.mtech.dao.ContentsDAO, com.mocomsys.mtech.vo.CommentVO,com.mocomsys.mtech.dao.CommentDAO"%>
<!DOCTYPE html>
<html>
<head>
    <%
		response.setContentType("text/html; charset=UTF-8");
    	request.setCharacterEncoding("UTF-8");
        String id = URLDecoder.decode(request.getParameter("id"), "UTF-8");
            	
        DataAccess da = new DataAccess();
        da.setDBProperty();
        da.connectionJDBC();

        ContentsVO ctvo = new ContentsVO();
        ContentsDAO ctdao = new ContentsDAO(da.getConnection());
        ctvo = ctdao.getSearchResultByID(id);

        String ctTitle = ctvo.getTitle();
    %>
    <title><%=ctTitle%> - MTechNet 검색</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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

	<section id="container">
		<form name="join_techNet" id="join_techNet-form" >
			<div id="wrapping" class="clearfix">
				<section id="aligned">
				
				<input type="text" name="title" id="title" autocomplete="off" tabindex="1" class="txtinput" value="<%=ctTitle %>">
				<input type="text" name="engineer" id="engineer" autocomplete="off" tabindex="1" class="txtinput" value="<%=ctvo.getReceive_user_id() %>">
				<input type="text" name="cc" id="cc" autocomplete="off" tabindex="1" class="txtinput" value="<%=ctvo.getRegist_user_id() %>">
				<input type="text" name="tag" id="tag" autocomplete="off" tabindex="1" class="txtinput" value="<%=ctvo.getTag() %>">
				<input type="text" name="file" id="file" autocomplete="off" tabindex="1" class="txtinput" readonly="true" value="<%=ctvo.getAttach_file()%>">
				<textarea  class="txtblock" rows="5" placeholder="Write Contents" name="contents"><%=ctvo.getBody() %> </textarea>
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
        		<textarea  class="txtblock" rows="2" cols="40" placeholder="댓글 작성" name="comment"> </textarea>
        		<button type="submit" id='search_btn' class="commentbtn">올 리 기</button>
        	</section>
        </div>
	</form>  
	</section>

<%

CommentDAO cmdao = new CommentDAO(da.getConnection());
ArrayList<CommentVO> cmvoList = new ArrayList<CommentVO>();
cmvoList = cmdao.getCommentList(id);

for(CommentVO cmvo : cmvoList)
{
	String cmId = cmvo.getId();
	String cmTitle = cmvo.getTitle();
	String cmregistID = cmvo.getRegist_user_id();
	String cmBody = cmvo.getBody();
	System.out.println("코멘트 ID = "+cmId);
	System.out.println("코멘트 작성자 ID = "+cmregistID);
    System.out.println("코멘트 제목 = "+cmTitle);
    System.out.println("코멘트 본문 = "+cmBody);

%>

	
	<section id="container">
	<h1><%=cmvo.getRegist_user_id()%></h1>                       <%=cmvo.getRegist_date() %>
	<br>
	<form name="searchList" id="comment-form">
		<div id="wrapping" class="clearfix">
			<section id="aligned">
        		<textarea  class="txtblock" rows="2" cols="40" placeholder="" name="comment"><%=cmvo.getBody() %></textarea>
        	</section>
        </div>
	</form>  
	</section>

<%
}
%>
	
	
</body>
</html>