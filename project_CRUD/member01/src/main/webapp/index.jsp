<!-- 헤더와 푸터를 포함하여 로그아웃, 로그인, 회원가입 등 여러 페이지를 출력하는 통합 페이지 -->
<!-- 박진석 추가사항(2022.10.08): 관리자 모드로 로그인 했을 때의 페이지를 가져오는 코드 추가(27~30라인)-->

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
<%@ include file="./header.jsp" %>
<%
	System.out.println("\n-------[index.jsp]---------\n");
	System.out.println("[index.jsp] session loginState:" + session.getAttribute("loginState"));
	
	if(session.getAttribute("loginState").equals("login")){
%>
		 <jsp:include page="./login_page.jsp"/>
<%
	}else if (session.getAttribute("loginState").equals("managerLogin")){
%>
		 <jsp:include page="./manager_page.jsp"/>
<%
 	}else if (session.getAttribute("loginState").equals("register")){
%>
 		<jsp:include page="./member_join.jsp"/>
<%
	}else {
%>
		 <jsp:include page="./logout_page.jsp"/>
<%
	}
%>		 
<%@ include file="./footer.jsp" %>
</body>
</html>

<!-- 디자인 개선사항: 필요시 기본 제공되는 사진을 변경 -->