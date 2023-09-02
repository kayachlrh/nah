<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Vector"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="chp0.Bean_Member"%>
<%@ page import="chp0.Bean_Booklist"%>
<%@ page import="chp0.Bean_Daechul"%>
<jsp:useBean id="bookMgr" class="chp0.memberMgr"/>
<%

	Vector<Bean_Daechul> vlist = null;
	String usid = (String) session.getAttribute("idKey");
	String check = request.getParameter("check");
	if (check == null) check = "N";
	int numb = 0;
	int totalRecord = 0; //전체레코드수
    int listSize = 0;    //현재 읽어온 자료의 수

	Bean_Member aBean = bookMgr.getMember(usid);     // 회원자료 가져오기  
    String gubn = null; // 회원 구분을 담을 변수

    if (aBean != null) {
        gubn = aBean.getGubn(); // 회원 구분 정보를 가져옴
    }

    if (gubn != null) {
        totalRecord = bookMgr.getDaeCount(gubn, usid, check);

    } else {
        out.println("회원 정보를 찾을 수 없습니다."); // 회원 정보가 없는 경우에 대한 처리 예시
    }
    

	totalRecord = bookMgr.getDaeCount(gubn, usid, check);

    long nal = 0;

    SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-dd");  // 데이터 포맷
    String nd_date = "2023-04-15";   // 문자형 날짜(가상 일자 임의지정)
    Date ny_date  = null;            // 날짜형 날짜 대출일자
    Date ny_dateb = null;            // 날짜형 날짜 반납일
    Date ny_datee = null;            // 날짜형 날짜 반납 예정일

    vlist = bookMgr.getDaeList(gubn, usid, check);
	listSize = vlist.size();           //브라우저 화면에 보여질 자료 수
    for (int i = 0;i<listSize; i++) {
		Bean_Daechul bean  = vlist.get(i);
		numb = bean.getNumb();
		usid = bean.getUsid();
		String isbn = bean.getIsbn();

		Bean_Member gBean = bookMgr.getMember(usid);     // 회원자료 가져오기
		String mgubn = gBean.getGubn();                 // 회원 구분
		

		String d_date = bean.getD_date();              // 대출일자
		ny_date = date_format.parse(d_date);           // parse: 문자형 날짜 -> Date 형태로 변환
		if (mgubn.equals("A")) {                       // 반납 예정일 계산
		   ny_date.setDate(ny_date.getDate() + 10);    // 특별회원 10일 더하기  
        } else if (mgubn.equals("B")) {
    	   ny_date.setDate(ny_date.getDate() + 5);     // 일반회원 5일 더하기  
        }
		String y_date = date_format.format(ny_date);  // 날짜형을 문자형으로 변환 .substring(0,10)
	    bookMgr.updateYdate(numb, y_date);            // 반납 예정일 Update
	    
		String b_date = bean.getB_date();
		if (b_date != null) {
			ny_dateb = date_format.parse(b_date);     // 반납일 parse: 문자형 날짜 -> Date 형태로 변환
		} else {
		  	ny_dateb = date_format.parse(nd_date);    // 미반납이 경우 특정일자로 지정(예, 오늘날짜 등)
		}
		bookMgr.updateMibannab(isbn, b_date);     // 미반납 도서에 "대출중"으로 표시  Update
		ny_datee = date_format.parse(y_date);     // 반납 예정일 parse: 문자형 날짜 -> Date 형태로 변환
		//nal = (ny_dateb.getTime() - ny_datee.getTime()) / currDay;  // 연체일수 : 반납일 - 반납  예정일  
		nal = ny_dateb.getDate() - ny_datee.getDate();  // 연체일수 : 반납일 - 반납  예정일  
		bookMgr.updateNalsu(numb, nal);                             // 연체일수 Update 
    }

    vlist = bookMgr.getDaeList(gubn, usid, check);
	listSize = vlist.size();           //브라우저 화면에 보여질 자료 수
    for (int i = 0;i<listSize; i++) {
		Bean_Daechul bean  = vlist.get(i);
		usid = bean.getUsid();
		int nalsu = bean.getNalsu();
		bookMgr.updateYun(usid, nalsu);     // 연체자 표시
	}
	
%>

<html>
<head>
	<title>도서 대출 관리</title>
	<link href="../resource/style.css" rel="stylesheet" type="text/css" >
