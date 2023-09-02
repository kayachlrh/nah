<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="chp0.memberMgr" />
<jsp:useBean id="mBean" class="chp0.Bean_Member" />
<jsp:setProperty name="mBean" property="*" />
<%
	String usid = (String) session.getAttribute("idKey");
	boolean result = mMgr.updateMember(mBean);
	if(result) {
%>
<script type="text/javascript">
		alert("회원정보를 수정하였습니다.");
		<% if (usid.equals("user00")) {%>
		location.href="member2.jsp?check=N&numb=0";
	<% } else { %>
		history.back();
	<% } %>
</script>
<% }else{ %>
<script type="text/javascript">
		alert("회원정보 수정에 실패하였습니다.");
		history.back();
</script>
<%} %>