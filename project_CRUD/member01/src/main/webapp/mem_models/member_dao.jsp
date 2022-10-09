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
	PreparedStatement pstmt = null;
	request.setCharacterEncoding("utf-8");

	int mem_num;
	String mem_name;
	String mem_id;
	String mem_passwd;
	String mem_email;
	String mem_phone;
	String mem_RRN;
	String mem_class;
	// sql 결과로 나온 레코드의 값들을 저장할 변수
	
	String userID;
	String userPW;
	// header.jsp 폼에서 가져온 아이디 비번 값
	
	
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
		mem_phone = request.getParameter("mem_phone");
		mem_RRN = String.valueOf(request.getParameter("mem_RRN1"))+"-"+String.valueOf(request.getParameter("mem_RRN2"));
		
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
	
		case "LOGIN":	// 로그인
			int usernum = -1;
			String userid = null;
			String userpasswd = null;
			String username = null;
			String useremail = null;
			String userphone = null;
			String userclass = null;
			String userRRN = null;
			System.out.println("\n-------[member_dao.jsp - actionType: LOGIN]---------\n");
			
			userID = request.getParameter("userid");
		    userPW = request.getParameter("passwd");
		    System.out.println("[member_dao.jsp] userID: " + userID);
		    System.out.println("[member_dao.jsp] userPW: " + userPW);
		    
		    
		    sql = "SELECT * FROM member WHERE mem_id = '" + userID + "';";
		    ResultSet rs = stmt.executeQuery(sql);
		    System.out.println("[member_dao.jsp] sql: " + sql);
		    
		    while (rs.next()) {
		    	
		    	userid = rs.getString("mem_id");
		    	userpasswd = rs.getString("mem_passwd");
		    	username = rs.getString("mem_name");
		    	useremail = rs.getString("mem_email");
		    	userphone = rs.getString("mem_phone");
		    	userclass = rs.getString("mem_class");
		    	userRRN = rs.getString("mem_RRN");
		    }
				System.out.println(userid);
				System.out.println(userpasswd);
				System.out.println(username);
				System.out.println(useremail);
				System.out.println(userphone);
				System.out.println(userclass);
				System.out.println(userRRN);
				
				System.out.println("[member_dao.jsp] getId: " + userid);
				System.out.println("[member_dao.jsp] getPw: " + userpasswd);
				System.out.println("[member_dao.jsp] getClass: " + userclass);
				
				if( userID.equals(userid)){
			    	if( userPW.equals(userpasswd)){
			    		if(userclass.equals("관리자")){	// memClass 컬럼을 통해 관리자 또는 일반 사용자 판단
			    			session.setAttribute("loginState", "managerLogin");
				    		session.setAttribute("userid", userid);
				    		session.setAttribute("userpw", userpasswd);
			                session.setAttribute("username", username); //유저 이름 저장
			                session.setAttribute("useremail", useremail); //유저 이메일 저장
			                session.setAttribute("userphone", userphone); //유저 휴대폰 저장
			                session.setAttribute("userclass", userclass); //유저 등급 저장
			                session.setAttribute("userRRN", userRRN); //유저 등급 저장
				    		System.out.println("[member_dao.jsp] session userid:" + session.getAttribute("userid"));
				    		System.out.println("[member_dao.jsp] session loginState:" + session.getAttribute("loginState"));
				    		System.out.println("관리자 로그인 처리 완료");
			    		}else{
			    			session.setAttribute("loginState", "login");
				    		session.setAttribute("userid", userid);
				    		session.setAttribute("userpw", userpasswd);
			                session.setAttribute("username", username); //유저 이름 저장
			                session.setAttribute("useremail", useremail); //유저 이메일 저장
			                session.setAttribute("userphone", userphone); //유저 휴대폰 저장
			                session.setAttribute("userclass", userclass); //유저 등급 저장
			                session.setAttribute("userRRN", userRRN); //유저 등급 저장
				    		System.out.println("[member_dao.jsp] session userid:" + session.getAttribute("userid"));
				    		System.out.println("로그인 처리 완료");
			    		}
			    		
			    	}else{
			    		session.setAttribute("loginState", "errorPW");
			    	}
			    }else{
			    	session.setAttribute("loginState", "errorID");
			    }
			
		    break;
		    
		case "LOGOUT":	// 로그인 페이지에서 빠져나오기 위해 세션값을 변경
			System.out.println("\n-------[member_dao.jsp - actionType: LOGOUT]---------\n");
			
			session.setAttribute("userid", null);
			session.setAttribute("userpw", null);
            session.setAttribute("username", null);
            session.setAttribute("useremail", null);
            session.setAttribute("userphone", null);
            session.setAttribute("userclass", null);
            session.setAttribute("userRRN", null);
			session.setAttribute("loginState", "logout");
			
			System.out.println("[member_dao.jsp] session userid:" + session.getAttribute("userid"));
			System.out.println("로그아웃 처리 완료");
			break;
			
		case "REGISTER":	// 회원가입 페이지 접근을 위해 세션값을 변경
			System.out.println("\n-------[member_dao.jsp - actionType: REGISTER]---------\n");
			
			session.setAttribute("loginState", "register");
			break;
		
		case "수정":
			System.out.println("\n-------[member_dao.jsp - actionType: UPDATE]---------\n");
			String mem_passwdCheck;
			mem_name = request.getParameter("mem_name");
			mem_id = String.valueOf(session.getAttribute("userid"));
			mem_passwd = request.getParameter("mem_passwd");
			mem_passwdCheck = request.getParameter("mem_passwdCheck");
			mem_email = request.getParameter("mem_email");
			mem_phone = request.getParameter("mem_phone");
			mem_RRN = request.getParameter("mem_RRN");
			mem_class = request.getParameter("userclass");
			System.out.println(mem_passwdCheck);
			sql ="update member set mem_name='" + mem_name + "', mem_passwd='" + mem_passwd + "',mem_email='" + mem_email + "',mem_phone='" + mem_phone +"'" ;
			sql += "where mem_id ='" + mem_id +"'"; 
			System.out.println(sql);
			if(mem_passwd.equals(mem_passwdCheck)){
				result = stmt.executeUpdate(sql);
				
				if(result == 1){
					System.out.println("회원정보 수정 성공");
					%>
					<script>alert("회원 정보를 수정을 하였습니다.");</script>
					<script>alert("다시 로그인을 해주세요");</script>
					<%
				}
				else {
					System.out.println("회원정보 수정 실패");
					%>
					<script>alert("예상치 못한 이유로 수정을 실패하였습니다.");</script>
					<script>alert("다시 로그인을 해주세요");</script>
					<%
				}
				session.setAttribute("userid", null);
				session.setAttribute("userpw", null);
	            session.setAttribute("username", null);
	            session.setAttribute("useremail", null);
	            session.setAttribute("userphone", null);
	            session.setAttribute("userclass", null);
	            session.setAttribute("userRRN", null);
				session.setAttribute("loginState", "logout");
				System.out.println("로그아웃 처리 완료");
			}else {
				System.out.println("비밀번호 불일치");
				%>
				<script>alert("비밀번호가 일치하지 않습니다!");</script>
				<script>location.href="../member_u.jsp"</script>
				<%
			}
			
			break;
			
		case "삭제":
			mem_passwd = request.getParameter("mem_passwd");
			mem_passwdCheck = request.getParameter("mem_passwdCheck");
			mem_id = String.valueOf(session.getAttribute("userid"));
			if(mem_passwd.equals(mem_passwdCheck) && mem_passwd.equals(String.valueOf(session.getAttribute("userpw")))){
				sql = "delete from member ";
				sql += "where mem_id = '" + mem_id +"'";
				System.out.println("sql : " + sql);
				
				result = stmt.executeUpdate(sql);
				if(result == 1){
					System.out.println("회원 삭제 성공");
					
					session.setAttribute("userid", null);
					session.setAttribute("userpw", null);
		            session.setAttribute("username", null);
		            session.setAttribute("useremail", null);
		            session.setAttribute("userphone", null);
		            session.setAttribute("userclass", null);
		            session.setAttribute("userRRN", null);
					session.setAttribute("loginState", "logout");
					%>
					<script>alert("회원삭제가 정상적으로 되었습니다.");</script>
					<%
					System.out.println("로그아웃 처리 완료");
				}
				else {
					%>
					<script>alert("회원삭제를 실패하였습니다..");</script>
					<script>location.href="../member_u.jsp"</script>
					<%
					System.out.println("회원 삭제 실패");

				}
				
			}else {
				System.out.println("비밀번호 불일치");
				%>
				<script>alert("비밀번호가 일치하지 않습니다!");</script>
				<script>location.href="../member_u.jsp"</script>
				<%
			}
			break;
		default:
			break;
	}
	
%>

<script>location.href="../index.jsp"</script>


</body>
</html>