<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>idCheckProc.jsp</title>
</head>
<body>
	<div style="text-align: center"></div>
	<h3>* 아이디 중복 확인 결과 *</h3>
	<%
		String driverName = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://localhost/member_db";
		String user = "root";
		String passwd = "root";
		
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url, user, passwd);
		Statement stmt = con.createStatement();
		request.setCharacterEncoding("utf-8");
		PreparedStatement pstmt;
		
		String mem_id;
		
		String SQL = "SELECT mem_id FROM member WHERE mem_id= ?";
	    pstmt = con.prepareStatement(SQL);
	    ResultSet rs;
	    String id = "";

       id = request.getParameter("mem_id");
       pstmt.setString(1, id);
       rs = pstmt.executeQuery();
	   
       if(rs.next()){
			if(rs.getString(1).equals(id)){
				out.println("<p style='color: red'>해당 아이디는 사용하실 수 없습니다.</p>");	
			}
		}
   		else 
   		{ 
		out.println("<p>사용 가능한 아이디입니다.</p>");
		out.println("<a href='javascript:apply(\"" + id + "\")'>[적용]</a>");
	%>
		<script>
	    	function apply(id){
	            //2) 중복확인 id를 부모창에 적용
	            //부모창 opener
	            opener.document.actionType.id.value=id;
	            window.close(); //창닫기
	        }//apply () end
	    </script>
		<%}%>
 <hr>
 <a href="javascript:history.back()">[다시시도]</a>
 &nbsp; &nbsp;
 <a href="javascript:window.close()">[창닫기]</a>
 </body>
 
 </html>