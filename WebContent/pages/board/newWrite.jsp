<%@page import="java.text.Normalizer.Form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <title>새글 등록하기</title>
  <meta name="author" content="매력대리's">
  <link rel="shortcut icon" href="http://static02.join_techNet.com/logo/hkdc/favicon.ico">
  <link rel="icon" href="img/join/mLogo.png">
  <link rel="stylesheet" type="text/css" media="all" href="stylesheets/board/board_styleSheet.css">
  <link rel="stylesheet" type="text/css" media="all" href="stylesheets/board/board_responsive.css">
</head>
<body>
<script>	

		
		function get_text_val(id)
		{
			var res = "";
			var set_id = "#" + id; 
			res = $(set_id).val();
			return res;
		}
		
		var getParameter = function (param) {
		    var returnValue;
		    var url = location.href;
		    var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
		    for (var i = 0; i < parameters.length; i++) {
		        var varName = parameters[i].split('=')[0];
		        if (varName.toUpperCase() == param.toUpperCase()) {
		            returnValue = parameters[i].split('=')[1];
		            return decodeURIComponent(returnValue);
		        }
		    }
		};
		
		function Completeclick() {
			f = document.join_techNet;
			
			
			if(get_text_val('title') == "")
			{
				f.title.focus();
				alert("제목을 입력해주세요.");
				return false;
			}
			else if(get_text_val('title') == "") // 로직 변경
			{
				f.engineer.focus();
				alert("받을 사람을 입력해주세요.");
				return false;
			}
			else if(get_text_val('title') == "") // 로직 변경
			{
				f.tag.focus();
				alert("카테고리를 한개 이상 입력해주세요.");
				return false;
			}	
			else
			{				
				var dataString = CreateContentsData();
				alert(dataString);
				$.ajax({
					url:'page/board/newWrite_Insert.jsp',
					type:'post',
					timeout:1000,
					data:"post_val="+dataString,
					dataType:'json',
					success:function(data) {
						var val = $.trim(data);
						if(val == "OK")	{
							alert("문의 등록에 성공했습니다.")
						}
						else {
							alert("문의 등록에 실패했습니다.");
						}
					},
					error:function() {
						alert("문의 등록에 실패했습니다.");
					}				
				});
				return true;
			}
  		}
		
		function CreateContentsData()
		{
			var strTitle = get_text_val('title');
			var strEngineer = get_text_val('engineer');
			var strcc = get_text_val('cc');
			var strTag = get_text_val('tag');
			var strFile = get_text_val('file');
			var strContentBody = get_text_val('contentBody'); 
			var userId = getParameter('userId'); 
			
			var Node = [
						 {name : "userId", value : userId}
			            ,{name : "title", value : strTitle}
			            ,{name : "engineer", value : strEngineer}
			            ,{name : "cc", value : strcc}
			            ,{name : "tag", value : strTag}
			            ,{name : "file", value : strFile}
			            ,{name : "contentBody", value : strContentBody}
			            ];
			return Node;
		}
		
</script>
	<section id="container">
		<h2>새글 등록</h2>
		<form name="join_techNet" id="join_techNet-form">
		<div id="wrapping" class="clearfix">
			<section id="aligned">			
			<input type="text" name="title" id="title" placeholder="제목" autocomplete="off" tabindex="0" class="txtinput">
			<input type="text" name="engineer" id="engineer" placeholder="받을 사람" autocomplete="off" tabindex="0" class="txtinput">
			<input type="text" name="cc" id="cc" placeholder="참조" autocomplete="off" tabindex="0" class="txtinput">
			<input type="text" name="tag" id="tag" placeholder="카테고리(Tag)" autocomplete="off" tabindex="0" class="txtinput">
			<input type="text" name="file" id="file" placeholder="첨부 파일" autocomplete="off" tabindex="0" class="txtinput">
			<textarea  class="txtblock" id="contentBody" rows="5" placeholder="새 글" name="contents" tabindex="0"> </textarea>
			</section>
		</div>
		<section id="buttons">
			<input type="reset" name="reset" id="resetbtn" class="resetbtn" value="다시 작성">
			<input type="button" name="submit" id="submitbtn" class="submitbtn" tabindex="0" value="신규 등록" onclick="Completeclick()">
			<br style="clear:both;">			
		</section>
		</form>
	</section>

</body>
</html>