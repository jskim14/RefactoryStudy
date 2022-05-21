<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include
	page="/WEB-INF/views/common/header.jsp" />
<section style="padding: 200px 10%;">
<style>
.pick{
	border:3px solid #41B979;
}
.btn-green {
	color: #fff;
	background-color: #41B979;
	border-color: #41B979;
}

.btn-purple {
	color: #fff;
	background-color: #7f47e9;
	border-color: #7f47e9;
}

</style>

	<div class="container-fluid">
		<div class="row">
			<div class="col-12">

				<div class="row">
					<div class="col-6">
						<div class="row">
							<div class="col-12">
								<div id="carouselExampleIndicators" class="carousel slide  mb-3"
									data-bs-ride="carousel">
									<div class="carousel-indicators">
										<c:if test="${not empty  product.images }">
											<c:forEach items="${product.images }" varStatus="status"
												var="img">
												<button type="button"
													data-bs-target="#carouselExampleIndicators"
													data-bs-slide-to="${status.index }"
													<c:if test="${status.first}">
												class="active" 
												aria-current="true"
												</c:if>
													aria-label="Slide${status.index+1 }"></button>
											</c:forEach>
										</c:if>
									</div>
									<div class="carousel-inner">
										<c:if test="${not empty product.images  }">
											<c:forEach items="${product.images }" varStatus="status"
												var="img">
												<c:if test="${status.first }">
													<div class="carousel-item active">
												</c:if>
												<c:if test="${not status.first }">
													<div class="carousel-item">
												</c:if>
												<img src="${path}/resources/upload/product/${img.imageName}"
													class="d-block" alt="..." width="100%" height="500px">
									</div>
									</c:forEach>
									</c:if>
								</div>
								<button class="carousel-control-prev" type="button"
									data-bs-target="#carouselExampleIndicators"
									data-bs-slide="prev">
									<strong class="carousel-control-prev-icon" aria-hidden="true"></strong>
									<strong class="visually-hidden">Previous</strong>
								</button>
								<button class="carousel-control-next" type="button"
									data-bs-target="#carouselExampleIndicators"
									data-bs-slide="next">
									<strong class="carousel-control-next-icon" aria-hidden="true"></strong>
									<strong class="visually-hidden">Next</strong>
								</button>
							</div>
							<div class="d-flex" style="justify-content: space-around;">
								<c:if test="${not empty product.images }">
									<c:forEach items="${product.images }" varStatus="status"
										var="img">
										<button type="button"
											data-bs-target="#carouselExampleIndicators"
											data-bs-slide-to="${status.index }"
											aria-label="Slide${status.index+1 }">
											<img src="${path}/resources/upload/product/${img.imageName}"
												alt="사진1" width="150px" height="150px">
										</button>
									</c:forEach>
								</c:if>

							</div>
						</div>

				

					</div>
				</div>
				<div class="col-1"></div>
				<div id="infoBox" class="col-5">
					<div class="row mb-1">
						<div class="col-12">
							<strong> <c:choose>
									<c:when test="${product.productCategory eq 'FS' }">
										<c:out value="패션(${product.productCategory})" />
									</c:when>
									<c:when test="${product.productCategory eq 'LF' }">
										<c:out value="라이프(${product.productCategory})" />
									</c:when>
									<c:when test="${product.productCategory eq 'TC' }">
										<c:out value="테크(${product.productCategory})" />
									</c:when>
									<c:when test="${product.productCategory eq 'AT' }">
										<c:out value="아트(${product.productCategory})" />
									</c:when>
									<c:otherwise>
									-
								</c:otherwise>
								</c:choose>
							</strong>
						</div>
					</div>
					<div class="row mb-1">
						<div class="col-12">
							<strong><c:out value="${product.productName}" /></strong>
						</div>
					</div>
					<div class="row mb-1">
						<div class="col-6">
							<strong>물품번호</strong>
						</div>
						<div class="col-6">
							<strong style="float: right;"><c:out
									value="${product.productNo }" /></strong>
						</div>
					</div>
					<hr>
					<div class="row mb-1">
						<div class="col-6">
							<strong>최고입찰자</strong>
						</div>
						<div class="col-6">
							<strong style="float: right;"> <c:if
									test="${product.highestBidder eq null }">
								-
							</c:if> <c:if test="${product.highestBidder ne null }">
									<c:out value="${product.highestBidder.nickName }" />
								</c:if>
							</strong>
						</div>
					</div>

					<div class="row">
						<div class="col-12">
							<strong>현재가</strong>
						</div>
					</div>

					<div class="row">
						<div class="col-12">
							<strong style="float: right;"><c:out
									value="${ product.nowBidPrice}" /><span>원</span></strong>
						</div>
					</div>
					<hr>
					<div class="row mb-1">
						<div class="col-12">
							<strong>시작가-</strong><strong><c:out
									value="${product.minBidPrice }" /></strong><strong>원</strong>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<strong>경매종료까지</strong>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div id="timer"
								style="padding-left: 10px; float: right; font-size: 40px; font-weight: bold;">

							</div>
						</div>
					</div>
					
					<hr>
					
						<div class="row">
							<div class="col-1"></div>
							<div class="col-6">
								<div style="border: 3px solid #41B979; border-radius: 10px">
									<input id="bidUnitInput" type=text
										value="<fmt:formatNumber value="${product.nowBidPrice+product.bidUnit }"/>"
										style="text-align: right; padding-right: 10px; background: none; font-size: 30px; width: 100%;"
										${!isSell?"disabled":"" }>
									<!-- <span>원</span> -->
								</div>
							</div>
							<div class="col-1"></div>
							<div class="col-4">
								<button type="button" class="btn btn-green"
									data-bs-toggle="modal" data-bs-target="#biddingModal"
									style="height: 100%; width: 100%; font-size: 20px"
									${!isSell?"disabled":"" }>입찰하기</button>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-12">
								<small style="font-size: 12px">다음 입찰금액은 <b><c:out
											value="${product.nowBidPrice+product.bidUnit }" /></b>원 이며 ,
									그이상을 직접입력하여 입찰할 수 있습니다.
								</small>
							</div>
						</div>
						<hr>
						<div class="row mb-3">
							<div class="col-12">
								<strong>buy now</strong>
							</div>
						</div>
						<div class="row">
							<div class="col-1"></div>
							<div class="col-6">
								<div
									style="border: 3px solid #41B979; border-radius: 10px; display: flex; justify-content: flex-end;">
									<span style="font-size: 30px; margin-right: 10px"> <fmt:formatNumber
											value="${product.buyNowPrice==null?0 : product.buyNowPrice }" />
									</span>
								</div>
							</div>
							<div class="col-1"></div>
							<div class="col-4">
								<button type="button" class="btn btn-green"
									style="height: 100%; width: 100%; font-size: 20px"
									onclick="checkBuyNow('${product.productNo}','${loginMember==null?false:true }');"
									${!isSell?"disabled":"" }>바로구매</button>
								<button id="buyNowModalBtn" type="button" data-bs-toggle="modal"
									data-bs-target="#buyNowModal" style="display: none"></button>

							</div>
						</div>


					
						<hr>
						<div class="row">
							<div class="col-12">
								<div class="accordion accordion-flush"
									style="border: 2px solid black;" id="accordionFlushExample">
									<div class="accordion-item">
										<h2 class="accordion-header" id="flush-headingOne">
											<button class="accordion-button collapsed" type="button"
												data-bs-toggle="collapse"
												data-bs-target="#flush-collapseOne" aria-expanded="false"
												aria-controls="flush-collapseOne">판매자 정보</button>
										</h2>
										<div id="flush-collapseOne"
											class="accordion-collapse collapse"
											aria-labelledby="flush-headingOne"
											data-bs-parent="#accordionFlushExample">
											<div class="accordion-body">
												<div class="row">
													<div class="col-1"></div>
													<div class="col-6">
														<strong>판매자 닉네임</strong>
													</div>
													<div class="col-4" style="text-align: right;">
														<c:out value="${product.seller.nickName}" />
													</div>
													<div class="col-1"></div>
												</div>
												<div class="row">
													<div class="col-1"></div>
													<div class="col-6">
														<strong>판매자 등급</strong>
													</div>
													<div class="col-4" style="text-align: right;">
														<c:out value="${product.seller.rank}" />
													</div>
													<div class="col-1"></div>
												</div>
												<div class="row">
													<div class="col-1"></div>
													<div class="col-6">
														<strong>구매후기</strong>
													</div>
													<div class="col-4 d-flex justify-content-end">
														<button id="reviewBtn" type="button" class="btn btn-green"
															data-bs-toggle="modal" data-bs-target="#reviewModal">보러가기</button>
													</div>
													<div class="col-1"></div>
													<script>

												$("#reviewBtn").click(e=>{
													
													$.ajax({
														url: "${path}/product/review",
														data:{sellerNo:'${product.seller.memberNo}'},
														dataType:'json',
														success:data=>{
															console.log(data);
															const root = $("#reviewContainer");
															root.html("");
															for(let i=0; i<data.length; i++){
																const box = $("<div>").addClass("list-group-item d-flex justify-content-between align-items-center");
																
																const div1 = $("<div>");
																const div2 = $("<div>");
																
																const content = $("<span>").html(data[i]['reviewContent']);
																const rate = $('<span>').addClass("badge bg-primary rounded-pill").html(data[i]['reviewRate']);
																const date = $('<span>').html(data[i]['reviewDate']);
															
																div1.append(content);
																div2.append(rate).append(date);
															
																box.append(div1).append(div2)
																root.append(box);
															}
															
															
															
														}
													});
												});

												</script>
												</div>
											</div>
										</div>
									</div>
								</div>

							</div>

						</div>
					
				</div>

				<div class="row">
					<div class="col-12">
						<hr>
						<h3>
							<strong>상품정보</strong>
						</h3>
					</div>
					<div class="col-12">
						<p>
							<c:out value="${product.productContent }" escapeXml="false" />
						</p>
					</div>

				</div>

