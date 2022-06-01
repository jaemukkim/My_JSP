<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session </title>
</head>
<body>

<table border="1" width = "90%"> 
	<tr> 
		<td align = "center"> 
		<!-- 로그인 여부에 따른 메뉴 변화  -->
		<% if (session.getAttribute("UserId") == null   ) { %> 
		 
			<a href = "../session02/LoginForm.jsp">로그인</a>
			
		<% }else {  %>
		
			<a href = "../session02/Logout.jsp">로그아웃</a>
			
		<% } %>		
		</td>
	</tr>
</table>

<h2> 로그인 페이지 </h2>

<span style = "color:red; font-size:1.2em;">
	<!-- 로그인 에러 메세지 출력  -->
	<%= request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg") 
	
	%>
</span>

<%
	if (session.getAttribute("UserId") == null ) {   //로그아웃 상태일때   
%>    
	<!-- 로그아웃 상태일때 HTML 처리 부분  -->
	
	<script>     
		function validateForm (form){
			if (!form.user_id.value){
				alert ("아이디를 입력해 주세요");
				return false; 
			}
			if (form.user_pw.value ==""){
				alert ("패스워드를 입력해 주세요"); 
				return false; 
			}	
		}	
	</script>
	<form action = "LoginProcess.jsp" method = "post" name ="loginFrm"
		 onsubmit = "return validateForm(this);">
		<p> 아이디 :  <input type = "text" name = "user_id"> 
		<p> 패스워드 : <input type = "password" name = "user_pw"> 
		<p> <input type= "submit" value ="로그인하기">	 
	</form>
		
	
<% }else {  //로그인 상태일때  %>      
	<!--로그인 상태일때 HTML 처리 부분   -->
	<%= session.getAttribute("UserName") %>  회원님, 로그인 하셨습니다. <br> 
	<a href ="Logout.jsp"> [로그아웃]</a>
	
<% } %>


</body>
</html>