<%@page contentType="application; charset=UTF-8"%>
<jsp:useBean id="bMgr" class="chp0.memberMgr" />
<%
	  bMgr.downLoad(request, response, out, pageContext);
%>