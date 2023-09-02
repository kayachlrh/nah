<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="chp0.Bean_Member"%>
<%@ page import="chp0.Bean_Booklist"%>
<%@ page import="chp0.Bean_Daechul"%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>

<%
	String usid = (String) session.getAttribute("idKey");
    int numb = Integer.parseInt(request.getParameter("numb"));
	Bean_Daechul daeBean = bookMgr.getDae1(numb);   //입력자료 가져오기
%>
<html>
<head>
	<title>도서대출 반납</title>
	<link href="../main/style.css" rel="stylesheet" type="text/css" >
</head>
<body bgcolor="#FFFFCC" onLoad="daeFrm.usid.focus()">
	<div align="center">
		<br /> <br />
		<form name="daeFrm" method="post" action="dae02_p.jsp" >
			<table align="center" cellpadding="5" >
				<tr>
					<td align="center" valign="middle" bgcolor="#FFFFCC">
						<table border="1" cellpadding="2" align="center" width="600">
							<tr align="center" bgcolor="#996600">
								<td colspan="3"><font color="#FFFFFF"><b>도서 대출 및 반납 내역 수정</b></font></td>
							</tr>
							<tr>
								<td width="20%">레코드번호</td>
								<td width="50%">
									<input name="numb" size="15" value="<%=numb%>">
								</td>
								<td width="30%">수정불가 : 레코드번호</td>
							</tr>
							<tr>
								<td>사용자 아이디</td>
								<td><input name="usid" size="15" value="<%=daeBean.getUsid()%>"></td>
								<td>사용자 아이디</td>
							</tr>
							<tr>
								<td>ISBN</td>
								<td><input name="isbn" size="15" value="<%=daeBean.getIsbn()%>"></td>
								<td>ISBN 도서 고유 번호</td>
							</tr>
							<tr>
								<td>대출일자</td>
								<td><input type="date" name="d_date" size="15" value="<%=daeBean.getD_date()%>"></td>
								<td>대출일자</td>
							</tr>
							<tr>
								<td>반납예정일자</td>
								<td><input type="date" name="y_date" size="15" value="<%=daeBean.getY_date()%>"></td>
								<td>반납예정일자</td>
							</tr>
							<tr>
								<td>반납일자</td>
								<td><input type="date" name="b_date" size="15" value="<%=daeBean.getB_date()%>"></td>
								<td>반납일자</td>
							</tr>
							<tr>
								<td>연체일수</td>
								<td><input name="nalsu" size="15" value="<%=daeBean.getNalsu()%>" readonly></td>
								<td>연체일수</td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="bigo" size="30" value="<%=daeBean.getBigo()%>"></td>
								<td>비고 내용을 적어주세요.</td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								<input type="submit" value="수정완료"> &nbsp; &nbsp; 
								<input type="reset" value="다시쓰기"> &nbsp; &nbsp; 
								<input type="button" value="자료삭제" onClick="location.href='dae03.jsp?numb=<%=numb%>'"> &nbsp; &nbsp;
								<input type="button" value="신규자료" onClick="location.href='dae01.jsp'"> &nbsp; &nbsp;
								<input type="button" value="대출내역" onClick="history.go(-1)"></td>						
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>