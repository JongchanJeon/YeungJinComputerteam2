<!-- 일반사용자가 자기 자신의 정보를 수정하는 페이지 -->
<!-- 박진석 추가사항(2022.10.08): 메인 메뉴(로그인 페이지)로 이동할 수 있는 버튼 추가(70라인)-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

    <meta charset="UTF-8">

    <title>수정페이지</title>
</head>
<body>
<%@ include file="../header.jsp" %>
<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/member_db";
	String user = "root";
	String passwd = "root";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	Statement stmt = con.createStatement();
	request.setCharacterEncoding("utf-8");
%>
<%
	int mem_num;
	String mem_name;
	String mem_id;
	String mem_passwd;
	String mem_email;
	String mem_phone;
	String mem_RRN;
	String mem_class;
	
String sql = "select * from member where mem_id = '" + (String) session.getAttribute("userid") + "'";
	System.out.println(sql);
	ResultSet rs = stmt.executeQuery(sql);
	while (rs.next()) {
		mem_name = rs.getString("mem_name");
		mem_id = rs.getString("mem_id");
		mem_passwd = rs.getString("mem_passwd");
		mem_email = rs.getString("mem_email");
		mem_phone = rs.getString("mem_phone");
		mem_RRN = rs.getString("mem_RRN");
		mem_class = rs.getString("mem_class");
		System.out.println(mem_RRN);
		
		System.out.println(session.getAttribute("userpw"));
	}
%>

<div class="container row">
    <div class="col-lg-5"></div>
    <div class="col-lg-6">
        <div style="padding-top:20px;">
            <h3 style="text-align: center;" class="mb-2">수정 페이지 </h3> <!-- 제목  -->

            <form class="validation-form" method="post" action="../member01/member_dao.jsp"> <!-- 경로 수정  !-->

                <div class="form-group">
                	<input class="form-control mb-2" type="text" name = "mem_name" value = <%=session.getAttribute("username")%> required>             
                </div>

                <div class="form-group">
                    <input class="form-control mb-2" type="text" name="mem_id" placeholder="아이디" value=<%=session.getAttribute("userid")%> required disabled>
                </div>
                <div class="form-group">
                    <input class="form-control mb-2"  type="text" name="mem_passwd"  placeholder="비밀번호"  required>
                </div>

                <div class="form-group has-danger">
                    <input class="form-control mb-2"  type="text" name="" placeholder="비밀번호 재확인"  required> <!-- name 추가 !-->
                </div>
                <div class="form-group">

                    <input class="form-control mb-2"  type="email" name="mem_email" placeholder="이메일 @ " value=<%=session.getAttribute("useremail")%>>
                </div>

                <div class="form-group">
                    <input class="form-control mb-2"  type="text" name="mem_phone" oninput="autoHyphen(this)" value=<%=session.getAttribute("userphone")%> maxlength="12" placeholder="핸드폰(숫자만 입력해주세요)">
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <input type="text" class="form-control mb-2" id="mem_RRN1" placeholder="주민번호 ( 6자리 -" value=<%=String.valueOf(session.getAttribute("userRRN")).substring(0, 6) %> maxlength="6" required disabled> <!-- name 변경 !-->
                    </div>
                    <div class="col-md-6 mb-3">
                        <input type="text" class="form-control mb-2" id="mem_RRN2" placeholder=" 7자리 )" value=<%=String.valueOf(session.getAttribute("userRRN")).substring(7, 14) %> maxlength="7" required disabled> <!-- name 변경 !-->
                    </div>
                </div>

                <div class="form-group">
                    <input class="form-control mb-2" type="text" name="mem_class" placeholder="등급" value=<%=session.getAttribute("userclass")%> disabled>
                </div>
				<div>
				<button type="submit" class="btn btn-danger float-right" data-toggle="modal" data-target="#exampleModal1" >삭제</button>
				<input type="hidden" name="actionType" value="UPDATE">
				</div>
                
                <button type="button" class="btn btn-primary float-right mx-2 "  data-toggle="modal" data-target="#exampleModal" >수정</button>
                
                <button type="button" class="btn btn-dark float-right" onclick="location.href='../member01/index.jsp'">취소</button>
            </form>
        </div>
    </div>
</div>


<!-- Modal -->

<!-- 수정 모달 !-->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">수정 하시겠습니까?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    수정 하시겠습니까?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick ="location.href='./mem_models/member_dao.jsp?actionType=UPDATE'">수정하기</button> <!-- 데이터 추가  -->
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

<!-- 삭제 모달 !-->
    <div class="modal fade" id="exampleModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">삭제 하시겠습니까?</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    삭제 하시겠습니까?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick ="location.href='./mem_models/member_dao.jsp?actionType=DELETE'">삭제하기</button> <!-- 데이터 추가  -->
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"> 닫기 </button>
                </div>
            </div>
        </div>
</div>

<%@ include file="../footer.jsp" %>
</body>
</html>