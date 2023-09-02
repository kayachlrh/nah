<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@page import="chp0.Bean_Booklist"%>
<%@page import="chp0.Bean_Member"%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>
<jsp:useBean id="bookBean" class="chp0.Bean_Booklist"/>
<jsp:setProperty  name="bookBean" property="*"/>
<%
	boolean result = bookMgr.updateBook(bookBean);
	if(result){
%>
<script type="text/javascript">
	alert("도서정보를 수정 하였습니다.");
	location.href="book02.jsp";
</script>
<% }else{%>
<script type="text/javascript">
	alert("도서정보 수정에 실패 하였습니다.");
	history.back();
</script>
<%} %>