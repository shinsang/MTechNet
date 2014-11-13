//xmlRequest.js
var xhr;
function setXMLHttpRequest(){
	if(window.ActiveXObject){//현브라우저가 IE라면
	   try{
		   xhr=new ActiveXObject("Msxml2.XMLHTTP");
	   }catch(e){
		   xhr=new ActiveXObject("Microsoft.XMLHTTP");
	   }
	}else if(window.XMLHttpRequest){//타브라우저라면
		xhr=new XMLHttpRequest();
	}else{//XMLHttpRequest객체를 지원하지 않는 브라우저라면
		xhr=null;
	}
}//setXMLHttpRequest

function sendRequest(url, params, callback, method){
	setXMLHttpRequest();
	var httpMethod = method ? method : 'GET';
	if(httpMethod != 'GET' && httpMethod != 'POST'){
		httpMethod='GET'
	}
	var httpParams = (params==null || params=='') ? null : params;
	var httpURL = url
	if(httpMethod =='GET' &&  httpParams !=null ){
		httpURL = httpURL+"?"+httpParams;
	}	
	xhr.open(httpMethod, httpURL, true);//요청방식, 요청URL, 비동기
	
	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xhr.onreadystatechange=callback;
	
	xhr.send(httpMethod=='POST'? httpParams : null);
}//sendRequest









