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
  	<script>	
		function Completeclick() {
			f = document.join_techNet;
			if(f.title.value == "")
			{
				f.title.focus();
				alert("제목을 입력해주세요.");
				return false;
			}
			else if(f.engineer.value == "") // 로직 변경
			{
				f.engineer.focus();
				alert("받을 사람을 입력해주세요.");
				return false;
			}
			else if(f.tag.value == "") // 로직 변경
			{
				f.tag.focus();
				alert("카테고리를 한개 이상 입력해주세요.");
				return false;
			}	
			else
			{

				return true;
			}
  		}
    </script>    
</head>
<body>
	<section id="container">
		<h2>새글 등록</h2>
		<form name="join_techNet" id="join_techNet-form" action="pages/board/newWrite_Insert.jsp" onSubmit="return Completeclick();">
		<div id="wrapping" class="clearfix">
			<section id="aligned">			
			<input type="text" name="title" id="title" placeholder="제목3" autocomplete="off" tabindex="0" class="txtinput">
			<input type="text" name="engineer" id="engineer" placeholder="받을 사람" autocomplete="off" tabindex="0" class="txtinput">
			<input type="text" name="cc" id="cc" placeholder="참조" autocomplete="off" tabindex="0" class="txtinput">
			<input type="text" name="tag" id="tag" placeholder="카테고리(Tag)" autocomplete="off" tabindex="0" class="txtinput">
			<input type="text" name="file" id="file" placeholder="첨부 파일" autocomplete="off" tabindex="0" class="txtinput">
			<textarea  class="txtblock" rows="5" placeholder="새 글" name="contents" tabindex="0"> </textarea>
			</section>
		</div>
		<!-- section id="buttons">
			<input type="reset" name="reset" id="resetbtn" class="resetbtn" value="다시 작성">
			<input type="submit" type="button" name="submit" id="submitbtn" class="submitbtn" tabindex="7" value="신규 등록" onclick="Completeclick();">
			<br style="clear:both;">
		</section-->
		<section id="buttons">
			<input type="submit" name="submit" id="submitbtn" class="submitbtn" tabindex="0" value="신규 등록">
			
		</section>
		</form>
	</section>

</body>
</html>