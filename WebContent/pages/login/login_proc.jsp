<%@ page contentType="text/html;charset=EUC-KR"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.UserVO,com.mocomsys.mtech.dao.UserDAO"%>
<%
	System.out.println("-------------login_proc--------");
    // �α��� ���� ����
    String loginMsg = "";
    String redirectURI ="";
    
    // login.jsp�κ��� form data�� �޴´�
    String id = request.getParameter("id");
    String pwd = request.getParameter("password");
    System.out.println("login_proc id = "+id);
    System.out.println("login_proc pwd = "+pwd);
    if(id == null || id == ""){
    	loginMsg = "ID�� �Է��� �ּ���";
    }else if(pwd == null || pwd == ""){
    	loginMsg = "��й�ȣ�� �Է��� �ּ���";
    }else{
	    DataAccess da = new DataAccess();
		da.setDBProperty("ORACLE", "orcl", "10.10.11.139", "1521", "mocomsys", "mocomsys");
		da.connectionJDBC();
	
		UserVO uvo = new UserVO();
		UserDAO udao = new UserDAO(da.getConnection());
		int userCheckResult = udao.userCheck(id, pwd);
	    
		redirectURI  = request.getParameter("redirectURI");
	    // id, pwd�� ���� ��� ����
	    if(userCheckResult == 1) 
	    {
	        session.setAttribute("id", id);
	        loginMsg ="����";
// 	        response.sendRedirect("../../index.html"); // index.html �� session ������ ������
	        
	    }
	    else if(userCheckResult == 0)
	    {
	        loginMsg ="�α��� ����";
	       // response.sendRedirect("./main.jsp");
	    }else{
	    	loginMsg ="���� ���̵� �Դϴ�.";
	    }
    }
    
    System.out.println("login_proc redirectURI = "+redirectURI);
    System.out.println("login_proc loginMsg = "+loginMsg);
%>

<%=redirectURI%>*<%=loginMsg%>