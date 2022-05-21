<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />
<section style="padding: 200px 10%;">
	<form action="${path}/member/loginMember" method="post">
		<div class="container-fluid">
			<div class="row mb-3">
				<div class="col-3"></div>
				<div class="col-6">
					<input type="text" class="form-control" name="email" placeholder="이메일 주소">
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
						<input class="form-check-input" type="checkbox" value=""
							id="flexCheckDefault"> <label class="form-check-label"
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
					<div class="row">
						<div class="col-4">
							<button type="button" class="btn w-100">이메일 가입</button>
						</div>
						<div class="col-4">
							<button type="button" class="btn w-100">이메일 찾기</button>
						</div>
						<div class="col-4">
							<button type="button" class="btn w-100">비밀번호 찾기</button>
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
							<button type="button" class="btn btn-secondary w-100">네이버</button>
						</div>
						<div class="col-4">
							<button type="button" class="btn btn-secondary w-100">카카오</button>
						</div>
						<div class="col-4">
							<button type="button" class="btn btn-secondary w-100">구글</button>
						</div>
					</div>
				</div>
				<div class="col-3"></div>
			</div>
		</div>
	</form>
</section>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp" />