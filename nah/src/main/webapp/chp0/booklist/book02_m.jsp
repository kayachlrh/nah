<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="chp0.Bean_Member"%>
<%@page import="chp0.Bean_Booklist"%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>
<%
	String usid = (String) session.getAttribute("idKey");
	int numb = Integer.parseInt(request.getParameter("numb"));
	Bean_Booklist bookBean = bookMgr.getBook1(numb);   //입력자료 가져오기
%>
<html>
<head>
	<title>도서등록</title>
	<link href="../main/style.css" rel="stylesheet" type="text/css" >
</head>
<body bgcolor="#FFFFCC" onLoad="regFrm.isbn.focus()">
	<div align="center">
		<br /> <br />
		<form name="regFrm" method="post" action="book02_p.jsp" >
			<table align="center" cellpadding="5" >
				<tr>
					<td align="center" valign="middle" bgcolor="#FFFFCC">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr align="center" bgcolor="#996600">
								<td colspan="3"><font color="#FFFFFF"><b>도서 등록 자료 수정</b></font></td>
							</tr>
							<tr>
								<td width="20%">레코드번호</td>
								<td width="50%">
									<input name="numb" size="15" 
									value="<%=bookBean.getNumb()%>"></td>
							</tr>
							<tr>
								<td>ISBN</td>
								<td><input name="isbn" size="15"
									value="<%=bookBean.getIsbn()%>"></td>
							</tr>
							<tr>
								<td>도서명</td>
								<td><input name="bookname" size="30"
									value="<%=bookBean.getBookname()%>"></td>
							</tr>
							<tr>
								<td>저자명</td>
								<td><input name="author" size="15"
									value="<%=bookBean.getAuthor()%>"></td>
							</tr>
							<tr>
								<td>출판사명</td>
								<td><input name="chulpan" size="15"
									value="<%=bookBean.getChulpan()%>"></td>
							</tr>
							<tr>
								<td>출판년도</td>
								<td><input name="bookyear" size="15"
									value="<%=bookBean.getBookyear()%>"></td>
							</tr>
							<tr>
								<td>페이지</td>
								<td><input name="page" size="15"
									value="<%=bookBean.getPage()%>"></td>
							</tr>
							<tr>
								<td>도서가격</td>
								<td><input name="price" size="15"
									value="<%=bookBean.getPrice()%>"></td>
							</tr>
							<tr>
								<td>도서상태</td>
								<td><input name="b_state" size="15"
									value="<%=bookBean.getB_state()%>"></td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="bigo" size="15"
									value="<%=bookBean.getBigo()%>"></td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp; &nbsp; 
								<input type="reset" value="다시쓰기"> &nbsp; &nbsp; 
								<input type="button" value="자료삭제" onClick="location.href='book03.jsp?numb=<%=numb%>'"> &nbsp; &nbsp;
								<input type="button" value="신규도서" onClick="location.href='book01.jsp'"> &nbsp; &nbsp;
								<input type="button" value="도서목록" onClick="history.go(-1)"></td>						
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>