<%@page import="com.mocomsys.mtech.dao.CommentDAO"%>
<%@page import="com.mocomsys.mtech.vo.BookMarkVO"%>
<%@page import="com.mocomsys.mtech.dao.BookMarkDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder, java.net.URLEncoder, java.sql.Date"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.*,com.mocomsys.mtech.dao.*"%>

<% 
	request.setCharacterEncoding("UTF-8");
	String requestContentId = request.getParameter("contentId");
	String loginUserId = request.getParameter("userId");
	StringBuffer SB = new StringBuffer();
	
	DataAccess da = new DataAccess();
	da.setDBProperty();
	da.connectionJDBC();
%>

<%
try{
	ArrayList<ContentsVO> civoList = new ArrayList<ContentsVO>();
	ContentsDAO cdao = new ContentsDAO(da.getConnection());
	ContentsVO cV = cdao.getSearchResultByID(requestContentId);
	
	String title = cV.getTitle();
	String registUserId = cV.getRegist_user_id();
	
	SimpleDateFormat FF = new SimpleDateFormat("yyyyMMddhhmmssSSS");
	SimpleDateFormat AF = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String registDate = AF.format(FF.parse(cV.getRegist_date()));
	
	String receiveUserId = cV.getReceive_user_id();
	String referenceUserId = cV.getRefrence_user_id();
	String tag = cV.getTag();
	String contentBody = cV.getBody();
	String attachFile = cV.getAttach_file();
	int status = Integer.parseInt(cV.getStatus());
	int clickCounts = Integer.parseInt(cV.getClick_counts());
	int recommendCounts = Integer.parseInt(cV.getRecommend_counts());		
	
	boolean isMyContents = false; // 내가 작성한 본문이지 판단 플레그
	boolean isReceiveUser = false; // 해당 글의 담당자인지 판단 플레그
	//boolean isRegistedBookMarkLable = false; // 즐겨 찾기 라벨 활성화 
	boolean isActivaionBookMark = false; // 즐겨 찾기 버튼 활성화
	boolean isActivaionRecommend = false; // 즐겨 찾기 버튼 활성화 
		
	if(registUserId.equals(loginUserId)) {
		isMyContents = true;		
	}

	//System.out.println("registUserId : "+registUserId + ", loginUserId : " + loginUserId);
	// 즐겨찾기 체크는 로그인 안했다면 체크 할 필요 없다. 무조건 비활성화 
	
	if(loginUserId != "") {
		BookMarkDAO Bdao = new BookMarkDAO(da.getConnection());
		isActivaionBookMark = Bdao.BookMarkCheck(loginUserId, requestContentId);
		if(isActivaionBookMark)
			System.out.println("isActivaionBookMark true");
		else
			System.out.println("isActivaionBookMark false");
		
		RecommendDAO Rdao = new RecommendDAO(da.getConnection());
		isActivaionRecommend = Rdao.RecommendCheck(loginUserId, requestContentId);
		if(isActivaionRecommend)
			System.out.println("isActivaionRecommendButton true");
		else
			System.out.println("isActivaionRecommendButton false");
	}
	
	if(receiveUserId.equals(loginUserId)) {
		isReceiveUser = true;
	}	
	
	SB.append("<section class=\"bigContainer\" id=\"MainBody\" style=\"font-family:verdana\">");
	
	// 상단 이미지 + 타이틀 부분
	SB.append("<div class=\"media\" style=\"text-align:center;\">");
	SB.append("<h1 class=\"media-heading text-danger\">");
	SB.append("<img align=\"middle\" src=\"img/ccc.png\"  alt=\"...\">");
	SB.append("<strong></strong><small class=\"media-heading\" style=\"padding-left:10px\"></small></h1></div>");
			
	SB.append("<br>");	
	SB.append("<div style=\"float:right;\" class=\"form-actions\">");  
	
	// 즐겨 찾기 버튼
	SB.append("<button type=\"button\" name=\"bookMarkButton\" id=\"bookMarkButton\" class=\"btn btn-warning btn-sm\" tabindex=\"0\" onclick=\"bookMarkClick();\" ");
	if(isActivaionBookMark || loginUserId == "") { // 즐겨찾기를 등록했을 경우  버튼 비활성화. - 로직 추가할 것.
		SB.append("disabled");
	}
	SB.append("><span class=\"glyphicon glyphicon-star\"></span> BookMark</button>\n");
	
	// 추천 버튼
	SB.append("<button type=\"button\" name=\"recommendButton\" id=\"recommendButton\" class=\"btn btn-info btn-sm\" tabindex=\"0\" onclick=\"recommndClick();\" ");
 	if(isActivaionRecommend  || loginUserId == "") { // 추천 버튼을 클릭했을 경우  버튼 비활성화. - 로직 추가할 것.
		SB.append("disabled");
	}
	SB.append("><span class=\"glyphicon glyphicon-thumbs-up\"></span> Recommend</button>\n");
	
	// 확인 버튼
	SB.append("<button type=\"button\" name=\"completeContent\" id=\"completeContent\" class=\"btn btn-primary btn-sm\" tabindex=\"0\" onclick=\"ChangeStatusClick();\"");
	if(!isReceiveUser || !(status == 0 || status == 1)) { // 담당자가 아닐 경우 버튼 비활성화 로직 추가. - 로직 추가할 것.
		SB.append("disabled");
	}
	SB.append("><span class=\"glyphicon glyphicon-forward\"></span> Confirm</button>\n");
	
	// 완료 버튼
	SB.append("<button type=\"button\" name=\"confirmContent\" id=\"confirmContent\" class=\"btn btn-success btn-sm\" tabindex=\"0\" onclick=\"ChangeStatusClick();\"");
	if(!isMyContents || !(status == 2 || status == 3)) { // 글쓴이와 동일하지 않을 경우 비활성화 로직 추가. - 로직 추가할 것.
		SB.append("disabled");
	}
	SB.append("><span class=\"glyphicon glyphicon-ok\"></span> Complete</button>\n");
	
	// 롤백 버튼
	SB.append("<button type=\"button\" name=\"confirmContent\" id=\"confirmContent\" class=\"btn btn-danger btn-sm\" tabindex=\"0\" onclick=\"ChangeStatusClick();\"");
	if(!isMyContents || !(status == 8 || status == 9)) { // 글쓴이와 동일하지 않을 경우 비활성화 로직 추가. - 로직 추가할 것.
		SB.append("disabled");
	}
	SB.append("><span class=\"glyphicon glyphicon-fast-backward\"></span> Rollback</button>");
	SB.append("</div>");
	
	SB.append("<br>");
	SB.append("<div>");
	SB.append("<button type=\"button\" name=\"pageDownButton\" id=\"movePageDown\" class=\"btn btn-default btn-xs\" tabindex=\"0\" onclick=\"movePageDown();\"><span class=\"glyphicon glyphicon-arrow-down\"></span></button>\n");
	SB.append("<button type=\"button\" name=\"reLoadContentPage\" id=\"reLoadContentPage\" class=\"btn btn-default btn-xs\" tabindex=\"0\" onclick=\"reLoadContentBodyPage();\"><span class=\"glyphicon glyphicon-repeat\"></span></button>\n");
	SB.append("<button type=\"button\" name=\"reAlertContentsStatus\" id=\"reAlertContentsStatus\" class=\"btn btn-default btn-xs\" tabindex=\"0\" onclick=\"reAlertContentsStatus();\"><span class=\"glyphicon glyphicon-bullhorn\"></span></button>");
	SB.append("</div>");
	SB.append("<hr>");	
	
	// 코드가 병신 같지만 일단 급하니깐 대충 이렇게 쓰도록 하자

	if(status == 0) {// 새글 일반 등록 상태
		SB.append("<div class=\"progress progress-striped active\">");
		SB.append("<div class=\"progress-bar progress-bar-info\" role=\"progressbar\" aria-valuenow=\"10\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 10%\">");
		SB.append("<span class=\"sr-only\" id=\"currentContentStauts\">"+status+"</span>");
		SB.append("</div>");
		SB.append("</div>");
		SB.append("<hr>");
		SB.append("<div>");
		SB.append("<span id=\"contentStatus\" class=\"label label-default\">New</span>"); // 상태 라벨
	}
	else if(status == 1) {// 새글 긴급 등록 상태
		SB.append("<div class=\"progress progress-striped active\">");
		SB.append("<div class=\"progress-bar progress-bar-danger\" role=\"progressbar\" aria-valuenow=\"10\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 10%\">");
		SB.append("<span class=\"sr-only\" id=\"currentContentStauts\">"+status+"</span>");
		SB.append("</div>");
		SB.append("</div>");
		SB.append("<hr>");
		SB.append("<div>");
		SB.append("<span id=\"contentStatus\" class=\"label label-danger\">New</span>"); // 상태 라벨
	}
	else if(status == 2) {// 일반 등록 상태
		SB.append("<div class=\"progress progress-striped active\">");
		SB.append("<div class=\"progress-bar progress-bar-warning\" role=\"progressbar\" aria-valuenow=\"50\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 50%\">");
		SB.append("<span class=\"sr-only\" id=\"currentContentStauts\">"+status+"</span>");
		SB.append("</div>");
		SB.append("</div>");
		SB.append("<hr>");
		SB.append("<div>");
		SB.append("<span id=\"contentStatus\" class=\"label label-warning\">Processing</span>"); // 상태 라벨
	}
	else if(status == 3) {// 긴급 등록 상태
		SB.append("<div class=\"progress progress-striped active\">");
		SB.append("<div class=\"progress-bar progress-bar-danger\" role=\"progressbar\" aria-valuenow=\"50\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 50%\">");
		SB.append("<span class=\"sr-only\" id=\"currentContentStauts\">"+status+"</span>");
		SB.append("</div>");
		SB.append("</div>");
		SB.append("<hr>");
		SB.append("<div>");
		SB.append("<span id=\"contentStatus\" class=\"label label-danger\">Processing</span>"); // 상태 라벨
	}
	else {// 완료 상태
		SB.append("<div class=\"progress progress-striped active\">");
		SB.append("<div class=\"progress-bar progress-bar-success\" role=\"progressbar\" aria-valuenow=\"100\" aria-valuemin=\"0\" aria-valuemax=\"100\" style=\"width: 100%\">");
		SB.append("<span class=\"sr-only\" id=\"currentContentStauts\">"+status+"</span>");
		SB.append("</div>");
		SB.append("</div>");
		SB.append("<hr>");
		SB.append("<div>");
		SB.append("<span id=\"contentStatus\" class=\"label label-success\">Complete</span>"); // 상태 라벨
	}
	
	// 글 추천 수 라벨	
	SB.append("\n<span class=\"label label-info\" ><span class=\"glyphicon glyphicon-thumbs-up\" id=\"recommentCount\"> "+recommendCounts+"</span></span>\n");
	
	if(isActivaionBookMark)// 즐겨찾기 등록 여부 확인 라벨
		SB.append("<span id=\"bookMarkStatus\" class=\"label label-warning\"><span class=\"glyphicon glyphicon-star\"></span></span>");
	
	SB.append("</div>");
	SB.append("<br>");
			
	// Content 본문
	//System.out.println("status = " + status);
	SB.append("<div class=\"panel panel-");
	
	if(status == 0) // 새글 일반 등록 상태
		SB.append("default\">");
	else if(status == 1) // 새글 긴급 등록 상태
		SB.append("danger\">");
	else if(status == 2) // 일반 등록 상태
		SB.append("warning\">");
	else if(status == 3) // 긴급 등록 상태
		SB.append("danger\">");
	else // 완료 상태
		SB.append("success\">");	
	
	SB.append("<div class=\"panel-heading\">");
	SB.append("<span class=\"glyphicon glyphicon-time\" style=\"float:right;\"> "+registDate+"</span>");
	SB.append("<br>");
	SB.append("<h3 class=\"panel-title\"><strong>"+title+"</strong></h3>"); // 제목
	SB.append("<br>");
	SB.append("<span class=\"glyphicon glyphicon-user\"> "+registUserId+"</span>");
	SB.append("<br>");
	SB.append("<span class=\"glyphicon glyphicon-share-alt\"> "+receiveUserId+"</span>");
	SB.append("<br>");
	SB.append("<span class=\"glyphicon glyphicon-subtitles\"> "+referenceUserId+"</span>");
	SB.append("</div>");
	SB.append("<div class=\"panel-body\"><p>");
	
	if(contentBody.contains("\r")) {
		contentBody = contentBody.replace("\r", ""); 	
	}	
	contentBody = contentBody.replace("\n", "<br>");	
	SB.append(contentBody);	
	SB.append("</p></div>");
	SB.append("</div>");
	
	// 하부 수정/삭제 버튼			
	SB.append("<div style=\"float:right;\" class=\"form-actions\">");
	SB.append("<button type=\"button\" name=\"modifyContents\" id=\"modifyContents\" class=\"btn btn-primary btn-xs\" onclick=\"modifyContents();\" "); 
	if(!isMyContents) 
		SB.append("disabled");
	SB.append("><span class=\"glyphicon glyphicon-pencil\"></span> Modify</button>\n");	
		
	SB.append("<button type=\"button\" name=\"removeContents\" id=\"removeContents\" class=\"btn btn-danger btn-xs\" onclick=\" contents_delete();\" ");
	if(!isMyContents) 
		SB.append("disabled");
	SB.append("><span class=\"glyphicon glyphicon-trash\"></span> Remove</button>");
	SB.append("</div>");
	
	String parentContentId = requestContentId;
	CommentDAO cmdao = new CommentDAO(da.getConnection());
	ArrayList<CommentVO> cmvoList = new ArrayList<CommentVO>();
	cmvoList = cmdao.getCommentList(parentContentId);

	//System.out.println("cmvoList : "+cmvoList.size());
	int CommentCount = 1;
	for(CommentVO cmvo : cmvoList)
	{
		String cmCommentId = cmvo.getId();
		String cmTitle = cmvo.getTitle();
		String cmRegistUserID = cmvo.getRegist_user_id();
		String cmRegistDate = AF.format(FF.parse(cmvo.getRegist_date()));
		String cmReceiveUserID = cmvo.getReceive_user_id();
		String cmRefrenceUserID = cmvo.getRefrence_user_id();
		String cmAttachFile = cmvo.getAttach_file();
		String cmBody = cmvo.getBody();
		
		//System.out.println("cmCommentId="+cmCommentId);
		//System.out.println("cmTitle="+cmTitle);
		//System.out.println("cmBody="+cmBody);
		
		SB.append("</br>");
		SB.append("<hr>");
		
		SB.append("<div class=\"panel panel-info\">");
		SB.append("<div class=\"panel-heading\">");
		SB.append("<span class=\"glyphicon glyphicon-time\" style=\"float:right;\"> "+cmRegistDate+"</span>");
		SB.append("<br>");
		SB.append("<div><span class=\"glyphicon glyphicon-chevron-right\"> Reply ( "+(CommentCount++)+" )</span></div>");
		SB.append("<br>");
		SB.append("<h3 class=\"panel-title\" ><strong>"+cmTitle+"</strong></h3>");
		SB.append("<br>");
		SB.append("<span class=\"glyphicon glyphicon-user\"> "+cmRegistUserID+"</span>");
		SB.append("<br>");          
		SB.append("<span class=\"glyphicon glyphicon-share-alt\"> "+cmReceiveUserID+"</span>");
		SB.append("<br>");
		SB.append("<span class=\"glyphicon glyphicon-subtitles\"> "+cmRefrenceUserID+"</span>");
		SB.append("</div>");
		SB.append("<div class=\"panel-body\">");
		
		if(cmBody.contains("\r")) {
			cmBody = cmBody.replace("\r", ""); 	
		}	
		cmBody = cmBody.replace("\n", "<br>");		
		SB.append("<p>"+cmBody+"</p>");
		
		SB.append("</div>");
		SB.append("</div>");
		
		// 하부 수정/삭제 버튼			
		SB.append("<div style=\"float:right;\" class=\"form-actions\">");
		SB.append("<button type=\"button\" name=\"modifyContents\" id=\""+cmCommentId+"\" class=\"btn btn-primary btn-xs\" "); 
		if(!isMyContents) 
			SB.append("disabled");
		SB.append("><span class=\"glyphicon glyphicon-pencil\"></span> Modify</button>\n");	
			
		SB.append("<button type=\"button\" name=\"removeContents\" id=\""+cmCommentId+"\" class=\"btn btn-danger btn-xs\" onclick=\"comment_delete(this);\"");
		if(!isMyContents) 
			SB.append("disabled");
		SB.append("><span class=\"glyphicon glyphicon-trash\"></span> Remove</button>");
		SB.append("</div>");
		
	}	
	SB.append("<br>");
	SB.append("<br>");
	SB.append("<hr>");	
	
	SB.append("<div class=\"panel panel-primary\">");
	SB.append("<div class=\"panel-heading\">");
	SB.append("<h3 class=\"panel-title\" ><strong> New Comment</strong></h3>");	
	SB.append("</div>");
	SB.append("<div class=\"panel-body\">");
	if(loginUserId == "")
	{
		SB.append("<div><span class=\"glyphicon glyphicon-exclamation-sign text-danger\"> Comments can be registered after login.</span></div>");
	}
	else 
	{
		SB.append("<form name=\"commentForm\" id=\"commentForm\">");
		SB.append("<div class=\"form-group row\">");
		SB.append("<div class=\"form-group col-sm-6\">");
		
		SB.append("<input type=\"text\" name=\"title\" id=\"ar_title\" class=\"form-control input-sm\" placeholder=\"제목\">");
		SB.append("<br>");
		SB.append("<input type=\"text\" name=\"engineer\" id=\"ar_engineer\" class=\"form-control input-sm\" placeholder=\"받을 사람\">");
		SB.append("<br>");
		SB.append("<input type=\"text\" name=\"cc\" id=\"ar_cc\" class=\"form-control input-sm\" placeholder=\"참조\">");
		SB.append("<br>");
		SB.append("<input type=\"file\" name=\"file\" id=\"ar_file\" class=\"form-control input-sm\" placeholder=\"파일\">");
		SB.append("</div>");	
		SB.append("<div class=\"form-group col-sm-6\">");
		SB.append("<textarea name=\"message\" id=\"ar_message\" class=\"form-control\" rows=\"9\">");
		SB.append("</textarea></div>");
		SB.append("</div>");
		SB.append("<button type=\"button\" class=\"btn btn-primary pull-right\" onclick=\"addComment();\">Comnfirm</button>");
		SB.append("</form>");
	}
	
	SB.append("</div>");
	SB.append("</div>");
	SB.append("<div>");
	SB.append("<button type=\"button\" name=\"pageUpButton\" id=\"movePageUp\" class=\"btn btn-default btn-xs\" tabindex=\"0\" onclick=\"movePageUp();\"><span class=\"glyphicon glyphicon-arrow-up\"></span></button>\n");
	SB.append("</div>");	
	
	SB.append("</section>");	
	//System.out.println("ContentsGenerator.jsp Result=====>"+SB.toString());	
	
}catch(Exception e) {
	System.out.println("ContentsGenerator="+e.toString());
}finally{
	if(da != null) {
		da.closeConnection();
		System.out.println("ContentsGenerator DA CloseSuccess!!");
	}
}


%>

<%=SB%>