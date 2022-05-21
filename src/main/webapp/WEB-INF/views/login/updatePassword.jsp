<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<link rel="stylesheet" href="${path}/resources/css/inputStyle.css">
</head>
<body>

<section>
    <div id="totalContainer" >
        <div class="pageTitle">
            <span><i class="fas fa-lock"></i> 비밀번호 변경</span>
        </div>
        <hr><br>
        <div class="pageMenu">
            <%-- <form action="${path }/member/updatePasswordEnd"> --%>
                <div class="subMenu">
                    <div class="titleLeft" style="width:150px;">
                        <span class="subMenuTitle">현재 비밀번호</span>
                    </div>
                    <div class="inputRight">
                        <input type="password" name="pw" class="form-control" value="" style="width: 250px; display:inline;">
                    </div>
                </div>
                <div class="subMenu">
                    <div class="titleLeft" style="width:150px;">
                        <span class="subMenuTitle">변경할 비밀번호</span>
                    </div>
                    <div class="inputRight">
                        <input type="password" name="newPw" class="form-control" value="" style="width: 250px; display:inline;">
                    </div>
                    <span id="pwSpan" class="inputNextSpan"> 영문자,특수문자를 포함하여 8글자 이상</span>
                </div>
                <div class="subMenu">
                    <div class="titleLeft" style="width:150px;">
                        <span class="subMenuTitle">비밀번호 확인</span>
                    </div>
                    <div class="inputRight">
                        <input type="password" name="pwck" class="form-control" value="" style="width: 250px; display:inline;">
                    </div>
                    <span id="pwckSpan" class="inputNextSpan"></span>
                </div>
                <br>
                <div class="" style="text-align: center;">
                    <button id="submitBtn" type="submit" class="btn btn-secondary btnP" >정보수정하기</button>
                </div>
	            <div>
	            </div>
           <!--  </form> -->
        </div>
    </div>
</section>

<script>
	$("#submitBtn").click(e=>{
		$.ajax({
			url:"${path}/member/updatePasswordEnd",
			data:{pw: $("input[name=pw]").val() , newPw: $("input[name=newPw]").val()},
			dataType:'json', 
			success:data=>{
				console.log(data);
				alert(data['result']);
				window.close();
			}
		});
	});

	$("input[name=newPw]").keyup(e=>{
	    let pw = $(e.target).val();
	    let textRoot = $("#pwSpan");
	    textRoot.html("");
	    if(pw.length <8){//#41B979
	        textRoot.css('color','red').html("8글자 이상 입력해주세요.")
	    }else{
	        let req = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
	        if(req.test(pw)){
	            textRoot.css('color','#41B979').html("사용이 가능합니다.");
	        }else{
	            textRoot.css('color','red').html("영문자,특수문자를 포함하여 8글자 이상 입력해주세요.");
	        }
	    }
	});
	
 	$("input[name=pwck]").keyup(e=>{
 		console.log($(e.target).val());
	    let checkPw = $(e.target).val();
	    let textRoot=$("#pwckSpan");
	    textRoot.html("");
	    if(checkPw.length >=8 && $("input[name=pwck]").val()==checkPw){
	       
	        textRoot.css('color','#41B979').html("비밀번호가 일치합니다.");
	      
	    }else{
	            textRoot.css('color','red').html("일치하지않습니다.");
	    }
	}) 
</script>

</body>
</html>