<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  	<meta name="author" content="매력대리's">  	
</head>
<body>
<script>
	// 차후 url에서 불러서 쓰는경우 사용할 예정.
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
	
	$(document).ready(function() {
		var userNamevalue = document.getElementById("loginUserName").value;    			
		//alert("검색 페이지 진입 ="+userNamevalue);
		
		location.href.replace("#", "")
		
		// 검색어 추출 및 검색창에 현재 검색어 다시 삽입.
		var searchString = document.getElementById("search").value;
		document.getElementById("search").value = searchString;
		
		var dataString = "search=" + searchString;		
		
		$.ajax({
			url:'pages/generator/SearchListGenerator.jsp',
			type:"POST",
			data:dataString,
			dataType:"text",
			success:function(data) {
				var mainContent = document.getElementById("mainContent");
				mainContent.innerHTML = data;			
			},
			error:function() {
				alert("검색 실패");
			}				
		});
		return true;
	});		
	
	function listFilter(obj)
	{
		var filterStatus = obj.value;
		
		var searchListResult = document.getElementById("searchResultTable");
		var tableLength = searchListResult.rows.length;
		
		if(tableLength > 1)
		{
			var idx;
			
			// 전체 row 보이도록 먼저 변경.
			TableRowVisiable(searchListResult);			
			if(filterStatus == "a") return true;
			
			for(idx=1 ;idx < tableLength; idx++) {
				var Tr = searchListResult.rows[idx];
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
	
	// 안쓰는 함수 모음
	function getUrlContentId()
	{
		var urlContentId = getParameter('contentId');
		if(typeof urlContentId != "undefined" && urlContentId != null) {
			return urlContentId;
		}
		return null;
	}
	
	function getUrlUserId()
	{
		var urlUserId = getParameter('userId'); 		
		if(typeof urlUserId != "undefined" && urlUserId != null) {
			return urlUserId;				
		}
		return null;
	}
	
	function getMoveUrlParameter(trContentId)
	{
		var urlParameter ="";
		var isReturnParamter = 0;
		
		var urlUserId = getUrlUserId();		
		
		if(urlUserId != null) {
			isReturnParamter++;
			
			urlParameter += "?";
			urlParameter += "userId=";
			urlParameter += urlUserId;
		}
		
		if(typeof trContentId != "undefined" && trContentId != null) {
			if(isReturnParamter == 0) urlParameter += "?";
			else urlParameter += "&";
			
			urlParameter += "contentId=";
			urlParameter += trContentId;	
			isReturnParamter++;
		}				
		if(isReturnParamter > 0) {
			return urlParameter;
		}
		return null;	
	}
</script>
<br><br>
<body> 
</body>
</html>