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








