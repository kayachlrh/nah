<%@ page contentType="text/html; charset=UTF-8"%>
<%
	  request.setCharacterEncoding("UTF-8");
	  String usid = (String)session.getAttribute("idKey");
%>
<html>
<head>
<title>로그인</title>
<link href="../resource/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function loginCheck() {
		if (document.loginFrm.usid.value == "") {
			alert("아이디를 입력해 주세요.");
			document.loginFrm.usid.focus();
			return;
		}
		if (document.loginFrm.uspw.value == "") {
			alert("비밀번호를 입력해 주세요.");
			document.loginFrm.uspw.focus();
			return;
		}
		document.loginFrm.action = "loginProc.jsp";
		document.loginFrm.submit();
	}
	
	function memberForm(){
		document.loginFrm.target = "content";
		document.loginFrm.action = "member/member1.jsp";
		document.loginFrm.submit();
	}
</script>
</head>
<body bgcolor="#FFFFCC">
<br/><br/>
 <div align="center">
		<%
			if (usid != null) {
		%>
		<b><%=usid%></b>님 환영 합니다.
		<p>제한된 기능을 사용 할 수가 있습니다.
		<p>
			<a href="logout.jsp">로그아웃</a>
			<%} else {%>
		<form name="loginFrm" method="post" action="loginProc.jsp">
			<table>
				<tr>
					<td align="center" colspan="2"><h4>Login</h4></td>
				</tr>
				<tr>
					<td>ID</td>
					<td><input name="usid" value=""></td>
				</tr>
				<tr>
					<td>PW</td>
					<td><input type="password" name="uspw" value=""></td>
				</tr>
				<tr>
					<td colspan="2">
						<div align="right">
							<input type="button" value="login" onclick="loginCheck()">&nbsp;
							<input type="button" value="join" onClick="memberForm()" >
						</div>
					</td>
				</tr>
			</table>
		</form>
		<%}%>
	</div>
</body>
</html>