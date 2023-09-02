<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>
<jsp:useBean id="bookBean" class="chp0.Bean_Booklist"/>
<jsp:setProperty  name="bookBean" property="*"/>
<%
	boolean result = bookMgr.Book_Insert(bookBean);
	if(result) {
%>
<script type="text/javascript">
	alert("도서등록을 하였습니다.");
	location.href="book02.jsp";
</script>
<% } else { %>
<script type="text/javascript">
	alert("도서등록에 실패 하였습니다.");
	history.back();
</script>
<% } %> 