<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  	<meta name="author" content="매력대리's">
<script>
function trim(txt)
{
 return txt.replace(/(^\s*)|(\s*$)/g, "");
}

function get_text_val(id)
{
	var res = "";
	var set_id = "#" + id; 
	res = $(set_id).val();
	return res;
}

function CheckInputData() {
	f = document.newArticleForm;			
	if(get_text_val('ar_title') == "")
	{
		f.ar_title.focus();
		alert("제목을 입력해주세요.");
		return false;
	}
	else if(get_text_val('ar_engineer') == "") // 로직 변경
	{
		f.ar_engineer.focus();
		alert("받을 사람을 입력해주세요.");
		return false;
	}
	else if(get_text_val('ar_tag') == "") // 로직 변경
	{
		f.ar_tag.focus();
		alert("카테고리를 한개 이상 입력해주세요.");
		return false;
	}			
	return true; 
}

function SubmitFormData() {			
	var userId = document.getElementById("loginUserId").value;
	var contentsId = document.getElementById("currentContentId").value;
	
	var dataString = $("#newArticleForm").serialize() + "&userId="+userId +"&contentId=" +contentsId;
//	alert(dataString);
	
	$.ajax({
		url:'pages/Contents/modifyContent_update.jsp',
		type:'post',
		timeout:1000,
		data:dataString,
		dataType:'text',
		async:false,
		success:function() {
			alert("수정 성공.");
			LoadSelectedCountentsBody();
		},
		error:function() {
			alert("수정 실패");
		}				
	});
	return true;
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

function Modifyclick() {

	if(CheckInputData() == true) {
		SubmitFormData();
		return true;
	}
	return false;
	};

		$(document).ready(function() {
			loadModifyBody();
						
			var contentsId = document.getElementById("currentContentId").value;
			var loginUserId = document.getElementById("loginUserId").value;

			var dataString = "contentsId=" + contentsId + "&userId=" + loginUserId;

			$.ajax({
				url:'pages/Contents/modifyContent_select.jsp',
				type:"POST",
				data:dataString,
				dataType:"text",
				success:function(data) {	
					var arr_data = trim(data).split("!@#MTN$%^");
					
					var title = arr_data[0];
					var receiveUserId = arr_data[1];
					var refrenceUserId = arr_data[2];
					var tag = arr_data[3];
					var file = arr_data[4];
					var body = arr_data[5];

					document.getElementById('ar_title').value=title;
					document.getElementById('ar_engineer').value=receiveUserId;
					document.getElementById('ar_cc').value=refrenceUserId;
					document.getElementById('ar_tag').value=tag;
//			 		document.getElementById('ar_file').value=file;
					document.getElementById('ar_contentBody').value=body;
					
					$('#ar_engineer').tokenfield('setTokens',receiveUserId);
					$('#ar_cc').tokenfield('setTokens',refrenceUserId);
					$('#ar_tag').tokenfield('setTokens',tag);
					
				},
				error:function() {
					alert("실패");
				}				
			});
		});
		
		function loadModifyBody() {
			$('#ModifyMainBody').load('pages/view/ModifyContentBody.html');
		}
  		
</script>
</head>
<body>
<div class="smallContainer">
<br>
<div id="ModifyMainBody">

</div>	
</div>
</body>
</html>
