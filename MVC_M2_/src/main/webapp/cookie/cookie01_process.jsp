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
		String user_id = request.getParameter("id"); 
		String user_pw = request.getParameter("pass"); 
		
		if (user_id.equals("admin") && user_pw.equals("1234")  ){
			// 쿠기 생성 , 클라이언트 HDD 에 쿠키의 값을 저장 
			
			//쿠키는 생성자에서 변수 이름과 값을 할당 ;  
			Cookie cookie_id = new Cookie("userID", user_id); 
			Cookie cookie_pw = new Cookie("userPW", user_pw);
			
			//쿠키 설정 
			cookie_id.setPath(request.getContextPath()); //쿠키를 사용할 서버의 경로 설정 
			cookie_id.setMaxAge( 60 * 60 );    //3600초 == 1시간 
			
			cookie_pw.setPath(request.getContextPath()); 
			cookie_pw.setMaxAge(60 * 60);    
					
			//쿠키를 response 객체를 사용해서 생성된 쿠키를 Client HDD에 저장 
			response.addCookie(cookie_id); 
			response.addCookie(cookie_pw); 
			
			out.println ("쿠키 생성이 성공 했습니다. "); 
			out.println (user_id + "님 환영 합니다. "); 
			
		}else {
			out.println ("쿠키 생성이 실패 하였습니다."); 
		}
		
	
	
	%>

</body>
</html>