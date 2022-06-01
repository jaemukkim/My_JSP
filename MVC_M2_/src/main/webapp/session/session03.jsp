<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 
 <%@ page import = "java.util.Enumeration" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h2>  session 객체에 저장된 모든 변수의 값을 가져올때 (getAttributeNames())</h2>

<% 
	String name ; 	//session 객체의 저장된 필드명 
	String value; 	//session 객체의 저장된 필드의 값
	
		//session 객체의 담긴 모든 필드를 가져온다. 
	Enumeration en = session.getAttributeNames(); 
	
	int i = 0 ; 
	
	while (en.hasMoreElements()){
		i++; 
		name = en.nextElement().toString();  //session 객체에 저장된 변수명을 가져온다. 
		value = session.getAttribute(name).toString();
		
		out.println ( "설정된 세션 속성이름 [ " + i + "] : " + name + "<br>"); 
		out.println ( "설정된 세션 속성값 [ " + i + "] : " + value + "<br>"); 
		
		
	}
	
%>


</body>
</html>