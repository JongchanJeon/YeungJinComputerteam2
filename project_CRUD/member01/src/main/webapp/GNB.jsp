<!-- 헤더 아래에 페이지 간 이동을 쉽게 할 수 있는 네비게이션 바 -->
<!-- 박진석 수정사항(2022.10.08): 관리자 모드냐, 일반 사용자 모드냐에 따라 출력되는 메뉴가 다르게끔 설정(27~43라인)-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<br>

<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #e3f2fd;">
	<a class="navbar-brand">Member Management System v0.1</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
    	<span class="navbar-toggler-icon"></span>
	</button>
		<div class="collapse navbar-collapse" id="navbarText">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="/member01/index.jsp">메인메뉴 <span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item">
<%
				if(session.getAttribute("loginState").equals("login")){
%>
		        	<a class="nav-link" href="/member01/mem_views/member01.jsp">조회</a>
<%
		        } else {
%>
		        	<a class="nav-link" href="/member01/member_m.jsp">조회 및 수정</a>
<%
		        }
%>
				</li>
				<li class="nav-item">
<%
				if(session.getAttribute("loginState").equals("login")){
%>
					<a class="nav-link" href="/member01/member_u.jsp">수정 및 삭제</a>
<%
				}
%>
				</li>
			</ul>
    	<span class="navbar-text">
			<small><i>원하는 메뉴를 클릭하세요요요요요!</i></small>
    	</span>
	</div>
</nav>
</body>
</html>

<!--  디자인 수정 예정: 관리자 모드 로그인 페이지에서의 색을 붉은 색으로 변경 예정 -->