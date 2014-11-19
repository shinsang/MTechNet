<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.database.UserInfoVO,com.mocomsys.mtech.database.UserResult"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>SalesForce Menu</title>
<script type="text/javascript">
<!--
function deleteAll()
{
    var deleteAll = confirm("정말 삭제 하시겠습니까?");
    if(deleteAll == true)
    {
        window.open("./userinfoDeleteAll.jsp", "", "width=1, height=1, status=1");
    }
}

function bulkInsertUserInfo()
{
    window.open("./bulkInsertUserInfo.jsp", "", "width=1, height=1, status=1");
}
//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="../../css/style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../js/default.js">
</script>



</head>
<body>

<%
	request.setCharacterEncoding("utf-8");
String search = request.getParameter("search");
%>
결과 :<%=search%>
	<%
		DataAccess da = new DataAccess();
		da.setDBProperty("ORACLE", "orcl", "10.10.11.139", "1521", "mocomsys", "mocomsys");
		da.connectionJDBC();

		ArrayList<UserInfoVO> uivoList = new ArrayList<UserInfoVO>();
		UserResult uir = new UserResult(da.getConnection());
		uivoList = uir.getAllUserInfoList();
	%>
<center>
	<center><b><font size='4' color='blue'>조치 리스트</font></b></center>
<table width="1000" cellspacing="0" border="1" class="tbl02" cellpadding="0" bordercolorlight="#B5B5B5" bordercolordark="#FFFFFF" frame="below">
  <tr>

	<td width="30"  class="tt01">순서</td>
    <td width="50"  class="tt01">ID</td>
    <td width="80"  class="tt01">이름</td>
    <td width="60"  class="tt01">비밀번호</td>
  	<td width="60"  class="tt01">핸드폰</td>
  	<td width="60" class="tt01">이메일</td>
  	<td width="80" class="tt01">성질</td>
  	<td width="80" class="tt01">상태</td>
  	<td width="80" class="tt01">보기</td>
  </tr>
  <%
  	String getParam = "";
      String tdBgColor = "";
      int count = 1;
      for (UserInfoVO uivo : uivoList)
      {
          getParam = "ID=" + uivo.getId();
          System.out.println("NAME = "+uivo.getName());
          System.out.println("PHONE_NUM = "+uivo.getPhone_num());
  %>
  <tr>
    <td height="22" bgcolor='<%=tdBgColor%>'><%=count%></td>
    <td bgcolor='<%=tdBgColor%>'><b><%=uivo.getId()%></b></td>
  	<td bgcolor='<%=tdBgColor%>'><b><%=uivo.getName()%></b></td>
  	<td bgcolor='<%=tdBgColor%>'><b><%=uivo.getPassword()%></b></td>
  	<td bgcolor='<%=tdBgColor%>'><b><%=uivo.getPhone_num()%></b></td>
  	<td bgcolor='<%=tdBgColor%>'><b><%=uivo.getEmail()%></b></td>
  	<td bgcolor='<%=tdBgColor%>'><b><%=uivo.getProperty()%></b></td>
  	<td bgcolor='<%=tdBgColor%>'><b><%=uivo.getStatus()%></b></td>
  	<td bgcolor='<%=tdBgColor%>'><b><a href="javascript:;" onClick="window.open('./MtechInfoRegister.jsp?<%=getParam%>','','width=420,height=580,toolbar=no,location=no,menubar=no, scrollbars=1');return false;"><font color='blue'><%="보기"%></font></a></b></td>
  </tr>

  <%
  count++;
  }

  da.closeConnection();
  %>
</table><br>
</br>
</center>
</body>
</html>