$(document).ready(function() {
 	 $('#writeBoard').click(function() {
 	 	$('#mainContent').load('html/board/newWrite.html');
 	 	return false;
 	 });
 	 $('#joinTechNet').click(function() {
 	 	alert('joinTechNet Clicked');
 	 	$('#mainContent').load('html/board/newWrite.html');
 	 	return false;
 	 });
  
 });
