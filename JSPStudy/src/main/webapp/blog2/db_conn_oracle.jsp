<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
    <%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
	// insert, update, select, delete	<== include 해서 사용. (수정사항이 생겼을때)
	
Connection conn = null;		//DB를 연결하는 객체
	String driver = "oracle.jdbc.driver.OracleDriver";	//Oracle Driver에 접속 
	String url = "jdbc:oracle:thin:@localhost:1521:XE";

	

	Class.forName (driver);		//오라클 드라이버 로드함.
	conn= DriverManager.getConnection (url,"hr2", "1234");

%>

</body>
</html>