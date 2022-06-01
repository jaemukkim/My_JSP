<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "logon02.LogonDAO" %>

<% request.setCharacterEncoding("utf-8");%>

<%
  //사용자가 입력한 아이디와 비밀번호
  String u_id = request.getParameter("u_id");
  String u_pass  = request.getParameter("u_pass");

  LogonDAO manager = LogonDAO.getInstance();
  int check= manager.userCheck(u_id, u_pass);//사용자인증처리 메소드

  if(check==1)//사용자인증에 성공시 세션속성을 설정
	session.setAttribute("u_id", u_id);

  out.println(check);//처리결과를 반환
%>