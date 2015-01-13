<%@page import="com.sun.xml.internal.fastinfoset.util.StringArray"%>
<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.UserVO,com.mocomsys.mtech.dao.UserDAO"%>
<%
	System.out.println("-------------login_proc--------");
    // 로그인 정보 설정
    String loginMsg = "";
    
    // login.jsp로부터 form data를 받는다
    String id = request.getParameter("id");
    String pwd = request.getParameter("password");
    String userName ="";
    
    System.out.println("login_proc id = "+id);
    System.out.println("login_proc pwd = "+pwd);
        
    if(id == null || id == ""){
    	loginMsg = "ID를 입력해 주세요";
    }else if(pwd == null || pwd == ""){
    	loginMsg = "비밀번호를 입력해 주세요";
    }else{
	    DataAccess da = new DataAccess();
		da.setDBProperty();
		da.connectionJDBC();
	
		UserVO uvo = new UserVO();
		UserDAO udao = new UserDAO(da.getConnection());
		String Result = udao.userCheck(id, pwd);
		String[] SA = Result.split("%");	  
		System.out.println("Result = "+Result+",[0]:"+SA[0]+","+SA[1]);
		
	    if(SA[0].equals("1"))   {	    	
	    	userName = SA[1];
	        session.setAttribute("id", id);
	        session.setAttribute("name", userName);
	        
	        loginMsg ="성공";      
	    }
	    else if(SA[0].equals("0"))   {
	        loginMsg ="로그인 실패";
	    }else{
	    	loginMsg ="없는 아이디 입니다.";
	    }
    }
    System.out.println(id+","+userName);
    System.out.println("login_proc loginMsg = "+loginMsg);
%>

<%=loginMsg%>*<%=id%>*<%=userName%> ,     