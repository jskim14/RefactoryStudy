<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include
	page="${pageContext.request.contextPath}/WEB-INF/views/common/header.jsp" />
<section style="padding: 200px 10%;">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">

				<div class="row">
					<div class="col-6 mb-1">
						<div id="carouselExampleIndicators" class="carousel slide"
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
										<img src="${path}/resources/upload/${img.imageName}"
											class="d-block" alt="..." width="100%" height="500px">
							</div>
							</c:forEach>
							</c:if>
						</div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
							<strong class="carousel-control-prev-icon" aria-hidden="true"></strong>
							<strong class="visually-hidden">Previous</strong>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
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
									<img src="${path}/resources/upload/${img.imageName}" alt="??????1"
										width="150px" height="150px">
								</button>
							</c:forEach>
						</c:if>


					</div>
				</div>
				<div class="col-1"></div>
				<div id="infoBox" class="col-5">
					<div class="row">
						<div class="col-12">
							<c:choose>
								<c:when test="${product.productCategory eq 'FS' }">
									<strong><c:out value="??????(${product.productCategory})" /></strong>
								</c:when>
								<c:when test="${product.productCategory eq 'LF' }">
									<strong><c:out value="?????????(${product.productCategory})" /></strong>
								</c:when>
								<c:when test="${product.productCategory eq 'TC' }">
									<strong><c:out value="??????(${product.productCategory})" /></strong>
								</c:when>
								<c:when test="${product.productCategory eq 'AT' }">
									<strong><c:out value="??????(${product.productCategory})" /></strong>
								</c:when>
								<c:otherwise>
									<strong>-</strong>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<strong><c:out value="${product.productName}" /></strong>
						</div>
					</div>
					<div class="row">
						<div class="col-6">
							<strong>????????????</strong>
						</div>
						<div class="col-6">
							<strong><c:out value="${product.productNo }" /></strong>
						</div>
					</div>
					<div class="row">
						<div class="col-6">
							<strong>???????????????</strong>
						</div>
						<div class="col-6">
							<c:if test="${product.highestBidder eq null }">
								<strong>-</strong>
							</c:if>
							<c:if test="${product.highestBidder ne null }">
								<strong><c:out value="${product.highestBidder }" /></strong>
							</c:if>

						</div>
					</div>

					<div class="row">
						<div class="col-12">
							<strong>?????????</strong>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<strong><c:out value="${ product.nowBidPrice}" /></strong><strong>???</strong>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<strong>?????????</strong><strong><c:out
									value="${product.minBidPrice }" /></strong><strong>???</strong>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<strong>??????????????????</strong>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<div style="padding-left: 10px;">
								<strong>00</strong>???&nbsp; <strong>00</strong>??????&nbsp; <strong>00</strong>???&nbsp;
								<strong>00</strong>???&nbsp;
							</div>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col-12">
							<strong>????????????</strong>
						</div>
					</div>
					<div id="bidButtons" class="row mb-3">
						<div class="col-3">
							<button type="button" class="w-100 btn btn-primary" value="1000">1000</button>
						</div>
						<div class="col-3">
							<button type="button" class="w-100 btn btn-primary" value="10000">10000</button>
						</div>
						<div class="col-3">
							<button type="button" class="w-100 btn btn-primary" value="100000">100000</button>
						</div>
						<div class="col-3">
							<button type="button" class="w-100 btn btn-primary" value="1000000">1000000</button>
						</div>
					</div>

					<div class="row">
						<div class="col-1"></div>
						<div class="col-6">
							<div style="border: 3px solid #41B979">
								<input id="bidUnitInput" type="number" value="${product.bidUnit }"><span>???</span>
							</div>
						</div>
						<div class="col-1"></div>
						<div class="col-4">
							<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#biddingModal">????????????</button>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<small>?????? ??????????????? <b><c:out value="${product.nowBidPrice+product.bidUnit }"/></b>??? ?????? , ???????????? ?????????????????? ????????? ??? ????????????.
							</small>
						</div>
					</div>
					<div class="row">
						<div class="col-12">
							<strong>buy now</strong>
						</div>
					</div>
					<div class="row">
						<div class="col-1"></div>
						<div class="col-6">
							<div style="border: 3px solid #41B979">
								<span style="font-size: 30px"><c:out
										value="${product.buyNowPrice }"></c:out></span>
							</div>
						</div>
						<div class="col-1"></div>
						<div class="col-4">
							<button type="button" class="btn btn-primary" onclick="checkBuyNow('${product.productNo}');">????????????</button>
							<button id="buyNowModalBtn" type="button" data-bs-toggle="modal" data-bs-target="#buyNowModal" style="display: none"></button>
							
						</div>
					</div>

					<div class="row">
						<div class="col-11">
							<strong>????????? ?????????</strong>
						</div>
						<div class="col-1">
							<a id="renewBtn" href=""> <i class="fas fa-sync-alt"></i></a>
						</div>
					</div>

					<div class="row">
						<div class="col-12" style="height: 200px; overflow: auto">
							<table class="table table-striped">
								<tr>
									<th>?????????</th>
									<th>?????? ??????</th>
								</tr>
								<tr>
									<td>?????????</td>
									<td><strong>999,999,999</strong>???</td>
								</tr>
								<tr>
									<td>?????????</td>
									<td><strong>999,999,999</strong>???</td>
								</tr>
								<tr>
									<td>?????????</td>
									<td><strong>999,999,999</strong>???</td>
								</tr>
								<tr>
									<td>?????????</td>
									<td><strong>999,999,999</strong>???</td>
								</tr>
							</table>
						</div>
					</div>


					<div class="row">
						<div class="col-12">
							<div
								style="width: 100%; height: 50px; border: 1px solid black; display: flex; justify-content: center; opacity: 0.3;">

								<i style="margin: 0;" class="far fa-bookmark fa-3x"></i> <strong
									style="height: 100%; margin: 0; padding-top: 10px; margin-left: 20px; font-size: 20px; font-weight: bold;">????????????</strong>


							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-12">
							<div class="accordion accordion-flush" id="accordionFlushExample">
								<div class="accordion-item">
									<h2 class="accordion-header" id="flush-headingOne">
										<button class="accordion-button collapsed" type="button"
											data-bs-toggle="collapse" data-bs-target="#flush-collapseOne"
											aria-expanded="false" aria-controls="flush-collapseOne">
											????????? ??????</button>
									</h2>
									<div id="flush-collapseOne" class="accordion-collapse collapse"
										aria-labelledby="flush-headingOne"
										data-bs-parent="#accordionFlushExample">
										<div class="accordion-body">
											<div class="row">
												<div class="col-1"></div>
												<div class="col-5">
													<strong>????????? ?????????</strong>
												</div>
												<div class="col-4">
													<span><c:out value="${product.seller}"/></span>
												</div>
												<div class="col-2"></div>
											</div>
											<div class="row">
												<div class="col-1"></div>
												<div class="col-5">
													<strong>????????? ??????</strong>
												</div>
												<div class="col-4"></div>
												<div class="col-2"></div>
											</div>
											<div class="row">
												<div class="col-1"></div>
												<div class="col-5">
													<strong>????????????</strong>
												</div>
												<div class="col-4"></div>
												<div class="col-2"></div>
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
						<h1>
							<strong>????????????</strong>
						</h1>
					</div>
					<div class="col-12">
						<p>
							<c:out value="${product.productContent }" />
						</p>
					</div>

				</div>
				<div class="row">
					<div class="col-12">
						<hr>
						<h1>
							<strong><strong>?????????</strong>??? ????????????</strong>
						</h1>
					</div>
					<div class="col-12 d-flex" style="overflow: hidden;">
						<div style="width: 210px;">
							<div>
								<img src="${path}/resources/images/exbag.png" width="200px"
									height="200px">
							</div>
							<div class="alignVertical">
								<div class="nameLine">
									<div>
										<strong>????????????</strong>
									</div>
									<div>
										<strong>?????????</strong>
									</div>
								</div>
								<div class="nameLine fontColorRed">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
								<div class="nameLine fontColorGreen">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
							</div>
						</div>
						<div style="width: 210px;">
							<div>
								<img src="${path}/resources/images/exbag.png" width="200px"
									height="200px">
							</div>
							<div class="alignVertical">
								<div class="nameLine">
									<div>
										<strong>????????????</strong>
									</div>
									<div>
										<strong>?????????</strong>
									</div>
								</div>
								<div class="nameLine fontColorRed">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
								<div class="nameLine fontColorGreen">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
							</div>
						</div>
						<div style="width: 210px;">
							<div>
								<img src="${path}/resources/images/exbag.png" width="200px"
									height="200px">
							</div>
							<div class="alignVertical">
								<div class="nameLine">
									<div>
										<strong>????????????</strong>
									</div>
									<div>
										<strong>?????????</strong>
									</div>
								</div>
								<div class="nameLine fontColorRed">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
								<div class="nameLine fontColorGreen">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
							</div>
						</div>
						<div style="width: 210px;">
							<div>
								<img src="${path}/resources/images/exbag.png" width="200px"
									height="200px">
							</div>
							<div class="alignVertical">
								<div class="nameLine">
									<div>
										<strong>????????????</strong>
									</div>
									<div>
										<strong>?????????</strong>
									</div>
								</div>
								<div class="nameLine fontColorRed">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
								<div class="nameLine fontColorGreen">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
							</div>
						</div>
						<div style="width: 210px;">
							<div>
								<img src="${path}/resources/images/exbag.png" width="200px"
									height="200px">
							</div>
							<div class="alignVertical">
								<div class="nameLine">
									<div>
										<strong>????????????</strong>
									</div>
									<div>
										<strong>?????????</strong>
									</div>
								</div>
								<div class="nameLine fontColorRed">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
								<div class="nameLine fontColorGreen">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
							</div>
						</div>
						<div style="width: 210px;">
							<div>
								<img src="${path}/resources/images/exbag.png" width="200px"
									height="200px">
							</div>
							<div class="alignVertical">
								<div class="nameLine">
									<div>
										<strong>????????????</strong>
									</div>
									<div>
										<strong>?????????</strong>
									</div>
								</div>
								<div class="nameLine fontColorRed">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
								<div class="nameLine fontColorGreen">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
							</div>
						</div>
						<div style="width: 210px;">
							<div>
								<img src="${path}/resources/images/exbag.png" width="200px"
									height="200px">
							</div>
							<div class="alignVertical">
								<div class="nameLine">
									<div>
										<strong>????????????</strong>
									</div>
									<div>
										<strong>?????????</strong>
									</div>
								</div>
								<div class="nameLine fontColorRed">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
								<div class="nameLine fontColorGreen">
									<strong>???????????????</strong> <strong>9999999<strong>???</strong></strong>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
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
				<div class="row">
					<span>????????????</span>
				</div>
				<div class="row">
					<div class="col-12" style="margin: 0 auto; text-align: center;">
						<img src="${path}/resources/upload/${product.images.get(0).imageName}" alt="..."
							width="250px">
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<span><c:out value="${product.productNo }"/></span>
					</div>
				</div>
				<div class="row">
					<div class="col-6">
						<span><c:out value="${product.productName }"/></span>
					</div>
					<div class="col-6">
						<span><c:out value="${product.buyNowPrice }"/></span>
					</div>
				</div>
				<div class="row">
					<div class="col-4"></div>
					<div class="col-8">

						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								name="inlineRadioOptions" id="inlineRadio1" value="option1">
							<label class="form-check-label" for="inlineRadio1">???????????????</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								name="inlineRadioOptions" id="inlineRadio2" value="option2">
							<label class="form-check-label" for="inlineRadio2">????????????</label>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-4">
						<span>????????????</span>
					</div>
					<div class="col-8">
						<input type="text" class="form-control w-100" readonly value="${loginMember.address }">
					</div>
				</div>
				<div class="row">
					<div class="col-4">
						<span>????????????</span>
					</div>
					<div class="col-8">
						<input type="text" class="form-control w-100">
					</div>
				</div>
				<div class="row">
					<div class="col-4"></div>
					<div class="col-8">

						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								name="inlineRadioOptions" id="inlineRadio1" value="option1">
							<label class="form-check-label" for="inlineRadio1">????????????</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								name="inlineRadioOptions" id="inlineRadio2" value="option2">
							<label class="form-check-label" for="inlineRadio2">????????????</label>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-4">
						<span>?????????</span>
					</div>
					<div class="col-8">
						<input type="text" class="form-control w-100" value="${loginMember.phone }">
					</div>
				</div>
				<div class="row">
					<div class="col-4">
						<span>????????????</span>
					</div>
					<div class="col-8">
						<input type="text" class="form-control w-100" value="${loginMember.memberName }">
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">??????</button>
				<button type="button" class="btn btn-primary">????????????</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="biddingModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">???????????????????????????????</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body container-fluid">???????????????...</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">????????????</button>
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
			<div class="modal-body container-fluid">???????????????...</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script src="${path }/resources/js/productDetail.js"></script>
<jsp:include
	page="${pageContext.request.contextPath}/WEB-INF/views/common/footer.jsp" />