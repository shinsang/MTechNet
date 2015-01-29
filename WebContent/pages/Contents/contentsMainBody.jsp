<%@page import="java.text.Normalizer.Form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  	<meta name="author" content="매력대리's">  
</head>
<body>
<script>
$(document).ready(function() {
	location.href.replace("#", "")
	var searchString = document.getElementById("search").value;
	document.getElementById("search").value = searchString;
	
	LoadSelectedCountentsBody();
		
	return true;
});

function reAlertContentsStatus(){
	var loginUserId = document.getElementById("loginUserId").value;
	var contentId = document.getElementById("currentContentId").value;

	var dataString = "contentId="+contentId;
	
	if(loginUserId != null) {
		dataString +="&userId="+loginUserId;
	}		

	$.ajax({
		url:'pages/generator/ContentsGenerator.jsp',
		type:"POST",
		data:dataString,
		dataType:"text",
		success:function(data) {	
			var mainContent = document.getElementById("mainContent");
			mainContent.innerHTML = data;	
		},
		error:function() {
			alert("실패");
		}
	});
}

function LoadSelectedCountentsBody(){
	var loginUserId = document.getElementById("loginUserId").value;
	var contentId = document.getElementById("currentContentId").value;

	var dataString = "contentId="+contentId;
	
	if(loginUserId != null) {
		dataString +="&userId="+loginUserId;
	}		

	$.ajax({
		url:'pages/generator/ContentsGenerator.jsp',
		type:"POST",
		data:dataString,
		dataType:"text",
		success:function(data) {	
			var mainContent = document.getElementById("mainContent");
			mainContent.innerHTML = data;	
		},
		error:function() {
			alert("실패");
		}
	});
}


function tokenFieldInit(){ 
	alert("토큰 짜르기");
	alert("init");
	 $('#ar_tag').tokenfield({
			delimiter: ',',
			createTokensOnBlur: true	
	});
    
    $('#ar_engineer, #ar_cc').tokenfield({
		autocomplete: {
	    source: ['신상헌','정융기','장승훈','홍종민'],
	    delay: 100
		  },
		  showAutocompleteOnFocus: true,
		  delimiter: ',',
		  beautify: true,
		  createTokensOnBlur: true
    });
}

function bookMarkClick() {
	var loginUserId = document.getElementById("loginUserId").value;
	var contentId = document.getElementById("currentContentId").value;

	var dataString = "";
	if(loginUserId != null && typeof contentId != "undefined")
	{
 		dataString = "contentId=" + contentId + "&userId=" + loginUserId;
 		//alert("dataString="+dataString);
		$.ajax({
			url:'pages/Contents/bookMark_Insert.jsp',
			type:"POST",
			data:dataString,
			dataType:"text",
			success:function(data) {	
				LoadSelectedCountentsBody();
				alert("즐겨찾기 등록 성공");	
			},
			error:function() {
				alert("즐겨찾기 등록 실패");
			}
		}); 
	}
	return true;
}

function recommndClick() {	
	var contentId = document.getElementById("currentContentId").value;
	var loginUserId = document.getElementById("loginUserId").value;
	var recommentCount = document.getElementById("recommentCount").innerText.trim();
	
	recommentCount++;
	var dataString = "contentId=" + contentId + "&recommentCount=" + recommentCount +"&userId=" + loginUserId;
	
	//alert("dataString="+dataString);
	$.ajax({
		url:'pages/Contents/recommend_update.jsp',
		type:'post',
		timeout:1000,
		data:dataString,
		dataType:'text',
		async:false,
		success:function() {
			LoadSelectedCountentsBody();
			alert("해당 컨텐츠가 추천되었습니다.");
		},
		error:function() {
			alert("추천 실패.");
		}				
	});
	
	
	return true;
}



function modifyContents(){
	$('#mainContent').load('pages/Contents/modifyContent.jsp');					
}

