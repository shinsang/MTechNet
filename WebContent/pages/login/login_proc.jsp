<%@page import="com.sun.xml.internal.fastinfoset.util.StringArray"%>
<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.UserVO,com.mocomsys.mtech.dao.UserDAO"%>
<%
    // �α��� ���� ����
    String loginMsg = "";
    
    // login.jsp�κ��� form data�� �޴´�
    String id = request.getParameter("id");
    String pwd = request.getParameter("password");
    String userName ="";
    
    DataAccess da = new DataAccess();
	da.setDBProperty();
	da.connectionJDBC();
    
    try {
    	if(id == null || id == ""){
        	loginMsg = "ID�� �Է��� �ּ���";
        }else if(pwd == null || pwd == ""){
        	loginMsg = "��й�ȣ�� �Է��� �ּ���";
        }else{
    		UserVO uvo = new UserVO();
    		UserDAO udao = new UserDAO(da.getConnection());
    		String Result = udao.userCheck(id, pwd);
    		String[] SA = Result.split("%");	  
    		
    	    if(SA[0].equals("1"))   {	    	
    	    	userName = SA[1];
    	        session.setAttribute("id", id);
    	        session.setAttribute("name", userName);
    	        
    	        loginMsg ="����";      
    	    }
    	    else if(SA[0].equals("0"))   {
    	        loginMsg ="�α��� ����";
    	    }else{
    	    	loginMsg ="���� ���̵� �Դϴ�.";
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