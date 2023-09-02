<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>
<jsp:useBean id="bookBean" class="chp0.Bean_Booklist"/>
<jsp:useBean id="daeBean" class="chp0.Bean_Daechul"/>
<jsp:setProperty  name="daeBean" property="*"/>
<%
	String isbn_1 = request.getParameter("isbn");

	boolean result = bookMgr.Dae_Insert(daeBean);
	if(result){
%>
<script type="text/javascript">
		alert("내용을 입력 하였습니다.");
		location.href="dae02.jsp";
</script>
<% } else {%>
<script type="text/javascript">
		alert("내용 입력에 실패 하였습니다.");
		history.back();
</script>
<% } %>