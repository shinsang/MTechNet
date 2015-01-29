<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.dao.JoinDAO,com.mocomsys.mtech.vo.UserVO" %>
	<%
		request.setCharacterEncoding("utf-8");
		String id= java.net.URLDecoder.decode(request.getParameter("id"),"UTF-8");
		String name= java.net.URLDecoder.decode(request.getParameter("name"),"UTF-8");
		String pass= java.net.URLDecoder.decode(request.getParameter("pass"),"UTF-8");
		String email= java.net.URLDecoder.decode(request.getParameter("email"),"UTF-8");
		String phone= java.net.URLDecoder.decode(request.getParameter("phone"),"UTF-8");
		String recipient= java.net.URLDecoder.decode(request.getParameter("recipient"),"UTF-8");
		
		
		System.out.println("updateUserInfo // Params ] = "+id+"//"+pass+"//"+name+"//"+email+"//"+phone+"//"+recipient);
		JoinDAO jdao=new JoinDAO();
		UserVO user=new UserVO();
		user.setId(id);
		user.setPassword(pass);
		user.setName(name);
		user.setEmail(email);
		user.setPhone_num(phone);
		user.setProperty(recipient);
		
		int count=jdao.userUpdate(user);
	%>
	<%=count %>