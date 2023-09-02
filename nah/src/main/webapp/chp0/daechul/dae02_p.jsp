<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>
<jsp:useBean id="daeBean" class="chp0.Bean_Daechul"/>
<jsp:setProperty  name="daeBean" property="*"/>

<%
	  boolean result = bookMgr.updateDae(daeBean);
	  if(result){
%>
<script type="text/javascript">
		alert("입력자료를 수정 하였습니다.");
		location.href="dae02.jsp";
</script>
<% } else {%>
<script type="text/javascript">
		alert("입력자료 수정에 실패 하였습니다.");
		history.back();
</script>
<% } %>