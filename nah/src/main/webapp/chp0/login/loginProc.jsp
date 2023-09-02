<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="mMgr" class="chp0.memberMgr"/>
<%
	  request.setCharacterEncoding("UTF-8");
	  String cPath = request.getContextPath();
	  String usid = request.getParameter("usid");
	  String uspw = request.getParameter("uspw");
	  String url = cPath+"/chp0/main/main.jsp";
	  String msg = "로그인에 실패 하였습니다.";
	  
	  boolean result = mMgr.loginMember(usid,uspw);
	  if(result){
	    session.setAttribute("idKey",usid);
	    msg = "로그인에 성공 하였습니다.";
	  }
%>
<script>
	alert("<%=msg%>");
	top.document.location.reload(); 
	location.href="<%=url%>";
</script>