<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder, java.net.URLEncoder"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.*,com.mocomsys.mtech.dao.*"%>
<%@page import="java.text.SimpleDateFormat"%>

<% 
	request.setCharacterEncoding("UTF-8");
	StringBuffer SB = new StringBuffer();
%>

<%

try{                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
	SB.append("<div class=\"bigContainer\">");
	
	// 상단 이미지 + 타이틀 부분
	SB.append("<div class=\"media\" style=\"text-align:center;\">");
	SB.append("<h1 class=\"media-heading text-info\">");
	SB.append("<img align=\"middle\" src=\"img/blue_bookmark.png\" style=\"width:120px;height:150px\" alt=\"...\">");
	SB.append("<strong>BOOKMARK</strong><small class=\"text-muted\" style=\"padding-left:30px\">   Check my bookmark list</small></h1></div>");

	SB.append("<br>");		
	
	// 정렬 버튼 추가.
	SB.append("<div style=\"float:right;\" class=\"form-actions\">");  
	SB.append("<div class=\"btn-group\">");
	SB.append("<button type=\"button\" class=\"btn btn-default dropdown-toggle\" data-toggle=\"dropdown\">Read Status <span class=\"caret\"></span>");
	SB.append("</button>");
	SB.append("<ul class=\"dropdown-menu\" role=\"menu\">");
	SB.append("<li><a href=\"#\" onclick=\"loadAskQuestionBody();\">All</a></li>");
	SB.append("<li><a href=\"#\" onclick=\"loadAskQuestionBody();\">Read Contents</a></li>");
	SB.append("<li><a href=\"#\" onclick=\"loadDataRegisterBody();\">UnRead Contents</a></li>");
	SB.append("</ul>");
	SB.append("</div>\n");

	
	SB.append("</div>");
	
	
	
//	System.out.println(SB.toString());

}catch(Exception e) {
	System.out.println("BookMarkListGenerator="+e.toString());
}
%>

<%=SB%>