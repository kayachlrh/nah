<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Vector" %>
<%@ page import = "chp0.Bean_Member" %>
<jsp:useBean id="mMgr" class="chp0.memberMgr"/>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="../resource/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
	
	function idCheck(usid) {
		frm = document.regFrm;
		if (usid == "") {
			alert("아이디를 입력해주세요.");
			frm.usid.focus();
			return;
		}
		url = "idCheck.jsp?usid=" + usid;
		window.open(url, "IDCheck", " width=300, height=150");
	}
	
	function zipSearch() {
		url = "zipSearch.jsp?search=n";
		window.open(url, "ZipCodeSearch", "width=500, height=300, scrollbars=yes");
	
	}
	</script>
</head>
<body bgcolor="#FFFFCC" onLoad="regFrm.usid.focus()">
<div align="center">
	<br /><br />
	<form name="regFrm" method="post" action="member1P.jsp">
	<table cellpadding="5">
	<tr>
		<td bgcolor="#CFEADFF">
		<table border="1" cellsapcing="0" cellpadding="2" width="600">
		<tr bgcolor="#996600">
					<td align="center" colspan="3"><font color="#FFFFFF"><b>회원 가입</b></font></td>
				</tr>
				<tr>
					<td width="20%">아이디</td>
					<td width="50%">
						<input name="usid" size="15"> 
						<input type="button" value="ID중복확인" onClick="idCheck(this.form.usid.value)">
	</td>
			<td width="30%">아이디를 적어 주세요.</td>
		</tr>
		<tr>
		<td>패스워드</td>
		<td><input type="password" name="uspw" size="15"></td>
		<td>패스워드를 적어주세요.</td>
		</tr>
		<tr>
			<td>패스워드 확인</td>
			<td><input type="password" name="repwd" size="15"></td>
			<td>패스워드를 확인합니다.</td>
		</tr>
		<tr>
			<td>회원권한</td>
			<td><input name="gubn" size="15" value = "B" readonly>
			</td>
			<td>입력,수정 불가</td>
		</tr>
		<tr>
			<td>승인여부</td>
			<td><input name="stat" size="15" value = "미승인" readonly>
			</td>
			<td>입력, 수정 불가</td>
		</tr>
		<tr>
			<td>회원상태</td>
			<td><input name="sang" size="15" value = "정상" readonly>
			</td>
			<td>회원상태를 적어주세요.</td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input name="name" size="15">
			</td>
			<td>이름을 적어주세요.</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input name="telp" size="15">
			</td>
			<td>전화번호를 적어주세요.</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				남<input type="radio" name="gend" value="1" checked> 
				여<input type="radio" name="gend" value="2">
			</td>
			<td>성별을 선택 하세요.</td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td><input name="brth" size="6">
				ex)830815</td>
			<td>생년월일를 적어 주세요.</td>
		</tr>
		<tr>
			<td>Email</td>
			<td><input name="mail" size="30">
			</td>
			<td>이메일를 적어 주세요.</td>
		</tr>
		<tr>
			<td>우편번호</td>
			<td><input name="post" size="5" readonly>
				<input type="button" value="우편번호찾기" onClick="zipSearch()">
			</td>
			<td>우편번호를 검색하세요.</td>
		</tr>
		<tr>
			<td>주소</td>
			<td><input name="addr" size="45"></td>
			<td>주소를 적어 주세요.</td>
		</tr>
		<tr>
			<td>취미</td>
			<td>운동<input type="checkbox" name="hobb" value="운동">
				여행<input  type="checkbox" name="hobb" value="여행"> 
				게임<input  type="checkbox" name="hobb" value="게임">
				영화<input  type="checkbox" name="hobb" value="영화">
				독서<input  type="checkbox" name="hobb" value="독서">
			</td>
			<td>취미를 선택 하세요.</td>
		</tr>
		<tr>
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
		</select></td>
		<td>직업을 선택하세요</td>
		</tr>
		<tr>
	 <td colspan="3" align="center">
	   <input type="button" value="회원가입" onclick="inputCheck()">
	    &nbsp; &nbsp; 
	    <input type="reset" value="다시쓰기">
	    &nbsp; &nbsp; 						
	 </td>
		</table>
		</td>
		</table>
	</form>
</div>
</body>
</html>