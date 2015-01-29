<%@page import="com.sun.xml.internal.fastinfoset.util.StringArray"%>
<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.UserVO,com.mocomsys.mtech.dao.UserDAO"%>
<%
    // 로그인 정보 설정
    String loginMsg = "";
    
    // login.jsp로부터 form data를 받는다
    String id = request.getParameter("id");
    String pwd = request.getParameter("password");
    String userName ="";
    
    DataAccess da = new DataAccess();
	da.setDBProperty();
	da.connectionJDBC();
    
    try {
    	if(id == null || id == ""){
        	loginMsg = "ID를 입력해 주세요";
        }else if(pwd == null || pwd == ""){
        	loginMsg = "비밀번호를 입력해 주세요";
        }else{
    		UserVO uvo = new UserVO();
    		UserDAO udao = new UserDAO(da.getConnection());
    		String Result = udao.userCheck(id, pwd);
    		String[] SA = Result.split("%");	  
    		
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
    	    da.closeConnection();
        }  	
    }catch (Exception e) {
		System.out.println(e.toString());
	}finally {
		try{
			if(da!=null){
				da.closeConnection();
				System.out.println("login_poc DA closeConnection Success!!");
			}
			
		}catch(Exception ee){
			System.out.println(ee.toString());	
		}
	}
    
    System.out.println("login_proc.jsp - result, loginMsg("+loginMsg + "), id=("+ id + "), userName=("+userName+")");
%>

<%=loginMsg%>*<%=id%>*<%=userName%>   