<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="chp0.Bean_Booklist"%>
<%@page import="chp0.Bean_Member"%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>
<%
	Vector<Bean_Booklist> vlist = null;
	String usid = (String) session.getAttribute("idKey");
	String check = request.getParameter("check");
	if (check == null) check = "N";
	
	String keyWord = "", keyField = "";
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
		check = "S";
	}
	
	int numb = 0;
	int recordsPerPage = 5; //한 페이지당 보여질 레코드 수
	
	int totalRecord = bookMgr.getBookCount(check, keyWord, keyField); // 전체 레코드 수 가져오기
	int totalPages = (int) Math.ceil((double) totalRecord / recordsPerPage);
	int listSize = 0;    //현재 읽어온 자료의 수
   	
	int currentPage = 1; //기본 페이지
   	if(request.getParameter("page") != null){
   		currentPage = Integer.parseInt(request.getParameter("page"));
   	}

	
	// 가져올 레코드의 시작 인덱스 계산
	int startRecord = (currentPage - 1) * recordsPerPage;
	vlist = bookMgr.getBookList(check, keyWord, keyField, startRecord, recordsPerPage);
	listSize = vlist.size(); // 브라우저 화면에 보여질 자료 수
%>

<html>
<head>
	<title>도서등록</title>
	<link href="../main/style.css" rel="stylesheet" type="text/css" >
<script type="text/javascript">
	function book02_m(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.action="book02_m.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function book03(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.action="book03.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function check() {
	     if (document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
	     }
	  document.searchFrm.action="book02.jsp";
      document.searchFrm.target="content";
	  document.searchFrm.submit();
	 }
	
	function openDae01(numb) {
	    window.open('../daechul/dae01.jsp?numb=' + numb, '_blank');
	  }
</script>

</head>
<body leftmargin="0" topmargin="0" bgcolor="#FFFFCC">
<div align="center">
    <br/>
		<h2>도 서 등 록 내 역</h2>
    <br>
	<table align="center" width="800" border="1">
		<tr>
			<td>도서 자료수 : <%=totalRecord%></td>
		</tr>
	</table>
	<table align="center" width="800" cellpadding="3" border="1">
		<tr>
			<td align="center" colspan="3">
			<%
				  vlist = bookMgr.getBookList(check, keyWord, keyField, startRecord, recordsPerPage);
				  listSize = vlist.size();           //브라우저 화면에 보여질 자료 수
				  if (vlist.isEmpty()) {
					out.println("등록된 자료가 없습니다.");
				  } else {
			%>
				  <table width="100%" cellpadding="2" cellspacing="0" border="1">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>순서</td>
						<td>ISBN</td>
						<td>도서명</td>
						<td>저자명</td>
						<td>출판사명</td>
						<td>도서상태</td>
						<td>비고</td>
						<td>수 정</td>
						<td>삭 제</td>
					</tr>
					<%
						  for (int i = 0;i<listSize; i++) {
							Bean_Booklist bean  = vlist.get(i);
							numb = bean.getNumb();
							String isbn = bean.getIsbn();
							String bookname = bean.getBookname();
							String author = bean.getAuthor();
							String chulpan = bean.getChulpan();
							String bookyear = bean.getBookyear();
							String pages = bean.getPage();
							String price = bean.getPrice();
							String b_state = bean.getB_state();
							String bigo = bean.getBigo();
					%>
					<tr>
						<td align="center">
 						   <a href="javascript:book02_m('<%=numb%>')" ><%=numb%></a>
						</td>
						<td align="center">
 						   <%=isbn%>
						</td>
						<td align="center">
 						   <%=bookname%>
						</td>
						<td align="center">
 						   <%=author%>
						</td>
						<td align="center">
 						   <%=chulpan%>
						</td>
						<%if(b_state.equals("대출가능")){ %>
						<td align="center">
						<a href="javascript:void(0);" onclick="openDae01('<%=numb%>')"><%=b_state%></a>
						</td>
						<%} else if(b_state.equals("대출중")) {%>
						<td align="center"><%=b_state%></td>
						<%} %>
						<td align="center">
						   <%=bigo%>
						</td>
						<td align="center">
						   <a href="javascript:book02_m('<%=numb%>')">수정</a>
						</td>
						<td align="center">
						   <a href="javascript:book03('<%=numb%>')">삭제</a>
						</td>
					</tr>
					<%}//for%>
				</table> <%
 			}//if
 		%>
			</td>
		</tr>
	</table>
		
	<form  name="searchFrm"  method="get" action="book2.jsp">
		<table width="600" cellpadding="4" cellspacing="0">
 			<tr>
  				<td align="center" valign="bottom">
   					<select name="keyField" size="1" >
    					<option value="bookname"> 도서명</option>
    					<option value="author"> 저자명</option>
    					<option value="chulpan"> 출판사</option>
   					</select>
   					<input size="16" name="keyWord">
   					<input type="button"  value="도서찾기" onClick="check()">
   				</td>
 			</tr>
 		</table>
	</form>
	
	<!-- 페이징 링크 표시 -->

<div style="display: flex; justify-content: center;">
    <ul style="list-style-type: none; padding: 0; margin: 0;">
        
        <%-- 이전 페이지 링크 표시 --%>
        <% if (currentPage > 1) { %>
            <li style="display: inline-block; margin-right: 10px;"><a href="book02.jsp?page=<%=currentPage - 1%>&check=<%=check%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>">이전</a></li>
        <% } %>

        <%-- 페이지 번호 표시 --%>
        <% 
            int firstPage = Math.max(currentPage - 2, 1);
            int lastPage = Math.min(firstPage + 4, totalPages);
        %>
        <% for (int i = firstPage; i <= lastPage; i++) { %>
            <li style="display: inline-block; margin-right: 10px;"><a href="book02.jsp?page=<%=i%>&check=<%=check%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>"><%=i%></a></li>
        <% } %>
        <% if (lastPage < totalPages) { %>
            <li style="display: inline-block; margin-right: 10px;"><a href="book02.jsp?page=<%=lastPage + 1%>&check=<%=check%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>">▶</a></li>
        <% } %>

        <%-- 다음 페이지 링크 표시 --%>
        <% if (currentPage < totalPages) { %>
            <li style="display: inline-block; margin-right: 10px;"><a href="book02.jsp?page=<%=currentPage + 1%>&check=<%=check%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>">다음</a></li>
        <% } %>
    </ul>
</div>
		
	<form name="readFrm" method="get">
	    <br>
		<input type="button" value="신규도서 등록" onClick="location.href='book01.jsp'"> &nbsp; &nbsp;
		<input type="button" value="전체도서" onClick="location.href='book02.jsp?check=N'"> &nbsp; &nbsp;
		<input type="button" value="대출도서" onClick="location.href='book02.jsp?check=J'"> &nbsp; &nbsp;
		<input type="button" value="대출가능" onClick="location.href='book02.jsp?check=G'"> &nbsp; &nbsp;
		<input type="hidden" name="numb"> 
	</form>
	</div>
</body>
</html>