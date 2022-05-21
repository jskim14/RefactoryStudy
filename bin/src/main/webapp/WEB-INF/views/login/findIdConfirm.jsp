<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp"/>
<section  style="padding: 200px 10%;">
	<div class="container-fluid">
        <div class="row">
            <div class="col-12" style="display: flex; justify-content: center;">
               <h1>이메일 찾기</h1>
            </div>
        </div>
        <hr>
        <div class="row mb-3">
            <div class="col-4"></div>
            <div class="col-4 d-flex justify-content-center">
                <span>등록된 이메일 주소 찾기에 성공하였습니다.</span>
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row mb-3">
            <div class="col-4"></div>
            <div class="col-4 d-flex justify-content-center">
                <span>000</span><span>님,</span>
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row mb-3">
            <div class="col-4"></div>
            <div class="col-4  d-flex justify-content-center">
                <span>찾은아이디자리</span>
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row mb-3">
            <div class="col-4"></div>
            <div class="col-2">
                <button type="button" class="btn btn-primary w-100">비밀번호 찾기</button>
            </div>
            <div class="col-2">
                <button type="button" class="btn btn-primary w-100">로그인</button>
            </div>
            <div class="col-4"></div>
        </div>
    </div>

</section>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp"/>