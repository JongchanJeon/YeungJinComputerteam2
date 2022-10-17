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
<style>
<%
	if( session.isNew()){
		session.setAttribute("loginState", "logout");
		session.setAttribute("viewState", "main");
		session.setAttribute("userid", null);
		session.setAttribute("userpw", null);
		session.setAttribute("usernum", null);
		session.setAttribute("useremail", null);
		session.setAttribute("userphone", null);
		session.setAttribute("userclass", null);
		session.setAttribute("username", null);
		session.setAttribute("userRRN", null);
		
	}
%>
<%
if(session.getAttribute("loginState").equals("login") && session.getAttribute("userclass").equals("manager")){
%>
		#navigationBox{
			background-color: #ffcdcd;
			
		}
		
		#loginForm{
			background-color: #fca9a9;
			padding:10px;
			border-radius: 10px;
		}
<%
	} else if((Thread.currentThread().getStackTrace()[1].getFileName()).contains("join") == true) {
%>
		#navigationBox{
			background-color: #d5f7e8;
		}
		
		#loginForm{
			background-color: #9aedc9;
			padding:10px;
			border-radius: 10px;
		}
<%		
	} else {
%>
		#navigationBox{
			background-color: #e3f2fd;
		}
		
		#loginForm{
			background-color: #baddf7;
			padding:10px;
			border-radius: 10px;
		}
<%
	}
	// 관리자 로그인 페이지, 회원가입 페이지, 일반 로그인 페이지에 따라 버튼과 헤더 색이 달라지는 코드 
%>
</style>
</head>
<body>



<nav class="navbar navbar-light" id="navigationBox">
	<a class="navbar-brand">
    	<img src="./images/yju_logo_01.png" style="max-width: 90%; height: auto;">
    	<img src="./images/system_logo_01.png" class="d-inline-block" alt="">
	</a>
  
<%
	if(session.getAttribute("loginState").equals("login") || session.getAttribute("loginState").equals("managerLogin")){
%>
	<div id="loginForm">
		<form name="logout" method="post" action="./mem_models/member_dao.jsp">	 
			<table>
				<tr>				
					<td><b><%=session.getAttribute("userid")%></b>님 반가워요!</td>
					<td>&nbsp&nbsp</td>
					<td style="text-align: center;">
						<button type="submit" name="actionType" value="LOGOUT" 
								class="<% if(session.getAttribute("userclass").equals("manager")){ %> btn btn-danger
										<% } else { %> btn btn-primary <% } %>">로그아웃</button>
						<!-- 로그인한 사용자가 관리자면 버튼을 붉은색으로, 아니면 기본 파란색으로 처리하는 코드. -->
					</td>
				</tr>
			</table>
		</form>
	</div>
<%
	}
	else{
%>		 
	<div id="loginForm">
			<form name="login" method="post" action="./mem_models/member_dao.jsp">	 
				<table style="border-collapse: separate; border-spacing: 30px 0;">
					<tr>
						<td><input type="text" placeholder="아이디" class="form-control form-control-sm" id="idForm" name="userid" ></td>
					</tr>
					
					<tr>
						<td><input type="password" placeholder="비밀번호" class="form-control form-control-sm" id="pwForm" name="passwd"></td>
					</tr>
					<tr>
						<td colspan="3" style="text-align: center;">
							<button type="submit" name="actionType" value="LOGIN" 
									class="btn btn-primary">로그인</button>
							
							<button type="submit" formaction="./member_join.jsp" 
									class="btn btn-success">회원가입</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	
<%
	if(session.getAttribute("loginState").equals("errorID")){
		System.out.println("사용자 ID 오류");
		out.println("<script>alert('사용자의 아이디를 잘못 입력하였습니다.');</script>");
	}
		
		if(session.getAttribute("loginState").equals("errorPW")){
			System.out.println("사용자 PW 오류");
			out.println("<script>alert('사용자의 비밀번호를 잘못 입력하였습니다.');</script>");
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