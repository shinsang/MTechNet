<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
		<title>TechNet Join</title>
		<meta name="author" content="매력대리's">
		<link rel="shortcut icon" href="http://static02.join_techNet.com/logo/hkdc/favicon.ico">
		<link rel="icon" href="../../img/join/mLogo.png">
		<script src="js/ajax.js" type="text/javascript"></script>
		<script src="js/jquery-1.11.1.js"></script>		
</head>
<body>
<script src="js/ajax.js" type="text/javascript" charset="utf-8"></script>
		<script>
		
		function total_check(){
			check_name();
			if(document.getElementById("check_value").value=='1'){
				check_email();
			}else 
				return 0;
			if(document.getElementById("check_value").value=='1'){
				check_phone();
			}else 
				return 0;
			
			insert_User();
			loadIndexBody();
		}
		function insert_User(){
			//alert('insert_user()');
			var id=document.getElementById("id").value;
			var pass=document.getElementById("passWord1").value;
			var name=document.getElementById("name").value;
			var email=document.getElementById("email").value;
			var phone=document.getElementById("telephone").value;
			var recipient=document.getElementById("recipient").value;
			
			var params="id="+id;
			params=params+"&"+"pass="+escape(encodeURIComponent(pass));
			params=params+"&"+"name="+escape(encodeURIComponent(name));
			params=params+"&"+"email="+escape(encodeURIComponent(email));
			params=params+"&"+"phone="+escape(encodeURIComponent(phone));
			params=params+"&"+"recipient="+escape(encodeURIComponent(recipient));
			
			sendRequest("pages/join/insertUser.jsp",params,function InsertUser(){	
				if(httpRequest.readyState==4){
					if(httpRequest.status==200){
						var returnCount=httpRequest.responseText.trim();
						if(returnCount==1){
							alert('회원가입 성공');
							return 1;
						}else{
							alert('회원가입 실패');
							return 0;
						}
					}
				}
			},"GET");}
		
		function check_phone(){
			var telephone=document.getElementById("telephone").value;
			if(telephone.trim().length==0){
				alert('연락처를 기입해주세요.');
				$('#telephone').focus();
				document.getElementById("check_value").value='-1';
				return 0;
			}
			document.getElementById("telephone").value=telephone.replace('-','');
			document.getElementById("check_value").value='3';
			alert('ok');
		}
		
		function check_name(){
			var name=document.getElementById("name").value;
			if(name.trim().length==0){
				alert('이름을 입력해주세요.');
				$('#name').focus();
				document.getElementById("check_value").value='-1';
				return 0;
			}
			document.getElementById("check_value").value='1';
		}
		
		
		function check_email(){
			
			var email=document.getElementById("email").value;
			if(email.trim().length==0){
				alert('올바른 email을 입력해주세요.');
				
				document.getElementById("check_value").value='-1';
				$('#email').focus();
				return 0;
			}
			var index=email.indexOf('@');
			if(index>0 & index<email.length){
				document.getElementById("check_value").value='1';
			}
			
			else{
				alert('올바른 email을 입력해주세요.');
				document.getElementById("check_value").value='-1';
				$('#email').focus();
			}
		}
		
		
		function check_password(){
			var pass1=document.getElementById("passWord1").value;
			var pass2=document.getElementById("passWord2").value;
			
			if(pass1.trim().length==0 || pass2.trim().length==0  ){
				alert('Password 값은 공백일 수 없습니다.');
				document.getElementById("passWord1").value='';
				document.getElementById("passWord2").value='';
				$('#passWord1').focus();
				return 0;
			}
			if( pass1 == pass2){				
				document.getElementById("passWord1").setAttribute("readonly","readonly");
				document.getElementById("passWord2").setAttribute("readonly","readonly");
				document.getElementById("name").removeAttribute("readonly",0);
				document.getElementById("email").removeAttribute("readonly",0);
				document.getElementById("telephone").removeAttribute("readonly",0);
				$('#name').focus();
				document.getElementById("submitbtn").removeAttribute("disabled",0);
				return 1;
			}else{
				alert('Password 값이 같지 않습니다.');
				document.getElementById("passWord2").value='';
				$('#passWord2').focus();
				return 0;
			}
				
		}

		function check_id(){
			var id=document.getElementById("id").value;			
			if(id.trim().length==0){
				alert('ID 값은 공백일수 없습니다.');
				$('#id').focus();
				return 0;
			}
			
			var dataString="id="+id;	
		
			$.ajax({
				url:'pages/join/check_id.jsp',
				type:"GET",
				data:dataString,
				dataType:"text",
				success:function(data) {	
					var id_count =  data.trim();
					if(id_count==0){
						alert('사용가능한 아이디 입니다. 비밀번호를 입력해주세요.');
						document.getElementById("id").setAttribute("readonly","readonly");
						document.getElementById("passWord1").removeAttribute("readonly",0);
						document.getElementById("passWord2").removeAttribute("readonly",0);
						
						$('#passWord1').focus();
						return 1;
					}else{
						alert('중복된 ID 입니다.');
						document.getElementById("id").value='';
						$('#id').focus();
						return 0;
					}
				},
				error:function() {
					alert("실패");
				}
			});
		}
		
		function total_reset()
		{
			document.getElementById("join_techNet-form").reset();
		}
		</script>
	<section id="container">
		<h2>Mocomsys TechNet 회원가입</h2>
		<input type="hidden" id="check_value" value=''>
		<div id="wrapping" class="clearfix">
			<form name="join_techNet" id="join_techNet-form" method="post" action="#">		
				<section id="aligned">
					<input type="button" id="confirmID" class="btninput" value="중복확인" onclick="check_id()"/>
					<input type="text" name="id" id="id" placeholder="Your ID" autocomplete="off" tabindex="1" class="txtinput" >
					<input type="password" name="passWord1" id="passWord1" placeholder="Write your password" autocomplete="off" tabindex="1" class="txtinput" readonly>
					<input type="button" id="confirmID" class="btninput" value="확인" onclick='check_password()' readonly/>
					<input type="password" name="passWord2" id="passWord2" placeholder="Confirm your password" autocomplete="off" tabindex="1" class="txtinput" readonly>
					<input type="text" name="name" id="name" placeholder="Your name" autocomplete="off" tabindex="1" class="txtinput" readonly>
					<input type="email" name="email" id="email" placeholder="Your e-mail address" autocomplete="off" tabindex="2" class="txtinput" readonly>
					<input type="tel" name="telephone" id="telephone" placeholder="Phone number?(optional)" tabindex="4" class="txtinput" readonly>
				</section>			
			</form>
			<section id="aside" class="clearfix">
				<section id="recipientcase">
				<h3>Recipient:</h3>				
					<select id="recipient" name="권한설정" tabindex="5" class="selmenu">
  						<option value="partner">파트너 고객사</option>
  						<option value="employee">직원</option> 
  						<option value="manager">운영진</option>
  						<option value="admin">사이트관리자</option>
					</select>
				</section>				
				<section id="prioritycase">
					<h3>Enter support code:</h3>					
						<input type="text" style="width: 48%" name="supportCode" id="code" placeholder="Support code" autocomplete="off" tabindex="1" class="txtinput">
				</section>
			</section>
		</div>
		<section id="buttons">
			<input type="button" name="reset" id="resetbtn" class="resetbtn" value="다시 작성" onclick="total_reset();">
			<input type="submit" name="submit" id="submitbtn" class="submitbtn" tabindex="7" value="회원 가입" onclick="total_check()" disabled>
			<br style="clear:both;">
		</section>
	</section>

</body>
</html>