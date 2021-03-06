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
	font-size:12px;
}

#bidderList {
	-ms-overflow-style: none;
}

#bidderList::-webkit-scrollbar {
		width:10px;
	}
#bidderList::-webkit-scrollbar-thumb{
    height: 30px;
    background-color: #C4C4C4;
    border-radius: 10px;    
}
#bidderList::-webkit-scrollbar-track{
    background-color: rgba(0,0,0,0);
}

.other{
}
.other:active{
	margin-left:5px;
	margin-top:5px;
	box-shadow:none;
}
.other:hover{
	cursor: pointer;
}




</style>
<script>
	const status = ${product.productStatus};
</script>
<fmt:formatDate var="endDate" value="${product.endDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
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
													class="d-block" alt="..." width="100%" height="400px">
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
							<div class="d-flex" style="justify-content: space-around; margin-bottom:20px;">
								<c:if test="${not empty product.images }">
									<c:forEach items="${product.images }" varStatus="status"
										var="img">
										<button type="button"
											data-bs-target="#carouselExampleIndicators"
											data-bs-slide-to="${status.index }"
											aria-label="Slide${status.index+1 }">
											<img src="${path}/resources/upload/product/${img.imageName}"
												alt="??????1" width="120px" height="120px">
										</button>
									</c:forEach>
								</c:if>

							</div>
						</div>

						<c:if test="${isGeneral ==true }">

							<div class="col-11">
								<strong>????????? ?????????</strong>
							</div>
							<div class="col-1">
								<a id="renewBtn" href=""> <i class="fas fa-sync-alt"></i></a>
							</div>



							<div id="bidderList" class="col-12"

								style="height: 120px; overflow: auto">
								<table class="table table-striped" style="text-align: center;">
									<tr
										style="position: sticky; top: 0; background-color:gray !important;font-weight: bolder;font-size:14px;">
										<th style="color: white;">?????????</th>
										<th style="color: white;">?????? ??????</th>
									</tr>
									<c:forEach items="${bidderList }" var="b">
										<tr style="font-size:14px;">
											<td><c:out value="${b['NICKNAME'] }" /></td>
											<td><strong><c:out value="${b['AMOUNT'] }" /></strong>???</td>
										</tr>

									</c:forEach>


								</table>
							</div>

						</c:if>

					</div>
				</div>
				<div class="col-1"></div>
				<div id="infoBox" class="col-5">
					<div class="row mb-1">
						<div class="col-8" style="font-size:14px;text-align:center;color:#41B979; width:95px; border:solid 1px #41B979; border-radius:8px; margin-left:10px;">
							<strong> <c:choose>
									<c:when test="${product.productCategory eq 'FS' }">
										<c:out value="??????(${product.productCategory})" />
									</c:when>
									<c:when test="${product.productCategory eq 'LF' }">
										<c:out value="?????????(${product.productCategory})" />
									</c:when>
									<c:when test="${product.productCategory eq 'TC' }">
										<c:out value="??????(${product.productCategory})" />
									</c:when>
									<c:when test="${product.productCategory eq 'AR' }">
										<c:out value="??????(${product.productCategory})" />
									</c:when>
									<c:otherwise>
									-
									</c:otherwise>
								</c:choose>
							</strong>
						</div>
					</div>
					<div class="row mb-1">
						
						<div class="col-12" style="color:gray;font-style:italic;">
							<c:out value="${product.productNo }" />
						</div>
						
					</div>
					<div class="row mb-1">
						<div class="col-12" style="font-size:26px;">
							<strong><c:out value="${product.productName}" /></strong>
						</div>
					</div>

					<hr>
					<div class="row mb-1">
						<div class="col-6">
							<strong>?????? ?????????</strong>
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
							<strong>?????????</strong>
							<strong style="float: right;"><c:out
									value="${ product.nowBidPrice}" /><span>???</span></strong>
						</div>
					</div>
					<hr>
					<div class="row mb-1">
						<div class="col-12">

							<strong>?????? ?????????: </strong>
							<strong style="float:right;"><c:out
									value="${product.minBidPrice }" /><span>???</span></strong>

						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<c:if test="${isGeneral == true }">
							<strong>?????? ???????????? ?????? ??????: </strong>
							</c:if>
							<c:if test="${isGeneral == false }">
							<strong>?????? ???????????? ?????? ??????: </strong>
							</c:if>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div id="timer"
								style="padding-left: 10px; float: right; font-size: 28px; font-weight: bold;">

							</div>
						</div>
					</div>
					<script>
					

						const countDown=(id , date,flag)=>{
							let targetDate = new Date(date);
							const second = 1000;
							const minute= second * 60;
							const hour = minute * 60;
							const day = hour* 24;
							let timer;
							
							function showRemaining(){
								let now = new Date();
								let distDate = targetDate-now;
								console.log(flag);
								console.log("${product.bannerImageName}"!=null);
								console.log(Number(status)==0);
								if(distDate < 0 ){
									clearInterval(timer);
									if(flag && Number(status)==1){
										$('#goBtn').attr({disabled:true});
										document.getElementById(id).textContent = "????????? ???????????????.";
									}else if(flag && "${product.bannerImageName}"!=null && Number(status)==0){
										console.log(status);
										$('#goBtn').attr({disabled:false});
										document.getElementById(id).textContent = "???????????????...";
									}
									return;
								}
								
								let days = Math.floor(distDate/day);
								let hours = Math.floor((distDate%day)/hour);
								let minutes = Math.floor((distDate%hour)/minute);
								let seconds = Math.floor((distDate%minute)/second);
								
								document.getElementById(id).textContent = days + '??? ';
								document.getElementById(id).textContent += hours + '?????? '; 
								document.getElementById(id).textContent += minutes + '??? '; 
								document.getElementById(id).textContent += seconds + '???';

							}
							
							timer = setInterval(showRemaining,1000);
							
						}
						countDown("timer",new Date('${endDate}'),'${isGeneral}');
						
					</script>
					<hr>
					<c:if test="${isGeneral == true }">

						<div class="row">
							<div class="col-7">
								<div style="border: 2px solid #7f47e9; border-radius: 10px">
									<input id="bidUnitInput" type=text
										value="<fmt:formatNumber value="${ product.nowBidPrice==null?product.minBidPrice+product.bidUnit:product.nowBidPrice+product.bidUnit }"/>"
										style="text-align: right; padding-right: 10px; background: none; font-size: 28px; width: 100%;"
										${!isSell?"disabled":"" }>
									<!-- <span>???</span> -->
								</div>
							</div>
							<div class="col-5">
								<button type="button" class="btn btn-purple"
									data-bs-toggle="modal" data-bs-target="#biddingModal"
									style="height: 100%; width: 100%; font-size: 20px"
									${!isSell?"disabled":"" }>????????????</button>
							</div>
						</div>
						
						<div id="bidButtons" class="row mb-3" style="margin-top:10px;">
							<div class="col-3">
								<button type="button" class="w-100 btn btn-purple"value="1000"
									${!isSell?"disabled":"" }>???1,000</button>
							</div>
							<div class="col-3">
								<button type="button" class="w-100 btn btn-purple" value="10000"
									${!isSell?"disabled":"" }>???10,000</button>
							</div>
							<div class="col-3">
								<button type="button" class="w-100 btn btn-purple"
									value="100000" ${!isSell?"disabled":"" }>???100,000</button>
							</div>
							<div class="col-3">
								<button type="button" class="w-100 btn btn-purple"
									value="1000000" ${!isSell?"disabled":"" }>???1,000,000</button>
							</div>
						</div>
						
						<div class="row mt-2">
							<div class="col-12">
								<small style="font-size: 13px; float:right;">?????? ??????????????? <b><c:out
											value="${(product.nowBidPrice==null?product.minBidPrice:product.nowBidPrice)+product.bidUnit }" /></b>?????????,
									???????????? ?????? ???????????? ????????? ??? ????????????.
								</small>
							</div>
						</div>
						<hr>
						<!-- <div class="row mb-3">
							<div class="col-12">
								<strong>?????? ????????????</strong>
							</div>
						</div> -->
						<div class="row">
							<c:choose>
								<c:when test="${product.buyNowPrice!=null and product.nowBidPrice==null?true:Integer.parseInt(product.nowBidPrice)<Integer.parseInt(product.buyNowPrice)}">
									<div class="col-7">
										<div
											style="border: 2px solid #41B979; border-radius: 10px; display: flex; justify-content: flex-end;">
											<span style="font-size: 28px; margin-right: 10px"> <fmt:formatNumber
													value="${product.buyNowPrice }" />
											</span>
										</div>
									</div>

									<div class="col-5">
										<button type="button" class="btn btn-green"
											style="height: 100%; width: 100%; font-size: 20px"
											onclick="checkBuyNow('${product.productNo}','${loginMember==null?false:true }');"
											${!isSell?"disabled":"" }>?????? ????????????</button>
										<button id="buyNowModalBtn" type="button"
											data-bs-toggle="modal" data-bs-target="#buyNowModal"
											style="display: none"></button>

									</div>
								</c:when>
								<c:otherwise>
									<div class="col-12 d-flex justify-content-center align-items-center" style="opacity:0.3; border-radius:20px; background-color: #41B979; width:99%;height:60px">
										<span style="font-size:24px;color:white;">???????????? ?????? ???????????????.</span>
									</div>
								</c:otherwise>
							</c:choose>

						</div>


						<div class="row mt-3">
							<div class="col-12">
								<!-- 	<div style="width: 100%; height: 50px; border: 1px solid black; display: flex; justify-content: center; opacity: 0.3;">

								<i style="margin: 0;" class="far fa-bookmark fa-3x"></i> <strong
									style="height: 100%; margin: 0; padding-top: 10px; margin-left: 20px; font-size: 20px; font-weight: bold;">????????????</strong>


							</div> -->
								<c:if test="${isWishList == false && product.productStatus == 0 }">
									<button id="wishListBtn" type="button"
										class="btn btn-green w-100 d-flex justify-content-center align-items-center">
										<i class="far fa-bookmark fa-2x"></i> &nbsp;&nbsp;<span style="font-size:20px">????????????</span>
									</button>
								</c:if>
								<c:if test="${isWishList == true || product.productStatus != 0}">

									<button id="wishListBtn" type="button"
										class="btn btn-green w-100 d-flex justify-content-center align-items-center"
										disabled>
										<i class="far fa-bookmark fa-2x"></i>&nbsp;&nbsp;<span style="font-size:20px">????????????</span>
									</button>
								</c:if>
							</div>
							<script>

						$("#wishListBtn").click(e=>{
							
							

							$.ajax({
								url:"${path}/product/wishList",
								data:{productNo:'${product.productNo}',memberNo:'${loginMember.memberNo}'},
								dataType:'json',
								success:data=>{
									console.log(data);
									alert(data['result']);
									$("#wishListBtn").attr('disabled',true);
								}
							});
							
						});

						</script>
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
												aria-controls="flush-collapseOne">????????? ??????</button>
										</h2>
										<div id="flush-collapseOne"
											class="accordion-collapse collapse"
											aria-labelledby="flush-headingOne"
											data-bs-parent="#accordionFlushExample">
											<div class="accordion-body">
												<div class="row">
													<div class="col-1"></div>
													<div class="col-6">
														<strong>????????? ?????????</strong>
													</div>
													<div class="col-4" style="text-align: right;">
														<c:out value="${product.seller.nickName}" />
													</div>
													<div class="col-1"></div>
												</div>
												<div class="row">
													<div class="col-1"></div>
													<div class="col-6">
														<strong>????????? ??????</strong>
													</div>
													<div class="col-4" style="text-align: right;">
														<c:out value="${product.seller.rank}" />
													</div>
													<div class="col-1"></div>
												</div>
												<div class="row">
													<div class="col-1"></div>
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

					</c:if>
					<c:if test="${isGeneral != true }">
						<div class="row">
							<div class="col-12">
								<button id="goBtn" type="button" class="btn btn-green w-100"
									onclick="goToSpecialAction()">????????? ???????????????~</button>
							</div>
						</div>
	<script>
			activeBtn('${product.startDate}');
			function activeBtn(date){
				const bidStartDate = new Date(date);
				const nowDate = new Date();

				let gap = nowDate - bidStartDate;

  				if(gap>0){
					$('#goBtn').attr({disabled:true});
				}else{
					$('#goBtn').attr({disabled:false});
				} 

			}


			function goToSpecialAction(){
				if("${loginMember}"!="") {
					open("${path}/product/realtimeaction?productNo=${product.productNo}","_blank","width=1100, height=700, left=150"); 
				}else {
					alert("????????? ??? ????????? ??? ????????????.");
				}
			}
	</script>


					</c:if>

				</div>
				<br>
				<div class="row" style="min-height:300px; margin-top:100px;">
					<div class="col-12">
						
						<h3>
							????????????
						</h3>
						<hr>
						<div style="justify-content:flex-start;align-items:flex-start;">
							<p><c:out value="${product.productContent }" escapeXml="false"/></p>
						</div>
					</div>

				</div>

				<c:if test="${isGeneral == true }">

					<div class="row">
						<div class="col-12" style="margin-top:100px;">
							
							<h3>
								<strong><c:out
											value="${product.seller.nickName}" /></strong>??? ????????????<br>
							</h3>
							<hr>
						</div>
						
						<div class="col-12 d-flex" style="overflow-x:auto; " >
						
							<c:forEach items="${otherList }" var="other">
								<div class="other m-1" onclick="location.href='${path}/product/productDetail?productNo=${other.productNo }';" 
								style="width:270px; height:340px; border-radius: 10px; margin-right:20px; box-shadow: 0px 0px 10px 1px lightgray; transition-duration:0.3s">
									<div class="d-flex justify-content-center my-2">
										<img src="${path}/resources/upload/product/${other.images.get(0).imageName}" width="220px"
											height="200px" style="border-radius: 10px;">
									</div>
									<div class="alignVertical" style="padding-left:20px;">
										<div class="nameLine">
											<div>
												<strong>
													<c:choose>
														<c:when test="${other.productCategory == 'AR' }">
														??????
														</c:when>
														<c:when test="${other.productCategory == 'FS' }">
														??????
														</c:when>
														<c:when test="${other.productCategory == 'LF' }">
														?????????
														</c:when>
														<c:when test="${other.productCategory == 'TC' }">
														??????
														</c:when>
													</c:choose>
												</strong>
											</div>
											<div>
												<strong><c:out value="${other.productName}"/></strong>
											</div>
										</div>
										<div class="nameLine fontColorRed">
											<c:if test="${other.buyNowPrice == 0 }">
												<strong style="color:#7f47e9;">????????????????????????</strong>
											</c:if>
											<c:if test="${other.buyNowPrice != 0 }">
												<strong>???????????????</strong> <strong style="color:#7f47e9;"><fmt:formatNumber value="${other.buyNowPrice}"/></strong>
											</c:if>
										</div>
										<div class="nameLine fontColorGreen">
											<strong>???????????????</strong> <strong style="color:#41B979;"><fmt:formatNumber value="${other.nowBidPrice}"/></strong>
										</div>
									</div>
								</div>
							</c:forEach>
						
						
						
							


						</div>
					</div>
			</div>
		</div>
		</c:if>
