<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder, java.net.URLEncoder"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.*,com.mocomsys.mtech.dao.*"%>
<%@page import="java.text.SimpleDateFormat"%>

<% 
	request.setCharacterEncoding("UTF-8");
	String loginUserId = URLDecoder.decode(request.getParameter("userId"), "UTF-8");
	StringBuffer SB = new StringBuffer();
%>

<%
	DataAccess da = new DataAccess();
	da.setDBProperty();
	da.connectionJDBC(); 
	
try{	
	ArrayList<ContentsVO> covoList = new ArrayList<ContentsVO>();
	ContentsDAO dao = new ContentsDAO(da.getConnection());
	covoList = dao.getMyContentsByUserID(loginUserId);
	
	int titleMaxLength = 40;
	int bodyMaxLength = 110;
	
	SB.append("<div class=\"bigContainer\">");
	
	// 상단 이미지 + 타이틀 부분
	SB.append("<div class=\"media\" style=\"text-align:center;\">");
	SB.append("<h1 class=\"media-heading text-muted\">");
	SB.append("<img align=\"middle\" src=\"img/suggest-title.png\" style=\"width:150px;height:150px\" alt=\"...\">");
	SB.append("<strong> MY CONTENTS</strong><small style=\"padding-left:30px\">Try manage the content that I wrote</small></h1></div>");

	SB.append("<br>");
	SB.append("<br>");
	
	SB.append("<span>");
	SB.append("<button type=\"button\" name=\"pageDownButton\" id=\"movePageDown\" class=\"btn btn-default btn-xs\" tabindex=\"0\" onclick=\"movePageDown();\"><span class=\"glyphicon glyphicon-arrow-down\"></span></button>\n");
	SB.append("<button type=\"button\" name=\"reLoadMyWritePage\" id=\"reLoadMyWritePage\" class=\"btn btn-default btn-xs\" tabindex=\"0\" onclick=\"LoadMyWritePage();\"><span class=\"glyphicon glyphicon-repeat\"></span></button>");
	SB.append("</span>");
	
	
	SB.append("<div style=\"float:right;\" class=\"form-actions\">");  
	
	// 상태별 검색 버튼. // 제외	
	
	
	// 상태 체크 라디오 버튼	
	SB.append("<div  class=\"form-actions\">");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"myWriteContentStatusRaido\" id=\"myWriteContentStatusRaido\" onclick=\"myWritelistFilter(this);\" value=\"a\" checked><span class=\"label label-info\">All</span></label>");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"myWriteContentStatusRaido\" id=\"myWriteContentStatusRaido\" onclick=\"myWritelistFilter(this);\" value=\"0\"><span class=\"label label-default\">New</span></label>");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"myWriteContentStatusRaido\" id=\"myWriteContentStatusRaido\" onclick=\"myWritelistFilter(this);\" value=\"1\"><span class=\"label label-danger\">New</span></label>");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"myWriteContentStatusRaido\" id=\"myWriteContentStatusRaido\" onclick=\"myWritelistFilter(this);\" value=\"2\"><span class=\"label label-warning\">Process</span></label>");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"myWriteContentStatusRaido\" id=\"myWriteContentStatusRaido\" onclick=\"myWritelistFilter(this);\" value=\"3\"><span class=\"label label-danger\">Process</span></label>");
	SB.append("<label class=\"radio-inline\"><input type=\"radio\" name=\"myWriteContentStatusRaido\" id=\"myWriteContentStatusRaido\" onclick=\"myWritelistFilter(this);\" value=\"9\"><span class=\"label label-success\">Complete</span></label>");
	SB.append("</div>\n");		
		
	SB.append("</div>");
	

	SB.append("<hr>");
	
	SB.append("<div class=\"CSSTableGenerator\" id=\"SearchMainContent\">");
	SB.append("<table id=\"myWriteContentsResultTable\">");
	SB.append("<tr>");
    SB.append("<td class=\"CSSTableMiddle\"><p class=\"text-center\">상태</p></td>");
    SB.append("<td class=\"CSSTableMiddle\"><p class=\"text-center\">추천</p></td>");
    SB.append("<td><p class=\"text-center\">글 정보</p></td>");
    SB.append("<td><p class=\"text-center\">담당자</p></td>");
    SB.append("<td class=\"CSSTableBig\"><p class=\"text-center\" style=\"text-align:center;\">등록일시</p></td>");
    SB.append("</tr>");
    
	for (ContentsVO cvo : covoList)
	{
		String id = cvo.getId();
		String title = cvo.getTitle();
		String body = cvo.getBody();
				
		SimpleDateFormat FF = new SimpleDateFormat("yyyyMMddhhmmssSSS");
		SimpleDateFormat AF = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String date = AF.format(FF.parse(cvo.getRegist_date()));
				
		int status = Integer.parseInt(cvo.getStatus());		
		int likeCount = Integer.parseInt(cvo.getRecommend_counts());
		String strContentStatus = "";
		String strTitle="";
		String strBody="";
				
		if(title.length()>titleMaxLength){
	    	strTitle = title.substring(0,titleMaxLength)+"....";
	    }else{
	    	strTitle = title;
	    }
		
		if(body.length()>bodyMaxLength){
	    	strBody = body.substring(0,bodyMaxLength)+"....";
	    }else{
	    	strBody = body;
	    }
		
		String strReceiver = cvo.getReceive_user_id();
		
		if(status == 0 ) { // 최초 일반 등록
			strContentStatus ="default\">New";
		}else if(status == 1) { // 최초 긴급 등록
			strContentStatus ="danger\">New";
		}else if(status == 2) { // 일반 진행 중 (Receiver 확인) 
			strContentStatus ="warning\">Processing";
		}else if(status == 3) { // 긴급 진행 중 (Receiver 확인)
			strContentStatus ="danger\">Processing";
		}else { // 완료
			strContentStatus = "success\">Complete";	    			
		}		
	     // 상태,추천,등록일시,제목,본문 순임.

	    SB.append("<tr type=\"submit\" id=\""+id+"\" style=\"cursor:pointer\" onclick=\"trClickEvent(this)\">");
	    
	    SB.append("<td value=\""+status+"\"><p class=\"text-center\"><span class=\"label label-"+strContentStatus+"</span></p></td>");
	    SB.append("<td><p class=\"text-center\"><span class=\"glyphicon glyphicon-thumbs-up\"> "+likeCount+"</span></p></td>");
	    SB.append("<td>");
	    SB.append("<div class=\"TableContentsTitleReadComplete\">"+strTitle+"</div>");
	 	SB.append("<div class=\"TableContentsBody\">"+strBody+"</div>");
	    SB.append("</td>");
	    SB.append("<td><p class=\"text-center\">"+strReceiver+"</p></td>");
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
	//System.out.println(SB.toString());
}catch(Exception e) {
	System.out.println("myWriteListGenerator="+e.toString());
}finally{
	if(da != null) {
		da.closeConnection();
		System.out.println("myWriteListGenerator DA CloseSuccess!!");
	}
}
%>

<%=SB%>