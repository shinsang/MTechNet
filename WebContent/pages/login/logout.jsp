<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.database.DataAccess, java.sql.Connection, java.util.ArrayList,com.mocomsys.mtech.vo.UserVO,com.mocomsys.mtech.dao.UserDAO"%>

<% session.invalidate(); %>

<script type="text/javascript">
function hostoryBack(){
history.back();
}
</script>
<script>
location.href="../../index.jsp";
</script>