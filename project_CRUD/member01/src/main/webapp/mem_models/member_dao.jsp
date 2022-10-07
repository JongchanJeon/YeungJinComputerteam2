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
	Statement stmt = con.createStatement();
	request.setCharacterEncoding("utf-8");

	int mem_num;
	String mem_name;
	String mem_id;
	String mem_passwd;
	String mem_email;
	String mem_contact;
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
	
    String actionType = request.getParameter("actionType");
	
	int loginState;

	switch( actionType){
		case "CREATE":	// 회원가입
			System.out.println("\n-------[member_dao.jsp - actionType: CREATE]---------\n");
			
			mem_name = request.getParameter("mem_name");
			mem_id = request.getParameter("mem_id");
			mem_passwd = request.getParameter("mem_passwd");
			mem_email = request.getParameter("mem_email");
			mem_contact = request.getParameter("mem_contact");
			mem_RRN = request.getParameter("mem_RRN");
			
			sql = "INSERT INTO member (mem_name, mem_id, mem_passwd, mem_email, mem_contact, mem_RRN) VALUES ('";
			sql += mem_name + "', '"  + mem_id + "', '" + mem_passwd + "','" + mem_email + "','" + mem_contact + "','" + mem_RRN + "');";
			
			System.out.println(sql);
			
			int result = stmt.executeUpdate(sql);
			
			if(result == 1) {
				System.out.println("[member_dao.jsp] 레코드 추가 성공");
				out.println("<script>");
			    out.println("alert('회원가입에 성공하였습니다.');");	// alert가 왜 안되냐 진짜;;;;;;;
			    out.println("</script>");
			} else {
				System.out.println("[member_dao.jsp] 레코드 추가 실패");
			}
			
			session.setAttribute("loginState", "logout");
			break;
			// 회원가입 부분(CREATE)은 사용하지 않음.
	
		case "LOGIN":	// 로그인
			System.out.println("\n-------[member_dao.jsp - actionType: LOGIN]---------\n");
			
			userID = request.getParameter("userid");
		    userPW = request.getParameter("passwd");
		    System.out.println("[member_dao.jsp] userID: " + userID);
		    System.out.println("[member_dao.jsp] userPW: " + userPW);
		    
		    
		    sql = "SELECT mem_id, mem_passwd, mem_class FROM member WHERE mem_id = '" + userID + "';";
		    ResultSet rs = stmt.executeQuery(sql);
		    System.out.println("[member_dao.jsp] sql: " + sql);
		    
		    while (rs.next()) {
				getID = rs.getString("mem_id");
				getPW = rs.getString("mem_passwd");
				getClass = rs.getString("mem_class");
				
				System.out.println("[member_dao.jsp] getId: " + getID);
				System.out.println("[member_dao.jsp] getPw: " + getPW);
				System.out.println("[member_dao.jsp] getClass: " + getClass);
				
				if( userID.equals(getID)){
			    	if( userPW.equals(getPW)){
			    		if(getClass.equals("관리자")){	// memClass 컬럼을 통해 관리자 또는 일반 사용자 판단
			    			session.setAttribute("loginState", "managerLogin");
				    		session.setAttribute("userid", userID);
				    		session.setAttribute("userpw", userPW);
				    		System.out.println("[member_dao.jsp] session userid:" + session.getAttribute("userid"));
				    		System.out.println("[member_dao.jsp] session loginState:" + session.getAttribute("loginState"));
				    		System.out.println("관리자 로그인 처리 완료");
			    		}else{
			    			session.setAttribute("loginState", "login");
				    		session.setAttribute("userid", userID);
				    		session.setAttribute("userpw", userPW);
				    		System.out.println("[member_dao.jsp] session userid:" + session.getAttribute("userid"));
				    		System.out.println("로그인 처리 완료");
			    		}
			    		
			    	}else{
			    		session.setAttribute("loginState", "errorPW");
			    	}
			    }else{
			    	session.setAttribute("loginState", "errorID");
			    }
			}
		    break;
		    
		case "LOGOUT":	// 로그인 페이지에서 빠져나오기 위해 세션값을 변경
			System.out.println("\n-------[member_dao.jsp - actionType: LOGOUT]---------\n");
			
			session.setAttribute("userid", null);
			session.setAttribute("userpw", null);
			session.setAttribute("loginState", "logout");
			
			System.out.println("[member_dao.jsp] session userid:" + session.getAttribute("userid"));
			System.out.println("로그아웃 처리 완료");
			break;
			
		case "REGISTER":	// 회원가입 페이지 접근을 위해 세션값을 변경
			System.out.println("\n-------[member_dao.jsp - actionType: REGISTER]---------\n");
			
			session.setAttribute("loginState", "register");
			break;
		
		default:
			break;
	}
%>

<jsp:forward page="../index.jsp"/>

</body>
</html>