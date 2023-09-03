<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@page import="java.util.Vector"%>
<%@page import="chp0.Bean_Booklist"%>
<%@page import="chp0.Bean_Member"%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>
<%
	//String usid = (String) session.getAttribute("idKey");
	String mbigo = null;
%>
<html>
<head>
	<title>도서 대출 관리</title>
	<link href="../resource/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function dae_inputCheck(){
	}
	if(document.daeFrm.isbn.value==""){
		alert("도서 ISBN을 입력해 주세요");
		document.daeFrm.isbn.focus();
		return;
	}

	document.daeFrm.action = "dae01_p.jsp";
	document.daeFrm.submit();
}

function bookSearch() {
	url = "bookSearch.jsp?search=n";
	window.open(url, "BookSearch","width=500,height=300,scrollbars=yes");
}

function usidSearch() {
	url = "usidSearch.jsp?search=n";
	window.open(url, "UsidSearch","width=500,height=300,scrollbars=yes");
}

function dae_trans() {
	bigo = document.getElementById("bigo").value;
	d_date = document.getElementById("d_date").value;
	alert(bigo + d_date);
}
</script>
</head>

<body bgcolor="#FFFFCC" onLoad="daeFrm.usid.focus()">
	<div align="center">
		<br /><br />
		<form name="daeFrm" method="post" action="dae01_p.jsp">
			<table cellpadding="5">
				<tr>
					<td bgcolor="#FFFFCC">
						<table border="1" cellspacing="0" cellpadding="2" width="600">
							<tr bgcolor="#996600">
								<td align="center" colspan="3"><font color="#FFFFFF"><b>대출 반납 내용 입력</b></font></td>
							</tr>
							<tr>
								<td width="20%">아이디</td>
								<td width="50%">
									<input name="usid" size="15" readonly>
									<input type="button" value="아이디찾기" onClick="usidSearch()">
								</td>
								<td width="30%">사용자 아이디입니다.</td>
							</tr>

							<tr>
								<td>ISBN</td>
								<td><input name="isbn" size="15" readonly>
									<input type="button" value="도서찾기" onClick="bookSearch()">
								</td>	
								<td>도서 ISBN 입니다.</td>
							</tr>

<!--
							<tr>
								<td>DB도서선택</td>
								<td><select name=isbn>
										<option value="0" selected>선택하세요.
								<%
                  					Vector<Bean_Booklist> vlist = null;
                  					int listSize = 0;    //현재 읽어온 자료의 수
				  					vlist = bookMgr.getBookList("N", "N", "N", 1, 10);
				  					listSize = vlist.size();     //브라우저 화면에 보여질 자료 수
				  					if (vlist.isEmpty()) {
										out.println("등록된 자료가 없습니다.");
				  					} else {
						  				for (int i = 0;i<listSize; i++) {
											Bean_Booklist bean  = vlist.get(i);
											String isbn = bean.getIsbn();
											String bookname = bean.getBookname(); %>
											<option value="<%=isbn%>"> <%=isbn%>_<%=bookname%>
										<% }  // for
				  					} %> 
								</select></td>
								<td>DB에서 도서 선택</td>
							</tr>
-->

							<tr>
								<td>대출일자</td>
								<td><input type="date" name="d_date" id="d_date" size="15">
								    <input type="button" value="자료전송예시임" onClick="dae_trans()"> 
						        </td>
								<td>도서 대출일자 입니다.</td>
							</tr>
							<tr>
								<td>반납일자</td>
								<td><input type="date" name="b_date" size="15"></td>
								<td>도서 반납일자 입니다.</td>
							</tr>
							<tr>
								<td>비고</td>
								<td><input name="bigo" id="bigo" size="15">
						        </td>
								<td>첨가 내용 입니다.</td>
							</tr>
							<tr>
								<td colspan="3" align="center">
								    <input type="button" value="자료입력" onClick="dae_inputCheck()"> &nbsp; &nbsp; 
								    <input type="reset"  value="다시쓰기"> &nbsp; &nbsp; 
  								    <input type="button" value="대출내역" onClick="history.go(-1)">											
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