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
	String pw = request.getParameter("password");
	
	int id = 1;		//DB�� id �÷��� ������ ��	
	int pos = 0;	
	if(cont.length()==1){
		cont = cont + " ";
	}
	
	//content�� (Text Area) �� ���͸� ó���� ����Ѵ�. Oracle DB�� ����ÿ�
	
	 //textarea ���� ' �� ���� DB�� insert, update�� ���� �߻�.
	
	while ((pos = cont.indexOf("\'",pos)) != -1){	//-1 �� ���� �������� ������
		String left = cont.substring(0,pos);
			//out.println("pos : " + pos + "<p>");
			//out.println("left : " + left + "<p>");
		
		String right = cont.substring(pos, cont.length());
			//out.println ("right : " + right + "<p>");
		
		cont = left + "\'" + right;
		pos += 2;
	}  
	
	//if(true) return;
	
	//������ ��¥ ó���ϴ� �Լ�
	
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
	String ymd = myformat.format(yymmdd);
	
	String sql = null;
	Statement st = null;
	ResultSet rs = null;
	int cnt = 0;		// Insert�� �ߵǾ����� �׷��� ������ Ȯ���ϴ� ����.
	
	try {
		
		// ���� �����ϱ� ���� �ֽ� �۹�ȣ(max(id))�� �����ͼ� + 1 �� �����Ѵ�.
		//conn (Connection) : Auto commit; �� �۵� �ȴ�.
			//commit�� ������� �ʾƵ� insert, update, delete, �ڵ� Ŀ���� �ȴ�.	
		
		st = conn.createStatement();
		sql = "select max (id) from freeboard";
		rs = st.executeQuery(sql);
		
		if(!(rs.next())){  //���� �������� �ʴ� ���
			id = 1;	
		}else{				//���� �����ϴ� ���
			id = rs.getInt(1) + 1;		//���� �����ϴ� ��� �ִ밪 + 1
		}
		rs.close();
		
		sql = "INSERT INTO freeboard (id, name, password, email, subject,";
		sql = sql + "content, inputdate, masterid, readcount, replaynum, step)";
		sql = sql + " values (" +id+",'" + na + "','" + pw + "','"+ em ;
		sql = sql + "','" + sub + "','" + cont + "','" + ymd + "'," + id + ",";
		sql = sql + "0,0,0)";
		
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
		if (rs != null)
			rs.close();
		if (st != null)
			st.close();
		if (conn != null)
			conn.close();
	}


%>
 
<jsp:forward page = "freeboard_list.jsp" />

<!--  ������ �̵�
	
	jsp:forward :		�����ܿ��� �������� �̵�, Ŭ���̾�Ʈ�� ������ URL ������ �ٲ��� �ʴ´�.
	response.sendRedirect :
		Ŭ���̾�Ʈ���� �������� ���û���� ������ �̵�, �̵��ϴ� �������� URL ������ �ٲ��.

 -->


</body>
</html>