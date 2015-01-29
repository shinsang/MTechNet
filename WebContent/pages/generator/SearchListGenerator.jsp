<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder, java.net.URLEncoder"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.ContentsVO,com.mocomsys.mtech.dao.ContentsDAO"%>
<%@page import="java.text.SimpleDateFormat"%>

<% 
	request.setCharacterEncoding("UTF-8");
	String SearchString = request.getParameter("search");
	
	System.out.println("SearchListGenerator.jsp =====> SearchString(" + SearchString + ")");
	StringBuffer SB = new StringBuffer();
	
	DataAccess da = new DataAccess();
	da.setDBProperty();
	da.connectionJDBC();   
%>


<%
try{
	ArrayList<ContentsVO> civoList = new ArrayList<ContentsVO>();
	ContentsDAO cdao = new ContentsDAO(da.getConnection());
	civoList = cdao.getContentsList(SearchString);
	
	int titleMaxLength = 40;
	int bodyMaxLength = 110;
	
	// 상단 이미지 + 타이틀 부분
	SB.append("<div class=\"bigContainer\">");
	SB.append("<br>");
	SB.append("<div class=\"media\" style=\"text-align:center;\">");
	SB.append("<h1 class=\"media-heading text-danger\">");
	//SB.append("<img align=\"middle\" src=\"img/search_splash.png\" style=\"width:150px;height:150px\" alt=\"...\">");
	SB.append("<strong> Search </strong><small class=\"media-heading\" style=\"padding-left:10px\"> Keyword : '"+ SearchString + "'</small></h1></div>");
	SB.append("<br>");
	
	SB.append("<span>");
	SB.append("<button type=\"button\" name=\"pageDownButton\" id=\"movePageDown\" class=\"btn btn-default btn-xs\" tabindex=\"0\" onclick=\"movePageDown();\"><span class=\"glyphicon glyphicon-arrow-down\"></span></button>\n");
	SB.append("<button type=\"button\" name=\"reLoadSearchPage\" id=\"reLoadSearchPage\" class=\"btn btn-default btn-xs\" tabindex=\"0\" onclick=\"reLoadSearchBodyPage();\"><span class=\"glyphicon glyphicon-repeat\"></span></button>");
	SB.append("</span>");	
	
	SB.append("<div style=\"float:right;\" class=\"form-actions\">");  
	
	// 상태 체크 라디오 버튼	
	SB.append("<div  class=\"form-actions\">");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"searchResultStatusRaido\" onclick=\"listFilter(this);\" value=\"a\" checked><span class=\"label label-info\">All</span></label>");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"searchResultStatusRaido\" onclick=\"listFilter(this);\" value=\"0\"><span class=\"label label-default\">New</span></label>");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"searchResultStatusRaido\" onclick=\"listFilter(this);\" value=\"1\"><span class=\"label label-danger\">New</span></label>");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"searchResultStatusRaido\" onclick=\"listFilter(this);\" value=\"2\"><span class=\"label label-warning\">Process</span></label>");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"searchResultStatusRaido\" onclick=\"listFilter(this);\" value=\"3\"><span class=\"label label-danger\">Process</span></label>");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"searchResultStatusRaido\" onclick=\"listFilter(this);\" value=\"9\"><span class=\"label label-success\">Complete</span></label>\n");
	SB.append("</div>\n");		
		
	SB.append("</div>");
	SB.append("<hr>");
		
	
	SB.append("<div class=\"CSSTableGenerator\" id=\"SearchMainContent\">");
	SB.append("<table id=\"searchResultTable\">");
	SB.append("<tr>");
    SB.append("<td class=\"CSSTableMiddle\"><p class=\"text-center\">상태</p></td>");
    SB.append("<td class=\"CSSTableMiddle\"><p class=\"text-center\">추천</p></td>");
    SB.append("<td><p class=\"text-center\">글 정보</p></td>");
    SB.append("<td><p class=\"text-center\">글쓴이</p></td>");
    SB.append("<td class=\"CSSTableBig\"><p class=\"text-center\">등록일시</p></td>");
    SB.append("</tr>");
    
    String id = ""; 
	String title = ""; 	
	String body = "";	
	
	SimpleDateFormat FF = new SimpleDateFormat("yyyyMMddhhmmssSSS");
	SimpleDateFormat AF = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    
	for (ContentsVO cvo : civoList)
	{
		id = cvo.getId();
		title = cvo.getTitle();
		System.out.println("============"+title);
		
		body = cvo.getBody();

		String strStatus = cvo.getStatus();
		int status = Integer.parseInt(strStatus);		
		
		String date = AF.format(FF.parse(cvo.getRegist_date()));
		
		String strRecommendCount = cvo.getRecommend_counts();
		int likeCount = Integer.parseInt(strRecommendCount);
		
		
		String strTitle = "";
		if(title.length()>titleMaxLength){
	    	strTitle = title.substring(0,titleMaxLength)+"....";
	    }else{
	    	strTitle = title;
	    }
		
		String strBody = "";
		if(body.length()>bodyMaxLength){
	    	strBody = body.substring(0,bodyMaxLength)+"....";
	    }else{
	    	strBody = body;
	    }				
	    
		String strWriter = cvo.getRegist_user_id();
		
	    SB.append("<tr type=\"submit\" id=\""+id+"\" style=\"cursor:pointer\" onclick=\"trClickEvent(this)\">");	    
	    if(status == 0) { // 최초 일반 등록
	    	SB.append("<td value=\""+status+"\"><p class=\"text-center\"><span class=\"label label-default\">New</span></p></td>");
		}else if(status == 1) { // 최초 긴급 등록
	    	SB.append("<td value=\""+status+"\"><p class=\"text-center\"><span class=\"label label-danger\">New</span></p></td>");
		}else if(status == 2) { // 일반 진행 중 (Receiver 확인) 
			SB.append("<td value=\""+status+"\"><p class=\"text-center\"><span class=\"label label-warning\">Process</span></p></td>");
		}else if(status == 3) { // 긴급 진행 중 (Receiver 확인)
			SB.append("<td value=\""+status+"\"><p class=\"text-center\"><span class=\"label label-danger\">Process</span></p></td>");
		}else { // 완료
			SB.append("<td value=\""+status+"\"><p class=\"text-center\"><span class=\"label label-success\">Complete</span></p></td>");
		}		    
	    
	    System.out.println("4");
	    
	    SB.append("<td><p class=\"text-center\"><span class=\"glyphicon glyphicon-thumbs-up\"> "+likeCount+"</span></p></td>");
	    SB.append("<td>");
	    SB.append("<div class=\"TableContentsTitleReadComplete\">"+strTitle+"</div>");
	 	SB.append("<div class=\"TableContentsBody\">"+strBody+"</div>");
	    SB.append("</td>");
	    SB.append("<td><p class=\"text-center\">"+strWriter+"</p></td>");
	    SB.append("<td><p class=\"text-center\">"+date+"</p></td>");
	    SB.append("</tr>");  
	}			
	SB.append("</table>");
	SB.append("</div>");
	
	SB.append("<hr>");
	SB.append("<div>");
	SB.append("<button type=\"button\" name=\"pageUpButton\" id=\"movePageUp\" class=\"btn btn-default btn-xs\" tabindex=\"0\" onclick=\"movePageUp();\"><span class=\"glyphicon glyphicon-arrow-up\"></span></button>\n");
	SB.append("</div>");
	
	
	SB.append("</div>");
	//System.out.println("====SearchListGenerator.jsp Return HTML====>"+SB.toString());
	da.closeConnection();
}catch(Exception e) {
	if(da != null) {
		da.closeConnection();
		System.out.println("SearchListGenerator DA CloseSuccess!!");
	}
}
%>

<%=SB%>