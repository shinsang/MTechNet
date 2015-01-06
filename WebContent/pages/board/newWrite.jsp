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
			var x = document.getElementById("submitbtn");
			
  		}
    </script>
    
</head>

<body>

	<section id="container">
		<h2>새글 등록</h2>
		<form name="join_techNet" id="join_techNet-form" >
		<div id="wrapping" class="clearfix">
			<section id="aligned">
			
			<input type="text" name="title" id="title" placeholder="제목(테스트)" autocomplete="off" tabindex="1" class="txtinput">
			<input type="text" name="engineer" id="engineer" placeholder="받을 사람" autocomplete="off" tabindex="1" class="txtinput">
			<input type="text" name="cc" id="cc" placeholder="참조" autocomplete="off" tabindex="1" class="txtinput">
			<input type="text" name="tag" id="tag" placeholder="카테고리(Tag)" autocomplete="off" tabindex="1" class="txtinput">
			<input type="text" name="file" id="file" placeholder="첨부 파일" autocomplete="off" tabindex="1" class="txtinput" readonly="true">
			<textarea  class="txtblock" rows="5" placeholder="새 글" name="contents"> </textarea>
			</section>
		</div>
		<section id="buttons">
			<input type="reset" name="reset" id="resetbtn" class="resetbtn" value="다시 작성">
			<input type="submit" type="button" name="submit" id="submitbtn" class="submitbtn" tabindex="7" value="신규 등록" onclick="Completeclick();">
			<br style="clear:both;">
		</section>
		</form>
	</section>

</body>
</html>