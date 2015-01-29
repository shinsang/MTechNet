<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" 
	 import="java.util.*" %>	

   		<script src="../../js/dropkick.js" type="text/javascript" charset="utf-8"></script>
		<script src="../../js/ajax.js" type="text/javascript"></script>
		<script src="../../js/jquery-1.11.1.js"></script>
</head>
<body>
<%

	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	System.out.println("id = "+id +" // passwd = "+passwd);
	try {

		String driverName = "oracle.jdbc.driver.OracleDriver";	

		String url = "jdbc:oracle:thin:@10.10.11.139:1521:ORCL";	
		
		ResultSet rs = null;

	 

		Class.forName(driverName);

		Connection con = DriverManager.getConnection(url,"mocomsys","mocomsys");

	 	System.out.println("DB Conn Success");

		Statement stmt = con.createStatement();			

		String sql = "select count(*) from USER_INFO where USER_ID='"+id+"' and USER_PASSWORD = '"+passwd+"'";
		int rowcount=0;
		System.out.println("Sql = "+sql);
		
		rs = stmt.executeQuery(sql);
		 if(rs.next()) {
	         rowcount = rs.getInt(1);
	        }
		System.out.println("Row Count = "+rowcount);
		String[] someValue={rowcount+""};
		//new HashMap(request.getParameterMap()).put("count", someValue);
	    //out.println("<p>"+rowcount+"</p>");
	   
		rs.close();
		stmt.close();
		con.close();
		if(rowcount==1){
			session.setAttribute("id", id);
	        System.out.println("MOB Session 성공");
		}
		 out.println("<font color='black' id='loginResult'>"+rowcount+"</font>");          
	}catch (Exception e) {
		System.out.println(e.toString());
		out.print("fail");		

	}

%>