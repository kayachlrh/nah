<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="chp0.Bean_Member" %>
<%@page import="java.util.Vector"%>
<jsp:useBean id="mMgr" class="chp0.memberMgr"/>
<%
    String usid = (String) session.getAttribute("idKey");
    String numbParam = request.getParameter("numb");
    int numb = 0;

    if (numbParam != null && !numbParam.isEmpty()) {
        try {
            numb = Integer.parseInt(numbParam);
        } catch (NumberFormatException e) {
            // 유효하지 않은 숫자 형식일 경우 처리할 내용
            e.printStackTrace();  // 로그에 오류 출력
        }
    }

    Bean_Member mBean = mMgr.getMember3(usid, numb);
    usid = mBean.getUsid();
%>

<html>
<head>
<meta charset="UTF-8">
<title>회원수정</title>
<link href="../resource/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
function zipSearch(){
	url = "zipSearch.jsp?search=n";
	window.open(url, "zipcodeSearch",
			"width=500, height=300, scrollbars=yes");
}
</script>
</head>
<body bgcolor="#FFFFCC" onLoad="regFrm.usid.focus()">
<div align="center">
<br /><br />
<form name="regFrm" method="post" action="member2P.jsp">
<table align="center" border="0" cellpadding="5">
	<tr>
	<td align="center" valign = "middle" bgcolor="#FFFFCC">
	<table border="1" cellpadding="2" align="center" width="600">
	<tr align="center" bgcolor="#996600">
	<td colspan="3"><font color="#FFFFFF"><b>회원 수정</b></font></td>
	</tr>
	<tr>
	<td width="20%">아이디</td>
	<td width="80%"><input name="usid" size="15"
	value="<%=usid%>" readonly></td>
	</tr>
	<tr>
	<td>레코드번호</td>
	<td><input name="numb" size="15"
	value="<%=mBean.getNumb() %>" readonly></td>
	</tr>
	<tr>
	<td>패스워드</td>
	<td><input type="password" name="uspw" size="15"
	value="<%=mBean.getUspw() %>"></td>
	</tr>
	<tr>
	<td>회원구분</td>
	<td><input name="gubn" size="15"
	value="<%=mBean.getGubn() %>" readonly></td>
	</tr>
	<tr>
	<td>승인여부</td>
	<td><input name="stat" size="15"
	value="<%=mBean.getStat()%>" readonly></td>
	</tr>
	<tr>
	<td>회원상태</td>
	<td><input name="sang" size="15" value = "정상" readonly>
	</td>
</tr>
	<tr>
	<td>이름</td>
	<td><input name="name" size="15"
	value="<%=mBean.getName() %>"></td>
	</tr>
	<tr>
	<td>전화번호</td>
	<td><input name="telp" size="15"
	value="<%=mBean.getTelp() %>"></td>
	</tr>
	<tr>
	<td>성별</td>
	<td>남<input type="radio" name="gend" value="1"
	<%=mBean.getGend().equals("1") ? "checked" : ""%>>
	여<input type="radio" name="gend" value="2"
	<%=mBean.getGend().equals("2") ? "checked" : ""%>>
	</td>
	</tr>
	<tr>
	<td>생년월일</td>
	<td><input name="brth" size="6"
	value="<%=mBean.getBrth()%>"> ex)940519</td>
	</tr>
	<tr>
	<td>Email</td>
	<td><input name="mail" size="30"
	value="<%=mBean.getMail()%>"></td>
	</tr>
	<tr>
	<td>우편번호</td>
	<td><input name="post" size="5"
	value="<%=mBean.getPost()%>" readonly>
	<input type="button" value="우편번호찾기" onClick="zipSearch()"></td>
	</tr>
	<tr>
	<td>주소</td>
	<td><input name="addr" size="45"
	value="<%=mBean.getAddr()%>"></td>
	</tr>
	<tr>
	<td>취미</td>
	<td>
	<%
		String list[] = {"운동","여행","게임","영화","독서"};
		String hobby[] = mBean.getHobb();
		for(int i = 0; i < list.length; i++) {
			out.println(list[i]);
			out.println("<input type=checkbox name=hobb");
			out.println("value=" + list[i] + " "+(hobby[i].equals("1") ? "checked" : "") + ">");
		}
	%>
	</td>
	</tr>
	<tr>
	<td>직업</td>
		<td><select name=jobb>
			<option value="0" selected>선택하세요.
			<option value="회사원">회사원
			<option value="연구전문직">연구전문직
			<option value="자영업">자영업
			<option value="농축산업">농축산업
			<option value="교수학생">교수학생
			<option value="기타">기타
		</select>
	<script>document.regFrm.jobb.value="<%=mBean.getJobb()%>"</script>
	</td>
	</tr>
	<tr>
	<td colspan="3" align="center">
			<input type="submit" value="수정완료"> &nbsp; &nbsp; 
			<input type="reset" value="다시쓰기"> &nbsp; &nbsp; 
				</tr>
				</table>
			</td>
		</tr>
</table>
</form>
</div>
</body>
</html>