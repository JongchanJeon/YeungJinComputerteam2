<!-- 관리자 모드로 사용자 DB를 조회 및 수정하는 페이지 -->
<!-- 박진석 추가사항(2022.10.08): 왼쪽 아래 메인메뉴(로그인 페이지)로 이동할 수 있는 버튼 추가 - 277라인 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>관리자 페이지</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    <style>
        body {
            color: #566787;
            font-family: 'Varela Round', sans-serif;
            font-size: 13px;
        }
        .table-responsive {
            margin: 30px 0;
        }
        .table-wrapper {
            background: #fff;
            padding: 20px 25px;
            border-radius: 3px;
            min-width: 1000px;
            box-shadow: 0 1px 1px rgba(0,0,0,.05);
        }
        .table-title {
            padding-bottom: 15px;
            background: #435d7d;
            color: #fff;
            padding: 16px 30px;
            min-width: 100%;
            margin: -20px -25px 10px;
            border-radius: 3px 3px 0 0;
        }
        .table-title h2 {
            margin: 5px 0 0;
            font-size: 24px;
        }
        .table-title .btn-group {
            float: right;
        }
        .table-title .btn {
            color: #fff;
            float: right;
            font-size: 13px;
            border: none;
            min-width: 50px;
            border-radius: 2px;
            border: none;
            outline: none !important;
            margin-left: 10px;
        }
        .table-title .btn i {
            float: left;
            font-size: 21px;
            margin-right: 5px;
        }
        .table-title .btn span {
            float: left;
            margin-top: 2px;
        }
        table.table tr th, table.table tr td {
            border-color: #e9e9e9;
            padding: 12px 15px;
            vertical-align: middle;
        }
        table.table tr th:first-child {
            width: 60px;
        }
        table.table tr th:last-child {
            width: 100px;
        }
        table.table-striped tbody tr:nth-of-type(odd) {
            background-color: #fcfcfc;
        }
        table.table-striped.table-hover tbody tr:hover {
            background: #f5f5f5;
        }
        table.table th i {
            font-size: 13px;
            margin: 0 5px;
            cursor: pointer;
        }
        table.table td:last-child i {
            opacity: 0.9;
            font-size: 22px;
            margin: 0 5px;
        }
        table.table td a {
            font-weight: bold;
            color: #566787;
            display: inline-block;
            text-decoration: none;
            outline: none !important;
        }
        table.table td a:hover {
            color: #2196F3;
        }
        table.table td a.edit {
            color: #FFC107;
        }
        table.table td a.delete {
            color: #F44336;
        }
        table.table td i {
            font-size: 19px;
        }
        table.table .avatar {
            border-radius: 50%;
            vertical-align: middle;
            margin-right: 10px;
        }
        .pagination {
            float: right;
            margin: 0 0 5px;
        }
        .pagination li a {
            border: none;
            font-size: 13px;
            min-width: 30px;
            min-height: 30px;
            color: #999;
            margin: 0 2px;
            line-height: 30px;
            border-radius: 2px !important;
            text-align: center;
            padding: 0 6px;
        }
        .pagination li a:hover {
            color: #666;
        }
        .pagination li.active a, .pagination li.active a.page-link {
            background: #03A9F4;
        }
        .pagination li.active a:hover {
            background: #0397d6;
        }
        .pagination li.disabled i {
            color: #ccc;
        }
        .pagination li i {
            font-size: 16px;
            padding-top: 6px
        }
        .hint-text {
            float: left;
            margin-top: 10px;
            font-size: 13px;
        }
        /* Modal styles */
        .modal .modal-dialog {
            max-width: 400px;
        }
        .modal .modal-header, .modal .modal-body, .modal .modal-footer {
            padding: 20px 30px;
        }
        .modal .modal-content {
            border-radius: 3px;
            font-size: 14px;
        }
        .modal .modal-footer {
            background: #ecf0f1;
            border-radius: 0 0 3px 3px;
        }
        .modal .modal-title {
            display: inline-block;
        }
        .modal .form-control {
            border-radius: 2px;
            box-shadow: none;
            border-color: #dddddd;
        }
        .modal textarea.form-control {
            resize: vertical;
        }
        .modal .btn {
            border-radius: 2px;
            min-width: 100px;
        }
        .modal form label {
            font-weight: normal;
        }
    </style>

    <script>
        const autoHyphen = (target) => {
            target.value = target.value
                .replace(/[^0-9]/, '')
                .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
        }

    </script>
</head>
<body>
<%@ include file="../header.jsp" %>

