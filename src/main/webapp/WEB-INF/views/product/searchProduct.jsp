<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
#btn-contaier {
	padding-top: 30px;
	padding-bottom: 30px;
	display: flex;
}
button.btn-choice {
	width: 60px;
	height: 30px;
	border-radius: 10px;
	background-color: #41B979;
	color: white;
	font-weight: bold;
	margin-right: 5px;
	cursor: pointer;
	border:1px solid #41B979;
}
.categoryBtn {
	width: 60px;
	height: 30px;
	border-radius: 10px;
	background-color: white;
	color: #41B979;
	font-weight: bold;
	margin-right: 5px;
	cursor: pointer;
	border:1px solid #41B979;
}
.categoryBtn:hover {
	background-color: #41B979;
	color: white;
}
.goods-box p {
	height: 108px;
}
</style>
<section style="padding-bottom: 5%;">
	<div style="height: 140px;"></div>
	<div id="list-con" style="padding-top:100px; padding-bottom: 50px;">
		<h5><span style="color:#41B979; font-weight: bold;"><c:out value="${keyword }" /></span>에 대한 검색결과는 <span style="color:#41B979; font-weight: bold;"><c:out value="${totalData }"/></span>개 입니다.</h5>
		<div id="btn-contaier">
			<button value="all" onclick="searchCategory(this.value);" class="${category eq 'all'?'btn-choice':'categoryBtn'}">전체</button>
			<button value="FS" onclick="searchCategory(this.value);" class="${category eq 'FS'?'btn-choice':'categoryBtn'}">패션</button>
			<button value="LF" onclick="searchCategory(this.value);" class="${category eq 'LF'?'btn-choice':'categoryBtn'}">라이프</button>
			<button value="TC" onclick="searchCategory(this.value);" class="${category eq 'TC'?'btn-choice':'categoryBtn'}">테크</button>
			<button value="AT" onclick="searchCategory(this.value);" class="${category eq 'AT'?'btn-choice':'categoryBtn'}">아트</button>
		</div>
		<div>
			<c:if test="${not empty searchProduct }">
				<c:forEach var="p" items="${searchProduct }" varStatus="sta">
				<c:if test="${sta.count % 4 == 1 }">
				<ul class="items-list" style="overflow: hidden;">
				<fmt:parseNumber value="${p.nowBidPrice}" var="nowBidPrice"/>
				<fmt:parseNumber value="${p.buyNowPrice}" var="buyNowPrice"/>
					<li style="width: 25%;">
						<a href="${path }/product/productDetail?productNo=${p.productNo}">
							<div class="goods-box">
								<c:if test="${not empty p.images}">
								<img src="${path }/resources/upload/product/${p.images.get(0).imageName}"
								width="100%" height="200" style="margin-bottom: 12px; border-radius: 20px;">
								</c:if>
								<c:if test="${empty p.images}">
								<img src="${path }/resources/images/"
								width="100%" height="200" style="margin-bottom: 12px; border-radius: 20px;">
								</c:if>
								<c:if test="${p.productStatus == 0 }">
								<p>
									<strong style="font-size: 15px">${p.productName }</strong><br>
									판매자&nbsp;<strong>${p.seller.nickName }</strong><br>
									<c:if test="${nowBidPrice != null }">
									현재입찰가&nbsp;<span class="price1"><fmt:formatNumber value="${p.nowBidPrice }"/></span><br>
									</c:if>
									<c:if test="${nowBidPrice == null }">
									현재입찰가&nbsp;<span class="price1"><fmt:formatNumber value="${p.minBidPrice }"/></span><br>
									</c:if>
									<c:if test="${buyNowPrice != null && nowBidPrice<buyNowPrice }">
									즉시구매가&nbsp;<span class="price2"><fmt:formatNumber value="${p.buyNowPrice }"/></span><br>
									</c:if>
									<c:if test="${buyNowPrice == null ||  nowBidPrice>buyNowPrice}">
									즉시구매불가<br>
									</c:if>
								</p>
								</c:if>
								<c:if test="${p.productStatus != 0 }">
								<p>
									<strong style="font-size: 15px">${p.productName }</strong><br>
									<span style="margin-top: 10px;">판매자&nbsp;<strong>${p.seller.nickName }</strong></span><br>
									<span style="padding-bottom: 30px;">판매 완료 상품</span><br><br>
								</p>
								</c:if>
							</div>
						</a>
					</li>
				</c:if>
				<c:if test="${sta.count % 4 != 1 }">
					<fmt:parseNumber value="${p.nowBidPrice}" var="nowBidPrice"/>
				<fmt:parseNumber value="${p.buyNowPrice}" var="buyNowPrice"/>
					<li style="width: 25%;">
						<a href="${path }/product/productDetail?productNo=${p.productNo}">
							<div class="goods-box">
								<c:if test="${not empty p.images}">
								<img src="${path }/resources/upload/product/${p.images.get(0).imageName}"
								width="100%" height="200" style="margin-bottom: 12px; border-radius: 20px;">
								</c:if>
								<c:if test="${empty p.images}">
								<img src="${path }/resources/images/"
								width="100%" height="200" style="margin-bottom: 12px; border-radius: 20px;">
								</c:if>
								<c:if test="${p.productStatus == 0 }">
								<p>
									<strong style="font-size: 15px">${p.productName }</strong><br>
									판매자&nbsp;<strong>${p.seller.nickName }</strong><br>
									<c:if test="${nowBidPrice != null }">
									현재입찰가&nbsp;<span class="price1"><fmt:formatNumber value="${p.nowBidPrice }"/></span><br>
									</c:if>
									<c:if test="${nowBidPrice == null }">
									현재입찰가&nbsp;<span class="price1"><fmt:formatNumber value="${p.minBidPrice }"/></span><br>
									</c:if>
									<c:if test="${buyNowPrice != null && nowBidPrice<buyNowPrice }">
									즉시구매가&nbsp;<span class="price2"><fmt:formatNumber value="${p.buyNowPrice }"/></span><br>
									</c:if>
									<c:if test="${buyNowPrice == null ||  nowBidPrice>buyNowPrice}">
									즉시구매불가<br>
									</c:if>
								</p>
								</c:if>
								<c:if test="${p.productStatus != 0 }">
								<p>
									<strong style="font-size: 15px">${p.productName }</strong><br>
									<span style="margin-top: 10px;">판매자&nbsp;<strong>${p.seller.nickName }</strong></span><br>
									<span style="padding-bottom: 30px;">판매 완료 상품</span><br><br>
								</p>
								</c:if>
							</div>
						</a>
					</li>
				</c:if>
				<c:choose>
					<c:when test="${sta.last && sta.count % 4 == 1 }">
					<li style="border:none; box-shadow: none;"></li><li style="border:none; box-shadow: none;"></li><li style="border:none; box-shadow: none;"></li>
					</c:when>
					<c:when test="${sta.last && sta.count % 4 == 2 }">
					<li style="border:none; box-shadow: none;"></li><li style="border:none; box-shadow: none;"></li>
					</c:when>
					<c:when test="${sta.last && sta.count % 4 == 3 }">
					<li style="border:none; box-shadow: none;"></li>
					</c:when>
				</c:choose>
				<c:if test="${sta.count % 4 == 0 }">
				</ul>
				<c:out value="${sta.end }"/>
				</c:if>
				</c:forEach>
			</c:if>
	</div>
	</div>
	<div style="padding-bottom: 80px;">
		${pageBar }
	</div>
	<script>
		function fn_paging(cPage) {
			let keyword = "${keyword}";
			let category = "${category}";
			location.assign("${path}/productSearch?cPage=" + cPage + "&keyword=" + keyword + "&category=" + category);
		}
		const searchCategory=(category)=> {
			let keyword = "${keyword}";
			location.assign("${path}/productSearch?&keyword=" + keyword + "&category=" + category);
		}
	</script>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />