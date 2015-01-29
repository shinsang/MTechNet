<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.dao.JoinDAO" %>
	<%
		
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		JoinDAO jdao=new JoinDAO();
		int count=jdao.getUserCountByID(id);
		//System.out.println("count="+count);
	%>
	<%=count %>