<script type="text/javascript">
	function dae02_m(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.action="dae02_m.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}

	function dae03(numb){
		document.readFrm.numb.value=numb;
		document.readFrm.action="dae03.jsp";
		document.readFrm.target="content";
		document.readFrm.submit();
	}	
</script>

</head>
<body leftmargin="0" topmargin="0" bgcolor="#FFFFCC">

<div align="center">
    <br/>
		<h2>대출 및 반납 내역</h2>
    <br>
	<table align="center" width="900" border="1">
		<tr>
			<td>&nbsp; 자료수 : <%=totalRecord%> &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
			        현재(가상) 일자 : <%=nd_date%></td>
		</tr>
	</table>
	<table align="center" width="900" cellpadding="3" border="1">
		<tr>
			<td align="center" colspan="3">
			<%
				  vlist = bookMgr.getDaeList(gubn, usid, check);
				  listSize = vlist.size();           //브라우저 화면에 보여질 자료 수

				  if (vlist.isEmpty()) {
					out.println("등록된 자료가 없습니다.");
				  } else {
			%>
				  <table width="100%" cellpadding="2" cellspacing="0" border="1">
					<tr align="center" bgcolor="#D0D0D0" height="120%">
						<td>순서</td>
						<td>사용자</td>
						<td>사용자명</td>
						<td>회원구분</td>
						<td>ISBN</td>
						<td>도서명</td>
						<td>대출일자</td>
						<td>반납예정일자</td>
						<td>반납일자</td>
						<td>연체일수</td>
						<% if ("S".equals(gubn)) { %>
           			 	<td>수정</td>
            			<td>삭제</td>
        			<% } %>
					</tr>
					<%
						  for (int i = 0;i<listSize; i++) {
							Bean_Daechul bean  = vlist.get(i);
							numb = bean.getNumb();
							usid = bean.getUsid();
							String isbn = bean.getIsbn();
							String d_date = bean.getD_date();
							String y_date = bean.getY_date();
							String b_date = bean.getB_date();
							if (b_date == null) b_date = "반납예정";
							int nalsu = bean.getNalsu();
							String bigo = bean.getBigo();
							
							Bean_Member mBean = bookMgr.getMember(usid);     // 회원자료 가져오기
                            String usid_name = mBean.getName();             // 회원 이름
                            String gubn1 = mBean.getGubn();                 // 회원 구분
                            String gubn_name = null;                        // 회원 구분
                            if (gubn1.equals("A")) {
                            	gubn_name = gubn1 + "_특별회원";
                            } else if (gubn1.equals("B")) {
                            	gubn_name = gubn1 + "_일반회원";
                            }
                            
                            Bean_Booklist bBean = bookMgr.getBook2(isbn);   // 도서자료 가져오기
                            String isbn_name = bBean.getBookname();

					%>
					<tr>
						<td align="center">
 						   <a href="javascript:dae02_m('<%=numb%>')" ><%=numb%></a>
						</td>
						<td align="center">
 						   <%=usid%>
						</td>
						<td align="center">
 						   <%=usid_name%>
						</td>
						<td align="center">
 						   <%=gubn_name%>
						</td>
						<td align="center">
 						   <%=isbn%>
						</td>
						<td align="center">
 						   <%=isbn_name%>
						</td>
						<td align="center">
						   <%=d_date%>
						</td>
						<td align="center">
						   <%=y_date%>
						</td>
						<td align="center">
						   <%=b_date%>
						</td>
						<td align="center">
						   <%=nalsu%>
						</td>
						<% if ("S".equals(gubn)) { %>
            		<td align="center"><a href="javascript:dae02_m('<%=numb%>')">수정</a></td>
            		<td align="center"><a href="javascript:dae03('<%=numb%>')">삭제</a></td>
        			<% } %>
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
		<input type="button" value="신규자료" onClick="location.href='dae01.jsp'"> &nbsp; &nbsp;
		<input type="button" value="전체자료" onClick="location.href='dae02.jsp?check=N'"> &nbsp; &nbsp;
		<input type="button" value="연체자료" onClick="location.href='dae02.jsp?check=Y'"> &nbsp; &nbsp;
		<input type="button" value="미 반 납" onClick="location.href='dae02.jsp?check=M'"> &nbsp; &nbsp;
		<input type="button" value="반납자료" onClick="location.href='dae02.jsp?check=B'"> &nbsp; &nbsp;
		<input type="hidden" name="numb">
	</form>
</div>
</body>
</html>