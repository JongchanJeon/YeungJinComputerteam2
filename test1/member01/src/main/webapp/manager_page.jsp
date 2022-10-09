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
<body style="background-color: #ffcdcd;">
<!-- 관리자모드 식별을 쉽게 하기 위해 배경을 붉은색으로 변경함. 이는 추후에 보기 좋게 수정 예정 -->
	<img src="/member01/images/yju_com_01.jpg" />
	<div class="container">
	<h3 style="color:red;"><b>⚠ 관리자 모드로 로그인되었습니다. ⚠</b></h3>
		<div class="row">
			<div class="col-12 col-sm-8 col-lg-5">
				<ul class="list-group">
					<a href="/member01/member_m.jsp" class="list-group-item list-group-item-action">
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
		</div>
	</div>
</body>
</html>

<!-- 디자인 수정예정: 로그인 알림 글자와 페이지 링크 가운데 정렬, 전체적으로 붉은 화면 개선 -->