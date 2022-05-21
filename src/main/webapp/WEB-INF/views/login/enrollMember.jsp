<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section  style="padding: 200px 10%;">
    <div class="container-fluid">
      <form action="${path}/member/enrollMemberMain" onsubmit="checkForm()" method="post">
        <div class="row mb-3">
            <div style="display: flex; justify-content: center;">
                <h1>회원가입</h1>
            </div>
        </div>
     
        <div class="row mb-1">
            <div class="col-6">
                <div class="row">
                    <div class="col-6">비밀번호</div>
                    <div class="col-6">
                        <input id="inputPassword" name="password" type="password" maxlength="13" class="form-control" required>
                    </div>
                </div>
            </div>
            <div class="col-6">
            	<div class="row">
            		<div class="col-6">
                        <span id="inputPasswordText"></span>
            		</div>
            		<div class="col-6">
                      
                    </div>
            	</div>
            </div>
        </div>
        <div class="row mb-4">
            <div class="col-3"></div>
            <div class="col-9">
                <span>※8~13자/영문/특수문자</span>
            </div>
        </div>
        <div class="row mb-4">
            <div class="col-6">
                <div class="row">
                    <div class="col-6">비밀번호 확인</div>
                    <div class="col-6">
                        <input id="checkPassword" type="password" maxlength="13" class="form-control">
                    </div>
                 
                </div>
            </div>
            <div class="col-6">
                <i id="visibleControl" class="fas fa-eye "></i>
                <span id="checkPasswordText"></span>
            </div>
        </div>
        <div class="row  mb-4">
            <div class="col-6">
                <div class="row">
                    <div class="col-6">이름</div>
                    <div class="col-6">
                        <input name="name" type="text" class="form-control" required>
                    </div>
                  
                </div>
            </div>
            <div class="col-6"></div>
        </div>
        <div class="row  mb-1">
            <div class="col-6">
                <div class="row">
                    <div class="col-6">닉네임</div>
                    <div class="col-6">
                        <input id ="inputNickname" name="nickName" type="text" class="form-control" required>
                    </div>
                </div>
            </div>
            <div class="col-6">
                <div class="row">
                    <div class="col-3">
                       <button type="button" class="btn btn-primary" onclick="checkDuplication();">중복확인</button>
                    </div>
                    <div class="col-9">
                        <span id="duplicationText"></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="row  mb-4">
            <div class="col-3"></div>
            <div class="col-9">
                <span>닉네임은 띄어쓰기 없이 8글자 까지 가능합니다.</span>
            </div>
        </div>
        <div class="row  mb-4">
            <div class="col-6">
                <div class="row">
                    <div class="col-6">
                        <span>휴대폰</span>
                    </div>
                    <div class="col-6">
                        <input type="tel" name="phone" placeholder="ex)01011112222" class="form-control" required>
                    </div>
                </div>
            </div>
            <div class="col-6"></div>
        </div>
        <div class="row  mb-4">
            <div class="col-6">
                <div class="row">
                    <div class="col-6">
                        <span>주소</span>
                    </div>
                    <div class="col-6">
                        <input type="text" id="sample4_postcode" class="w-100 form-control" placeholder="우편번호">
                        <span id="guide" style="color:#999;display:none"></span>
                    </div>
                </div>
            </div>
            <div class="col-6">
                <div class="row">
                    <div class="col-6">
                        <input type="button" class="btn btn-primary" onclick="sample4_execDaumPostcode()" value="주소 검색">
                    </div>
                    <div class="col-6">
                     
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-3"></div>
            <div class="col-6">
                <div class="row">
                    <div class="col-12">
                        <input type="text" name="address" id="sample4_roadAddress" class="w-100 form-control" placeholder="도로명주소" required>
                    </div>
                   <div class="col-12">
                   	<input type="hidden" id="sample4_jibunAddress" placeholder="지번주소">
                   </div>
                   
                    <div class="col-12">
                        <input type="text" id="sample4_detailAddress" name="detailAddress" class="w-100 form-control" placeholder="상세주소">
                    </div>
                    <div class="col-12">
                        <input type="text" id="sample4_extraAddress" name="plusAddress" class="w-100 form-control" placeholder="참고항목">
                    </div>
                   
                </div>
            </div>
            <div class="col-3"></div>
        </div>
       
        <div class="row">
            <div class="col-4"></div>
            <div class="col-4">
                <button type="submit" class="btn btn-primary w-100" >가입하기</button>
            </div>
            <div class="col-4"></div>
        </div>
    </form>
    </div>

</section>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	let isDuplicationCheck = false;

	function checkForm(){
		let pw = $('#inputPassword').val();
		let checkPw = $('#checkPassword').val();

        if(!isDuplicationCheck){
            alert('닉네임 중복체크 해주세요');
            return false;
        }
		
		if(pw==checkPw){
			return true;
		}else{
			return false;
		}
	}


    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<script>

    $('#inputNickname').keyup(e=>{
        isDuplicationCheck=false;
    });

    function checkDuplication(){
        const nickName = $("#inputNickname").val();
        
        $.ajax({
            url:"${path}/member/duplicationCheck",
            data:{'nickName':nickName},
            success:data=>{
                console.log(data['result']);
                $("#duplicationText").html("");
                if(data['result']){
                    $("#duplicationText").css('color','#41B979').html('사용가능');
                    isDuplicationCheck = true;
                   
                }else{
                    $("#duplicationText").css('color','#7f47e9').html('이미 존재하는 닉네임입니다.');
                    isDuplicationCheck = false;
                }
            }

        });
    }


    let toggleTypePassword = flagControl();
    $("#visibleControl").click(e=>{
        toggleTypePassword();
    });

    function flagControl(){
        let flag = true;

        return ()=>{

          let icon = $("#visibleControl");  
          if(flag){
              $("#checkPassword").attr("type",'text');
              icon.removeClass("fa-eye");
              icon.addClass("fa-eye-slash");
          }else{
              $("#checkPassword").attr("type",'password');
              icon.removeClass("fa-eye-slash");
              icon.addClass("fa-eye");
          }
          flag=!flag;
        
      }

    }


	$("#inputPassword").keyup(e=>{
        let pw = $("#inputPassword").val();
        let textRoot = $("#inputPasswordText");
        textRoot.html("");
        if(pw.length <8){//#41B979
            textRoot.css('color','#7f47e9').html("8글자 이상 입력해주세요.")
        }else{
            let req = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
            if(req.test(pw)){
                textRoot.css('color','#41B979').html("사용가능");
            }else{
                textRoot.css('color','#7f47e9').html("형식에 맞게 입력해주세요.");
            }
        }
    });

    $('#checkPassword').keyup(e=>{
        let checkPw = $("#checkPassword").val();
        let textRoot=$("#checkPasswordText");
        textRoot.html("");
        if(checkPw.length >=8&&$("#inputPassword").val()==checkPw){
           
            textRoot.css('color','#41B979').html("확인");
           // $("#checkPassword").attr("type","text");
          
        }else{
                textRoot.css('color','#7f47e9').html("일치하지않습니다.");
        }
    })


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>