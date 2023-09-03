<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="chp0.Bean_Member"%>
<%@page import="chp0.Bean_Booklist"%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>

<html>
<head>
	<title>도서등록</title>
	<link href="../resource/style.css" rel="stylesheet" type="text/css">
<%
	request.setCharacterEncoding("UTF-8");
	int numb = Integer.parseInt(request.getParameter("numb"));
    String cPath = request.getContextPath();
	String usid = (String) session.getAttribute("idKey");

    Bean_Member gBean = bookMgr.getMember(usid);     //회원자료 가져오기
    Bean_Booklist bBean = bookMgr.getBook1(numb);    //도서자료 가져오기
    
	//System.out.println("자료확인");
    //System.out.println(numb); 
    //System.out.println(gBean.getUspw());
    
	if (request.getParameter("pass") != null) {
		String inPass = request.getParameter("pass");
		String dbPass = gBean.getUspw();
		if (inPass.equals(dbPass)) {
			bookMgr.deleteBook(numb);
			String url = "book02.jsp";
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
		<table width="300" cellpadding="3">
			<tr>
				<td bgcolor=#dddddd height="21" align="center">
					사용자의 비밀번호를 입력해주세요.
				</td>
			</tr>
		</table>
		<form name="delFrm" method="post" action="book03.jsp">
			<table width="300" cellpadding="2">
				<tr>
					<td align="center">
						<table>
							<tr>
								<td>레코드 번호</td>
								<td><%=bBean.getNumb()%></td>
							</tr>
							<tr>
								<td>ISBN</td>
								<td><%=bBean.getIsbn()%></td>
							</tr>
							<tr>
								<td>도서명</td>
								<td><%=bBean.getBookname()%></td>
							</tr>
							<tr>
								<td>저자명</td>
								<td><%=bBean.getAuthor()%></td>
							</tr>
							<tr>
								<td>출판사명</td>
								<td><%=bBean.getChulpan()%></td>
							</tr>
							<tr>
								<td>출판년도</td>
								<td><%=bBean.getBookyear()%></td>
							</tr>
							<tr>
								<td align="center">
									<input type="password" name="pass" size="17" maxlength="15">
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