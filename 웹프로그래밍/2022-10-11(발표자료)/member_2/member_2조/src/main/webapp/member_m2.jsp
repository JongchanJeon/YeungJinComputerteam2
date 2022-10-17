<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

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
<%@ include file="./header.jsp" %>

<div class="container row">
    <div class="col-lg-5"></div>
    <div class="col-lg-6">
        <div style="padding-top:20px;">
            <h3 style="text-align: center;" class="mb-2">관리자 회원 수정 </h3> <!-- 제목  -->

            <form class="validation-form" method="post" action="./mem_models/member_dao.jsp"> <!-- 경로 수정  !-->

                <div class="form-group">
                        <label>이름  </label>
                        <input class="form-control mb-2" type="text" name="mem_name" placeholder="이름" value= <%=mem_name %>>
                    </div>
                    <div class="form-group">
                      <label>아이디  </label> 
                      <input class="form-control mb-2" type="text" name="mem_id" placeholder="아이디" value=<%=mem_id %> required readonly>
                    </div>
                    <div class="form-group">
                       <label>비밀번호  </label> 
                       <input class="form-control mb-2"  type="text" name="mem_passwd"  placeholder="비밀번호" value=<%=mem_passwd %> required>
                    </div>
                    <div class="form-group">
                       <label>비밀번호 재확인  </label> 
                       <input class="form-control mb-2"  type="text" name = "mem_passwdCheck" placeholder="비밀번호 재확인" value=<%=mem_passwd %> required>
                    </div>
                    <div class="form-group">
                    <label>이메일  </label>
                        <input class="form-control mb-2"  type="email" name="mem_email" placeholder="이메일 @ " value=<%=mem_email %> >
                    </div>
                    <label>휴대폰  </label>
                    <div class="form-group">
                        <input class="form-control mb-2"  type="text" name="mem_phone" oninput="autoHyphen(this)" value=<%=mem_phone %> maxlength="12" placeholder="핸드폰(숫자만 입력해주세요)">
                    </div>
                    <label>주민등록번호  </label>
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

                    <input type="radio" class="btn-check" name="mem_class" id="danger-outlined" value ="manager" autocomplete="off" aria-pressed="true">
                    <label class="btn btn-outline-danger" for="danger-outlined">관리자</label>
                    
   
               <div class="modal-footer">
                    <!-- <input type="button" class="btn btn-default" data-dismiss="modal" value="닫기">
                    <input type="submit" class="btn btn-primary" value="저장"> -->
                     <input type="submit" class="btn btn-primary float-right mx-2 " name="actionType" value="수정" onclick="if(!confirm('정말로 수정하시겠습니까?')){return false;}">
               <input type="hidden" name="actionType" value="수정"> 
               <input type="hidden" name="mem_num" value=<%=mem_num%>>
               <input type="hidden" name="mem_class" value=<%=mem_class%>>     
               <input type="hidden" name="memState" value="admin">    
               
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