<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="chp0.Bean_Member"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="mMgr" class="chp0.memberMgr" />
<%
request.setCharacterEncoding("UTF-8");
int totalRecord = 0; //전체레코드수
int listSize = 0; //현재 읽어온 게시물의 수
Vector<Bean_Member> vlist = null;

String usid = (String) session.getAttribute("idKey");
String cPath = request.getContextPath();

String url1 = "../member/member1.jsp";
String url2 = "../login/login.jsp";
String label = "Sign In";
String label2 = "Login";
String url3 = "";
String label3 = "";

if (usid != null) {
    url1 = "../member/member2.jsp";
    url2 = "../login/logout.jsp";
    label = "My Info";
    label2 = "Logout";

    if ("user00".equals(usid)) {
        url3 = "../member/Admin.jsp";
        label3 = "Member List";
    }
}
%>
<html>
<head>
<meta charset="UTF-8">
<link href="../resource/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#CAD8FF">
<div align="center">
	<br> <font size="2"><a href="<%=url1%>" target="content"><b><%=label%></b></a></font> /
	<font size="2"><a href="<%=url2%>" target="content"><b><%=label2%></b></a></font><br>
	<br> <font size="2"><a href="<%=url3%>" target="content"><b><%=label3%></b></a></font><br>
		<br>
	</div>
</body>
</html>