<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<section>
    <div id="totalContainer" style="padding:15% 20% 15% 20%">
        <div class="pageTitle">
            <span><i class="fas fa-info-circle"></i> 나의정보 관리</span>
        </div>
        <hr><br>
        <div class="pageMenu">
            <form action="${path }/member/updateMyPageEnd" onsubmit="return checkForm();" method="post">
                <div class="subMenu">
                    <div class="titleLeft">
                        <span class="subMenuTitle">이메일</span>
                    </div>
                    <div class="inputRight">
                        <input type="text" name="email" class="form-control" value="${m.email }" style="width: 250px; display:inline;" readonly>
                    </div>
                    
                </div>

                <div class="subMenu">
                    <div class="titleLeft">
                        <span class="subMenuTitle">이름</span>
                    </div>
                    <div class="inputRight">
                        <input type="text" class="form-control" value="${m.memberName }" style="width: 250px; display:inline;" readonly>
                    </div>
                </div>

                <div class="subMenu">
                    <div class="titleLeft">
                        <span class="subMenuTitle">닉네임</span>
                    </div>
                    <div class="inputRight">
                        <input type="text" name="nickName" class="form-control" value="${m.nickName }" style="width: 250px; display:inline;" required>
                    </div>
                       <button type="button" class="btn btn-secondary btnColor" onclick="checkDuplication();">중복확인</button>
                    <span id="nickSpan" class="inputNextSpan">닉네임은 띄어쓰기 없이 8글자 이하까지 가능합니다. </span>
                </div>

                <div class="subMenu">
                    <div class="titleLeft">
                        <span class="subMenuTitle">휴대폰</span>
                    </div>
                    <div class="inputRight">
                        <input type="text" name="phone" class="form-control" value="${m.phone }" style="width: 250px; display:inline;">
                    </div>
                    <span id="phoneSpan" class="inputNextSpan">휴대폰번호는 -없이 입력해주세요.  </span>
                </div>

                <div class="subMenu">
                    <div class="titleLeft">
                        <span class="subMenuTitle">주소</span>
                    </div>
                    <div class="inputRight">
                        <input type="text" name="shipAddress" id="shipAddress" class="form-control" placeholder="도로명주소"
                        style="width: 350px; display:inline;"/>
                    </div>
                    <button id="search" type="button" class="btn btn-secondary btnColor" onclick="javascript: findAddress();"> 
                    주소 검색</button>
                    
                </div>
                <div class="subMenu">
                    <div class="titleLeft">
                        <input type="hidden" class="subMenuTitle"></span>
                    </div>
                    <div class="inputRight">
                        <input type="text" name="detailAddress" id="detailAddress" class="form-control" 
                        style="width: 350px; display:inline;" placeholder="읍,면,동 이하 상세주소" />
                        <input type="hidden" name="memberAddress" value ="${m.address }" />
                    </div>
                </div>
                
                <br>
                <div class="" style="text-align: center;">
                    <button id="submitBtn" type="submit" class="btn btn-secondary btnP">정보수정하기</button>
	            	<button type="button" class="btn btn-secondary btnP" 
	            	onclick="javascript: upadatePW();"> 비밀번호 변경</button>
                </div>
	            <div>
	            </div>
            </form>
        </div>
    </div>
</section>
<script>

	let isDuplicationCheck = false;
	
	$("input[name=nickName]").keyup(e=>{
        isDuplicationCheck=false;
    });


	function checkForm(){	
		if($("input[name=nickName]").val() != "${m.nickName }") {
		    if(!isDuplicationCheck){
		        alert('닉네임 중복체크를 해주세요');
		        return false;
		    }
		}
	}
	
	$("#shipAddress").keyup(()=>{
		alert('주소검색을 이용하세요.');
		$("#search").click();
		$("#shipAddress").val("");
	});

	$("input[name=phone]").change(e=>{
 		var numPattern = /([^0-9])/;
		numPattern = $(e.target).val().match(numPattern);
		if (numPattern != null) {
			$(e.target).val("");
			$("#phoneSpan").html("숫자만 입력이 가능합니다.").css("color","red");
			return false;
		} else {
			$("#phoneSpan").html("");
		}
	});
	
	$("input[name=nickName]").change(e=>{
		console.log($(e.target).val().length);
 		var numPattern = /([^0-9])/;
		numPattern = $(e.target).val().match(numPattern);
		if (numPattern != null && $(e.target).val().length>8) {
			$(e.target).val("");
			$("#nickSpan").html("닉네임은 띄어쓰기 없이 8글자 이하까지 가능합니다.").css("color","red");
			return false;
		} else {
			$("#nickSpan").html("");
		}
	});


	const upadatePW=()=>{
		event.stopPropagation();
		const url="${path}/member/updatePassword"; 
		const style="width=1050, height=670, left=400, top=150";
		open(url,"_blank",style);
	}

function findAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
          
            var roadAddr = data.roadAddress; 
            var extraRoadAddr = ''; 

         
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
          
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
           
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            
            const totalAddress = roadAddr + extraRoadAddr;
            
            
            if(totalAddress !== ''){
                document.getElementById("shipAddress").value = totalAddress;
                document.getElementById("detailAddress").focus();
            } else {
                document.getElementById("shipAddress").value = '';
            }
        }
    }).open();
}

function checkDuplication(){
    const nickName = $("input[name=nickName]").val();
    
    $.ajax({
        url:"${path}/member/duplicationCheck",
        data:{'nickName':nickName},
        success:data=>{
            console.log(data['result']);
            $("#nickSpan").html("");
            if(data['result'] && nickName!="" ){
                $("#nickSpan").css('color','#41B979').html('사용가능합니다.');
                isDuplicationCheck = true;
            } else if(nickName =="") {
            	$("#nickSpan").css('color','red').html('1글자 이상 입력해주세요.');
                isDuplicationCheck = false;
            } else{
                $("#nickSpan").css('color','red').html('이미 존재하는 닉네임입니다.');
                isDuplicationCheck = false;
            }
        }

    });
}




</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>