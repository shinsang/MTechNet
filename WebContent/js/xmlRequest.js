//xmlRequest.js
var xhr;
function setXMLHttpRequest(){
	if(window.ActiveXObject){//���������� IE���
	   try{
		   xhr=new ActiveXObject("Msxml2.XMLHTTP");
	   }catch(e){
		   xhr=new ActiveXObject("Microsoft.XMLHTTP");
	   }
	}else if(window.XMLHttpRequest){//Ÿ���������
		xhr=new XMLHttpRequest();
	}else{//XMLHttpRequest��ü�� �������� �ʴ� ���������
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
	xhr.open(httpMethod, httpURL, true);//��û���, ��ûURL, �񵿱�
	
	xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	xhr.onreadystatechange=callback;
	
	xhr.send(httpMethod=='POST'? httpParams : null);
}//sendRequest









