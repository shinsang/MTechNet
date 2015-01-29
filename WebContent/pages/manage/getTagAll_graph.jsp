<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mocomsys.mtech.dao.ManageDAO,com.mocomsys.mtech.vo.ManageVO,java.util.*" %>
	<%
		request.setCharacterEncoding("utf-8");
		System.out.println("getTagAll.jsp");
		String progress1="progress-bar-s-info";
		String progress2="progress-bar-s-success";
		String progress3="progress-bar-s-warning";
		String progress4="progress-bar-s-danger";
		String progress5="progress-bar-s-grey";
		
		ManageDAO mdao=new ManageDAO();
		ArrayList<ManageVO> alm=mdao.getTagAll();
		int arraySize=alm.size();
		int totalCount=0;
		for(int i=0;i<arraySize;i++){
			totalCount+=Integer.parseInt(alm.get(i).getCount().trim());
		}
		
		for(int i=0;i<arraySize;i++){
			String tagName=alm.get(i).getTagName().trim();
			int count=Integer.parseInt(alm.get(i).getCount().trim());
			
			switch((i+1)%5){
				case 1:
					
					%>
					<DIV class=progress-heading><%=tagName%> ( <%=count*100/ totalCount%> % ) - <%=count%> EA</DIV>
						 <DIV class=progress-small>
					         <DIV role=progressbar aria-valuenow=10 aria-valuemin=0 class="progress-bar-small <%=progress1%>" style="WIDTH: <%=count*100/ totalCount%>%" aria-valuemax=100>
					   	 </DIV><!-- Complete -->
					</DIV><!-- /progress-small -->
		       		<br>
					<%
					break;
				case 2:
					%>
					<DIV class=progress-heading><%=tagName%> ( <%=count*100/ totalCount%> % ) - <%=count%> EA</DIV>
						 <DIV class=progress-small>
					         <DIV role=progressbar aria-valuenow=10 aria-valuemin=0 class="progress-bar-small <%=progress2%>" style="WIDTH: <%=count*100/ totalCount%>%" aria-valuemax=100>
					   	 </DIV><!-- Complete -->
					</DIV><!-- /progress-small -->
		       		<br>
					<%
					break;
				case 3:
					%>
					<DIV class=progress-heading><%=tagName%> ( <%=count*100/ totalCount%> % ) - <%=count%> EA</DIV>
						 <DIV class=progress-small>
					         <DIV role=progressbar aria-valuenow=10 aria-valuemin=0 class="progress-bar-small <%=progress3%>" style="WIDTH: <%=count*100/ totalCount%>%" aria-valuemax=100>
					   	 </DIV><!-- Complete -->
					</DIV><!-- /progress-small -->
		       		<br>
					<%
					break;
				case 4:
					%>
					<DIV class=progress-heading><%=tagName%> ( <%=count*100/ totalCount%> % ) - <%=count%> EA</DIV>
						 <DIV class=progress-small>
					         <DIV role=progressbar aria-valuenow=10 aria-valuemin=0 class="progress-bar-small <%=progress4%>" style="WIDTH: <%=count*100/ totalCount%>%" aria-valuemax=100>
					   	 </DIV><!-- Complete -->
					</DIV><!-- /progress-small -->
		       		<br>
					<%
					break;
				case 5:
					%>
					<DIV class=progress-heading><%=tagName%> ( <%=count*100/ totalCount%> % ) - <%=count%> EA</DIV>
						 <DIV class=progress-small>
					         <DIV role=progressbar aria-valuenow=10 aria-valuemin=0 class="progress-bar-small <%=progress5%>" style="WIDTH: <%=count*100/ totalCount%>%" aria-valuemax=100>
					   	 </DIV><!-- Complete -->
					</DIV><!-- /progress-small -->
		       		<br>
					<%
					break;
				default :
					
					break;
			}			
		}
		%>
		