function addComment() {
	
	f = document.commentForm;
	
	if(get_text_val('ar_title') == "")
	{
		f.title.focus();
		alert("제목을 입력해주세요.");
		return false;
	}
	else if(get_text_val('ar_title') == "") // 로직 변경
	{
		f.engineer.focus();
		alert("받을 사람을 입력해주세요.");
		return false;
	}
	else
	{	
		var loginUserId = document.getElementById("loginUserId").value;
		var ContentsId = document.getElementById("currentContentId").value;
		var dataString = $("#commentForm").serialize() + "&contentsId=" +ContentsId + "&userId=" + loginUserId;
		
		//alert(dataString);
		
		$.ajax({
			url:'pages/Contents/addComment_insert.jsp',
			type:'post',
			timeout:1000,
			data:dataString,
			dataType:'text',
			async:false,
			success:function() {
				alert("문의 등록에 성공 하였습니다.");
				LoadSelectedCountentsBody();				
			},
			error:function() {
				alert("문의 등록에 오류가 발생했습니다.");
			}				
		});
		
		return true;
	}
}

function get_text_val(id)
{
	var res = "";
	var set_id = "#" + id; 
	res = $(set_id).val();
	return res;
}

function reLoadContentBodyPage()
{
	LoadSelectedCountentsBody();
}

function ChangeStatusClick()
{
	var contentId = document.getElementById("currentContentId").value;
	var currentContentStauts = document.getElementById("currentContentStauts").innerText.trim();
	
	// 조건부	
	if(currentContentStauts == 0) { // 일반 새글 -> 일반 진행 (confirm)
		currentContentStauts = 2;
		alert("담당자가  일반 문의를 확인하였습니다.");
	}
	else if(currentContentStauts == 1) { // 긴급 새글 -> 긴급 진행 (confirm)
		currentContentStauts = 3;
		alert("담당자가 긴급 문의를 확인하였습니다.");
	}
	else if(currentContentStauts == 2) { // 일반 진행 -> 일반 완료 (complete)
		currentContentStauts = 8;
		alert("문의자가 일반 문의를 완료되었습니다.");
	}
	else if(currentContentStauts == 3) { // 긴급 진행 -> 긴급 완료 (complete)
		currentContentStauts = 9;
		alert("문의자가 긴급 문의를 완료되었습니다.");
	}
	else if(currentContentStauts == 8) { // 일반 완료 -> 일반 진행 (rollback)
		currentContentStauts = 2;
		alert("문의자가 해당 컨텐츠 상태를 재문의로 변경 했습니다.");
	}
	else if(currentContentStauts == 9) { // 긴급 완료 -> 긴급 진행 (rollback)
		currentContentStauts = 3;
		alert("문의자가 해당 컨텐츠 상태를 재문의로 변경 했습니다.");
	}
	else {
		currentContentStauts = 9;
	}
	
	var dataString = "contentId=" + contentId + "&changeStatus=" + currentContentStauts;;
	//alert("dataString="+dataString);
	$.ajax({
		url:'pages/Contents/statusContents_update.jsp',
		type:'post',
		timeout:1000,
		data:dataString,
		dataType:'text',
		async:false,
		success:function() {
			LoadSelectedCountentsBody();			
		},
		error:function() {
			alert("확인 실패.");
		}				
	});
}

function contents_delete() {
	var contentId = document.getElementById("currentContentId").value;
	var dataString = "contentsId=" + contentId;
		
	//alert(dataString);
	$.ajax({
		url:'pages/Contents/contents_delete.jsp',
		type:'post',
		timeout:1000,
		data:dataString,
		dataType:'text',
		async:false,
		success:function() {
			alert("contents delete 성공 하였습니다.");
			document.getElementById("currentContentId").value = "";
			
			// ==> 방법을 생각해보자.
			location.href = "index.jsp";
		},
		error:function() {
			alert("contents delete 실패 하였습니다.");
		}				
	});
	return true;
}
	
function comment_delete(cmObj) {
	var getContentsId = cmObj.id;
	var dataString = "commentId=" + getContentsId;
	
	//alert(dataString);
	
	
	$.ajax({
		url:'pages/Contents/comment_delete.jsp',
		type:'post',
		timeout:1000,
		data:dataString,
		dataType:'text',
		async:false,
		success:function() {
			LoadSelectedCountentsBody();
			alert("comment delete 성공 하였습니다.");			
		},
		error:function() {
			alert("comment delete 실패 하였습니다.");
		}				
	});
	
	
	return true;
}


</script>
</body>
</html>