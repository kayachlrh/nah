<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	  String usid = (String) session.getAttribute("idKey");
      String cPath = request.getContextPath();

	  String url1 = "../main/main.jsp";
	  String url2 = "../main/main.jsp";
	  String url2T = "도서관리";
	  String url3 = "../board/list.jsp";
	  
	  if (usid == null) {
         
      } else if (usid.equals("user00")) {
         
      	  url1 = "../booklist/book02.jsp";
    	  url2 = "../daechul/dae02.jsp";
    	  url2T = "도서관리";
    	  url3 = "../board/list.jsp";
         
      } else if (usid != null) {
          
    	  url1 = "../booklist/book02.jsp";
    	  url2 = "../member/member2.jsp";
    	  url2T = "회원수정";
    	  url3 = "../board/list.jsp";
      }
%>
<html>
<head>
<meta charset="UTF-8">
<title>head</title>
<link href="../resource/style.css" rel="stylesheet" type="text/css">
</head>
<body style="margin:0px">
<table width = "1280" border="0" cellpadding ="0" cellspacing="0">
<tr>
<td colspan="5">
<table width= "100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td height="50">
<a href="index.jsp" target="_parent" onFocus="this.blur();">
<img src="../images/e.jpeg" width="140" height="80"> </a>
</td>
</tr>
</table>
</td>
</tr>
<tr>
	<td width="300" height="0">&nbsp;</td>
	<td><font size="3"><a href="<%=url1%>" target="content"><b>도서등록</b></a></font></td>
	<td><font size="3"><a href="<%=url2%>" target="content"><b><%=url2T%></b></a></font></td>
	<td><font size="3"><a href="<%=url3%>" target="content"><b>Q&A</b></a></font></td>
</tr>
</table>
</body>
</html>