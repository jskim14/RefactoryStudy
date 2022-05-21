<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
.emoneyBtn {
    width: 95px;
    height: 55px;
    font-size: 20px;
}


#stateContainer>div {
    padding-top: 3%;
}
</style>
<section>
	<div class="row" style="padding: 15%;">
		<div id="stateContainer" class="row">
		    <div style="margin-bottom:5%;">
	            <span class="pageTitle2"><i class="fas fa-coins"></i>&nbsp;MY EMONEY</span>
	            <p>현재 나의 이머니 잔액과 내역을 확인할 수 있습니다.</p>
        	</div>
		    <div class="row" style="border:1px solid rgba(0,0,0,.125); margin: 0; border-radius: 0.25rem;"> 
				<div class="" style="display: flex; justify-content: center;">
					<a href="${path }/member/emoneyDetail?memberNo=${loginMember.memberNo}" 
					class="col-7 aColor" style="font-weight: bold; padding: 0 5% 3% 0; ">
						<span style="font-size: 20px;">이머니 잔액</span><br>
						<span style="font-size: 35px;">
						<fmt:formatNumber value="${m.balance }" pattern="#,###"/>원
						</span>
					</a>
					<div class="col-5" style=" padding: 1% 0 0 5%; ">
						<form action="${path }/member/emoneySelectList" method="get">
				            <button type="submit" class="btn btn-secondary emoneyBtn" 
				             name="btnCategory" value="input">입금</button> 
				            <button type="submit" class="btn btn-secondary emoneyBtn" 
				             name="btnCategory" value="output">출금</button> 
				            <button type="submit" class="btn btn-secondary emoneyBtn" 
				             name="btnCategory" value="charge">충전</button>
			            </form>
		        	</div>
	    		</div>
			</div>
			<div class="col">
		    <!-- 검색 -->
 		    	<select class="form-select" id="selectNum" style="float: right; width : 100px">
				  <option value="15" ${numPerPage==15?"selected":"" }>15</option>
				  <option value="30" ${numPerPage==30?"selected":"" }>30</option>
				  <option value="50" ${numPerPage==50?"selected":"" }>50</option>
				  <option value="70" ${numPerPage==70?"selected":"" }>70</option>
				  <option value="100" ${numPerPage==100?"selected":"" }>100</option>
				</select> 
			</div>
			<div id="listContainer" class="row" style="">
				<div class="row">
	        		<hr>
			        <table class="table table-borderless">
			            <tbody style="text-align: center;">
			            <c:if test="${empty list }">
			            	<div style="text-align: center">내역이 없습니다.</div>
			            </c:if>
			            <c:if test="${not empty list }">
			            	<c:forEach var="w" items="${list }">
			            		<c:if test="${w.category eq '0' }">
								<tr>
								  	<th scope="row" style="color: green; width: 20%; font-size: 18px; font-weight: bold;">
								    입금</th>
									<td style="width: 40%; text-align: left ;">
										<div style="font-weight: bold; font-size: 20px;">
											<c:out value="${w.productNo.productName }"/>
										</div>
										<c:if test="${w.categoryDetail eq '0' }">
											<span>판매완료 수익</span>
										</c:if>
										<c:if test="${w.categoryDetail eq '1' }">
											<span>입찰실패로 사용취소</span>
										</c:if>
										<c:if test="${w.categoryDetail eq '2' }">
											<span style="font-weight: bold; font-size: 20px;">포인트 충전</span>
										</c:if>
									</td>
									<td style="width: 15%;">
										<c:out value="${w.tradeDate }"/>
									</td>
									<td style="width: 15%; color: green">
										+<fmt:formatNumber value="${w.amount }" pattern="#,###"/>원
									</td>
								</tr>
								</c:if>
								<c:if test="${w.category eq '1' }">
								<tr>
								  	<th scope="row" style="color: red; width: 20%; font-size: 18px; font-weight: bold;">
								    출금</th>
									<td style="width: 40%; text-align: left ;">
										<div style="font-weight: bold; font-size: 20px;">
											<c:out value="${w.productNo.productName }"/>
										</div>
										<c:if test="${w.categoryDetail eq '3' }">
											<span>입찰시 사용</span>
										</c:if>
										<c:if test="${w.categoryDetail eq '4' }">
											<span>즉시구매시 사용</span>
										</c:if>
									</td>
									<td style="width: 15%;">
										<c:out value="${w.tradeDate }"/>
									</td>
									<td style="width: 15%; color: red">
										-<fmt:formatNumber value="${w.amount }" pattern="#,###"/>원
									</td>
								</tr>
				              	</c:if>
			              	</c:forEach>
		              	</c:if>
			            </tbody>
		            </table>
				</div>
	        </div>
	        <div id="pageBar" class="col-12">
				${pageBar }
			</div>
	    </div>
	</div>
</section>

<style>
.page-item.active .page-link {
    z-index: 3;
    color: #fff;
    background-color: #41B979;
    border-color: #41B979;
}

.page-item.active .page-link {
    z-index: 3;
    color: #fff;
    background-color: #41B979;
    border-color: #41B979;
}

.page-link:hover {
    z-index: 2;
    color: #41B979;
    background-color: #e9ecef;
    border-color: #dee2e6;
}

.page-link {
    position: relative;
    display: block;
    color: #41B979;
    text-decoration: none;
    background-color: #fff;
    border: 1px solid #dee2e6;
}

</style>
<script>
 	function fn_paging(cPage,numPerPage) {
		location.assign("${path}/member/emoneyDetail?cPage=" + cPage + "&numPerPage="+ numPerPage+
					"&memberNo=" + ${loginMember.memberNo});
	} 
 	function fn_paging2(cPage,numPerPage,btnCategory) {
 		
 		location.assign("${path}/member/emoneySelectList?cPage=" + cPage + "&numPerPage="+ numPerPage+
				"&btnCategory="+ btnCategory);
	} 

/* 	const emoneyBtn=(value=>{
		console.log(value);
		$.ajax({
			url: "/member/emoneySelectList",
			dataType:"json",
			data: {"category" : value , "memberNo" : '${loginMember.memberNo}'},
			success: data =>{
				console.log(data);
				for(let i=0; i<data.length; i++) {
					const category = data[i]['category'];
					const proName = data[i]['productNo']['productName'];
					const date = data[i]['tradeDate'];
					const amount = data[i]['amount'];
					$("#listContainer").html(category);
				}
				
			},
		})
	}) */


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>