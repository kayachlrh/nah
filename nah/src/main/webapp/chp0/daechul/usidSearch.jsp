<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@page import="java.util.Vector"%>
<%@page import="chp0.Bean_Member"%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>
<%
	 String search = request.getParameter("search");
	 String name = null;
	 Vector<Bean_Member> vlist = null;
	 if (search.equals("y")) {
		 name = request.getParameter("name");
		 vlist = bookMgr.UsidRead(name);
	 }
%>
<html>
<head>
	<title>아이디 검색</title>
	<link href="../resource/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function loadSearch() {
		frm = document.zipFrm;
		if (frm.name.value == "") {
			alert("이름을 입력하세요.");
			frm.name.focus();
			return;
		}
		frm.action = "usidSearch.jsp"
		frm.submit();
	}

	function sendAdd(Usid) {
		opener.document.daeFrm.usid.value = Usid;
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
					<td>
						<br/>이름 입력 : <input name="name">
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
					<td align="center"><br/>※검색 후, 아래 이름을 클릭하면 자동으로 입력됩니다.</td>
				</tr>
				<%
					for (int i = 0; i < vlist.size(); i++) {
						    Bean_Member bean = vlist.get(i);
							int rNumb = bean.getNumb();
							String rUsid = bean.getUsid();
							String rName = bean.getName();
							String rStat = bean.getStat();
							String rTelp = bean.getTelp();
				%>
				<tr>
					<td><a href="#" onclick="javascript:sendAdd('<%=rUsid%>')">
						<%=rNumb%> <%=rStat%> <%=rUsid%> <%=rName%> <%=rTelp%></a></td>
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