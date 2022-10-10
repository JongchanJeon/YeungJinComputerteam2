<!-- 일반 로그인을 했을 때의 나타나는 페이지 -->
<!-- 박진석 수정사항(2022.10.08): 수정 페이지로 가는 링크와 삭제 페이지로 가는 링크 통합  -->

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
		<img src="./images/yju_com_01.jpg" />
	</div>
	<div style="display: flex; justify-content: center;">
		<div style="width: 400px; margin: 20px">
			<ul class="list-group">
				<a href="./member_u.jsp" class="list-group-item list-group-item-action">
					<li class="list-group-item d-flex justify-content-between align-items-center">
						<i class="bi-pencil-square" style="font-size: 64px;"></i>
						<div style="margin-left: 20px">
							<h5><b>회원정보 수정 및 삭제</b></h5>
							<small> 개인 정보를 변경하거나 삭제하려면 여기를 클릭하세요.</small>
						</div>
					</li>
				</a>
			</ul>
		</div>
	</div>
</body>
</html>

<!-- 디자인 수정예정: 페이지 링크 가운데 정렬, 페이지 링크의 레이아웃 보기 좋게 수정 -->