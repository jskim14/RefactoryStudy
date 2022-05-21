<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section style="padding: 100px 10%;">
	<div class="container-fluid">
		<div class="row d-flex justify-content-center">
			<div class="col">
				<h4>회원관리</h4>
			</div>
		</div>
	</div>
	<div class="row ">
		<div class="col-11">
			<form action="${path }/admin/memberManagement" method="get">
				<div class="row">
					<div class="col-2">
						 <select class="form-select" name="selectedCol" id="typeSelect">
						    <option selected>Choose...</option>
						    <option value="1">회원번호</option>
						    <option value="2">이름</option>
						    <option value="3">전화번호</option>
						    <option value="4">Email</option>
						    <option value="5">닉네임</option>
						    <option value="6">주소</option>
						    <option value="7">배송주소</option>
						    <option value="8">가입일</option>
    					    <option value="9">등급</option>
						</select>
					</div>
					<div class="col-5">
						<div class="input-group mb-3">	 
							  <input id="searchWord" type="text" class="form-control" >
							  <button class="btn btn-outline-secondary" type="submit" id="fixedSearchBtn">검색</button>
						</div>
					</div>		
				</div>
			</form>
			
			
		</div>
		<script>
			$('#typeSelect').change(e=>{
				const typeValue=$('#typeSelect').val();
				
				switch(typeValue){
					case '1': $('#searchWord').attr({'type':'number'}); break;
					case '3': $('#searchWord').attr({'type':'tel'}); break;
					case '4': $('#searchWord').attr({'type':'email'}); break;
					case '8': $('#searchWord').attr({'type':'date'}); break;
					default: $('#searchWord').attr({'type':'text'}); 
				}
			});
		</script>
		<div class="col-1">
			<select id="rowCount" name="rowCount" class="form-control">
				<option value="10" selected>10</option>
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
			</select>
		</div>
	</div>
	<hr>
	<div class="row">
		
		<div class="col-7">
			<form action="" method="get">
				<div class="row my-1">
					<div class="col-2">
						<span>잔고</span>
					</div>
					<div class="col-5">
						<input type="number" class="form-control" placeholder="이상">
					</div>
					<div class="col-5">
						<input type="number" class="form-control" placeholder="이하">
					</div>
				</div>
				<div class="row my-1">
					<div class="col-2">
						<span>가입일</span>
					</div>
					<div class="col-5">
						<input type="date" class="form-control">
					</div>
					<div class="col-5">
						<input type="date" class="form-control">
					</div>
				</div>
			</form>
		</div>
		<div class="col mt-1">
			<button type="submit" class="btn btn-outline-secondary">검색</button>
		</div>
	</div>
	<div class="row">
		<div class="col-12">
			<table class="table table-hover">
			  <thead>
			    <tr>
			      <th scope="col">회원번호</th>
			      <th scope="col">아이디</th>
			      <th scope="col">닉네임</th>
			      <th scope="col">전화번호</th>
			      <th scope="col">가입일</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach items="${memberList}" var="m">
				    <tr>
				      <th scope="row"><c:out value="${m.memberNo }"/></th>
				      <td><c:out value="${m.email }"/></td>
				      <td><c:out value="${m.nickName}"/></td>
				      <td><c:out value="${m.phone }"/></td>
				      <td><c:out value="${m.enrollDate}"/></td>
				    </tr>
			   </c:forEach>
			  </tbody>
			</table>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>