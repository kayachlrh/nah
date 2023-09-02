<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@page import="java.util.Vector"%>
<%@page import="chp0.Bean_Booklist"%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>
<%
	 String search = request.getParameter("search");
	 String bookname = null;
	 Vector<Bean_Booklist> vlist = null;
	 if (search.equals("y")) {
		bookname = request.getParameter("bookname");
		vlist = bookMgr.IsbnRead(bookname);
	 }
%>
<html>
<head>
	<title>도서 검색</title>
	<link href="../main/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function loadSearch() {
		frm = document.zipFrm;
		if (frm.bookname.value == "") {
			alert("도서명을 입력하세요.");
			frm.bookname.focus();
			return;
		}
		frm.action = "bookSearch.jsp"
		frm.submit();
	}

	function sendAdd(Bookisbn) {
		opener.document.daeFrm.isbn.value = Bookisbn;
		self.close();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br />
		<form name="zipFrm" method="post">
			<table>
				<tr>
					<td><br/>도서명 입력 : <input name="bookname">
					 <input type="button" value="검색" onclick="loadSearch();">
					 </td>
				</tr>
				<!-- 검색결과 시작 -->
				<%
					if (search.equals("y")) {
							if (vlist.isEmpty()) {
				%>
				<tr>
					<td align="center"><br/>검색된 결과가 없습니다.</td>
				</tr>
				<%
					} else {
				%>
				<tr>
					<td align="center"><br/>※검색 후, 아래 ISBN을 클릭하면 자동으로 입력됩니다.</td>
				</tr>
				<%
					for (int i = 0; i < vlist.size(); i++) {
						    Bean_Booklist bean = vlist.get(i);
							int rNumb = bean.getNumb();
							String rBookisbn = bean.getIsbn();
							String rBookname = bean.getBookname();
							String rAuthor = bean.getAuthor();
							String rChulpan = bean.getChulpan();
							String rB_state = bean.getB_state();
				%>
				<tr>
					<td><a href="#"
						onclick="javascript:sendAdd('<%=rBookisbn%>')">
							<%=rNumb%> <%=rB_state%> <%=rBookisbn%> <%=rBookname%> <%=rAuthor%> <%=rChulpan%></a></td>
				</tr>
				<%
					}//for
						}//if
					}//if
				%>
				<!-- 검색결과 끝 -->
				<tr>
					<td align="center"><br/>
					<a href="#" onClick="self.close()">닫기</a></td>
				</tr>
			</table>
			<input type="hidden" name="search" value="y">
		</form>
	</div>
</body>
</html>