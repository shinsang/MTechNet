<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.ContentsVO,com.mocomsys.mtech.dao.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>MTechNet Search List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" href="../img/logo/mLogo.png" />
    <!-- START 필요 스타일 -->
    <link rel="stylesheet" href="../stylesheets/main.css"/>
    <link rel="stylesheet" href="../stylesheets/search.css">
    <link rel="stylesheet" href="../stylesheets/dropdown/dropkick.css">
    <!-- //END 필요 스타일 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="../js/dropkick.js" type="text/javascript" charset="utf-8"></script>
	<script>

		function eventonclick() {
    	window.open('test.html','검색결과',width='500px',height='400px');
  		}
    </script>

</head>

	<div id="result_TopBar" class="container">
	    <header>
	       		<div id="topBar2" >
	       		<a href="../index.html"><img src="../img/logo/RandWLog.png" width="8%" height="80%" border="0" style="float:left;margin-top:0.5%;margin-left:5%;margin-right: 10%"/></a>
					<form action="searchResult.jsp" method="post" class="search-wrapper2 result">
				        <input type="search" name="search" placeholder="Search here..." required="">
				        <button type="submit">Search</button>
				</form>

				<select name="personal" class="mama_bear">
					<option>Log-In</option>
					<option>개인정보 수정</option>
					<option>Log-Out</option>
					<option>설정</option>
				</select>
				<select name="newWrite" class="mama_bear">
					<option>신규 작성</option>
				</select>
				<select name="easyMenu" class="mama_bear">
					<option>간편 메뉴</option>
					<option>새글 알림</option>
					<option>게시글 확인</option>
					<option>개인정보 확인</option>
					<option>Sign Out</option>
				</select>


	      		</div>


				<!-- <div><img src="../img/logo.jpg" style="float: left"/>
					<form class="search-wrapper2 result">
				        <input type="text" placeholder="Search here..." required="">
				        <button type="submit" onclick="eventonclick()">Search</button>
				</form></div>    -->
	    </header>
    </div>
    <script>
	//꼭 여기 있어야만, selectbox 가 정상적으로 생성됨.
	$(function () {
			$('.mama_bear').dropkick();
		});
	</script>
    <div class="reulst_Contents">
    	 <div class="well">
        </div>
    </div>
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

		ArrayList<ContentsVO> civoList = new ArrayList<ContentsVO>();
		UserDAO uir = new UserDAO(da.getConnection());
		civoList = uir.getContentsList(search);

	int count = 1;
	for (ContentsVO cvo : civoList)
	{
		String title = cvo.getContents_title();
		String body = cvo.getContents_body();
	    System.out.println("제목 = "+title);
	    System.out.println("본문 = "+body);
%>
<br>
 <a href="../searchResult.jsp?title=<%=cvo.getContents_title() %>&id=<%=cvo.getContents_id() %>" target="_blank"><%=cvo.getContents_title() %></a><br>
 <%=cvo.getContents_body() %><br>

<%
 	count++;
	}

	da.closeConnection();
%>

</body>
</html>