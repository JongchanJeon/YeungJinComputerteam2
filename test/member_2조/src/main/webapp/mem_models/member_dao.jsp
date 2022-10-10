<!-- 로그인 판단, DB 접근, 세션값 변경 등 계산이 필요한 모든 상황을 모와둔 페이지 -->
<!-- 박진석 추가사항(2022.10.08): DB에서부터 mem_class 값을 가져와 로그인 한 유저가 관리자인지 일반 유저인지-->
<!-- 							  판단하는 if문 작성(106~119 라인) -->
<!-- 							  회원가입 페이지 접근을 위해 새로운 "register" 세션값을 설정(143~147 라인) -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
 <%@page import="java.io.PrintWriter"%>
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
	PrintWriter script = response.getWriter();

	int mem_num;
	String mem_name;
	String mem_id;
	String mem_passwd;
	String mem_email;
	String mem_phone;
	String mem_RRN;
	String mem_class;
	String memState;
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
		   pstmt.setString(7, "'user'");
		
		
		int result = pstmt.executeUpdate();
		
		if(result == 1) {

			%>
			<script>alert("정상적으로 회원가입이 되었습니다!")</script>
			<%
		} else {
			%>
			<script>alert("비정상적 접근입니다.")</script>
			<%
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

			userID = request.getParameter("userid");
		    userPW = request.getParameter("passwd");

		    
		    
		    sql = "SELECT * FROM member WHERE mem_id = '" + userID + "';";
		    ResultSet rs = stmt.executeQuery(sql);
		    
		    while (rs.next()) {
		    	
		    	userid = rs.getString("mem_id");
		    	userpasswd = rs.getString("mem_passwd");
		    	username = rs.getString("mem_name");
		    	useremail = rs.getString("mem_email");
		    	userphone = rs.getString("mem_phone");
		    	userclass = rs.getString("mem_class");
		    	userRRN = rs.getString("mem_RRN");
		    }

				
				if(userID.equals(userid) && userPW.equals(userpasswd)){
	                session.setAttribute("loginState", "login"); //현재 로그인상태인지 아닌지 체크한다. 
	                session.setAttribute("usernum", usernum); //유저 번호 저장
	                session.setAttribute("username", username); //유저 이름 저장
	                session.setAttribute("userid", userid); //유저 아이디 저장
	                session.setAttribute("userpw", userpasswd); //유저 비번 저장
	                session.setAttribute("useremail", useremail); //유저 이메일 저장
	                session.setAttribute("userphone", userphone); //유저 휴대폰 저장
	                session.setAttribute("userclass", userclass); //유저 등급 저장
	                session.setAttribute("userRRN", userRRN);
	           
	            }else{
	                session.setAttribute("loginState", "errorPW");
	                session.setAttribute("loginState", "errorID");
	            }
			
		    break;
		    
		case "LOGOUT":	// 로그인 페이지에서 빠져나오기 위해 세션값을 변경

			session.setAttribute("userid", null);
			session.setAttribute("userpw", null);
            session.setAttribute("username", null);
            session.setAttribute("useremail", null);
            session.setAttribute("userphone", null);
            session.setAttribute("userclass", null);
            session.setAttribute("userRRN", null);
			session.setAttribute("loginState", "logout");
			
			break;
			
		case "REGISTER":	// 회원가입 페이지 접근을 위해 세션값을 변경

			
			session.setAttribute("loginState", "register");
			break;
		case "수정":

	         
	         mem_num = Integer.parseInt(request.getParameter("mem_num"));
	         mem_name = request.getParameter("mem_name");
	         mem_id = request.getParameter("mem_id");
	         mem_passwd = request.getParameter("mem_passwd");
	         String mem_passwdCheck = request.getParameter("mem_passwdCheck");
	         mem_email = request.getParameter("mem_email");
	         mem_phone = request.getParameter("mem_phone");
	         mem_RRN = request.getParameter("mem_RRN");
	         mem_class = request.getParameter("mem_class");
	         
	         if(!mem_passwd.equals(mem_passwdCheck)){
	            
	            if(session.getAttribute("userclass").equals("user")){
	               %>
	               
	               <script>alert("비밀번호가 일치하지않습니다.");</script>
	               <script>alert("다시 시도해주세요");</script>
	               <script>location.href="../member_u.jsp"</script>
	               <%
	            }else if(session.getAttribute("userclass").equals("manager")){
	               %>
	               <script>alert("비밀번호가 일치하지않습니다.");</script>
	               <script>alert("다시 시도해주세요");</script>
	               <script>location.href=window.history.back();</script>
	               <%
	               
	            }
	         }
	         else if(session.getAttribute("userclass").equals("user")){

	            sql ="update member set mem_name='" + mem_name + "', mem_passwd='" + mem_passwd + "',mem_email='" + mem_email + "',mem_phone='" + mem_phone +"'" ;
	            sql += "where mem_id ='" + mem_id +"'"; 
	   			System.out.println(sql);
	            if(mem_passwd.equals(mem_passwdCheck)){
	               result = stmt.executeUpdate(sql);
	               
	               if(result == 1){
	   
	                  %>
	                  <script>alert("회원 정보를 수정을 하였습니다.");</script>
	                  <script>alert("다시 로그인을 해주세요");</script>
	                  <%
	               }
	               else {
	   
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
	   
	            }else {
	               %>
	               <script>alert("비밀번호가 일치하지 않습니다!");</script>
	               <script>location.href="../member_u.jsp"</script>
	               <%
	            }
	         }else if (session.getAttribute("userclass").equals("manager")){
	            sql = "update member set mem_name =?, mem_id =?, mem_passwd=?, mem_email=?, mem_phone =?,mem_class =? where mem_num=?";
	            mem_id = request.getParameter("mem_id");
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, mem_name);
	            pstmt.setString(2, mem_id);
	            pstmt.setString(3, mem_passwd);
	            pstmt.setString(4, mem_email);
	            pstmt.setString(5, mem_phone);
	            pstmt.setString(6, mem_class);
	            pstmt.setInt(7, mem_num);
	            System.out.printf("%s %s %s %s %s %s %d",mem_name,mem_id, mem_passwd , mem_email, mem_phone, mem_class,mem_num);
	            result = pstmt.executeUpdate();
	            if(result == 1){
	               //PrintWriter script = response.getWriter();
	               script.println("<script>");
	               script.println("alert('업데이트 성공.')");
	               script.println("</script>");
	            }
	            else{
	               //PrintWriter script = response.getWriter();
	               script.println("<script>");
	               script.println("alert('업데이트 실패.')");
	               script.println("</script>");
	            }
	         }
	         
	         
	         
	         
	         break;
			
		case "삭제":
			mem_passwd = request.getParameter("mem_passwd");
			mem_passwdCheck = request.getParameter("mem_passwdCheck");
			mem_id = String.valueOf(session.getAttribute("userid"));
			if(mem_passwd.equals(mem_passwdCheck) && mem_passwd.equals(String.valueOf(session.getAttribute("userpw")))){
				sql = "delete from member ";
				sql += "where mem_id = '" + mem_id +"'";
				
				
				result = stmt.executeUpdate(sql);
				if(result == 1){
	
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

				}
				else {
					%>
					<script>alert("회원삭제를 실패하였습니다..");</script>
					<script>location.href="../member_u.jsp"</script>
					<%


				}
				
			}else {
				%>
				<script>alert("비밀번호가 일치하지 않습니다!");</script>
				<script>location.href="../member_u.jsp"</script>
				<%
			}
			break;
		case "UPDATE":
			mem_num = -1;
			mem_name = null;
			mem_id = null;
			mem_passwd = null;
			mem_email = null;
			mem_phone = null;
			mem_RRN = null;
			mem_class = null;
			memState = null;
			boolean updatechk = Boolean.parseBoolean(request.getParameter("updatechk"));
			 if(!updatechk){
				script.println("<script>");
				script.println("history.back()");
				script.println("</script>");
				return;
			} 
		
			
			mem_num = Integer.parseInt(request.getParameter("mem_num"));
			mem_name = request.getParameter("mem_name");
			mem_id = request.getParameter("mem_id");
			mem_passwd = request.getParameter("mem_passwd");
			mem_email = request.getParameter("mem_email");
			mem_phone = request.getParameter("mem_phone");
			mem_class = request.getParameter("mem_class");
			
			memState = request.getParameter("memState");
			
			
			sql = "update member set mem_name =?, mem_id =?, mem_passwd=?, mem_email=?, mem_phone =?,mem_class =? where mem_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_name);
			pstmt.setString(2, mem_id);
			pstmt.setString(3, mem_passwd);
			pstmt.setString(4, mem_email);
			pstmt.setString(5, mem_phone);
			
			pstmt.setString(6, mem_class);
			pstmt.setInt(7, mem_num);

			result = pstmt.executeUpdate();
			if(result == 1){
				//PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('업데이트 성공.')");
				script.println("</script>");
			}
			else{
				//PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('업데이트 실패.')");
				script.println("</script>");
			}
			
			
			break;
			
		default:
			break;
	}
	
%>

<script>location.href="../index.jsp"</script>


</body>
</html>