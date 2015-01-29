<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder, java.net.URLEncoder"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.ContentsVO,com.mocomsys.mtech.dao.ContentsDAO"%>
<%-- <%@ page import="java.sql.*" import="java.util.*" import="java.text.*" import="java.rmi.*" %>	 --%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String userId = request.getParameter("userId");
	String contentsId = request.getParameter("contentsId");

	DataAccess da = new DataAccess();
	
	String title = "";
	String receiveUserId = "";
	String refrenceUserId = "";
	String tag = "";
	String file = "";
	String body = "";
	
	try {
		da.setDBProperty();
		da.connectionJDBC();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
	
		ContentsDAO cdao = new ContentsDAO(da.getConnection());
		ContentsVO cvo = cdao.getSearchResultByID(contentsId);
		
		title = cvo.getTitle();
		
		receiveUserId = cvo.getReceive_user_id();
		refrenceUserId = cvo.getRefrence_user_id();
		tag = cvo.getTag();
		file = cvo.getAttach_file();
		body = cvo.getBody();
		System.out.println("body="+body);
					
//		System.out.println("title = " + title);
//		System.out.println("receiveUserId = " + receiveUserId);
//		System.out.println("refrenceUserId = " + refrenceUserId);
//		System.out.println("tag = " + tag);
//		System.out.println("file = " + file);
//		System.out.println("body = " + body);
	}catch(Exception e) {
		
	}finally{
		if(da != null) {
			da.closeConnection();
			System.out.println("ModifyContents_Seclect DA CloseSuccess!!");
		}
	}
	
%>
<%=title%>!@#MTN$%^<%=receiveUserId%>!@#MTN$%^<%=refrenceUserId%>!@#MTN$%^<%=tag%>!@#MTN$%^<%=file%>!@#MTN$%^<%=body%>