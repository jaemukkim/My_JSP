<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import = "java.sql.*, java.util.*, java.text.*" %>
<% request.setCharacterEncoding("EUC-KR"); %>	<!-- �ѱ� ó�� -->

<%@ include file = "dbconn_oracle.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���� �޾Ƽ� DataBase�� ���� �־��ִ� ����</title>
</head>
<body>
<%	
	//������ �ѱ� ������ �޾Ƽ� ����.
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String sub = request.getParameter("subject");
	String cont = request.getParameter("content");

	
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
	String ymd = myformat.format(yymmdd);
	
	String sql = null;
	Statement st = null;
	int cnt = 0;		// Insert�� �ߵǾ����� �׷��� ������ Ȯ���ϴ� ����.
	
	try {
		
		sql = "INSERT INTO guestboard ( name, email, inputdate,";
		sql = sql + "subject, content)";
		sql = sql + " values ('"  + na + "','" + em ;
		sql = sql + "','" + ymd + "','" + sub + "','" + cont + "')" ;
		st = conn.createStatement();
		 cnt = st.executeUpdate(sql);	  //cnt > 0 : Insert ����

		 
		
		//out.println (sql);
		//if(true) return;	//
		
		
		if(cnt > 0){
			out.println("�����Ͱ� ���������� �Է� �Ǿ����ϴ�.");
		}else{
			out.println("�����Ͱ� �Էµ��� �ʾҽ��ϴ�. ");
		}
		st.close();
		conn.close();
		
	}catch (Exception ex){
		out.println (ex.getMessage());
	}finally{
		if (st != null)
			st.close();
		if (conn != null)
			conn.close();
	}


%>
 
<jsp:forward page = "dbgb_show.jsp" />



</body>
</html>