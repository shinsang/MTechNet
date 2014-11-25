<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder, java.net.URLEncoder"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.ContentsVO,com.mocomsys.mtech.dao.ContentsDAO"%>
<!DOCTYPE html>
<html>
<head>
   
</head>

<body>
<br>
<br>
<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
String search = URLDecoder.decode(request.getParameter("search"), "UTF-8");

System.out.println("list1 검색어 = "+search);
%>

<%
	DataAccess da = new DataAccess();
		da.setDBProperty("ORACLE", "orcl", "10.10.11.139", "1521", "mocomsys", "mocomsys");
		da.connectionJDBC();

		ArrayList<ContentsVO> civoList = new ArrayList<ContentsVO>();
		ContentsDAO cdao = new ContentsDAO(da.getConnection());
		civoList = cdao.getContentsList(search);

	int count = 1;
	for (ContentsVO cvo : civoList)
	{
		String title = URLEncoder.encode(cvo.getTitle(),"UTF-8");
		String id = URLEncoder.encode(cvo.getId(),"UTF-8");
		String body = URLEncoder.encode(cvo.getBody(),"UTF-8");
	    System.out.println("제목 = "+title);
	    System.out.println("본문 = "+body);
%>
<br>
 <a href="pages/search/searchResult.jsp?title=<%=title %>&id=<%=id %>" target="_blank"><%=cvo.getTitle() %></a><br>
 <%=cvo.getBody() %><br>

<%
 	count++;
	}

	da.closeConnection();
%>


</body>
</html>