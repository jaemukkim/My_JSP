<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팝업 띄우기 </title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	div#popup {
		position : absolute; top : 100px; left:100px; color:yellow; 
		width: 270px; height:100px; background-color:gray; 
	}
	div#popup>div { 
		position : relative ; background-color: #ffffff ; 
		top : 0px; border : 1px solid gray;  padding : 10px; color : black; 
	
	}

</style>

<script>
$(function(){
	$('#closeBtn').click(function(){
		$('#popup').hide(); 
		var chkVal = $ ("input:checkbox[id=inactiveToday]:checked").val(); 
		
		$.ajax ({   //ajax 통한 비동기 통신 
			url : './PopupCookie.jsp',		//서버와 통신할 주소 : URL 
			type : 'get', 					//get, post 
			data : {inactiveToday : chkVal},
			dataType: "text",
			success : function(resData){
				if (resData != '') location.reload();
			}
			
		}); 	
		
	});
});

</script>

</head>
<body>

<%
	String popupMode = "on"; 

	//쿠키의 값을 읽어 와서 popupClose 변수의 값이 off라면 popupMode변수의 값을 off
	
	Cookie[] cookie = request.getCookies(); 
	
	if (cookie != null) {
		for ( Cookie c : cookie){
			String cookieName = c.getName(); 
			String cookieValue = c.getValue(); 
			
			if ( cookieName.equals("popupClose")) {
				popupMode = cookieValue;            
			}
		}	
	}

%>

<h2> 팝업 메인 페이지 </h2>
<%
	for (int i = 1 ; i <= 10 ; i++){
		out.println ("현재 팝업 창은 " + popupMode + "상태입니다. <br> "); 
	}

	if (popupMode.equals("on")){
%>
	<!-- popupMode = "on" 일때 출력 되는 html 블락  -->

	<div id = "popup">
		<h2 align = "center"> 공지사항 팝업 입니다. </h2>
		<div align = "left">
		   -- 내용 1 <br> 
		   -- 내용 2 <br> 
		   -- 내용 3 <br> <p>
		   <form name = "popFrm">
				<input type = "checkbox" id = "inactiveToday" value = "1">
				하루동안 열리지 않기 
				<input type ="button" value = "닫기" id = "closeBtn"> 		
			</form>
		</div>	
	</div>
<%
	}
%>

</body>
</html>