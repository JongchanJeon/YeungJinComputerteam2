<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int mem_num = Integer.parseInt(request.getParameter("mem_num"));
String mem_name =request.getParameter("mem_name");
String mem_id = request.getParameter("mem_id");
String mem_passwd = request.getParameter("mem_passwd");
String mem_email = request.getParameter("mem_email");
String mem_phone = request.getParameter("mem_phone");
String mem_RRN = request.getParameter("mem_RRN");
String mem_class = request.getParameter("mem_class");
%>


<div id="editEmployeeModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
       <!--  <form> -->
           <form method="post" action="/member01/mem_models/member_dao.jsp">
                <div class="modal-header">
                    <h4 class="modal-title">회원 수정 하기</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <input class="form-control mb-2" type="text" name="mem_name" placeholder="이름" value= <%=mem_name %>>
                    </div>
                    <div class="form-group">
                        <input class="form-control mb-2" type="text" name="mem_id" placeholder="아이디" value=<%=mem_id %> required readonly>
                    </div>
                    <div class="form-group">
                        <input class="form-control mb-2"  type="text" name="mem_passwd"  placeholder="비밀번호" value="" required>
                    </div>
                    <div class="form-group">
                        <input class="form-control mb-2"  type="text" placeholder="비밀번호 재확인" value="" required>
                    </div>
                    <div class="form-group">
                        <input class="form-control mb-2"  type="email" name="mem_email" placeholder="이메일 @ " value=<%=mem_email %> >
                    </div>
                    <div class="form-group">
                        <input class="form-control mb-2"  type="text" name="mem_phone" oninput="autoHyphen(this)" value=<%=mem_phone %> maxlength="12" placeholder="핸드폰(숫자만 입력해주세요)">
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <input type="text" class="form-control mb-2" name="mem_RRN1" placeholder="주민번호 ( 6자리 -" value=<%=mem_RRN.substring(0, 6) %> maxlength="6" required disabled>
                        </div>
                        <div class="col-md-6 mb-3">
                            <input type="text" class="form-control mb-2" name="mem_RRN2" placeholder=" 7자리 )" value=<%=mem_RRN.substring(7,14) %> maxlength="7" required disabled>
                        </div>
                    </div>

                    <input type="radio" class="btn-check" name="mem_class" id="success-outlined" value ="user" autocomplete="off"  checked>
                    <label class="btn btn-outline-warning" for="success-outlined">유저</label>

                    <input type="radio" class="btn-check" name="mem_class" id="danger-outlined" value ="admin" autocomplete="off" aria-pressed="true">
                    <label class="btn btn-outline-danger" for="danger-outlined">관리자</label>

                </div>

                <div class="modal-footer">
                    <!-- <input type="button" class="btn btn-default" data-dismiss="modal" value="닫기">
                    <input type="submit" class="btn btn-primary" value="저장"> -->
                    <br><button type="submit" id="updatechk" value="" onclick="updateid()" name="updatechk">수정
					<input type="hidden" name="actionType" value="UPDATE"> 
					<input type="hidden" name="mem_num" value=<%=mem_num%>>   
					<input type="hidden" name="memState" value="admin"> 	
					</button>
                </div>
            </form>
            
        </div>
    </div>
</div>
<script>
		function updateid(){
			let check = confirm("정말로 수정하시겠습니까?");
			if(check){
				
				document.getElementById("updatechk").value= 'true';
				
			}else{
				document.getElementById("updatechk").value='false';
			}
			alert(document.getElementById("updatechk").value);
		}
		
		function deleteid(){
			let check = confirm("정말로 삭제하시겠습니까?");
			if(check){
				
				document.getElementById("deletechk").value= 'true';
				
			}else{
				document.getElementById("deletechk").value='false';
			}
			alert(document.getElementById("deletechk").value);
		}
	</script>

<%@ include file="./footer.jsp" %>
</body>
</html>