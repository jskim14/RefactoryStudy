<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript" src="${path }/resources/js/jquery.timepicker.min.js" ></script><!-- 타이머js -->
<link type="text/css" rel="stylesheet" href="${path }/resources/css/jquery.timepicker.css" media=""/>
<script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
<section style="padding: 15%;">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<h2>실시간경매 물품등록</h2>
			</div>
		</div>
		<hr>
		<form action="${path}/admin/specialProductEnrollEnd" method="post" enctype="multipart/form-data">
			<div class="row ">
				<div class="col-12 d-flex justify-content-center" style="padding-bottom: 3%">
					<span style="font-size:30px">경매설정</span>
				</div>
			</div>
			
			<div class="row m-1">
				<div class="col-2">
					<span>입찰시작가</span>
				</div>
				<div class="col-3">
					<input type="text" id="minBidPrice" name="minBidPrice" class="form-control" required>
				</div>
			</div>
			
			<div class="row m-1">
				<div class="col-2">
					<span>경매시작일</span>
				</div>
				<div class="col-3">
					<input type="text" id="startDate" name="startDate" placeholder="YYYY-MM-DD" class="form-control">
				</div>
				
				<div class="col-3">
					<input type="text" id="startTime" name="startTime" placeholder="00:00" class="form-control">
				</div>
			</div>
			
			<div class="row m-1" style="padding-bottom: 3%">
				<div class="col-2">입찰단위</div>
				<div class="col-3">
					<select id="bidUnit" class="form-select" name="bidUnit" required>
						 <option value="" selected>---선택하세요---</option>
                         <option value="1000">1,000원</option>
                         <option value="5000">5,000원</option>
                         <option value="10000">10,000원</option>
                         <option value="50000">50,000원</option>
                         <option value="100000">100,000원</option>
                         <option value="typing">직접입력</option>
					</select>
				</div>
				<div class="col-3">
					<input type="text" id="bidUnitInput" name="bidUnitInput" class="form-control" disabled required/>
				</div>
			</div>
			
			<hr>
			
			<div class="row m-1">
				<div class="col-12 d-flex justify-content-center" style="padding-bottom: 3%">
					<span style="font-size:30px">물품정보</span>
				</div>
				
			</div>
			<div class="row m-1">
				<div class="col-2">
					<span>카테고리</span>
				</div>
				<div class="col-2">
					<select id="category" name="category" class="form-select" required>
					  <option value="" selected>선택</option>
					  <option value="FS">패션</option>
					  <option value="LF">라이프</option>
					  <option value="TC">테크</option>
					  <option value="AR">아트</option>
					</select>
				</div>
			</div>
			
			<div class="row m-1">
				<div class="col-2">
					<span>상품명</span>
				</div>
				<div class="col-10">
					<input type="text" id="productName" name="productName" class="form-control" required> 
				</div>
			</div>
			
			<div class="row m-1">
				<div class="col-2">
					<span>물품설명</span>
				</div>
				<div class="col-10">
					<textarea name="productContent" id="productContent" class="form-control" style="height: 40rem;"
                                placeholder="상품을 소개할 내용을 적어주세요." required>  </textarea>
				</div>
			</div>
			
			<hr>
			
			<div class="row m-1">
				<div class="col-2">
					<span>배너 이미지</span>
				</div>
				<div class="col-10">
					<label for="formFileMultiple" class="form-label">
                      *1장
                    </label>
                    <input class="form-control" type="file" id="bannerImageFile" name="bannerImageFile" onclick=""
                             accept=".jpg, .jpeg, .png" required>
                    
				</div>
			</div>
			
			<hr>
			
			<div class="row m-1" style="padding-bottom: 3%">
				<div class="col-2">
					<span>상품 이미지</span>
				</div>
				<div class="col-10">
					<label for="formFileMultiple" class="form-label">
                       *사진은 4장까지 등록 가능하며, 첫번째 등록한 사진이 메인사진으로 등록됩니다.
                    </label>
                    <input class="form-control" type="file" id="formFileMultiple" name="imageFile" onclick=""
                             accept=".jpg, .jpeg, .png" multiple required>
                    <div id="showFiles" style="padding-right:50px"></div>
				</div>
			</div>
			<div class="row justify-content-center mt-3">
				<div class="col-10">
					<button type="submit" class=" w-100 btn btn-primary btnColor">등록</button>
				</div>
			</div>
		</form>
	</div>
</section>
<style>
        .ck.ck-editor {
            max-width: 100%;
        }
        .ck-editor__editable {
            min-height: 300px;
        }
</style>
<script src="${path }/resources/js/specialProductEnroll.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>