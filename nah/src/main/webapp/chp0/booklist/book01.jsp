<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>

<html>
<head>
	<title>도서등록</title>
	<link href="../resource/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function book_inputCheck(){
	if(document.bookFrm.isbn.value==""){
		alert("ISBN 코드를 입력해 주세요.");
		document.bookFrm.isbn.focus();
		return;
	}
	if(document.bookFrm.bookname.value==""){
		alert("도서명을 입력해 주세요");
		document.bookFrm.bookname.focus();
		return;
	}
	if(document.bookFrm.author.value==""){
		alert("저자명을 입력해 주세요.");
		document.bookFrm.author.focus();
		return;
	}
	if(document.bookFrm.chulpan.value==""){
		alert("출판사명을 입력해 주세요.");
		document.bookFrm.chulpan.focus();
		return;
	}
	document.bookFrm.action = "book01_p.jsp";
	document.bookFrm.submit();
}
</script>
</head>
<body bgcolor="#FFFFCC" onLoad="bookFrm.isbn.focus()">
	<div align="center">
		<br /><br />
		<form name="bookFrm" method="post" action="book01_p.jsp">
			<table cellpadding="5">
				<tr>
					<td bgcolor="#FFFFCC">
						<table border="1" cellspacing="0" cellpadding="2" width="600">
							<tr bgcolor="#996600">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>도서 등록</b></font></td>
							</tr>
							<tr>
								<td width="20%">ISBN</td>
								<td width="50%">
									<input name="isbn" size="15"> 
								</td>
								<td width="30%">ISBN 코드를 입력해 주세요.</td>
							</tr>
							<tr>
								<td>도서명</td>
								<td><input name="bookname" size="30"></td>
								<td>도서명을 입력해 주세요.</td>
							</tr>
							<tr>
								<td>저자명</td>
								<td><input name="author" size="15"></td>
								<td>저자명을 입력해 주세요.</td>
							</tr>
							<tr>
								<td>출판사명</td>
								<td><input name="chulpan" size="15"></td>
								<td>출판사명을 입력해 주세요.</td>
							</tr>
							<tr>
								<td>출판년도</td>
								<td><input name="bookyear" size="15"></td>
								<td>출판년도를 입력해 주세요.</td>
							</tr>
							<tr>
								<td>페이지</td>
								<td><input name="page" size="15"></td>
								<td>도서 페이지를 입력해 주세요.</td>
							</tr>
							<tr>
								<td>도서가격</td>
								<td><input name="price" size="15"></td>
								<td>도서가격을 입력해 주세요.</td>
							</tr>
							<tr>
								<td>도서상태</td>
								<td><input name="b_state" size="15" value = "대출가능">
								</td>
								<td>도서상태를 적어주세요.</td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="bigo" size="15">
								</td>
								<td>첨가 사항을 적어주세요.</td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								    <input type="button" value="도서등록" onclick="book_inputCheck()"> &nbsp; &nbsp; 
								    <input type="reset" value="다시쓰기"> &nbsp; &nbsp; 
  								    <input type="button" value="뒤로가기" onClick="history.go(-1)">						
								 </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>