</section>
<div class="modal fade" id="buyNowModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">?????? ??????</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body container-fluid">
				<form action="${path}/product/buyNowEnd" method="post">
					<div class="row">
						<div class="col-12">
							<span style="font-size: 30px;">????????????</span>
						</div>


						<div class="col-12" style="margin: 0 auto; text-align: center;">
							<img
								src="${path}/resources/upload/product/${product.images.get(0).imageName}"
								alt="..." width="250px">
						</div>


						<div class="col-12">
							<span><c:out value="${product.productNo }" /></span>
							<input type="hidden" name="productNo" value="<c:out value="${product.productNo }" />">
						</div>
						<div class="col-12 mb-3">
							<span><c:out value="${product.productName }" /></span>
						</div>

						<div class="row"
							style="text-align: center; font-size: 20px; font-weight: bold;">
							<div class="col-6">
								<span>?????????</span>
							</div>
							<div class="col-6" style="border: 5px solid #41B979;">
								<span><c:out value="${product.buyNowPrice }" /></span>
							</div>

						</div>




						<div class="col-12">

							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="radioAddressCheck" id="normalAddressRadio" value="normal"
									checked> <label class="form-check-label"
									for="normalAddressRadio">????????????</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="radioAddressCheck" id="shipAddressRadio" value="ship">
								<label class="form-check-label" for="shipAddressRadio">????????????</label>
							</div>
						</div>


						<div class="col-12">
							<span>????????????</span>
						</div>
						<div class="col-12 mb-3">
							<input id="normalAddress" type="text" class="form-control w-100"
								readonly value="${loginMember.address }">
						</div>


						<div class="col-12 mb-3">
							<span>????????????</span>
							<button type="button" class="btn btn-green" onclick="newAddressInput(); findAddress()">?????? ??????</button>
						</div>
						<div class="col-12">
							<input id="shipAddress" name="shipAddress" type="text" class="form-control w-100"
								value="${loginMember.deliveryAddress }" readonly>
							 <input
								id="hiddenAddress" type="hidden"
								value="${loginMember.deliveryAddress }" />
						</div>


						<div class="col-12">

						</div>


						<div class="col-12">
							<span>?????????</span>
						</div>
						<div class="col-12">
							<input type="text" name="phone" class="form-control w-100"
								value="${loginMember.phone }">
						</div>


						<div class="col-12">
							<span>????????????</span>
						</div>
						<div class="col-12">
							<input type="text" name="name" class="form-control w-100"
								value="${loginMember.memberName }">
						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">??????</button>
						<button type="submit" class="btn btn-green">????????????</button>
					</div>
				</form>
			</div>
		</div>


	</div>
</div>

<div class="modal fade" id="biddingModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">?????? ?????????????????????????</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body container-fluid">???????????????...</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>
				<button type="button" class="btn btn-green"
					onclick="bid('${product.productNo}');">????????????</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="reviewModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">????????? ??????</h5>
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
<script>

    //??? ??????????????? ????????? ?????? ?????? ????????? ?????? ????????? ??????, ???????????? ???????????? ???????????? ????????? ????????? ???????????? ????????? ???????????????.
    function findAddress() {
        new daum.Postcode({
            oncomplete: function(data) {
              
                var roadAddr = data.roadAddress; 
                var extraRoadAddr = ''; 

             
                if(data.bname !== '' && /[???|???|???]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
              
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
               
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                
                const totalAddress = roadAddr + extraRoadAddr;
                
                
                if(totalAddress !== ''){
                    document.getElementById("shipAddress").value = totalAddress;
                } else {
                    document.getElementById("shipAddress").value = '';
                }

              
            }
        }).open();
    }
</script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${path }/resources/js/productDetail.js"></script>
<jsp:include
	page="/WEB-INF/views/common/footer.jsp" />