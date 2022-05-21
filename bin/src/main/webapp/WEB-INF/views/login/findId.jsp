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
            <div class="col-4">
                <span>이름과 가입시 등록한 휴대폰 번호를 입력해주세요.<br>
                    이메일 주소의 일부를 확인하가능합니다.</span>
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row mb-3">
            <div class="col-4"></div>
            <div class="col-4">
                <input type="text" placeholder="ex)홍길동" class="form-control w-100">
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row mb-3">
            <div class="col-4"></div>
            <div class="col-4">
                <input type="text" placeholder="ex)01011112222" class="form-control w-100">
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row mb-3">
            <div class="col-4"></div>
            <div class="col-4">
                <button type="button" class="btn btn-primary w-100">이메일 아이디 찾기</button>
            </div>
            <div class="col-4"></div>
        </div>
    </div>

</section>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp"/>