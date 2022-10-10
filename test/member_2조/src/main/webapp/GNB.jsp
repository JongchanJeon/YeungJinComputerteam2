<!-- 헤더 아래에 페이지 간 이동을 쉽게 할 수 있는 네비게이션 바 -->
<!-- 박진석 수정사항(2022.10.08): 관리자 모드냐, 일반 사용자 모드냐에 따라 출력되는 메뉴가 다르게끔 설정(27~43라인)-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
<%
	if(session.getAttribute("userclass").equals("manager")){
%>
		#navigationBox{
			background-color: #ffcdcd;
			
		}

<%		
	} else {
%>
		#navigationBox{
			background-color: #e3f2fd;
		}
<%
	}
%>
</style>
</head>
<body>
<br>
<nav class="navbar navbar-expand-lg navbar-light" id="navigationBox">
	<a class="navbar-brand">Member Management System v0.1</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
    	<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarText">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
				<a class="nav-link" href="./index.jsp">메인메뉴 <span class="sr-only">(current)</span></a>
			</li>
			<li class="nav-item">
<%
			if(session.getAttribute("userclass").equals("manager")){
%>
	        	<a class="nav-link" href="./member_m.jsp?currentPageNo=0&limitCnt=10">조회 및 수정</a>
<%
	        } else {
%>
	        	<a class="nav-link" href="./member_u.jsp">수정 및 삭제</a>
<%
	        }
%>
			</li>
		</ul>
   		<span class="navbar-text">
			<small><i>원하는 메뉴를 클릭하세요!</i></small>
   		</span>
	</div>
</nav>

</body>
</html>