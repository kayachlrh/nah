<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="chp0.Bean_Member"%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>

<%
	request.setCharacterEncoding("UTF-8");
	Vector<Bean_Member> vlist = null;
	String usid = (String) session.getAttribute("idKey");
	Bean_Member gBean = bookMgr.getMember(usid);   //회원자료 가져오기
    String gubn = gBean.getGubn();
	int numb = gBean.getNumb();

    int totalRecord=0; //전체레코드수
    int listSize=0;    //현재 읽어온 게시물의 수

	String check = request.getParameter("check");
	String perm1 = request.getParameter("perm1");
	String perm2 = request.getParameter("perm2");
	
	int recnum = 0; // 기본값으로 0을 설정
	String recnumParam = request.getParameter("numb");
	if (recnumParam != null && !recnumParam.isEmpty()) {
	    recnum = Integer.parseInt(recnumParam);
	}
	if (check == null) check = "N";  // 구분값
	if (perm1 == null) perm1 = "Z";  // 승인여부 값
	if (perm2 == null) perm2 = "Z";  // 클릭 여부
	if (perm2.equals("GG")) {
		bookMgr.updatePerm(recnum, perm1);
	}
	
    totalRecord = bookMgr.getTotalCount(gubn, check);
%>

<html>
<head>
	<title>도서대출</title>
	<link href="../resource/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function h02_m(numb){
	document.readFrm.numb.value=numb;
	document.readFrm.action="member2.jsp";
	document.readFrm.target="content";
	document.readFrm.submit();
}

function h02_s(numb, stat){
	document.readFrm.numb.value=numb;
	document.readFrm.perm1.value=stat;
	document.readFrm.perm2.value="GG";
	document.readFrm.action="Admin.jsp";
	document.readFrm.target="content";
	document.readFrm.submit();
}

function h03(numb){
	document.readFrm.numb.value=numb;
	document.readFrm.action="member3.jsp";
	document.readFrm.target="content";
	document.readFrm.submit();
}
</script>
</head>
<body leftmargin="0" topmargin="0" bgcolor="#FFFFCC">
<div align="center">
    <br/>
		<h2>회 원 명 단</h2>
    <br>
	<table align="center" width="800" border="1">
		<tr>
			<td>회원수 : <%=totalRecord%></td>
		</tr>
	</table>
	<table align="center" width="800" cellpadding="3" border="1">
		<tr>
			<td align="center" colspan="3">
			<%
				  vlist = bookMgr.getMemberList(gubn, check);
				  listSize = vlist.size();//브라우저 화면에 보여질 게시물 번호
				  if (vlist.isEmpty()) {
					out.println("등록된 게시물이 없습니다.");
				  } else {
			%>
				  <table width="100%" cellpadding="2" cellspacing="0" border="1">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>번 호</td>
						<td>아이디</td>
						<td>회원구분</td>
						<td>회원구분</td>
						<td>승인여부</td>
						<td>연체여부</td>
						<td>이 름</td>
						<td>전화번호</td>
						<td>수 정</td>
						<td>삭 제</td>
					</tr>
					<%
						  for (int i = 0;i<listSize; i++) {
							Bean_Member bean = vlist.get(i);
							numb = bean.getNumb();
							usid = bean.getUsid();
							gubn = bean.getGubn();
							String gu = null;
							if (gubn.equals("S")) { gu = "도서담당자"; } 
							else if (gubn.equals("A")) { gu = "특별회원"; }
							else { gu = "일반회원";}
							String stat = bean.getStat();
							String sang = bean.getSang();
							String name = bean.getName();
							String telp = bean.getTelp();
					%>
					<tr>
						<td align="center">
						   <%=numb%>
						</td>
						<td align="center">
 						   <a href="javascript:h02_m('<%=numb%>')" ><%=usid%></a>
						</td>
						<td align="center">
						   <%=gubn%>
						</td>
						<td align="center">
						   <%=gu%>
						</td>
						<td align="center">
 						   <a href="javascript:h02_s('<%=numb%>', '<%=stat%>')" ><%=stat%></a>
						</td>
						<td align="center">
						   <%=sang%>
						</td>
						<td align="center">
						   <%=name%>
						</td>
						<td align="center">
						   <%=telp%>
						</td>
						<td align="center">
						   <a href="javascript:h02_m('<%=numb%>')">수정</a>
						</td>
						<td align="center">
						   <a href="javascript:h03('<%=numb%>')">삭제</a>
						</td>
					</tr>
					<%}//for%>
				</table> <%
 			}//if
 		%>
			</td>
		</tr>
	</table>
	<form name="readFrm" method="get">
	    <br>
		<input type="button" value="신규회원"   onClick="location.href='member1.jsp'"> &nbsp; &nbsp;
		<input type="button" value="전체회원"   onClick="location.href='Admin.jsp?check=N&numb=0'"> &nbsp; &nbsp;
		<input type="button" value="승인회원"   onClick="location.href='Admin.jsp?check=J&numb=0'"> &nbsp; &nbsp;
		<input type="button" value="미승인회원"  onClick="location.href='Admin.jsp?check=Y&numb=0'"> &nbsp; &nbsp;
		<input type="button" value="정상회원"   onClick="location.href='Admin.jsp?check=S1&numb=0'"> &nbsp; &nbsp;
		<input type="button" value="연체회원"   onClick="location.href='Admin.jsp?check=S2&numb=0'"> &nbsp; &nbsp;
		<input type="button" value="A_특별회원" onClick="location.href='Admin.jsp?check=H1&numb=0'"> &nbsp; &nbsp;
		<input type="button" value="B_일반회원" onClick="location.href='Admin.jsp?check=H2&numb=0'"> &nbsp; &nbsp;
		<input type="hidden" name="numb"> 
		<input type="hidden" name="perm1"> 
		<input type="hidden" name="perm2"> 
	</form>
</div>
</body>
</html>