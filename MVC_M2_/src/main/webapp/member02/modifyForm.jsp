<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "logon02.LogonDAO" %>
<%@ page import = "logon02.LogonDTO" %>

<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="../css/style.css"/>
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="modify.js"></script>

<% request.setCharacterEncoding("utf-8");%>

<% 
  String u_id = (String)session.getAttribute("u_id");
  String u_pass = request.getParameter("u_pass");

  LogonDAO manager = LogonDAO.getInstance();
  //아이디와 비밀번호에 해당하는 사용자의 정보를 얻어냄
  LogonDTO m = manager.getMember(u_id, u_pass); 
    
  try{//얻어낸 사용자 정보를 화면에 표시
%>

<div id="regForm" class="box">
   <ul>
      <li><p class="center">회원 정보 수정
      <li><label for="u_id">아이디</label>
          <input id="u_id" name="id" type="email" size="20" 
           maxlength="50" value="<%=u_id%>" readonly disabled>
      <li><label for="u_pass">비밀번호</label>
          <input id="u_pass" name="passwd" type="password" 
           size="20" placeholder="6~16자 숫자/문자" maxlength="16">
      <li><label for="u_name">이름</label>
          <input id="u_name" name="name" type="text" 
           size="20" maxlength="10" value="<%=m.getU_name()%>">
      <li><label for="u_address">주소</label>
          <input id="u_address" name="address" type="text" 
           size="30" maxlength="50" value="<%=m.getU_address()%>">
      <li><label for="u_tel">전화번호</label>
          <input id="u_tel" name="tel" type="tel" 
           size="20" maxlength="20" value="<%=m.getU_tel()%>">
      <li class="label2"><button id="modifyProcess">수정</button>
          <button id="cancle">취소</button>
   </ul>
</div>
<%}catch(Exception e){}%>