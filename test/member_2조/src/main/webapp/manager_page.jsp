<!-- 관리자 모드(loginState 세션값이 "managerLogin"일 때 활성)의 로그인 페이지 -->
<!-- 박진석 수정사항(2022.10.08): 조회 및 수정만 가능한 페이지 링크만 살리고 삭제 페이지 링크는 제거 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
</head>
<body>
	<div style="text-align:center;">
		<h3 style="color:red;"><b>⚠ 관리자 모드로 로그인되었습니다. ⚠</b></h3>
		<img src="./images/yju_com_01.jpg" />
	</div>
	<div style="width: 400px; margin:0 auto; ">
		<ul class="list-group">
			<a href="./member_m.jsp?currentPageNo=0&limitCnt=10" class="list-group-item list-group-item-action">
				<li class="list-group-item d-flex justify-content-between align-items-center">
					<i class="bi-person-lines-fill" style="font-size: 64px;"></i>
					<div style="margin-left: 20px">
						<h5><b>회원정보 조회 및 수정</b></h5>
						<small> 유저의 모든 정보를 보려면 여기를 클릭하세요.</small>
					</div>
				</li>
			</a>
		</ul>
	</div>
</body>
</html>