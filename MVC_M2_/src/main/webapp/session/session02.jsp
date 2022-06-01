<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h2> session 객체의 변수에 할당된 값 가져오기 </h2>

<% 
	//Session 객체의 값을 가져올때 Object 타입이므로 다운 캐스팅이 필요함.
	
	 	//모든 페이지에서 세션의 변수에 들어간 값을 가져와서 null 일 경우 : 로그인이 안된 상태 
	 	//getAttribute <== 세션객체에 담긴 하나의 변수의 값을 가져올때 
	String user_id = (String) session.getAttribute("userID"); 
			
	String user_pw	= (String) session.getAttribute("userPW"); 
	
	out.println ("<p> 설정된 세션의 속성갑 1 : " + user_id); 
	out.println ("<p> 설정된 세션의 속성갑 2 : " + user_pw); 



%>


</body>
</html>