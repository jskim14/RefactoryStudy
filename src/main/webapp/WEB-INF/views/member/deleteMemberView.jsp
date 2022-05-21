<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
section {
	padding: 200px 30%;
	min-height: 800px;
}

</style>


<section>
	<h2 style="text-align:center;">회원탈퇴</h2>
	<br>
	<hr>
	<div style="text-align:center; item-align:center;">
		<form action="${path }/member/deleteMember" method="post" id="deleteForm" name="deleteForm">
	                       <input type="hidden" id="memberNo" name="memberNo" value="${loginMember.memberNo}">
	        <div class="panel panel-default panel-margin-10" style="display:inline-block;">
	            <div class="panel-body panel-body-content text-center">
	                <p>탈퇴의 길은 쉽지 않습니다. <br>다음의 경우에는 회원 탈퇴가 제한됩니다.<br>
					진행 중인 거래(판매/구매)가 있을 경우, 해당 거래 종료 후 탈퇴 가능합니다.</p>
	                <span id=checkResult></span>
	                <div class="form-group">
	                    <input type="password" class="form-control" id ="password" name="password" placeholder="비밀번호" />
	                </div>
	                <div class="form-group">
	                    <input type="password" class="form-control" id ="password2" name="password2" placeholder="비밀번호 확인" />
	                </div>
	                <br>
	                <input type="button" id="checkDelBtn"class="btn btn-success" value="탈퇴 가능 여부 확인" >
	                <button type="button" id="delete" name="delete" class="btn btn-success" disabled>회원탈퇴</button>
	            </div>
	        </div>
	    </form>
    </div>
</section>

<script>
	$("#checkDelBtn").click(e=>{
		let memberNo=$("#memberNo").val().trim();
		$.ajax({
			url:"${path}/member/beforeDelete",
			type: "post",
			data: {"memberNo" : memberNo},
			dataType: "json",
			success: function(result){
				if(result==1){
					$("#checkResult").text("탈퇴 불가 진행중인 거래/입찰이 있습니다.").css({"color":"red"});
					
				}else{
					$("#checkResult").text("탈퇴 가능합니다. 안녕...").css({"color":"green"});
					$("#delete").attr("disabled",false);
					$("#check").attr("disabled",true).css({"background":"gray"});
				}
			},
			error : function(){
				alert("서버요청 실패");
			}
		})
	});
	
	$("#delete").on("click", function(){
		
		if($("#password").val()==""){
			alert("비밀번호를 입력해주세요");
			$("#password").focus();
			return false
		}
		
		if($("#password2").val()==""){
			alert("비밀번호 확인을 입력해주세요");
			$("#password2").focus();
			return false
		}
		
		if ($("#password").val() != $("#password2").val()) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#password").focus();
			return false;
			}
		let memberNo=$("#memberNo").val().trim();
		let password=$("#password").val().trim();
		$.ajax({
			url : "${path}/member/checkPw",
			type : "POST",
			dataType : "json",
			data : {"memberNo" : memberNo, "password" : password},
			success: function(result){
				console.log(result);
				if(result==0){
					alert("비밀번호를 확인해주세요.");
					return;
				}else{
					if(confirm("탈퇴하시겠습니까?")){
						$("#deleteForm").submit();
					}
					
				}
			}
		})
	});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />