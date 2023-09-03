<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="chp0.Bean_Member"%>
<%@page import="chp0.Bean_Daechul"%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>

<html>
<head>
	<title>JSP Board</title>
	<link href="../resource/style.css" rel="stylesheet" type="text/css" >
<%
	String usid = (String) session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));

	Bean_Member     aBean = bookMgr.getMember(usid); //회원 자료 가져오기
	Bean_Daechul daeBean = bookMgr.getDae1(numb);   //대출반납 내역 자료 가져오기
    	
	if (request.getParameter("pass") != null) {
		String inPass = request.getParameter("pass");
		String dbPass = aBean.getUspw();
		if (inPass.equals(dbPass)) {
			bookMgr.deleteDae(numb);
			String url = "dae02.jsp";
			response.sendRedirect(url);
		} else {
%>
<script type="text/javascript">
	alert("입력하신 비밀번호가 아닙니다.");
	history.back();
</script>
<%}
	} else {
%>
<script type="text/javascript">
	function check() {
		if (document.delFrm.pass.value == "") {
			alert("패스워드를 입력하세요.");
			document.delFrm.pass.focus();
			return false;
		}
		document.delFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
	<div align="center">
		<br/><br/>
		<table width="400" cellpadding="3">
			<tr>
				<td bgcolor=#dddddd height="21" align="center">
					자료를 삭제합니다.
				</td>
			</tr>
		</table>
		<form name="delFrm" method="post" action="dae03.jsp">
			<table width="400" cellpadding="2">
				<tr>
					<td align="center">
						<table>
							<tr>
							<tr>
								<td>레코드 번호</td>
								<td><%=daeBean.getNumb()%></td>
							</tr>
							<tr>
								<td>사용자 아이디</td>
								<td><%=daeBean.getUsid()%></td>
							</tr>
							<tr>
								<td>ISBN</td>
								<td><%=daeBean.getIsbn()%></td>
							</tr>
							<tr>
								<td>대출일자</td>
								<td><%=daeBean.getD_date()%></td>
							</tr>
							<tr>
								<td>반납예정일자</td>
								<td><%=daeBean.getY_date()%></td>
							</tr>
							<tr>
								<td>반납일자</td>
								<td><%=daeBean.getB_date()%></td>
							</tr>
							<tr>
								<td>연체일수</td>
								<td><%=daeBean.getNalsu()%></td>
							</tr>
							<tr>
								<td align="center">
									패스워드 &nbsp; &nbsp;&nbsp; &nbsp; 
									<input type="password" name="pass" size="10" maxlength="15">
								</td>
							</tr>
							<tr>
								<td><hr size="1" color="#eeeeee"/></td>
							</tr>
							<tr>
								<td align="center">
									<input type="button" value="삭제완료" onClick="check()"> 
									<input type="reset" value="다시쓰기">
									<input type="button" value="뒤로" onClick="history.go(-1)">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="numb" value="<%=numb%>">
		</form>
	</div>
	<%}%>
</body>
</html>