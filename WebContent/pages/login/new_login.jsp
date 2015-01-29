<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<body>
<script>	
	function get_text_val(id)
	{
		var res = "";
		var set_id = "#" + id; 
		res = $(set_id).val();
		return res;
	}	
	
	function loginButtonClick() {		
		var userId = get_text_val('inputUserId');
		var userPassword = get_text_val('inputPassword');
		
		if(userId == "") {
			alert("사용자 아이디를 입력해주세요.");
			return false;
		}
		
		if(userPassword == "") {
			alert("사용자 비밀번호를 입력해주세요.");
			return false;
		}
					
		dataString = "id=" + userId + "&password=" + userPassword; 
		$.ajax({
			url:"pages/login/login_proc.jsp",		 
			data : dataString,  // 넘겨질 데이타 
		    type: "POST",
			success:function(result) {	
				
				var arr_data = trim(result).split("*");
				var loginMsg = arr_data[0];
				
				if(loginMsg=="성공"){
					var userId = arr_data[1];
					var userName = arr_data[2];	
        			
        			document.getElementById("loginUserId").value = userId;
        			document.getElementById("loginUserName").value = userName;
   	 			
        			var userIdSlot = document.getElementById("userIdSlot");
    	 			var topBarMenuList = document.getElementById("TopBarMenu");
        			
    	 			userIdSlot.innerHTML = "<strong> "+ userName + " <strong>";    	 			
    	 			var topBarString = "<li><a href=\"#\" id=\"topBarMyWriteContents\">내 글 관리</a></li>"	 
    	 							 + "<li><a href=\"#\" id=\"topBarMyReferenceContents\">받은 글 관리</a></li>"
									 + "<li><a href=\"#\" id=\"topBarMyBookMarkContents\">즐겨찾기</a></li>"
									 + "<li><a href=\"#\" id=\"topBarMyInfoModify\">내 정보 수정</a></li>"
									 + "<li><a href=\"pages/login/logout.jsp\" id=\"topBarLogout\">로그 아웃</a></li>"; 
									 
					if(userId == "mocomsys"){
						
						topBarString += "<li class=\"divider\"></li>"
									 + "<li><a href=\"#\" id=\"tagManagement\">통계 화면</a></li>";
						
						//document.getElementById("tagManagement").style.display = "inline"; 
					}
									 
    	 			topBarMenuList.innerHTML = topBarString;    
    	 			
    	 			$('#tagManagement').click(function() {
    	 				tagManagementPage();
    	 				return false;
    	 		 	 });
    	 			
    	 			$('#topBarMyBookMarkContents').click(function() {
    	 				LoadMyBookMarkPage();
    	 				return false;
    	 		 	 });
    	 			
    	 			$('#topBarMyWriteContents').click(function() {
    	 				LoadMyWritePage();
    	 				return false;
    	 		 	 }); 
    	 			
    	 			$('#topBarMyReferenceContents').click(function() {
    	 				LoadMyReceivePage();
    	 				return false;
    	 		 	 }); 
    	 			$('#topBarMyInfoModify').click(function() {
    					$('#mainContent').load('pages/join/modifyUser.html');					
    	 		 	 	return false;
    	 		 	 });    	 			
    	 			
    	 			var dataString2 = "userId="+ get_text_val('inputUserId');
    	 		   	$.ajax({
	 	 				url:'pages/login/myNoReadContents_select.jsp',
	 	 				type:"POST",
	 	 				data:dataString2,
	 	 				dataType:"text",
	 	 				success:function(data) {
	 	 					//alert(data)
	 	 					if(parseInt(data) > 0 )
	 	 					{
	 	 						//document.getElementById("userInfoCount").innerText = parseInt(data);
	 	 						alert("아직 확인하지 않은 컨텐츠가 ("+parseInt(data)+")건 있습니다." + "\n받은 글 관리 페이지를 확인해 주세요.");
	 	 					}
	 					},
	 	 				error:function() {
	 	 					alert("뱃지 로드 실패");
	 	 				}				
	 	 			});	
    	 			
    	 			$('#mainContent').load('pages/view/indexBody.html #indexBodyJumboTron');
				}else{
					alert("로그인 실패");
				}
				return true;
			},
			error:function(){
				alert("알수 없는 이유 : 로그인 실패");
				return false;
			}		
		});
	}
	
	function tagManagementPage() {
		$('#mainContent').load('pages/manage/manageTechNet.html');
	}
	
	function ReceivedtrClickEvent(trObj) {
		var selectedContentId = trObj.id;
		if(typeof trContentId != "undefined") // 선택된 tr 값이 있고 해당 contentId 값이 정의되지 않은 값이라면
		{
			alert("해당 컨텐츠는 삭제되었습니다.");
			return false;
		}
			
		document.getElementById("currentContentId").value = selectedContentId;	
			
		var isReadTdId = selectedContentId + "IsRead";
		var readStatus = document.getElementById(isReadTdId).getAttribute("value");
		//alert(readStatus);
		if(readStatus == "N") {  // 안 읽은 상태면 쿼리로 상태를 업데이트 친다.
 			var userId = document.getElementById("loginUserId").value;
 			var dataString = "userId=" + userId + "&contentId=" + selectedContentId;		
 			//alert("dataString="+dataString);
 			
 			$.ajax({
 				url:'pages/Contents/myReceivedContentsReadStatus_update.jsp',
 				type:"POST",
 				data:dataString,
 				dataType:"text",
 				success:function(data) {
 					//alert("읽음"); 					
				},
 				error:function() {
 					alert("실패");
 				}				
 			});													
		}		
		$('#mainContent').load("pages/Contents/contentsMainBody.jsp");		
		return false;		
	}

	
	function myWritelistFilter(obj)
	{
		var filterStatus = obj.value;		
		var myWriteContentsListResult = document.getElementById("myWriteContentsResultTable");		
		var tableLength = myWriteContentsListResult.rows.length;
		
		if(tableLength > 1)
		{
			var idx;			
			// 전체 row 보이도록 먼저 변경.
			TableRowVisiable(myWriteContentsListResult);			
			if(filterStatus == "a") return true;
			
			for(idx=1 ;idx < tableLength; idx++) {
				var Tr = myWriteContentsListResult.rows[idx];
				var trStatus = Tr.cells[0].getAttribute("value");
				
				if(filterStatus == 0) { // 일반 new 라면 나머진 다 noe
					if(trStatus != 0)
						Tr.style.display="none";							
				}
				else if(filterStatus == 1) {
					if(trStatus != 1)
						Tr.style.display="none";							
				}
				else if(filterStatus == 2) {
					if(trStatus != 2)
						Tr.style.display="none";	
				}
				else if(filterStatus == 3) {
					if(trStatus != 3)
						Tr.style.display="none";	
				}
				else {
					if(trStatus != 8 && trStatus != 9)
						Tr.style.display="none";	
				} 				
			}			
		}		
	}
	
	function bookMarklistFilter(obj)
	{
		var filterStatus = obj.value;		
		var myBookMarkContentsListResult = document.getElementById("myBookMarkContentsResultTable");		
		var tableLength = myBookMarkContentsListResult.rows.length;
		
		if(tableLength > 1)
		{
			var idx;			
			// 전체 row 보이도록 먼저 변경.
			TableRowVisiable(myBookMarkContentsListResult);			
			if(filterStatus == "a") return true;
			
			for(idx=1 ;idx < tableLength; idx++) {
				var Tr = myBookMarkContentsListResult.rows[idx];
				var trStatus = Tr.cells[0].getAttribute("value");
				
				if(filterStatus == 0) { // 일반 new 라면 나머진 다 noe
					if(trStatus != 0)
						Tr.style.display="none";							
				}
				else if(filterStatus == 1) {
					if(trStatus != 1)
						Tr.style.display="none";							
				}
				else if(filterStatus == 2) {
					if(trStatus != 2)
						Tr.style.display="none";	
				}
				else if(filterStatus == 3) {
					if(trStatus != 3)
						Tr.style.display="none";	
				}
				else {
					if(trStatus != 8 && trStatus != 9)
						Tr.style.display="none";	
				} 				
			}			
		}		
	}
	
	function myReceivelistFilter(obj)
	{
		var filterStatus = obj.value;		
		var myReceiveContentsListResult = document.getElementById("myReceiveContentsResultTable");		
		var tableLength = myReceiveContentsListResult.rows.length;
		
		if(tableLength > 1)
		{
			var idx;			
			// 전체 row 보이도록 먼저 변경.
			TableRowVisiable(myReceiveContentsListResult);			
			if(filterStatus == "a") return true;
			
			for(idx=1 ;idx < tableLength; idx++) {
				var Tr = myReceiveContentsListResult.rows[idx];
				var trStatus = Tr.cells[0].getAttribute("value");
				
				if(filterStatus == 0) { // 일반 new 라면 나머진 다 noe
					if(trStatus != 0)
						Tr.style.display="none";							
				}
				else if(filterStatus == 1) {
					if(trStatus != 1)
						Tr.style.display="none";							
				}
				else if(filterStatus == 2) {
					if(trStatus != 2)
						Tr.style.display="none";	
				}
				else if(filterStatus == 3) {
					if(trStatus != 3)
						Tr.style.display="none";	
				}
				else {
					if(trStatus != 8 && trStatus != 9)
						Tr.style.display="none";	
				} 				
			}			
		}		
	}
	
	function TableRowVisiable(T)
	{
		var length = T.rows.length;
		var idx;
		for(idx=1 ;idx < length; idx++) {
			T.rows[idx].style.display="";				
		}
	}
	
	
	
	
	
	
	
	function LoadMyWritePage()
	{
		var userId = document.getElementById("loginUserId").value;
		var dataString = "userId=" + userId;		
		
		$.ajax({
			url:'pages/generator/myWriteListGenerator.jsp',
			type:"POST",
			data:dataString,
			dataType:"text",
			success:function(data) {
				//alert("성공");
				var mainContent = document.getElementById("mainContent");
				mainContent.innerHTML = data;			
			},
			error:function() {
				alert("실패");
			}				
		});
		return false;			
	}
	
	

	
	function LoadMyReceivePage()
	{
		var userId = document.getElementById("loginUserId").value;
		var dataString = "userId=" + userId;		
		
		$.ajax({
			url:'pages/generator/myReciveListGenerator.jsp',
			type:"POST",
			data:dataString,
			dataType:"text",
			success:function(data) {
				//alert("성공");
				var mainContent = document.getElementById("mainContent");
				mainContent.innerHTML = data;			
			},
			error:function() {
				alert("실패");
			}				
		});		
		return false;
	}
	
	function LoadMyBookMarkPage()
	{
		var userId = document.getElementById("loginUserId").value;
		var dataString = "userId=" + userId;		
		
		$.ajax({
			url:'pages/generator/bookMarkListGenerator.jsp',
			type:"POST",
			data:dataString,
			dataType:"text",
			success:function(data) {
				//alert("성공");
				var mainContent = document.getElementById("mainContent");
				mainContent.innerHTML = data;			
			},
			error:function() {
				alert("실패");
			}				
		});
		return false;			
	}
	
	// 공백 제거 	
	function trim(txt)
	{
	 return txt.replace(/(^\s*)|(\s*$)/g, "");
	}
</script>

<div class="smallerContainer">

	<br>
	<div class="media" style="text-align:center;">	
		<img align="middle" src="img/logo-login.png" style="width:150px;height:150px" alt="...">
	</div>

		<br>
		<h2 class="text-center text-muted"><strong> MTechNet  Login </strong></h2>
		<hr>			
		<form class="form-horizontal" role="form" id="userInfoform">
    		<div class="form-group">
    			<label class="col-lg-3 control-label text-muted">ID</label>
    			<div class="col-lg-9">
    				<input type="text" class="form-control" id="inputUserId" placeholder="UserId">
   				</div>
  			</div>  
  			<div class="form-group">
    			<label class="col-lg-3 control-label text-muted">PASSWORD</label>
    			<div class="col-lg-9">
      				<input type="password" class="form-control" id="inputPassword" placeholder="Password">
    			</div>
  			</div>    			
  			<div style="float:right;" class="form-actions">
  				<button type="button" class="btn btn-warning btn-sm" onclick="loginButtonClick();">Login</button>  				
  				<button type="button" class="btn btn-default btn-sm" onclick="loginButtonClick();">cancel</button>
      		</div>  			
		</form>

</div>
</body>
</html>