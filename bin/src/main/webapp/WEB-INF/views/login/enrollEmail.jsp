<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp"/>
<section  style="padding: 200px 10%;">
	 <div class="container-fluid" >
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<div class="w-100" style="display: flex; justify-content: center;">
					<h1>회원가입</h1>
				</div>
				
			</div>
			<div class="col-4"></div>
		</div>
		<hr>
		<div class="row mb-3">
			<div class="col-4"></div>
			<div class="col-4">
				<span>이메일 인증 후 회원가입이 진행됩니다.</span>
				<span>가입할 이메일 주소와 전송받은 인증번호를 입력해주세요.</span>
			</div>
			<div class="col-4"></div>
		</div>
		<div class="row mb-3">
			<div class="col-4"></div>
			<div class="col-4">
				<div class="row">
					<div class= "col-6">
						<input type="text" class="form-control" placeholder="ex) nbif@naver.com">
					</div>
					<div class= "col-6">
						<button type="button" class="btn btn-primary">인증번호받기</button>
					</div>
				</div>
			</div>
			<div class="col-4"></div>
		</div>
		<div class="row mb-3">
			<div class="col-4"></div>
			<div class="col-4">
				<div class="row">
					<div class="col-6">
						<input type="text" class="form-control" placeholder="인증번호를 입력해주세요">
					</div>
					<div class="col-6">
						<button type="button" class="btn btn-primary">인증</button>
					</div>
				</div>
			</div>
			<div class="col-4"></div>
		</div>
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<button class="btn btn-primary" style="width: 100%;">회원가입 진행</button>
			</div>
			<div class="col-4"></div>
		</div>
	 </div>
</section>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp"/>