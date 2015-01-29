<%@ page language="java" contentType="text/html;charset=euc-kr"%>
<%@ page
	import="com.mocomsys.mtech.database.DataAccess,com.mocomsys.mtech.dao.UserDAO,java.sql.Connection,java.util.ArrayList,com.mocomsys.mtech.vo.UserVO"%>
<html>
<head>
<title>Business Register</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../css/style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../js/default.js"></script>

<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>
<body>
	<%
		String USER_ID = "";
		  String USER_NAME = "";
		  String USER_PASSWORD = "";

		  DataAccess da = new DataAccess();
			da.setDBProperty("ORACLE", "orcl", "10.10.11.139", "1521", "mocomsys", "mocomsys");
			da.connectionJDBC();

		  if((String)request.getParameter("ID") != null)
		  {
		      USER_ID = (String)request.getParameter("ID");

			    UserDAO uir = new UserDAO(da.getConnection());
			    UserVO uivo = new UserVO();
			    uivo = uir.getUserInfoByID(USER_ID);

			    USER_NAME = uivo.getName();
			    USER_PASSWORD = uivo.getPassword();
		      String space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp";

		  }
	%>
<!-- 	<center> -->
		<font size='4' color='blue'></font>
		<form action="./IBKinfoRegisterResult.jsp" method="post"
			name="search" onsubmit="">
			<table width="400" height="550">

				<td background="../../images/phone.jpg"><font size='3' style="line-height:1.4" face=돋움><br><%=USER_NAME%></font></td>

			</table>
<!-- 	</center> -->
</body>
</html>
