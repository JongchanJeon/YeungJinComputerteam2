<!-- 회원가입 페이지 -->
<!-- 박진석 수정사항(2022.10.08): 기존의 메인메뉴로 돌아가는 <a> 링크 삭제 -->
<!-- 박진석 추가사항(2022.10.08): 가입 버튼 옆에 메인 화면(index)로 돌아갈 수 있는 취소 버튼 추가 (75~77라인) -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

    <meta charset="UTF-8">
    <title>회원가입</title>
</head>
<body>

    <div class="container row">
        <div class="col-lg-4"></div>
        <div class="col-lg-7">
            <div class ="jumbotron" style="padding-top:20px;">
                <h3 style="text-align: center;" class="mb-4">회원가입 </h3>

                <form method="post" action="../member01/member_dao.jsp" name="regForm">  <!-- 경로 수정 -->
                    <div class="form-group">
                        <div>
                            <input class="form-control mb-2" type="text" name="mem_name" placeholder="이름">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-2">
                            <input class="form-control" type="text" name="mem_id" placeholder="아이디" required>
                        </div>
                        <div class="col-md-6 mb-2">
                             <input type="button"  class="btn btn-secondary"  value="중복확인" > <!-- 데이터 추가  -->
                        </div>
                    </div>

                    <div class="form-group">
                        <input class="form-control mb-2"  type="password" name="mem_passwd"  placeholder="비밀번호" required>
                    </div>

                    <div class="form-group has-danger">
                        <input class="form-control mb-2"  type="password" placeholder="비밀번호 재확인" required>
                    </div>
                    <div class="form-group">
                        <input class="form-control mb-2"  type="email" name="mem_email" placeholder="이메일 @ " >
                    </div>

                    <div class="form-group">
                        <input class="form-control mb-2"  type="text" name="mem_phone" oninput="autoHyphen(this)" maxlength="12" placeholder="핸드폰(숫자만 입력해주세요)">
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <input type="text" class="form-control mb-2" id="mem_RRN1" placeholder="주민번호 ( 6자리 -" maxlength="6" required>
                        </div>
                        <div class="col-md-5 mb-3">
                            <input type="text" class="form-control mb-2" id="mem_RRN2" placeholder=" 7자리 )" maxlength="7" required>
                        </div>
                        <div class="col-md-3 mb-2">
                            <input class=" btn btn-secondary" type="button" value="사용자 인증"> <!-- 데이터 추가  -->
                        </div>
                    </div>
                    
					<button type="submit" class="btn btn-success float-right" style=" margin-left: 10px;"> 가입</button>
                </form>
                
                <form name="logout" method="post" action="/member01/mem_models/member_dao.jsp">
					<input type="hidden" name="actionType" value="LOGOUT">
					<input type="submit" class="btn btn-dark float-right" value="취소">
				</form> 
				
            </div>
        </div>
        <div class="col-lg-4"></div>
    </div>

</body>
<script type="text/javascript">

    const autoHyphen = (target) => {
        target.value = target.value
            .replace(/[^0-9]/, '')
            .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
    }


</script>
</html>
