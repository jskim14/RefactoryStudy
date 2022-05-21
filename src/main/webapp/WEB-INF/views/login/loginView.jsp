<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<c:if test="${cookie.flexCheckDefault.value != null }">
	<c:set value="checked" var="check" />
	<c:set value="${cookie.flexCheckDefault.value }" var="saveEmail" />
</c:if>
<section style="padding: 200px 10%;">
	<form action="${path}/member/loginMember" method="post">
	<div class="row mb-3">
            <div style="display: flex; justify-content: center;">
                <h1>로그인</h1>
            </div>
        </div>
        <hr>
        <br>
		<div class="container-fluid">
			<div class="row mb-3">
				<div class="col-3"></div>
				<div class="col-6">
					<input type="text" class="form-control" name="email" placeholder="이메일 주소" value="${saveEmail }">
				</div>
				<div class="col-3"></div>
			</div>
			<div class="row mb-1">
				<div class="col-3"></div>
				<div class="col-6">
					<input type="password" class="form-control" name="password" placeholder="비밀번호">
				</div>
				<div class="col-3"></div>
			</div>
			<div class="row mb-3">
				<div class="col-3"></div>
				<div class="col-6">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" name="flexCheckDefault"
							id="flexCheckDefault" ${check }> <label class="form-check-label"
							for="flexCheckDefault"> 아이디 저장 </label>
					</div>
				</div>
				<div class="col-3"></div>
			</div>
			<div class="row mb-1">
				<div class="col-3"></div>
				<div class="col-6">
					<button type="submit" class="btn btn-secondary w-100">로그인</button>
				</div>
				
				<div class="col-3"></div>
			</div>
			<div class="row">
				<div class="col-3"></div>
				<div class="col-6">
					<div class="row d-flex justify-content-center">
						<div class="col">
							<button onclick="kakaoLogin()" type="button" class="btn btn-secondary w-100" style="height: 42px; background:#FEE500; font-size:13px;border:none;color:#624A3D;">
								<img src="${path }/resources/images/kakao.png" style="width:20px;height:20px;padding:0;">
								카카오 로그인
							</button>
						</div>
					</div>

				</div>
				<div class="col-3"></div>
			</div>
			<div class="row">
				<div class="col-3"></div>
				<div class="col-6">
					<div class="row">
						<div class="col-4">
							<button type="button" class="btn w-100" onclick="goToEnroll()">이메일 가입</button>
						</div>
						<div class="col-4">
							<button type="button" class="btn w-100" onclick="goToFindId()">아이디 찾기</button>
						</div>
						<div class="col-4">
							<button type="button" class="btn w-100" onclick="goToFindPassword()">비밀번호 찾기</button>
						</div>
					</div>
				</div>
				<div class="col-3"></div>
			</div>
			
		</div>
	</form>
</section>
<script>




	function goToEnroll(){
		location.assign("${path}/member/enrollMember");
	}

	function goToFindId(){
		
		location.assign("${path}/member/findId");
	}

	function goToFindPassword(){
		location.assign("${path}/member/findPassword");
	}
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />