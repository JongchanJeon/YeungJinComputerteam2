<!-- 로그인 판단, DB 접근, 세션값 변경 등 계산이 필요한 모든 상황을 모와둔 페이지 -->
<!-- 박진석 추가사항(2022.10.08): DB에서부터 mem_class 값을 가져와 로그인 한 유저가 관리자인지 일반 유저인지-->
<!-- 							  판단하는 if문 작성(106~119 라인) -->
<!-- 							  회원가입 페이지 접근을 위해 새로운 "register" 세션값을 설정(143~147 라인) -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/member_db";
	String user = "root";
	String passwd = "root";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	PreparedStatement pstmt = null;
	request.setCharacterEncoding("utf-8");

	int mem_num;
	String mem_name;
	String mem_id;
	String mem_passwd;
	String mem_email;
	String mem_phone;
	String mem_RRN;
	// sql 결과로 나온 레코드의 값들을 저장할 변수
	
	String userID;
	String userPW;
	// header.jsp 폼에서 가져온 아이디 비번 값
	
	String getID;
	String getPW;
	String getClass;
	// DB에서 가져온 아이디 비번 값
	
	String sql;
	String msg = "실행결과 : ";
	
    String actionType = request.getParameter("actionType");
	
	int loginState;

	switch(actionType) {
		case "CREATE":	// 회원가입
			System.out.println("\n-------[member_dao.jsp - actionType: CREATE]---------\n");
			
			mem_name = request.getParameter("mem_name");
			mem_id = request.getParameter("mem_id");
			mem_passwd = request.getParameter("mem_passwd");
			mem_email = request.getParameter("mem_email");
			mem_phone = request.getParameter("mem_phone");
			mem_RRN = request.getParameter("mem_RRN1")+"-"+request.getParameter("mem_RRN2");
			
			sql = "INSERT INTO member (mem_name, mem_id, mem_passwd, mem_email, mem_phone, mem_RRN, mem_class) VALUES (?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			   pstmt.setString(1, mem_name);
			   pstmt.setString(2, mem_id);
			   pstmt.setString(3, mem_passwd);
			   pstmt.setString(4, mem_email);
			   pstmt.setString(5, mem_phone);
			   pstmt.setString(6, mem_RRN);
			   pstmt.setString(7, "user");
			
			System.out.println(sql);
			
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				System.out.println("[member_dao.jsp] 레코드 추가 성공");
			} else {
				System.out.println("[member_dao.jsp] 레코드 추가 실패");
			}
			
			session.setAttribute("loginState", "logout");
			break;
			// 회원가입 부분(CREATE)은 사용하지 않음.
	}
%>

<jsp:forward page="../index.jsp"/>

</body>
</html>