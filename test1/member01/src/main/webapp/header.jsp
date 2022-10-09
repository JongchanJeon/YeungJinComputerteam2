<!-- 로그인 폼, 로그아웃 폼과 시스템 이름이 있는 헤더 -->
<!-- 박진석 추가사항(2022.10.08): 회원가입 버튼 활성화 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" 
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" 
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" 
	crossorigin="anonymous">
</head>
<body>

<%
	if( session.isNew()){
		session.setAttribute("loginState", "managerLogin");
		session.setAttribute("userid", null);
		session.setAttribute("userpw", null);
		session.setAttribute("viwState", "main");
		session.setAttribute("mem_num", null);
		session.setAttribute("mem_name", null);
		session.setAttribute("mem_id", null);
		session.setAttribute("mem_pw", null);
		session.setAttribute("mem_email", null);
		session.setAttribute("mem_phone", null);
		session.setAttribute("mem_class", null);
	}
%>

<nav class="navbar navbar-light" style="background-color: #e3f2fd;">
	<a class="navbar-brand">
    	<img src="/member01/images/yju_logo_01.png" class="d-inline-block" alt="">
    	<img src="/member01/images/system_logo_01.png" class="d-inline-block" alt="">
	</a>
  
<%
	if(session.getAttribute("loginState").equals("login") || session.getAttribute("loginState").equals("managerLogin")){
%>
	
	<div class="alert alert-primary" role="alert">
		<form name="logout" method="post" action="/member01/mem_models/member_dao.jsp">
			<div class = "row" >
				<div class="col" display="flex" align-items="center"><%=session.getAttribute("userid")%>님 반가워요!</div>
				<div class="col">
				<input type="hidden" name="actionType" value="LOGOUT">
			 	<button type="submit" class="btn btn-primary">로그아웃</button>
				</div>			
			</div>
		</form>
	</div>
<%
	}
	else{
%>		 
	<div style="background-color: #baddf7; padding:10px; border-radius: 10px;" >
		<form name="login" method="post" action="/member01/mem_models/member_dao.jsp">
			<div>
		  		<label for="idForm" >아이디<input type="text" class="form-control form-control-sm" id="idForm" name="userid">
		  		</label>
		  	</div>
		  	<div>
		  		<label for="pwForm">비밀번호<input type="password" class="form-control form-control-sm" id="pwForm" name="passwd">
		  		</label>
		  	</div>
		<input type="hidden" name="actionType" value="LOGIN">
		<button type="submit" class="btn btn-primary">로그인</button>

		</form>
		<form method="post" action="/member01/mem_models/member_dao.jsp">
			<input type="hidden" name="actionType" value="REGISTER">
		  	<button type="submit" class="btn btn-primary">회원가입</button>
		</form>
	</div>
	
<%
	if(session.getAttribute("loginState").equals("errorID")){
		out.print("[사용자ID오류]");
	}
		
		if(session.getAttribute("loginState").equals("errorPW")){
			out.print("[사용자PW오류]");
		}
	}
%>
</nav>
<%
	if(session.getAttribute("loginState").equals("login") || session.getAttribute("loginState").equals("managerLogin")){
%>
		<%@ include file= "/GNB.jsp" %>
<%
	}
%>
<hr> 
</body>
</html>

<!-- 디자인 수정예정: 로그인 폼,로그아웃 폼의 재정렬 -->