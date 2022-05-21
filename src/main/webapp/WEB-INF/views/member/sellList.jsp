<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
section {
	padding: 200px 10%;
	min-height: 800px;
}

#goods-div {
	display: flex;
	flex-wrap: wrap;
	justify-content: left;
}

.goods-box {
	width: 270px;
	height: 370px;
	border-radius: 20px;
	padding: 10px;
	margin-bottom: 30px;
	margin-right: 15px;
	box-shadow:0px 0px 10px 1px lightgray;
	color:black;
	/* margin-left: 0.5%; */
}
</style>


<section>
	
	<c:if test="${empty sellList}">
		<h2>현재 판매 중인 상품이 없습니다.</h2>
	</c:if> 
	
	<c:if test="${not empty sellList }">
	<h2><strong style="color:royalblue">${sellList.get(0).seller.nickName}</strong> 님의 판매 상품</h2>
	<br>
		<div id="goods-div">
			<c:forEach items="${sellList }" var="sl">
			<fmt:parseNumber value="${sl.nowBidPrice}" var="nowBidPrice"/>
			<fmt:parseNumber value="${sl.buyNowPrice}" var="buyNowPrice"/>
				<a href="${path }/product/productDetail?productNo=${sl.productNo}">
					<div class="goods-box">
						<c:if test="${not empty sl.images}">
							<img
								src="${path }/resources/upload/product/${sl.images.get(0).imageName}"
								width="100%" height="200"
								style="margin-bottom: 12px; border-radius: 20px;">
						</c:if>
						<c:if test="${empty sl.images}">
							<img src="${path }/resources/images/" width="100%" height="200"
								style="margin-bottom: 12px; border-radius: 20px;">
						</c:if>
						<p>
							<strong style="font-size: 18px">${sl.productName }</strong><br>
									<c:if test="${nowBidPrice != null }">
									현재입찰가&nbsp;<span class="price1"><fmt:formatNumber value="${nowBidPrice }"/></span>원<br>
									</c:if>
									<c:if test="${nowBidPrice == null }">
									현재입찰가&nbsp;<span class="price1"><fmt:formatNumber value="${minBidPrice }"/></span>원<br>
									</c:if>
									<fmt:parseNumber value="${nowBidPrice}" var="nowBidPrice"/>
									<fmt:parseNumber value="${buyNowPrice}" var="buyNowPrice"/>
									<c:choose>
										<c:when test="${nowBidPrice<buyNowPrice }" >
											즉시구매가&nbsp;<span class="price2"><fmt:formatNumber value="${buyNowPrice }"/></span>원<br>
										</c:when>
										<c:when test="${nowBidPrice>=buyNowPrice }">
											즉시구매불가<br>
										</c:when>
										<c:otherwise>
											즉시구매불가<br>
										</c:otherwise>
									</c:choose>
									판매자&nbsp;<strong>${sl.seller.nickName }</strong>
						
							<%-- <strong style="font-size: 18px">${sl.productName }</strong><br>
							<c:if test="${nowBidPrice != null }">
									현재입찰가&nbsp;<span class="price1"><fmt:formatNumber
										value="${nowBidPrice }" />원</span>
								<br>
							</c:if>
							<c:if test="${nowBidPrice == null }">
									현재입찰가&nbsp;<span class="price1"><fmt:formatNumber
										value="${sl.minBidPrice }" />원</span>
								<br>
							</c:if>
							<c:if test="${buyNowPrice != null }">
									즉시구매가&nbsp;<span class="price2"><fmt:formatNumber
										value="${buyNowPrice }" />원</span>
								<br>
							</c:if>
							<c:if test="${buyNowPrice == null }">
									즉시구매불가<br>
							</c:if>
							판매자&nbsp;<strong>${sl.seller.nickName }</strong>
						 --%>
						</p>
					</div>
				</a>
			</c:forEach>
		</div>
	</c:if>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />