<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id = "person" class = "dao.Person" scope = "request" /> 
	
	<!--  setProperty : Setter 주입  -->
	
	<jsp:setProperty name="person" property="id" value="20220601" />
			<!--  person 객체의 id를 setter를 통해서 접근 setId(20220601) -->
	<jsp:setProperty name="person" property="name" value="지방선거(휴일)" />
	
	<p> 아이디 : <% out.println(person.getId()); %>
	<p> 이름  : <% out.println (person.getName()); %>
	
	<p><p><p> 
	
	<p> 아이디 : <%= person.getId() %>
	<p> 이 름  : <%= person.getName() %>

</body>
</html>