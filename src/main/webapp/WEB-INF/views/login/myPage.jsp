<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
    section{
       padding:180px 10%;
       min-height:600px;
    }
    #memberinfo{padding:30px; width:48%; height:130px; border-radius:20px; box-shadow:0px 0px 10px 2px lightgray;}
    #emoney-box{padding:30px; width:48%; height:130px; border-radius:20px; box-shadow:0px 0px 10px 2px lightgray;}
    .menu-div{display:flex; flex-wrap: wrap; justify-content: space-around; padding-top:30px;}
    .menu-box{
    width:22%; height:120px; justify-content:space-around; border-radius:20px;
	border:solid 1px none; color:black; font-size:18px; font-weigth:bold;
	box-shadow:0px 0px 10px 2px lightgray; background:white;}
	.menu-box:hover{background:yellow;color:black;}
	.myinfo-btn{background:royalblue; color:white; width:100px; height:36px;border-radius:8px;float:right;}
	.myinfo-btn:hover{background:gray;}
	.menu-box2{
    width:50%; height:120px; justify-content:space-around; border-radius:20px;
	border:solid 1px none; color:black; font-size:18px; font-weigth:bold;
	box-shadow:0px 0px 10px 2px lightgray; background:white;}
	.menu-box2:hover{background:powderblue;}
</style>

<section>
	<h2 style="text-align: center;">
		<i class="fas fa-box-check"></i>MY PAGE
	</h2>
	<hr>
	<div class="menu-div">
		<div id="memberinfo" style="display: flex;">
			<div style="min-width: 80%;">
				<span>안녕하세요,</span><br>
				<h2 class="subTitle">
					<c:out value="${myPageMember.memberName }" />
					<span style="font-size: 18px;">님의 등급은 <c:choose>
							<c:when test="${myPageMember.rank eq 'DIAMOND' }">
								<img src="${path }/resources/images/rank/rank4.png" width=20px;
									height=20px;>
							</c:when>
							<c:when test="${myPageMember.rank eq 'GOLD' }">
								<img src="${path }/resources/images/rank/rank3.png" width=20px;
									height=20px;>
							</c:when>
							<c:when test="${myPageMember.rank eq 'SILVER' }">
								<img src="${path }/resources/images/rank/rank2.png" width=20px;
									height=20px;>
							</c:when>
							<c:when test="${myPageMember.rank eq 'BRONZE' }">
								<img src="${path }/resources/images/rank/rank1.png" width=20px;
									height=20px;>
							</c:when>
						</c:choose> <c:out value="${myPageMember.rank }" /> 입니다.
					</span>
				</h2>
			</div>
			<div>
				<button type="button" class="myinfo-btn"
					style="margin-bottom: 10px;"
					onclick="location.assign('${path }/member/updateMyPage?memberNo=${loginMember.memberNo}');">내정보
					관리</button>
				<br>
				<button type="button" class="myinfo-btn"
					onclick="location.assign('${path }/member/deleteMemberView');">회원탈퇴</button>
			</div>
		</div>
		<div id="emoney-box" style="display: flex;">
			<div style="min-width: 82%;">
				<h2 class="subTitle">
					이머니 관리&nbsp <a
						href="${path }/member/emoneyDetail?memberNo=${loginMember.memberNo}"
						class="aColor"> <i class="fas fa-cog"
						style="font-size: 1.6rem; color: green;"></i></a>
				</h2>
				<a
					href="${path }/member/emoneyDetail?memberNo=${loginMember.memberNo}"
					class="aColor"> <span style="font-size: 20px">사용가능 잔액 </span> <span
					style="font-size: 30px;"><fmt:formatNumber
							value="${myPageMember.balance }" pattern="#,###" />원</span>
				</a>
			</div>

			<div style="float: right;">
				<button type="button" class="btn btn-secondary btnColor"
					style="height: 78px; width: 80px;" onclick="goToCharge()">
					충전<br>하기
				</button>
			</div>

		</div>
	</div>
	<div class="menu-div">
		<button type="button" class="menu-box"
			onclick="location.assign('${path}/product/todayView');">
			오늘본 상품<br> <i class="fas fa-eye" style="font-size: 2rem;"></i>
		</button>
		<button type="button" class="menu-box"
			onclick="location.assign('${path }/member/myWishList?memberNo=${loginMember.memberNo}');">
			관심상품<br> <i class="far fa-bookmark" style="font-size: 2rem;"></i>
		</button>

		<button class="menu-box2" onclick="location.assign('${path}/member/buyStates?memberNo=${loginMember.memberNo}');">
			<strong style="font-size: 20px;">내 구매현황</strong><br> 전체
			<c:out value="${buyCnt.get(0)}" />
			건&nbsp;&nbsp;&nbsp;&nbsp; 입찰중
			<c:out value="${buyCnt.get(1)}" />
			건&nbsp;&nbsp;&nbsp;&nbsp; 구매대기
			<c:out value="${buyCnt.get(2)}" />
			건&nbsp;&nbsp;&nbsp;&nbsp; 종료
			<c:out value="${buyCnt.get(3)}" />
			건
		</button>

	</div>
	<div class="menu-div">
		<button type="button" class="menu-box"
			onclick="location.assign('${path }/cs/myQna?memberNo=${loginMember.memberNo}');">
			내 문의내역<br> <i class="fas fa-question" style="font-size: 2rem;"></i>
		</button>
		<button type="button" class="menu-box"
			onclick="location.assign('${path}/product/insertProduct')">
			물품 등록<br> <i class="fas fa-registered" style="font-size: 2rem;"></i>
		</button>
		<button class="menu-box2" onclick="location.assign('${path}/member/salesStates?memberNo=${loginMember.memberNo}');">
			<strong style="font-size: 20px;">내 판매현황</strong><br> 전체
			<c:out value="${salesCnt.get(0)}" />
			건&nbsp;&nbsp;&nbsp;&nbsp; 판매대기
			<c:out value="${salesCnt.get(1)}" />
			건&nbsp;&nbsp;&nbsp;&nbsp; 판매중
			<c:out value="${salesCnt.get(2)}" />
			건&nbsp;&nbsp;&nbsp;&nbsp; 판매완료
			<c:out value="${salesCnt.get(3)}" />
			건&nbsp;&nbsp;&nbsp;&nbsp; 종료
			<c:out value="${salesCnt.get(4)}" />
			건
		</button>

	</div>

</section>


<script>
	function goToCharge(){
		/* event.stopPropagation(); */
		let chargeWindow = window.open('${path}/member/charge','_blank','width=400,height=500');
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>