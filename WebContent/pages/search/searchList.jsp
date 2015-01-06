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
  	
  	table{width:100;border-collapse: collapse;}
  	td{
  	padding: 5px 10px;}
  	th{
  	border-top: 1px solid #bcbcbc;
  	padding: 5px 10px;}
  	.ellipsis { text-overflow:ellipsis; overflow:hidden; white-space:nowrap; -moz-binding:url(/css/ellipsis.xml#ellipsis); }
    .clip { text-overflow:clip; overflow:hidden; white-space:nowrap; }
  </style>
  
	<style type="text/css">
	
	.EllipsText{
	overflow : hidden;
	white-space: nowrap;
	text-overflow:ellipsis;
	-o-text-overflow:ellipsis;
	-ms-text-overflow:ellipsis;
	-moz-binding:url(/xe/ellipsis.xml#ellipsis)
	}
	.listTable{table-layout:fixed;white-space:nowrap;}
	.listTable th{border-top: 1px solid #bcbcbc;padding: 5px 10px;}
	.listTable td{padding: 5px 10px;}
	.listTable tr{font-size:10pt;border:border:1px solid #E0E1DB;}
	.listTable .number{text-align:center;font-size:7pt;font-family:verdana;}
	.listTable .title{color:#616161;font-size:8pt;font-family:verdana;}
	.listTable .title a{color:#616161;text-decoration:none;}
	.listTable .date{font-size:7pt;font-family:verdana;text-align:left;color:#616161;text-align:center;}
	
	
	</style>
</head>

<body>
<br>
<br>
<table width=900 class="listTable">

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

// 	int count = 1;
// 	int pageNum = 1;
// 	int lastPageNum = 5;
// //페이지 1이면 0~4까지 for문 돌고 페이지 2이면 5~9까지 for문을 돈다.
// 	int startNum = 1;
// 	int lastNum = 10;
// 	int totalContentsSize = civoList.size();

	
// 	for(int i = 1; i<totalContentsSize+1; i++)
	for (ContentsVO cvo : civoList)
	{
// 		ContentsVO cvo = civoList.get(i-1);
		String title = URLEncoder.encode(cvo.getTitle(),"UTF-8");
		String id = URLEncoder.encode(cvo.getId(),"UTF-8");
		String body = URLEncoder.encode(cvo.getBody(),"UTF-8");
		String status = URLEncoder.encode(cvo.getStatus(),"UTF-8");
	    System.out.println("제목 = "+title);
	    System.out.println("본문 = "+body);
	    System.out.println("상태 = "+status);
%>
<tr>
 <td width=5>
  <%
  if(status.equals("Y")){
  %> 
  <img src="img/search/green.jpg" width="15" height="15">
  <%
  }else if(status.equals("N")){
  %>
  <img src="img/search/red.jpg" width="15" height="15">
  <%
  }else{
  %>
   <img src="img/search/yellow.jpg" width="15" height="15">
  <%
  }
  %>
 </td>
 <td width=800 colspan="2"><a href="pages/search/searchResult.jsp?title=<%=title %>&id=<%=id %>" target="_blank"><%=cvo.getTitle() %>  <img src="img/search/like_face.png" width="15" height="15"></a></td>
</tr>
<tr>
 <td></td>
 <td width=800 height=50 colspan="2" align=left valign=top><%=cvo.getBody() %></td>
</tr>
<tr>
 <td></td>
 <td></td>
 <td></td>
</tr>
<th colspan="3"></th>
<%
	}
	da.closeConnection();
%>
</table>
<%
	final int ROWSIZE = 4;
	final int BLOCK = 10;

	int pg = 1;
	
	if(request.getParameter("pg")!=null) {
		pg = Integer.parseInt(request.getParameter("pg"));
	}
	
	int start = (pg*ROWSIZE) - (ROWSIZE-1);
	int end = (pg*ROWSIZE);
	
	int allPage = 0;
	
	int startPage = ((pg-1)/BLOCK*BLOCK)+1;
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK;

%>

<table width="900" cellpadding="0" cellspacing="0" border="0">
  <tr><td colspan="4" height="5"></td></tr>
  <tr>
	<td align="center">
		<%
			if(pg>BLOCK) {
		%>
			<a href="list.jsp?pg=1">◀◀</a>
			<a href="list.jsp?pg=<%=startPage-1%>">◀</a>
		<%
			}
		%>
		
		<%
			for(int i=startPage; i<= endPage; i++){
				if(i==pg){
		%>
					<u><b><%=i %></b></u>
		<%
				}else{
		%>
					<a href="list.jsp?pg=<%=i %>"><%=i %></a>
		<%
				}
			}
		%>
		
		<%
			if(endPage<allPage){
		%>
			<a href="list.jsp?pg=<%=endPage+1%>">▶</a>
			<a href="list.jsp?pg=<%=allPage%>">▶▶</a>
		<%
			}
		%>
		</td>
		</tr>
 </table>

</body>
</html>