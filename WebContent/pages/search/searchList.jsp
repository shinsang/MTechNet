<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder, java.net.URLEncoder"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.ContentsVO,com.mocomsys.mtech.dao.ContentsDAO"%>
<!DOCTYPE html>
<html>
<head>
  <style type="text/css">
  	A:link{text-decoration:none; font-size:12pt; color:blue}
  	A:visited{font-size:12pt; color:red}
  	A:hover{text-decoration:underline; font-size:12pt; color:blue}
  	
  	table{width:100%;border-collapse: collapse;}
  	td{
  	padding: 5px 10px;}
  	th{
  	border-top: 1px solid #bcbcbc;
  	padding: 5px 10px;}
  </style>
</head>

<body>
<br>
<br>
<table>

<%
	response.setContentType("text/html; charset=UTF-8");
	request.setCharacterEncoding("UTF-8");
	String search = URLDecoder.decode(request.getParameter("search"), "UTF-8");

	System.out.println("list1 검색어 = "+search);

	DataAccess da = new DataAccess();
		da.setDBProperty();
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
<tr>
 <td><img src="img/search/green.jpg" width="15" height="15"></td>
 <td colspan="2"><a href="pages/search/searchResult.jsp?title=<%=title %>&id=<%=id %>" target="_blank"><%=cvo.getTitle() %>  <img src="img/search/like_face.png" width="15" height="15"></a></td>
</tr>
<tr>
 <td></td>
 <td></td>
 <td><font size=2><%=cvo.getBody() %></font></td>
</tr>
<tr>
 <td></td>
 <td colspan="2"> </td>
</tr>
<th colspan="3"></th>
<%
 	count++;
	}

	da.closeConnection();
%>
</table>

</body>
</html>