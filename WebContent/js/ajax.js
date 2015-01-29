//ajax.js
/*
var ajax = new Object();
ajax.Request = function(){

}
ajax.Request.prototype={
   key:value,
   gildong:function(){}
} 
*/
var ajax={};//ajax��Ű������
ajax.xhr={};//ajax.xhr��Ű������

ajax.xhr.Request=function(url,params,callback,method){
	this.url=url;
	this.params=params;
	this.callback=callback;
	this.method=method;
	this.send();
};

ajax.xhr.Request.prototype={
   getXMLHttpRequest:function(){
	  if(window.ActiveXObject){//�������� IE���
		   try{
			   return new ActiveXObject("Msxml2.XMLHTTP");
		   }catch(e){
			   return new ActiveXObject("Microsoft.XMLHTTP");
		   }
		}else if(window.XMLHttpRequest){//Ÿ��������
			 return new XMLHttpRequest();
		}else{//XMLHttpRequest��ü�� �������� �ʴ� ��������
			return null;
		}
   }//setXMLHttpRequest
  ,
   send:function(){	  
      this.req= this.getXMLHttpRequest();
	  var httpMethod = this.method ? this.method : 'GET';
		if(httpMethod != 'GET' && httpMethod != 'POST'){
			httpMethod='GET';
		}
		var httpParams = (this.params==null || this.params=='') ? null : this.params;
		var httpURL = this.url;
		if(httpMethod =='GET' &&  httpParams !=null ){
			httpURL = httpURL+"?"+httpParams;
		}	
		this.req.open(httpMethod, httpURL, true);//��û���, ��ûURL, �񵿱�
		
		this.req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		
		var request=this;
		this.req.onreadystatechange=function(){
			request.onStateChange.call(request);
			//�Լ���.call --> �ش��Լ�ȣ��
		};
		
		this.req.send(httpMethod=='POST'? httpParams : null);
   }//send
   ,
   onStateChange:function(){
	   this.callback(this.req);
	   //this.callbackȣ�� --> callback�Ӽ��� ���ǵ� �Լ�ȣ��
	   
	   //RequestŬ���� ��ü���ϸ� �Ķ���ͷ� ���� callback�Լ��� ȣ���Ѵ�!!
	   //ȣ���� �ϸ鼭 this.req�� ����Ѵ�!! (this.req==XMLHttpRequest��ü)
   }
  
};//prototype


var xhr = null;

// 브라우저를 구별하여 xhr 객체를 생성하는 함수

function getRequest(){
	if(window.ActiveXObject)
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	else
		xhr = new XMLHttpRequest();
}

// 사용자가 서버를 호출할 때 사용하는 함수

function sendRequest(url, param, callback, method, async){
	// ( 요청경로, 인자, 도착함수, 전송방식, 비동기식여부 )
	getRequest();
	
	// 전송방식 문자열을 받아서 소문자로 변경 후 "get"과 비교한다.
	// 만약! "get"이면 "GET"으로 변경하고, 아니면 "POST"로 변경
	method = (method.toLowerCase() == "get") ? "GET":"POST";
	
	// 요청방식에 따라 파라미터의 URL이 달라진다.
	// 예를 들면 get방식일 때는 URL이 "test.jsp?v1=java"
	// post방식일 때는 "test.jsp"
	
	param = (param == null || param == "") ? null : param;
	
	if(method == "GET" && param != null){
		url = url + "?" + param;
	}


	xhr.onreadystatechange = callback; // 서버의 응답이 도착하는 함수지정
	xhr.open(method, url, async); // 요청정보 지정
	
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	// 서버 요청 보내기
	xhr.send( (method == "POST") ? param : null);
}


ajax.Event = {}; 
ajax.Event.addListener = function(element, name, observer, useCapture) { 
	useCapture = useCapture || false; 
	if (element.addEventListener) { 
		element.addEventListener(name, observer, useCapture); 
	} else if (element.attachEvent) { 
		element.attachEvent('on' + name, observer); 
	} 
} 

ajax.Event.removeListener = function(element, name, observer, useCapture) { 
	useCapture = useCapture || false; 
	if (element.removeEventListener) { 
		element.removeEventListener(name, observer, useCapture); 
	} else if (element.detachEvent) { 
	element.detachEvent('on' + name, observer); 
	} 
} 




