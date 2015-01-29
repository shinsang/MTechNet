<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.dao.ManageDAO,com.mocomsys.mtech.vo.ManageVO,java.util.*" %>
	<%
		request.setCharacterEncoding("utf-8");
		System.out.println("getTagAll.jsp");
		ManageDAO mdao=new ManageDAO();
		ArrayList<ManageVO> alm=mdao.getTagAll();
			
		%>
		<table id="resultTable">
		<tr>
			<th colspan="2">Total 등록 Tag 분포</th>
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
