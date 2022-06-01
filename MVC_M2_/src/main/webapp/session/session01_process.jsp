<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>session 객체에 변수의 값을 할당  </title>
</head>
<body>

<%    //client 폼에서 ID, Password 
	String user_id = request.getParameter("id"); 
	String user_pw	= request.getParameter("passwd"); 
	
	
	//DB에서 가져온 
	if (user_id.equals("admin") && user_pw.equals("1234")){
		//세션에 세션 변수의 값을 할당 
		session.setAttribute("userID", user_id); 
		session.setAttribute("userPW", user_pw); 
		
		out.println ("세션 설정이 성공 되었습니다"); 
		out.println (user_id + " 님 환영 합니다.");
		
		
	}else {
		out.println ("세션 설정이 실패 했습니다. "); 
	}



%>

</body>
</html>