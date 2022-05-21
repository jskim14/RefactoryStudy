<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
    section{
       padding:200px 10%;
       min-height:800px;
    }
    #cs-title{text-align: center;}
    
</style>

        <section>
            
            <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                <button type="button" id="btn1" class="btn btn-outline-dark" onclick="location.assign('${path }/cs/noticeList');">공지사항</button>
                <button type="button" id="btn2" class="btn btn-outline-dark" onclick="location.assign('${path }/cs/qnaList');">1:1 문의</button>
            </div>
              
            <div id="cs-title">
            	<h2 id="title">1:1 문의</h2>
            </div>
            <br>
            <hr>
            <br>
            <div style="padding:0 10%;">
            	<table class="table">
            	<tr>
            		<td class="table-active" style="text-align:center;font-weight:bold;">글번호</td>
            		<td width="50%;">${qna.qnaNo }</td>
            		<td class="table-active" style="text-align:center;font-weight:bold;">등록일</td>
            		<td>${qna.questionDate }</td>
            	</tr>
            	<tr>
            		<td class="table-active" style="text-align:center;font-weight:bold;">제목</td>
            		<td colspan="3">${qna.qnaTitle }</td>
            	</tr>
            	<tr>
            		<td class="table-active" style="text-align:center;font-weight:bold;">문의내용</td>
            		<td style="height:150px;" colspan="3";>${qna.qnaContent }</td>
            	</tr>
            	<tr>
            		<td class="table-active" style="text-align:center;vertical-align:middle;font-weight:bold;">답변</td>
            		<c:if test="${empty qna.qnaAnswer }">
            			<td style="height:150px; color:red;font-style:italic;">관리자가 확인 중입니다. 조금만 기다려주세요.</td>
            		</c:if>
            		<td style="height:150px;" colspan="3">${qna.qnaAnswer }</td>
            	</tr>
            	<tr>
            		<td class="table-active" style="text-align:center;font-weight:bold;">답변 완료일</td>
            		<c:if test="${empty qna.answerDate }">
            			<td style=" color:red;font-style:italic;">-</td>
            		</c:if>
            		<td colspan="3">${qna.answerDate }</td>
            	</tr>
            	
            	</table>
            	<c:if test="${loginMember.memberNo eq '5' }">
            	<div style="float:right;"> 
					<button type="button" class="btn btn-warning" data-bs-toggle="modal"
						data-bs-target="#staticBackdrop">답변 등록</button>
				<!-- 모달창 -->
					<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
						data-bs-keyboard="false" tabindex="-1"
						aria-labelledby="staticBackdropLabel" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
							<form name="reportForm" action="${path }/cs/insertAnswer" method="POST">
								<div class="modal-header">
									<h5 class="modal-title" id="staticBackdropLabel"
										style="color: black;">답변 등록</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" style="color: black;">
									<div class="mb-3">
										<label for="exampleFormControlInput1" class="form-label">답변 등록</label>
										<textarea class="form-control" id="exampleFormControlTextarea1" name="qnaAnswer"
											rows="3" placeholder="답변을 입력하세요."></textarea>
									</div>
									<input type="hidden" value="${qna.qnaNo }" name="qnaNo">
								</div>
								
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">닫기</button>
									<button type="submit" class="btn btn-warning">등록</button>
									
								</div>
								</form>
							</div>
						</div>
					</div>
            	</div>
            		<br>
            </c:if>
            </div>
            
        </section>
        <script>
        	$("#btn2").addClass("active");
        	
        	
        </script>
        

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>