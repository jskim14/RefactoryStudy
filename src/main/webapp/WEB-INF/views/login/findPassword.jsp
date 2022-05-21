<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section  style="padding: 200px 10%;">
    <form action="${path}/member/findPasswordEnd" method="post">
    <div class="container-fluid">
        <div class="row mb-3">
            <div class="col-4"></div>
            <div class="col-4">
                <span>
                    가입한 이메일과 휴대폰번호를 입력해주세요.<br>
                    이메일로 임시 비밀번호를 발송합니다.
                </span>
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row mb-3">
            <div class="col-4"></div>
            <div class="col-4">
                <input type="text" name="phone" placeholder="ex)01011112222" class="form-control w-100">
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row mb-3">
            <div class="col-4"></div>
            <div class="col-4">
                <input type="text" name="email" placeholder="ex)000@naver.com" class="form-control w-100">
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row">
            <div class="col-4"></div>
            <div class="col-4">
                <button type="submit" class="btn btn-primary w-100">임시비밀번호 발급</button>
            </div>
            <div class="col-4"></div>
        </div>
    </div>
</form>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>