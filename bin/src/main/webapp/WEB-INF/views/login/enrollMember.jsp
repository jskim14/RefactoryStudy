<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp"/>
<section  style="padding: 200px 10%;">
    <div class="container-fluid">
        <div class="row mb-3">
            <div style="display: flex; justify-content: center;">
                <h1>회원가입</h1>
            </div>
        </div>
        <div class="row mb-4">
            <div class="col-6">
                <div class="row">
                    <div class="col-6">비밀번호</div>
                    <div class="col-6">
                        <input type="password" class="form-control">
                    </div>
                </div>
            </div>
            <div class="col-6"></div>
        </div>
        <div class="row mb-4">
            <div class="col-6">
                <div class="row">
                    <div class="col-6">비밀번호 확인</div>
                    <div class="col-6">
                        <input type="password" class="form-control">
                    </div>
                 
                </div>
            </div>
            <div class="col-6">
                <span>비밀번호가 일치하지 않습니다.</span>
            </div>
        </div>
        <div class="row  mb-4">
            <div class="col-6">
                <div class="row">
                    <div class="col-6">이름</div>
                    <div class="col-6">
                        <input type="text" class="form-control">
                    </div>
                  
                </div>
            </div>
            <div class="col-6"></div>
        </div>
        <div class="row  mb-4">
            <div class="col-6">
                <div class="row">
                    <div class="col-6">닉네임</div>
                    <div class="col-6">
                        <input type="text" class="form-control">
                    </div>
                </div>
            </div>
            <div class="col-6">
                <div class="row">
                    <div class="col-6">
                        <span>닉네임은 띄어쓰기 없이 8글자 까지 가능합니다.</span>
                    </div>
                    <div class="col-6">
                        <span>이미 존재하는 닉네임입니다.</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="row  mb-4">
            <div class="col-6">
                <div class="row">
                    <div class="col-6">
                        <span>휴대폰</span>
                    </div>
                    <div class="col-6">
                        <input type="tel" placeholder="ex)01011112222" class="form-control">
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
                        <input type="tel" placeholder="ex)01011112222" class="form-control">
                    </div>
                </div>
            </div>
            <div class="col-6">
                <div class="row">
                    <div class="col-6">
                        <button type="button" class="btn btn-primary">주소검색</button>
                    </div>
                    <div class="col-6">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                            <label class="form-check-label" for="flexCheckDefault">
                             배송주소와 일치합니다.
                            </label>
                          </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row  mb-4">
            <div class="col-3"></div>
            <div class="col-5">
                <input type="text" class="form-control" readonly>
            </div>
            <div class="col-4">
                <input type="text" class="form-control">
            </div>
        </div>
        <div class="row">
            <div class="col-4"></div>
            <div class="col-4">
                <button type="button" class="btn btn-primary w-100">가입하기</button>
            </div>
            <div class="col-4"></div>
        </div>
     
    </div>

</section>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp"/>