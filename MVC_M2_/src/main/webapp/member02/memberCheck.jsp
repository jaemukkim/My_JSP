<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "logon02.LogonDAO" %>

<% request.setCharacterEncoding("utf-8");%>
<% 
   //사용자의 id값은 세션속성값으로부터 얻어냄
   String u_id = (String)session.getAttribute("u_id");
   String u_pass = request.getParameter("u_pass");

   LogonDAO manager = LogonDAO.getInstance();
   int check = manager.userCheck(u_id, u_pass);
   
   out.println(check);
%>