<div class="container" style="z-index: 999;position: fixed; right:150px; top:60%; left:10%; height: 160px; width: 300px;background-color: rgba( 255, 255, 255, 0.5 ); border: 1px solid yellow; border-radius: 10px">
	<div class="row mt-4" style="text-align:center;">
		<i class="fas fa-exclamation fa-3x"></i>
		<h4>물품을 승인하시겠습니까?</h4>
		<br>
		<div class="col ">
			<button type="button" class="btn btn-purple w-100" data-bs-toggle="modal" data-bs-target="#rejectModal">거절</button>
		</div>
		<div class="col">
			<button type="button" class="btn btn-green w-100" onclick="permission()">승인</button>
		</div>
	</div>
	<script>
		function permission(){
			location.assign("${path}/admin/permission?productNo=${product.productNo}");
		}
	
	</script>
	
	
</div>



</section>
<div class="modal fade" id="rejectModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">거절 사유</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body container-fluid">
				<div class="roww">
					<div class="col-12">
						<textarea id="rejectReason" class="form-control" rows="3"></textarea>
					</div>
				</div>
	
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>
				<button type="button" class="btn btn-purple" onclick="reject()">거절완료</button>
				<script>
				
					function reject(){
						//location.assign(location.origin+"/admin/reject?productNo=${product.productNo}");
						let form = document.createElement('form');
						form.setAttribute("method",'post');
						form.setAttribute("action","${path}/admin/reject");
						document.charset ="utf-8";

						let hiddenInput1 = document.createElement('input');
						hiddenInput1.setAttribute('type','hidden');
						hiddenInput1.setAttribute('name','rejectReason');
						hiddenInput1.setAttribute('value',$('#rejectReason').val());
						form.appendChild(hiddenInput1);

						let hiddenInput2 = document.createElement('input');
						hiddenInput2.setAttribute('type','hidden');
						hiddenInput2.setAttribute('name','productNo');
						hiddenInput2.setAttribute('value','${product.productNo}');
						form.appendChild(hiddenInput2);


						document.body.appendChild(form);
						form.submit();
					}
				
				</script>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="reviewModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">판매자 후기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body container-fluid">
				<ul id="reviewContainer" class="list-group">

				</ul>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script src="${path }/resources/js/productDetail.js"></script>
<jsp:include
	page="/WEB-INF/views/common/footer.jsp" />