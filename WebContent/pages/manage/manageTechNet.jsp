<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<!-- BOOTSTAP 소스 -->
	<script src="js/bootstrap.js"></script>	
	<link rel="stylesheet" href="css/bootstrap.css">



	
</head>
<body>
<script>
	 function getAgoDate(yyyy, mm, dd)
	 {
	  var today = new Date();
	  var year = today.getFullYear();
	  var month = today.getMonth();
	  var day = today.getDate();
	  
	  var resultDate = new Date(yyyy+year, month+mm, day+dd);
	  
	  
	        year = resultDate.getFullYear();
	        month = resultDate.getMonth() + 1;
	        day = resultDate.getDate();

	        if (month < 10)
	            month = "0" + month;
	        if (day < 10)
	            day = "0" + day;

	        return year + "" + month + "" + day;
	 }
		function searchTagByDate(){
			
			var sDate=document.getElementById('startDate').value.trim();
			var eDate=document.getElementById('endDate').value.trim();
			if (sDate.length!=8|| eDate.length!=8){
				alert('시작일과 종료일이 적당하지 않아, \n오늘날짜로 검색을 합니다.\n형식) YYYYMMDD');
				var sDate=getAgoDate(0,0,0);
				var eDate=getAgoDate(0,0,0);
				document.getElementById('startDate').value=sDate ;
				document.getElementById('endDate').value=eDate ;
			}
			var params="sdate="+sDate;
			params=params+"&edate="+eDate;
			
			$.ajax({
				url:'pages/manage/getTagByDate_graph.jsp',
				type:"GET",
				data:params,
				dataType:"text",
				success:function(data) {

					var result=data.trim();					
					document.getElementById('graphTag').innerHTML=result;		
				},
				error:function() {
					alert("실패");
				}				
			});	
					
		}
		function searchTagByName(){
			
			var params="";
			
			$.ajax({
				url:'pages/manage/getTagAll_graph.jsp',
				type:"GET",
				data:params,
				dataType:"text",
				success:function(data) {

					var result=data.trim();					
					document.getElementById('graphTag').innerHTML=result;		
				},
				error:function() {
					alert("실패");
				}				
			});
			
			
		}
		</script>
<table>
  <tr>
  	<th colspan="2" class="success"><input type="button" value="기간별 검색" onclick="searchTagByDate()">     
  	<input type="text" id="startDate" style="width:25%;" value="" placeholder="시작일 _YYYYMMDD">
  	<input type="text" id="endDate"  value="" style="width:25%;" placeholder="종료일 _YYYYMMDD">  	
  	</th>
  </tr>
  <tr>
  	<th colspan="2"><input type="button" value="Tag 별 검색" onclick="searchTagByName()"></th>
  </tr>
   </table>
   
   <br><br>
 <div id='table_contents'></div>
 
 <DIV class="progress-box progress-box-default" id='graphTag'>

</DIV>
</body>
</html>
