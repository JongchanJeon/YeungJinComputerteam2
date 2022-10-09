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
	String passwd = "maria";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url,user,passwd);
	PreparedStatement pstmt = null;
	request.setCharacterEncoding("UTF-8");
	PrintWriter script = response.getWriter();

	int result;
	int mem_num = -1;
	String mem_name = null;
	String mem_id = null;
	String mem_passwd = null;
	String mem_email = null;
	String mem_phone = null;
	String mem_RRN = null;
	String mem_class = null;
	String memState = null;
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
	case "UPDATE":
		boolean updatechk = Boolean.parseBoolean(request.getParameter("updatechk"));
		System.out.println(updatechk+"형변환");
		System.out.println(request.getParameter("updatechk"));
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
		
        
		System.out.println(sql);
		System.out.printf("%s %s %s %s %s %s %d",mem_name,mem_id, mem_passwd , mem_email, mem_phone,mem_class,mem_num);
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
		
	}
%>

<jsp:forward page="../index.jsp"/>

</body>
</html>