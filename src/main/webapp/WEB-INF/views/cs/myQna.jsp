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
            
            <div id="cs-title">
            	<h2 id="title">내 1:1 문의 내역</h2>
            </div>
            <br>
            <table class="table table-hover">
            	<thead id="thead">
            		 <tr>
	            		<th style="text-align:center; min-width:50px;" class="table-dark">#</th>
	            		<th style="text-align:center; min-width:200px;" class="table-dark">제목</th>
	            		<th style="text-align:center;" class="table-dark">작성자</th>
	            		<th style="text-align:center; width:130px;" class="table-dark">작성일</th>
	            		<th style="text-align:center;" class="table-dark">답변여부</th>
            		</tr> 
            	</thead>
            	<tbody id="cslist">
            	<c:if test="${empty myQnaList }">
            	<tr>
            		<td colspan="5" style="text-align:center;">문의하신 내역이 없습니다.</td>
            	</tr>
            	</c:if>
            	<c:if test="${not empty myQnaList }">
            	<c:forEach items="${myQnaList }" var="q">
            		<tr>
            			<td style="text-align:center;"><c:out value="${q.qnaNo}"/></td>
            			<td style="">
            				<a href="${path }/cs/qnaContent?qnaNo=${q.qnaNo}" style="text-decoration:none;color:black;"><c:out value="${q.qnaTitle}"/></a>
            			</td>
            			<td style="text-align:center;"><c:out value="${q.writer.nickName}"/></td>
            			<td style="text-align:center;"><c:out value="${q.questionDate}"/></td>
            			<td style="text-align:center;">
            				<c:if test="${empty q.qnaAnswer}">
            					<span style="color:tomato;">미답변</span>
            				</c:if>
            				<c:if test="${not empty q.qnaAnswer}">
            					<span style="color:royalblue;">완료</span>
            				</c:if>
            				
            			</td>
            		</tr>
            	</c:forEach>
            		</c:if>
            	</tbody>
            </table>
            
            <div>
            	${pageBar }
            </div>
            
        </section>
        

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>