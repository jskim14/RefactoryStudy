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
    .rank-box{
        width: 100%;
        height: 90px;
        border: solid 1px lightgray;
        border-left: solid 8px gray;
        box-shadow: 1px 1px darkgray;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        padding:20px 20px;
        vertical-align:middle;
    }
    #_rank{margin-left:2%; min-width:50px;}
    #_sym{margin-left:5%; min-width:30px;margin-right:0;}
	#_id{margin-left:0%; min-width:15%; height:28px;}
    #_total{margin-left:4%; min-width:10%; height:50px;}
	#_ing{margin-left:4%;min-width:10%;height:50px;}
	#_done{margin-left:4%;min-width:10%;height:50px;}
	#_review{margin-left:4%;min-width:10%;height:50px;}
	#_goods{margin-left:3%; text-align:center; min-width:10%;}
</style>

     <section>
     	<div class>
            <h2><i class="fas fa-crown"></i>&nbsp&nbsp판매자 랭킹</h2>
            <p>1위부터 10위까지 판매자 랭킹입니다.</p>
            <br>
            <div>
            	<c:forEach begin="0" end="9" items="${sellerList}" var="s" varStatus="status">
                <div class="rank-box">
                	<c:choose>
                	<c:when test="${status.count eq 1 }">
	                    <div id="_rank"><img src="${path }/resources/images/trophy1.png" width=50px; height=50px;></div>
	                </c:when>
	                <c:when test="${status.count eq 2 }">
	                    <div id="_rank"><img src="${path }/resources/images/trophy2.png" width=50px; height=50px;></div>
	                </c:when>
	                <c:when test="${status.count eq 3 }">
	                    <div id="_rank"><img src="${path }/resources/images/trophy3.png" width=50px; height=50px;></div>
                    </c:when>
                    <c:otherwise>
                    	<div id="_rank"><h1 style="margin-left:10px;"><c:out value="${status.count }"/></h1></div>
                    </c:otherwise>
                    </c:choose>
                    
                    
                    <c:choose>
                	<c:when test="${s.RANK eq 'DIAMOND' }">
	                    <div id="_sym"><img src="${path }/resources/images/rank/rank4.png" width=20px; height=20px;></div>
	                </c:when>
	                <c:when test="${s.RANK eq 'GOLD' }">
	                    <div id="_sym"><img src="${path }/resources/images/rank/rank3.png" width=20px; height=20px;></div>
	                </c:when>
	                <c:when test="${s.RANK eq 'SILVER' }">
	                    <div id="_sym"><img src="${path }/resources/images/rank/rank2.png" width=20px; height=20px;></div>
                    </c:when>
                    <c:when test="${s.RANK eq 'BRONZE' }">
	                    <div id="_sym"><img src="${path }/resources/images/rank/rank1.png" width=20px; height=20px;></div>
                    </c:when>
                    <c:otherwise>
                    	<div id="_rank"><h1 style="margin-left:10px;"><c:out value="${status.count }"/></h1></div>
                    </c:otherwise>
                    </c:choose>
                    
                    <div id="_id"><p><strong style="font-size:21px;"><c:out value="${s.NICKNAME }"/></strong></p></div>
                    
                    <div id="_total"><p>총 판매 물품<br><strong style="font-size:20px; color:#7f47e9;"><c:out value="${s.TOTALCOUNT }"/></strong> 건</p></div>
                    <div id="_ing"><p>진행 중인 경매<br><strong style="font-size:20px; color:#7f47e9;"><c:out value="${s.ING }"/></strong> 건</p></div>
                    <div id="_done"><p>판매 완료 상품<br><strong style="font-size:20px; color:#7f47e9;"><c:out value="${s.DONE }"/></strong> 건</p></div>
                    <div id="_review"><p>구매후기<br><strong style="font-size:20px; color:#7f47e9;"><c:out value="${s.REVIEWCOUNT }"/></strong> 건</p></div>
                   	<c:if test="${s.ING==0 }">
                    <div id="_goods"><a href="javascript:window.alert('판매자가 진행중인 경매가 없습니다.')"><strong>판매 중인 상품<br>보러가기</strong></a></div>
                	</c:if>
                	<c:if test="${s.ING!=0 }">
                    <div id="_goods"><a href="${path }/member/sellList?memberNo=${s.MEMBERNO}"><strong>판매 중인 상품<br>보러가기</strong></a></div>
                	</c:if>
                </div>
                </c:forEach>
                
            </div>
            </div>
     	
     	
     	
     </section>
     
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>