<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder, java.net.URLEncoder"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.ContentsVO,com.mocomsys.mtech.dao.ContentsDAO"%>
<%-- <%@ page import="java.sql.*" import="java.util.*" import="java.text.*" import="java.rmi.*" %>	 --%>
<%
System.out.println("modifyArticle_select");	
	request.setCharacterEncoding("UTF-8");
	
	String userId = "shinsang";
	String contentsId = request.getParameter("contentsId");
	System.out.println("contentsId = " + contentsId);	
	
	
	DataAccess da = new DataAccess();
	da.setDBProperty();
	da.connectionJDBC();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            

	ContentsDAO cdao = new ContentsDAO(da.getConnection());
	ContentsVO cvo = cdao.getSearchResultByID(contentsId);

	String title = cvo.getTitle();
	String receiveUserId = cvo.getReceive_user_id();
	String refrenceUserId = cvo.getRefrence_user_id();
	String tag = cvo.getTag();
	String file = cvo.getAttach_file();
	String body = cvo.getBody();
	
	System.out.println("title = " + title);
	System.out.println("receiveUserId = " + receiveUserId);
	System.out.println("refrenceUserId = " + refrenceUserId);
	System.out.println("tag = " + tag);
	System.out.println("file = " + file);
	System.out.println("body = " + body);
	
%>
<%=title%>!@#MTN$%^<%=receiveUserId%>!@#MTN$%^<%=refrenceUserId%>!@#MTN$%^<%=tag%>!@#MTN$%^<%=file%>!@#MTN$%^<%=body%>