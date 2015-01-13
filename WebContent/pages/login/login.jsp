<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.UserVO,com.mocomsys.mtech.dao.UserDAO"%>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <title>MTechNet Login</title>
  <meta name="author" content="매력대리's">
  <link rel="shortcut icon" href="http://static02.login_techNet.com/logo/hkdc/favicon.ico">
  <link rel="icon" href="../../img/join/mLogo.png">
  <link rel="stylesheet" type="text/css" media="all" href="../../stylesheets/login/login_styleSheet.css">
  <link rel="stylesheet" type="text/css" media="all" href="../../stylesheets/login/login_responsive.css">
  <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/ui-darkness/jquery-ui.css" type="text/css" media="all" />
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#layer_ajax").hide();
		$("#layer_ajax").ajaxStart(function(){
			$("#wait").css("display","block");
		});
	 	$("#layer_ajax").ajaxComplete(function(){
			$("#wait").css("display","none");
		});
		$("#layer_ajax").ajaxError(function(){
			alert("통신 애러");
		});
		$("#confirmID").click(function(e){
			//아래 코드 실행
			 var dataString = $("#login_techNet-form").serialize();
			//form 과 직렬화..
			$.ajaxSetup({
				url:"login_proc.jsp",		 
				data : dataString,  // 넘겨질 데이타 
			    type: "POST",
				success:function(result) {	
					var arr_data = trim(result).split("*");
					var loginMsg= arr_data[0];
					
					if((loginMsg)=="성공"){
						var userId = arr_data[1];
						var userName = arr_data[2];	
							
						localStorage.removeItem("userId"); // 먼저 해당 데이터 중복을 위해 속성 값 날림
						localStorage.removeItem("userName"); // 먼저 해당 데이터 중복을 위해 속성 값 날림
						localStorage.setItem("userId", userId);
						localStorage.setItem("userName", userName);
						
						alert("Login Success - Login Id : "+localStorage["userId"]+", Login Name : "+ localStorage["userName"]);							
						location.href="../../index.jsp?userId=" + userId;
					}else{
						console.log("Login Fail - loginMsg : "+loginMsg);
					}
	
					// 받아온 메세지 전달 (실패 메세지..)
					$("#layer_ajax").html("<p style='color:red'>"+loginMsg+"</p>");
					// 실패면 패스워드 데이타 지우고 포커스 이동
					$("input[name=password]").val('');
					$("input[name=password]").focus(); 
				}		 
			});	 
			 
			$.ajax();
			$("#layer_ajax").show();		
		}); 
});
	// 공백 제거 	
	function trim(txt)
	{
	 return txt.replace(/(^\s*)|(\s*$)/g, "");
	}
</script>
</head>

<body>
	<%System.out.println("---------------------login.jsp---------------"); %>
	
	<!-- 로그인 전에 url 을 전달하기 위해 히든으로 url 받아둔다 -->
<%-- 	<input type="hidden"  name="redirectURI"  value="<%=(request.getAttribute("redirectURI"))==null?"/":request.getAttribute("redirectURI")%>" > --%>
	
	<section id="container">
		<span class="chyron"><em><a href="../../index.jsp">&laquo; 뒤로</a></em></span>
		<h2>Mocomsys TechNet 로그인</h2>
		<form name="loginFrm" id="login_techNet-form" method="post">
			<div id="wrapping" class="clearfix">
				<section id="aligned">
				<input type="text" name="id" id="id" placeholder="ID 입력" autocomplete="off" tabindex="1" class="txtinput">
				<input type="password" name="password" id="passWord" placeholder="암호 입력" autocomplete="off" tabindex="1" class="txtinput">
				<div id="layer_ajax"></div>
				<input type="button" id="confirmID" class="btninput" tabindex="1" value="로그인">
				</section>
			<div id="layer_ajax"></div>
			</div>
		</form>
		<div>
		<span class="chyron"><em><a href="../join/JoinTechNet.html">&laquo; 회원가입</a></em></span>
		</div>
	</section>
	

</body>
</html>