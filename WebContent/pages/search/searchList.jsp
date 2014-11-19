<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.database.ContentsInfoVO,com.mocomsys.mtech.database.UserResult"%>
<!DOCTYPE html>
<html>
<head>
   
</head>

<body>
<br>
<br>
<%
	request.setCharacterEncoding("utf-8");
String search = request.getParameter("search");
System.out.println("list1 검색어 = "+search);
%>

<%
	DataAccess da = new DataAccess();
		da.setDBProperty("ORACLE", "orcl", "10.10.11.139", "1521", "mocomsys", "mocomsys");
		da.connectionJDBC();

		ArrayList<ContentsInfoVO> civoList = new ArrayList<ContentsInfoVO>();
		UserResult uir = new UserResult(da.getConnection());
		civoList = uir.getSeachList(search);

	int count = 1;
	for (ContentsInfoVO cvo : civoList)
	{
		String title = cvo.getTitle();
		String body = cvo.getBody();
	    System.out.println("제목 = "+title);
	    System.out.println("본문 = "+body);
%>
<br>
 <a href="pages/search/searchResult.jsp?title=<%=cvo.getTitle() %>&id=<%=cvo.getId() %>" target="_blank"><%=cvo.getTitle() %></a><br>
 <%=cvo.getBody() %><br>

<%
 	count++;
	}

	da.closeConnection();
%>


</body>
</html>