<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.UserVO,com.mocomsys.mtech.dao.UserDAO"%>
<%
	System.out.println("-------------login_proc--------");
    // 로그인 정보 설정
    String loginMsg = "";
    String redirectURI ="";
    
    // login.jsp로부터 form data를 받는다
    String id = request.getParameter("id");
    String pwd = request.getParameter("password");
    System.out.println("login_proc id = "+id);
    System.out.println("login_proc pwd = "+pwd);
    if(id == null || id == ""){
    	loginMsg = "ID를 입력해 주세요";
    }else if(pwd == null || pwd == ""){
    	loginMsg = "비밀번호를 입력해 주세요";
    }else{
	    DataAccess da = new DataAccess();
		da.setDBProperty("ORACLE", "orcl", "10.10.11.139", "1521", "mocomsys", "mocomsys");
		da.connectionJDBC();
	
		UserVO uvo = new UserVO();
		UserDAO udao = new UserDAO(da.getConnection());
		int userCheckResult = udao.userCheck(id, pwd);
	    
		redirectURI  = request.getParameter("redirectURI");
	    // id, pwd가 맞을 경우 실행
	    if(userCheckResult == 1) 
	    {
	        session.setAttribute("id", id);
	        loginMsg ="성공";
// 	        response.sendRedirect("../../index.html"); // index.html 에 session 정보를 보낸다
	        
	    }
	    else if(userCheckResult == 0)
	    {
	        loginMsg ="로그인 실패";
	       // response.sendRedirect("./main.jsp");
	    }else{
	    	loginMsg ="없는 아이디 입니다.";
	    }
    }
    
    System.out.println("login_proc redirectURI = "+redirectURI);
    System.out.println("login_proc loginMsg = "+loginMsg);
%>

<%=redirectURI%>*<%=loginMsg%>