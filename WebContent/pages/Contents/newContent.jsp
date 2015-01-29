<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  	<meta name="author" content="매력대리's">
<script>

		$(document).ready(function() {
			loadAskQuestionBody();			
		});
			
			
		var userDb = function (){
// 			var user = ['shinsang','a','mocomsys','USER001','USER002'];
			var user = [];
			$.ajax({
				url:'pages/Contents/user_select.jsp',
				type:'post',
				timeout:1000,
				data:"",
				dataType:'text',
				async:false,
				success:function(result) {
					user = result.split(',');
					
				},
				error:function() {
					alert("userDb 실패 하였습니다.");
				}				
			});
// 			alert(user);
			return user;
		}
		
		var tagDb = function (){
			var tag = [];
			$.ajax({
				url:'pages/Contents/tag_select.jsp',
				type:'post',
				timeout:1000,
				data:"",
				dataType:'text',
				async:false,
				success:function(result) {
					tag = result.split(',');
					
				},
				error:function() {
					alert("tagDb 실패 하였습니다.");
				}				
			});
			return tag;
		}
			
			
		function receivePersonClick(){
			//var userName = ['shinsang','a','mocomsys','USER001','USER002'];
			$('#ar_engineer').tokenfield({
				autocomplete: {
				source: userDb(),
			    delay: 100
				  },
				  showAutocompleteOnFocus: true,
				  delimiter: ',',
				  beautify: true,
				  createTokensOnBlur: true
		    });
		}
		
		function referencePersonClick(){
			//var userName = ['shinsang','a','mocomsys','USER001','USER002'];
			$('#ar_cc').tokenfield({
				autocomplete: {
				source: userDb(),
			    delay: 100
				  },
				  showAutocompleteOnFocus: true,
				  delimiter: ',',
				  beautify: true,
				  createTokensOnBlur: true
		    });
		}
		
		function categoryTagClick(){
			//var userName = ['MTE','MI','VITRIA','IFM'];
			$('#ar_tag').tokenfield({
				autocomplete: {
				source: tagDb(),
			    delay: 100
				  },
				  showAutocompleteOnFocus: true,
				  delimiter: ',',
				  beautify: true,
				  createTokensOnBlur: false
		    });
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
		
		function SubmitFormData(Contentsstatus) {			
			var userId = document.getElementById("loginUserId").value;
			
			var dataString = $("#newArticleForm").serialize() + "&userId="+userId + Contentsstatus;
			//alert(dataString);
			
			$.ajax({
				url:'pages/Contents/newContent_insert.jsp',
				type:'post',
				timeout:1000,
				data:dataString,
				dataType:'text',
				async:false,
				success:function() {
					alert("문의 등록에 성공 하였습니다.");
					loadAskQuestionBody();
				},
				error:function() {
					alert("문의 등록에 오류가 발생했습니다.");
				}				
			});
			return true;
		}		

		function Normalclick() {
			var status = "&contentStatus=0"
			if(CheckInputData() == true) {
				SubmitFormData(status);
				return true;
			}
			return false;
  		};
  		
  		function Emergencyclick() {
  			var status = "&contentStatus=1"
			if(CheckInputData() == true) {
				SubmitFormData(status);
				return true;
			}
			return false;
  		};
  		
  		function ResetFormData() {
  			//alert("데이터 리셋");
  			document.getElementById("newArticleForm").reset(); 			
  			
  			$('#newArticleForm').on('reset', function (evt) {
  				// input 데이터를 지워버리는 로직 삽입.
  				alert("이벤트 발생");  		        
  		    });
  			
  			return true;
  		}
  		
  		function loadAskQuestionBody()	{
			$('#NewWriteMainBody').load('pages/view/AskQuestionsBody.html #AskQuestionsBody');
		}
		
		function loadDataRegisterBody()	{
			$('#NewWriteMainBody').load('pages/view/DataRegisterBody.html #DataRegisterBody');
		}
		
		function loadEtcBody()	{
			$('#NewWriteMainBody').load('pages/view/EtcBody.html #EtcBody');
		}
  		
</script>
</head>
<body>
<div class="smallContainer">
<section id="ar_container">
<br><br>
<div class="btn-group pull-right">
  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">Content Type  <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" role="menu">
    <li><a href="#" onclick="loadAskQuestionBody();">Ask Question</a></li>
    <li><a href="#" onclick="loadDataRegisterBody();">Data register</a></li>
    <li><a href="#" onclick="loadEtcBody();">Etc</a></li>    
  </ul> 
</div>
<br>
<br>
<hr>
<div id="NewWriteMainBody">

</div>	
</section>
</div>
<!-- <script type="text/javascript" src="//code.jquery.com/ui/1.9.2/jquery-ui.js"></script> -->
</body>
</html>
