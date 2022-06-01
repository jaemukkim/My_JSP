<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Java Bean 사용 </title>
</head>
<body>
	<jsp:useBean id = "date" class= "java.util.Date" />
	
	<!--  Java Bean 은 JSP 페이지 에서 *.java 페이지에게 로직을 처리하도록 JSP 페이지 에서 셋팅  -->
	
	<p> <%
	
		out.println ("오늘의 날짜 및 시간"); 
	%>
	
	<p> <%= date %> 
	
</body>
</html>