<%
   String driverName = "org.mariadb.jdbc.Driver";
   String url = "jdbc:mariadb://localhost/member_db";
   String user = "root";
   String passwd = "maria";
   
   Class.forName(driverName);
   Connection con = DriverManager.getConnection(url, user, passwd);
   PreparedStatement pstmt = null;
   request.setCharacterEncoding("UTF-8"); 
%>

<%
	//user라는 클래스를 지닌 사람의 수만 조회한다 그외의 등급은 안함 사용자 중 등급을 나눴더라면 그사람들 조건 추가하기 (관리자 미포함)
   String sql2 = "SELECT count(*) FROM member where mem_class = 'user'";
   pstmt = con.prepareStatement(sql2);
   ResultSet rs2= pstmt.executeQuery();
   
   int recordCnt =0;
   int pageCnt;
   int limitCnt = Integer.parseInt(request.getParameter("limitCnt"));/** limitCnt는 페이지를 제한하는 변수다.*/
   int startRecord =0;
   int currentPageNo;
   
   /** currentPageNo는 pageCnt에 의해서 정해진 페이지의 갯수를 뜻한다.*/
   currentPageNo = Integer.parseInt(request.getParameter("currentPageNo"));
   
   //index.jsp에서 currentPageNo를 넘겨주는걸 getParameter로 받는다. 
   /**startRecord는 테이블의 데이터 갯수*/
   startRecord = currentPageNo * limitCnt;
   //request의 요청을 받으면 response를 하게되는데 response는 html문서로 저장되어 있다.
   
   
   while(rs2.next()){
      recordCnt = rs2.getInt(1);
   }
   
   pageCnt = recordCnt/limitCnt; //페이지를 10으로 나누었을때 딱 떨어지는 값만큼 페이지를 증가.
   
   //페이지를 10으로 나눈후 남은 몫이 존재할수 있으므로 그 값이 0이아닐 경우 pageCnt 1증가
   if(recordCnt%limitCnt !=0){
      pageCnt++;
   }
   System.out.println("member_m페이지 254번째줄쯤 입니다."+limitCnt);
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
	
	
	//user만 조회할 수 있도록 한다. user중 등급을 추가한다면 조건을 추가하여서 생성
   String sql = "SELECT mem_num, mem_name, mem_id,mem_passwd,mem_email,mem_phone,mem_RRN,mem_class FROM member where mem_class = 'user' OR mem_class = 'block' ORDER BY mem_num limit ?,?";
   pstmt = con.prepareStatement(sql);
   pstmt.setInt(1,startRecord);
   pstmt.setInt(2,limitCnt);
   ResultSet rs = pstmt.executeQuery();
   
