<%@page import="com.sun.xml.internal.fastinfoset.util.StringArray"%>
<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.UserVO,com.mocomsys.mtech.dao.UserDAO"%>
<%
	System.out.println("-------------login_proc--------");
    // �α��� ���� ����
    String loginMsg = "";
    
    // login.jsp�κ��� form data�� �޴´�
    String id = request.getParameter("id");
    String pwd = request.getParameter("password");
    String userName ="";
    
    System.out.println("login_proc id = "+id);
    System.out.println("login_proc pwd = "+pwd);
        
    if(id == null || id == ""){
    	loginMsg = "ID�� �Է��� �ּ���";
    }else if(pwd == null || pwd == ""){
    	loginMsg = "��й�ȣ�� �Է��� �ּ���";
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
	        
	        loginMsg ="����";      
	    }
	    else if(SA[0].equals("0"))   {
	        loginMsg ="�α��� ����";
	    }else{
	    	loginMsg ="���� ���̵� �Դϴ�.";
	    }
    }
    System.out.println(id+","+userName);
    System.out.println("login_proc loginMsg = "+loginMsg);
%>

<%=loginMsg%>*<%=id%>*<%=userName%> ,     