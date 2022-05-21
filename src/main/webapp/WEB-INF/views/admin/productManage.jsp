<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section style="padding: 200px 10%;">
	<div class="container-fluid">
		<div class="row">
			<div class="col-11">
				<h2>물품승인</h2>
			</div>
			<div class="col-1">
				<select class="form-select" id="selectNum">
				  <option value="5" ${numPerPage==5?"selected":"" }>5</option>
				  <option value="10" ${numPerPage==10?"selected":"" }>10</option>
				  <option value="30" ${numPerPage==30?"selected":"" }>30</option>
				  <option value="50" ${numPerPage==50?"selected":"" }>50</option>
				  <option value="100" ${numPerPage==100?"selected":"" }>100</option>
				</select>
			</div>
			<div class="col-12">
				<table class="table table-hover">
					<thead  style="text-align: center;">
						<tr>
							<th scope="col">제품번호</th>
							<th scope="col">제품명</th>
							<th scope="col">아이디</th>
							<th scope="col">등록일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${waitList}" var="w">
							<tr>
								<th scope="row">[<c:out value="${w.productNo }"/>]</th>
								<td><a href="${path}/admin/productConfirmDetail?productNo=${w.productNo}"><c:out value="${w.productName }"/></a></td>
								<td><c:out value="${w.seller.email }"/></td>
								<td><fmt:formatDate value="${w.productEnrollDate}" type="both" pattern="yyyy-MM-dd [E] a hh:mm:ss"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col-12">
				${pageBar }
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>