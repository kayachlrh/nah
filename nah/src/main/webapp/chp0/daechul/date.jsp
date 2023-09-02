<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>날짜 계산 </title>
<script type="text/javascript">
    document.write("<br><br><br><br>");	
    document.write("날짜 더하기  3일" + "<br/>");	
	var ddatea = new Date("2023-04-02");
	var ddateb = new Date("2023-04-31");
	var ddatec = new Date("2023-01-01");
    document.write("처음날짜  " + ddatea + "<br/>");	
	ddatea.setDate(ddatea.getDate() + 3);
    document.write("계산날짜  " + ddatea + "<br/>");	
	ddatea.setDate(ddatea.getDate() - 5);
    document.write("계산날짜  " + ddatea + "<br/>");
    
	ddatea = new Date("2023-05-02");
	ddateb = new Date("2023-04-31");
	ddatec = new Date("2023-01-01");
	
	
	var currDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
    var diffff = ddatea - ddateb;
	document.write("* 날짜 두개 : " + ddatea + " ............... " + ddateb + "<br/>");
	document.write("* 일수 차이 : " + parseInt(diffff/currDay) + " 일<br/>");

	document.write("날짜 년 월 일 : " + ddatea.toLocaleString() + "<br/>");
	document.write("날짜 년 월 일 : " + ddatea.getFullYear() + "<br/>");
	document.write("날짜 년 월 일 : " + (ddatea.getMonth()+1) + "<br/>");
	document.write("날짜 년 월 일 : " + ddatea.getDate() + "<br/>");

	//<fmt:formatDate value="${ddatea.toLocaleString()}" pattern="yyyy-MM-dd HH:mm:ss"/>	
</script>
 
</head>
<body>
</body>
</html>