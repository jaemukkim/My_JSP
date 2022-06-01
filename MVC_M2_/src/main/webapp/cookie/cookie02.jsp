<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%

	try {
	Cookie[] cookies = request.getCookies(); 
	
	out.println ("현재 저장된 쿠키의 갯수 : " + cookies.length + "<p>"); 
	out.println ("================ <p>"); 
	
	for (int i = 0 ; i <cookies.length ; i++) {
		out.println ("쿠키의 속성 이름 [" + i + "] : " + cookies[i].getName() + "<br>"); 
		out.println ("쿠키의 속성 값  [" + i + "] : " + cookies[i].getValue() + "<br>");
		out.println ("쿠키의 유효 시간 알아오기 : " + cookies[i].getMaxAge() + "<br>" );
		
		out.println ("================= <p>"); 
		
	}
	
	} catch (Exception e) {
		e.printStackTrace(); 
		out.println ("쿠키 처리중 예외발생 , 새로 고침을 다시 하세요."); 
		response.sendRedirect("cookie02.jsp"); 
	}

	
	out.println ("<p><p> request.getContextPath() : " + request.getContextPath()); 

	

%>


</body>
</html>