%>
	
			
<div class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-10">
                        <h2>관리자 <b>조회 수정</b></h2>
                    </div>
                    <div class="col-sm-2">
					   <form method="post" action="/member01/member_m.jsp">
	                        <select class="custom-select" name = 'limitCnt'>
	                            <option selected>10</option>
	                            <option value="20">20</option>
	                            <option value="30">30</option>
	                            <option value="50">50</option>
	                            <option value="100">100</option>
	                        </select>
	                        <input type = "hidden" name = "currentPageNo"  value =0>
				      		<input type ="submit" value = "확인">
	                   </form>
                    </div>
                </div>
            </div>

            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>이름</th>
                    <th>아이디</th>
                    <th>비밀번호</th>
                    <th>휴대폰</th>
                    <th>이메일</th>
                    <th>주민번호</th>
                    <th>등급</th>
                    <th>수정</th>
                </tr>
                </thead>
               
                <tbody>
                <!-- while 문 변경 !-->
                <%
				while (rs.next()) {
					mem_num =rs.getInt("mem_num");
					mem_name =rs.getString("mem_name");
					mem_id = rs.getString("mem_id");
					mem_passwd =rs.getString("mem_passwd");
					mem_email =rs.getString("mem_email");
					mem_phone =rs.getString("mem_phone");
					mem_RRN =rs.getString("mem_RRN");
					mem_class =rs.getString("mem_class");
				%>
				<tr>
					<th><%=mem_name%></th>
					<th><%=mem_id%></th>
					<th><%=mem_passwd%></th>
					<th><%=mem_phone%></th>
					<th><%=mem_email%></th>
					<th><%=mem_RRN%></th>
					<th><%=mem_class%></th>
					<th>
					
					<a href="/member01/member_m2.jsp?mem_num=<%=mem_num %>&mem_name=<%=mem_name %>&mem_id=<%=mem_id %>&mem_passwd=<%=mem_passwd %>&mem_phone=<%=mem_phone %>&mem_email=<%=mem_email %>&mem_RRN=<%=mem_RRN %>&mem_class=<%=mem_class %>"> 
					<i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
					<!-- class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a> -->
					</th>
					<!-- DB에 lock을 안 걸게되어서 id만 전송후에 where절을 통해 데이터베이스에서 셀렉트를해서 처리를 하는게 좋다. -->
	
				</tr>
	
				<%
				}
				pstmt.close();
				con.close();
				%>
               

                </tbody>
            </table>
                       
                    
 

            <!-- 페이징 수정 값 변경!-->
            <div class="clearfix">
                <ul class="pagination">
                   <li class="page-item disabled"><a href="/member01/member_m.jsp?currentPageNo=0&limitCnt=<%=limitCnt%>">처음으로</a></li>
				<%      
				   
				   if(currentPageNo > 0 ){
				%>
				  <li class="page-item"><a href="/member01/member_m.jsp?currentPageNo=<%=(currentPageNo-1) %>&limitCnt=<%=limitCnt%>" class="page-link">이전</a></li>
				<%
				   }
				   else{
				     
				%>
				 <li class="page-item">이전</li>
				<%
				   }
				   for(int i = currentPageNo/10*10 ; i<( currentPageNo/10+1)*10; i++){
					   if(i>pageCnt-1) break;
				      if(i == currentPageNo){
				%>
				 [<%=(i+1) %>]
				 <%
				      }else{
				 %>
				   
				     <li class="page-item"><a href="/member01/member_m.jsp?currentPageNo=<%=i %>&limitCnt=<%=limitCnt%>" class="page-link"><%=i+1 %></a></li>  
				       <!--   <li class="page-item active"><a href="#" class="page-link">1</a></li> -->
				 <%
				      }
				   }
				   
				   %>
				<%
				   if(currentPageNo < pageCnt - 1){
				 %>
				  <li class="page-item"><a href="/member01/member_m.jsp?currentPageNo=<%=(currentPageNo+1) %>&limitCnt=<%=limitCnt%>" class="page-link">다음</a></li>
				 <%
				   }else{
				 %>
				  <li class="page-item"><a href="#" class="page-link">다음</a></li>
				 <%
				   }
				   pstmt.close();
				   con.close();
				 %>
				 <li class="page-item"><a href="/member01/member_m.jsp?currentPageNo=<%=(pageCnt-1) %>&limitCnt=<%=limitCnt%>" class="page-link">마지막</a></li>    
                </ul>
                
            </div>
			<button type="button" class="btn btn-black" style="color: grey;" onclick="location.href='../member01/index.jsp'"><small>메인메뉴</small></button>
        </div>
    </div>
</div>


<!-- 수정 모달  데이터 수정 !-->

<div id="editEmployeeModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form>
                <div class="modal-header">
                    <h4 class="modal-title">회원 수정 하기</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <input class="form-control mb-2" type="text" name="mem_name" placeholder="이름" value= "">
                    </div>
                    <div class="form-group">
                        <input class="form-control mb-2" type="text" name="mem_id" placeholder="아이디" value=""required disabled>
                    </div>
                    <div class="form-group">
                        <input class="form-control mb-2"  type="text" name="mem_passwd"  placeholder="비밀번호" value="" required>
                    </div>
                    <div class="form-group">
                        <input class="form-control mb-2"  type="text" placeholder="비밀번호 재확인" value="" required>
                    </div>
                    <div class="form-group">
                        <input class="form-control mb-2"  type="email" name="mem_email" placeholder="이메일 @ " value="" >
                    </div>
                    <div class="form-group">
                        <input class="form-control mb-2"  type="text" name="mem_phone" oninput="autoHyphen(this)" value="" maxlength="12" placeholder="핸드폰(숫자만 입력해주세요)">
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <input type="text" class="form-control mb-2" id="mem_RRN1" placeholder="주민번호 ( 6자리 -" value="" maxlength="6" required disabled>
                        </div>
                        <div class="col-md-6 mb-3">
                            <input type="text" class="form-control mb-2" id="mem_RRN2" placeholder=" 7자리 )" value="" maxlength="7" required disabled>
                        </div>
                    </div>

                    <input type="radio" class="btn-check" name="options-outlined" id="success-outlined" autocomplete="off"  checked>
                    <label class="btn btn-outline-warning" for="success-outlined">유저</label>

                    <input type="radio" class="btn-check" name="options-outlined" id="danger-outlined" autocomplete="off" aria-pressed="true">
                    <label class="btn btn-outline-danger" for="danger-outlined">관리자</label>

                </div>

                <div class="modal-footer">
                    <input type="button" class="btn btn-default" data-dismiss="modal" value="닫기">
                    <input type="submit" class="btn btn-primary" value="저장">
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="../footer.jsp" %>
</body>

</html>
