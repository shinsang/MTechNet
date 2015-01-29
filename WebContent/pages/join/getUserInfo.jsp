<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.dao.JoinDAO,com.mocomsys.mtech.vo.UserVO" %>
	<%
		request.setCharacterEncoding("utf-8");
		String userId=request.getParameter("id");
		
		JoinDAO jdao=new JoinDAO();
		UserVO user=jdao.getUserInfoByID(userId);
		
		String id=user.getId();
		String name=user.getName();
		String pass=user.getPassword();
		String email=user.getEmail();
		String phone=user.getPhone_num();
		String recipient=user.getProperty();
		System.out.println("getUserInfo // Params ] = "+id+"//"+pass+"//"+name+"//"+email+"//"+phone+"//"+recipient);
	%>
	<%=id %>@SEP@<%=name%>@SEP@<%=pass%>@SEP@<%=email%>@SEP@<%=phone%>@SEP@<%=recipient%>
