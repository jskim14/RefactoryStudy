<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
#wishContainer{
   padding:15%;
}
.wish-box{
    width: 100%;
    height: 100px;
    border: solid 1px lightgray;
    border-left: solid 8px lightskyblue;
    box-shadow: 1px 1px darkgray;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    padding-top:5px;
    text-align:center;
}

#wishTitle {
    padding: 0 1% 1% 0;
    font-weight: bold;
    text-align:center;
    
}
        
</style>
<section>
    <div id="wishContainer">
        <div style="margin-bottom:5%;">
            <h2 class="pageTitle2"><i class="fas fa-eye"></i>&nbsp;오늘 본 상품</h2>
            <p>오늘 본 상품입니다.<br> 일정시간 이후 삭제되니 관심상품에 담으세요!</p>
        </div>
        <br>
        <div>
            <div id="wishTitle" class="row">
                <div class="col">
	                <button type="button" id="delete" class="btn btn-secondary btnP" style="width:100px;"
			        onclick="location.assign('${path}/product/todayDelete')"> 모두삭제
			        </button>
	        	</div>
                <div class="col-4">찜한상품</div>
                <div class="col">즉시구매가</div>
                <div class="col">현재입찰가</div>
                <div class="col">마감일</div>
                <div class="col">판매자</div>
                <div class="col"></div>
            </div>
            <c:if test="${empty list }">
            	<div style="text-align: center; padding-top: 1%;">오늘 본 상품이 없습니다.<br> 다양한 상품을 구경해보세요! </div>
            </c:if>
            <c:if test="${not empty list }">
	            <c:forEach var="p" items="${list }">
		            <div id="wishBox" class="row wish-box" onclick="javascript:wishbox('${p.productNo}');"
		            style="cursor:pointer;"> <!--  -->
		                <div class="col"><img src="${path }/resources/upload/product/${p.images[0].imageName }" width=60px; height=60px;></div>
		                <div class="col-4"><p><strong><c:out value="${p.productName }"></c:out></strong></p></div>
		                <c:if test="${empty p.buyNowPrice or p.buyNowPrice=='0' }">
		                	<div class="col"><p>즉시구매불가</p></div>
		                </c:if>
		                <c:if test="${not empty p.buyNowPrice and p.buyNowPrice!='0'}">
		                	<div class="col"><p><fmt:formatNumber value="${p.buyNowPrice }"/>원</p></div>
		                </c:if>
		                <div class="col"><p><fmt:formatNumber value="${p.nowBidPrice }"/>원</p></div>
		                <div class="col"><p><c:out value="${p.endDate }"></c:out></p></div>
		                <div class="col"><p><c:out value="${p.seller.nickName }"></c:out></p></div>
		                <div class="col">
		                </div>
		            </div>
	            </c:forEach>
            </c:if>
        </div>
    </div>
</section>
<script>

  	const wishbox=(productNo)=>{
		location.assign('${path}/product/productDetail?productNo='+productNo);
	}   
/* 
     $("#delete").click(e=>{
        e.stopPropagation();
    })  */
    
/*      const deleteWish=()=>{
    	event.stopPropagation();
		location.assign('${path}/product/todayDelete');
	}  */
    

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>