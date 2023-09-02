<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String strTitle = "NANA";
	String cPath = request.getContextPath();
%>
<html>
<head>
<meta charset="UTF-8">
<title><%=strTitle%></title>
</head>
<frameset frameborder="0" framespacing="0" border="0" rows="100, *">
<frame frameborder="0" scrolling="NO" resize="NO" name="head" src="<%=cPath%>/chp0/main/head.jsp">
<frameset name="body" frameborder="0" framespacing="0" border="0" rows="*,20">
<frameset name="main" frameborder="0" framespacing="0" border="0" cols="240,*">
<frame name="left" marginwidth="0" marginheight="30" frameborder="0" scrolling="NO" resize="NO" src="<%=cPath%>/chp0/main/left.jsp">
<frame name="content" src="<%=cPath%>/chp0/main/main.jsp" scrolling="YES" marginwidth="0" marginheight="0" frameborder="0" noresize>
</frameset>
<frame name="copy" src="<%=cPath%>/chp0/main/copy.jsp" scrolling="NO" marginwidth="0" marginheight="0" frameborder="0" noresize>
</frameset>
</frameset>
</html>