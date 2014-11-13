<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.database.ContentsInfoVO,com.mocomsys.mtech.database.MtechInfoResult"%>
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

</body>
</html>