<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.dao.ManageDAO,com.mocomsys.mtech.vo.ManageVO,java.util.*" %>
	<%
		request.setCharacterEncoding("utf-8");
		String sDate=request.getParameter("sdate");
		String eDate=request.getParameter("edate");
		System.out.println("getTagByDate.jsp");
		ManageDAO mdao=new ManageDAO();
		ArrayList<ManageVO> alm=mdao.getTagByDate(sDate, eDate);
			
		%>
		<table id="resultTable">
		<tr>
			<th colspan="2"> <%=sDate%> ~ <%=eDate%> Tag 등록 분포</th>
		</tr>
  		<tr>
	  		<th>Tag Name </th>
	  		<th> Count </th>
  		<tr>
  		
		<%System.out.println(alm.size());
		for(int i=0;i<alm.size();i++){
			%>
			<tr>
			<td><%=alm.get(i).getTagName().trim()%></td>
			<td><%=alm.get(i).getCount().trim()%></td>
			</tr>							
		<%	
		}%>
		</table>
