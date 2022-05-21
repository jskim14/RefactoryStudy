<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
#stateCount {
	margin: 0;
	text-align: center;
	border: 1px solid rgba(0, 0, 0, .125);
	border-radius: 0.25rem;
	padding: 3% 0 3% 0;
}

#searchBox {
	height: 70px;
	background-color: #fafafa;
	margin: 0;
	text-align: center;
	padding: 1% 0 1% 10%;
}

#stateContainer>div {
	padding-top: 3%;
}

#centerRow>div {
	padding-bottom: 5px;
}

#middleDiv>div {
	padding-bottom: 5px;
}
</style>
<section>
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel"
						style="color: black;">신고내용</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" style="color: black;">
					<div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">신고
							상품명</label> <input type="text" class="form-control" id="productName"
							value="" readonly>
					</div>
					<div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">신고사유</label>
						<input type="text" class="form-control" id="reportReason" value=""
							readonly>
					</div>
					<div class="mb-3" id="reportImage">
						<label for="exampleFormControlTextarea1" class="form-label">첨부
							이미지</label><br>
					</div>
					<div class="mb-3">
						<label for="exampleFormControlInput1" class="form-label">처리
							결과</label> <input type="text" class="form-control" readonly="readonly"
							id="exampleFormControlTextarea1" name="reportResult">
					</div>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<div class="row" style="padding: 15%">
		<div id="stateContainer" class="row">
			<a href="${path }/member/buyStates?memberNo=${loginMember.memberNo}"
				class="aColor">
				<div class="pageTitle row">
					<span><i class="fas fa-shopping-bag"></i>&nbsp;구매현황</span>
				</div>
			</a>
			<div id="stateCount" class="row">
				<div class="subMenuTitle col">
					<div>
						전체<br>
						<c:out value="${buyCnt.get(0)}" />
						건
					</div>
				</div>
				<div class="subMenuTitle col">
					<div>
						입찰중<br>
						<c:out value="${buyCnt.get(1)}" />
						건
					</div>
				</div>
				<div class="subMenuTitle col">
					<div>
						구매대기<br>
						<c:out value="${buyCnt.get(2)}" />
						건
					</div>
				</div>
				<div class="subMenuTitle col">
					<div>
						종료<br>
						<c:out value="${buyCnt.get(3)}" />
						건
					</div>
				</div>
			</div>
			<div class="row" style="">
				<form
					action="${path }/member/buySearch?memberNo=${loginMember.memberNo}"
					method="post">
					<div id="searchBox" class="row" style="">
						<!-- 검색 -->
						<div class="col-3">
							<select class="form-select" name="status"
								aria-label="Default select example"
								style="width: 200px; color: gray; float: right" required>
								<option selected>----- 전체 -----</option>
								<option value="입찰중">입찰중</option>
								<!-- 승인 0,2 -->
								<option value="구매대기">구매대기</option>
								<!-- 승인1&&상태0 -->
								<option value="종료">종료</option>
							</select>
						</div>
						<div class="col-7">
							경매기간 &nbsp;<input type="date" id="startDate" class="form-control"
								name="startDate" style="width: 180px; display: inline;">&nbsp;
							~ &nbsp;<input type="date" id="endDate" class="form-control"
								name="endDate" style="width: 180px; display: inline;">&nbsp;
						</div>
						<div class="col-2">
							<button type="submit" class="btn btn-secondary btnColor"
								style="float: left;">조회하기</button>
						</div>
					</div>
				</form>
			</div>
			<!-- ---------------------------------------- -->
			<!-- 
           		         
           -->
			<!--   ${productList[0].productNo.productStatus } 이 형태다 -->
			<c:if test="${empty productList}">
				<div style="text-align: center">
					<hr>
					구매한 물품이 없습니다. 새로운 물품을 구매해보세요.
				</div>
			</c:if>
			<c:if test="${not empty productList }">
				<!-- 상품내용 한줄 -->
				<c:forEach var="p" items="${productList}" varStatus="st">
					<c:if test="${p.categoryDetail ne '0' }">
						<div class="row" style="margin: 0; text-align: center;">
							<hr>
							<a
								href="${path }/product/productDetail?productNo=${p.productNo.productNo}"
								class="col-2"> <!-- 사진 --> <!-- images 의 첫번째.... --> <c:if
									test="${not empty p.productNo.images }">
									<img
										src="${path }/resources/upload/product/${p.productNo.images.get(0).imageName }"
										alt="" style="width: 150px; height: 130px;">
								</c:if> <c:if test="${empty p.productNo.images}">
									<img src="" alt="확인중" style="width: 150px; height: 130px;">
								</c:if>
							</a>
							<div class="col-6">
								<!-- 중간 -->
								<div id="centerRow" class="row">
									<!-- 
						    		입찰중[디테일4(입찰시)] && 상태 0(판매중) 
						    		구매대기[디테일4(입찰시)], && 상태 1(입완)
						    		구매대기[디테일4(입찰시)], && 상태 2(발완) => 구매확정, 신고버튼
						    		종료 [디테일4(입찰시)] && 상태 4(구매확정),5(신고)
						    		종료 [디테일4(입찰시)] && 같지않고 
						    		-->
									<a
										href="${path }/product/productDetail?productNo=${p.productNo.productNo}"
										class="row aColor" id="middleDiv">
										<div>
											<c:choose>
												<c:when test="${p.productNo.productStatus eq '0' }">
													<strong><span
														style="font-size: 18px; float: left; color: #ef6253;">입찰중</span></strong>
												</c:when>
												<c:when
													test="${(p.productNo.productStatus eq '1' or p.productNo.productStatus eq '2') 
						        	and p.productNo.finalPrice eq p.amount }">
													<strong><span
														style="font-size: 18px; float: left; color: #ef6253;">구매대기</span></strong>
												</c:when>
												<c:when
													test="${(p.productNo.productStatus eq '3' or p.productNo.productStatus eq '4' or p.productNo.productStatus eq '5') 
						        	and p.productNo.finalPrice eq p.amount}">
													<!-- 내가입찰 -->
													<strong><span
														style="font-size: 18px; float: left; color: #ef6253;">종료</span></strong>
												</c:when>
												<c:when
													test="${p.productNo.productStatus ne '0' and p.productNo.finalPrice ne p.amount }">
													<!-- 실패 -->
													<strong><span
														style="font-size: 18px; float: left; color: #ef6253;">종료</span></strong>
												</c:when>
											</c:choose>
										</div>
										<div>
											<span style="float: left; font-size: 12px;"> <c:out
													value="${p.productNo.productNo }" />
											</span>
										</div>
										<div>
											<span
												style="font-size: 21px; color: #333; float: left; font-weight: 550;">
												<c:out value="${p.productNo.productName }" />
											</span>
										</div>
									</a>
									<!-- 
						        배송대기[디테일4(입찰시)], && 상태 1(입완) / 발송전
						        구매대기 버튼 두개 [디테일4(입찰시)], && 상태 2(발완) => 구매확정, 신고버튼 /발송버튼 눌렀을때
						         -->
									<div>
										<c:choose>
											<c:when
												test="${p.productNo.productStatus eq '1' and p.productNo.finalPrice eq p.amount }">
												<span style="font-size: 18px; float: left; color: gray;">배송대기</span>
											</c:when>
											<c:when
												test="${(p.productNo.productStatus eq '2' or p.productNo.productStatus eq '3') and p.productNo.finalPrice eq p.amount }">
												<button type="button" class="btn btn-secondary btnColor"
													style="float: left; margin-right: 1%;"
													data-bs-toggle="modal" data-bs-target="#buyEnd${st.count }">
													구매확정</button>
												<!-- Modal -->
												<div class="modal fade" id="buyEnd${st.count }"
													data-bs-backdrop="static" data-bs-keyboard="false"
													tabindex="-1" aria-labelledby="staticBackdropLabel"
													aria-hidden="true">
													<div class="modal-dialog">
														<div class="modal-content">
															<div class="modal-header">
																<!-- <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5> -->
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal" aria-label="Close"></button>
															</div>
															<div class="modal-body">
																물품에 이상이 없는지 확인을 마치셨습니까? <br> 구매확정 후에는 거래가 완전종료 됩니다.
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-secondary"
																	data-bs-dismiss="modal">취소</button>
																<button type="submit" class="btn btn-primary btnColor"
																	id="modaltest"
																	onclick="location.assign('${path}/product/buyEnd?productNo=${p.productNo.productNo }')">구매확정</button>
															</div>
														</div>
													</div>
												</div>
												<button type="button" class="btn btn-secondary btnP"
													data-bs-toggle="modal"
													data-bs-target="#staticBackdrop${st.count }"
													style="float: left;">신고(환불신청)</button>
												<!-- 모달창 -->
												<div class="modal fade" id="staticBackdrop${st.count }"
													data-bs-backdrop="static" data-bs-keyboard="false"
													tabindex="-1" aria-labelledby="staticBackdropLabel"
													aria-hidden="true">
													<div class="modal-dialog modal-dialog-centered">
														<div class="modal-content">
															<form name="reportForm"
																action="${path }/report/insertReport" method="POST"
																enctype="multipart/form-data">
																<div class="modal-header">
																	<h5 class="modal-title" id="staticBackdropLabel"
																		style="color: black;">상품 신고/반품</h5>
																	<button type="button" class="btn-close"
																		data-bs-dismiss="modal" aria-label="Close"></button>
																</div>

																<div class="modal-body" style="color: black;">
																	<div class="mb-3">
																		<label for="exampleFormControlInput1"
																			class="form-label">상품 번호</label> <input type="text"
																			class="form-control" name="product" readonly
																			id="exampleFormControlInput1"
																			value="${p.productNo.productNo }">
																	</div>
																	<div class="mb-3">
																		<label for="exampleFormControlInput1"
																			class="form-label">상품 명</label> <input type="text"
																			class="form-control" readonly
																			id="exampleFormControlInput1"
																			value="${p.productNo.productName}">
																	</div>
																	<div class="mb-3">
																		<input type="hidden" class="form-control"
																			name="writer" readonly id="exampleFormControlInput1"
																			value="${loginMember.memberNo }">
																	</div>
																	<div class="mb-3">
																		<label for="exampleFormControlTextarea1"
																			class="form-label">신고/반품 사유</label>
																		<textarea class="form-control"
																			id="exampleFormControlTextarea1" name="reportReason"
																			rows="3" autofocus required></textarea>
																	</div>
																	<!-- 첨부파일 여러장 선택 -->
																	<div class="mb-3">
																		<label for="formFileMultiple" class="form-label">첨부파일
																			*최대 3장</label> <input name="upFile" id="upFile"
																			class="form-control" type="file"
																			id="formFileMultiple" multiple required>
																	</div>
																</div>

																<div class="modal-footer">
																	<button type="button" class="btn btn-secondary"
																		data-bs-dismiss="modal">닫기</button>
																	<button type="submit" id="report-btn"
																		class="btn btn-warning">등록</button>
																</div>
															</form>
														</div>
													</div>
												</div>
												<!--  -->
											</c:when>
											<c:when
												test="${p.productNo.productStatus eq '5' and p.productNo.finalPrice eq p.amount}">
												<button type="button" class="btn btn-secondary btnP rtBtn"
													value="${p.productNo.productNo}"
													style="float: left; margin-right: 1%;">신고내역확인</button>
												<button type="button" style="display: none;"
													id="openReporyBtn" data-bs-toggle="modal"
													data-bs-target="#staticBackdrop"></button>
												<!-- 여기 창  -->

												<!-- 여기 창 -->
											</c:when>
											<c:when
												test="${(p.productNo.productStatus eq '3' or p.productNo.productStatus eq '4') 
						        	and p.productNo.finalPrice eq p.amount}">
												<span style="font-size: 18px; float: left; color: gray;">입찰완료</span>
											</c:when>
										</c:choose>
									</div>
								</div>
							</div>
							<a
								href="${path }/product/productDetail?productNo=${p.productNo.productNo}"
								class="col-4 aColor"> <!-- 오른쪽 -->
								<div class="row" style="padding-top: 13%">
									<!--  -->
									<!-- 
							분기 7개 
							 -->
									<c:choose>
										<c:when test="${p.productNo.productStatus eq '0' }">
											<!-- 입찰중 -->
											<div class="col">
												<span style="font-size: 14px;">나의입찰액</span><br>
												<fmt:formatNumber value="${p.amount }" pattern="#,###" />
												원
											</div>
											<div class="col">
												<span style="font-size: 14px;">현재입찰가</span><br>
												<fmt:formatNumber value="${p.productNo.nowBidPrice }"
													pattern="#,###" />
												원
											</div>
											<div class="col">
												<span style="font-size: 14px;">마감일</span><br>
												<c:out value="${p.productNo.endDate }" />
											</div>
										</c:when>
										<c:when
											test="${(p.productNo.productStatus eq '1' or p.productNo.productStatus eq '2' or p.productNo.productStatus eq '3') 
						        and p.productNo.finalPrice eq p.amount }">
											<!-- 구매대기(입완) -->
											<div class="col">
												<span style="font-size: 14px;">최종구매가격</span><br>
												<fmt:formatNumber value="${p.productNo.finalPrice }"
													pattern="#,###" />
												원
											</div>
											<div class="col">
												<span style="font-size: 14px;">판매자</span><br>
												<c:out value="${p.productNo.seller.nickName }" />
											</div>
											<div class="col">
												<span style="font-size: 14px;">구매일</span><br>
												<c:out value="${p.tradeDate }" />
											</div>
										</c:when>
										<c:when
											test="${(p.productNo.productStatus eq '3' or p.productNo.productStatus eq '4' or p.productNo.productStatus eq '5') 
						        	and p.productNo.finalPrice eq p.amount }">
											<!-- 내가입찰 -->
											<div class="col">
												거래가 종료되었습니다. <br> 자세한 사항은 1:1 문의사항을 이용하여 주세요.
											</div>
											<!-- <div class="row">
								        <a href="#" class="aColor" style="color: gray;">문의사항 바로가기</a>
								    </div> -->
										</c:when>
										<c:when
											test="${p.productNo.productStatus ne '0' and p.productNo.finalPrice ne p.amount }">
											<div class="col">낙찰에 실패하였습니다.</div>
										</c:when>
									</c:choose>
								</div>
							</a>
						</div>
					</c:if>
				</c:forEach>
			</c:if>
		</div>
	</div>
	<script>
	$(()=>{
	    var date = new Date();
	    date.setMonth(date.getMonth() - 3);
	    $("#startDate").val(date.toISOString().substring(0, 10));
	    var date = new Date();
	    date.setMonth(date.getMonth() + 3);
	    $("#endDate").val(date.toISOString().substring(0, 10));
	});

	$(()=>{
		$("[name=reportImages]").change(e=>{
			const fileName=$(e.target).prop('files')[0].name;	
			$(e.target).next(".custom-file-label").html(fileName);
		})
	})
	/* 신고이미지 갯수 제한 3장*/	
		$('#upFile').on("change", function() {
			if($('#upFile')[0].files.length>3){
				alert("파일은 최대 3장까지 등록 가능합니다.");
				$('#upFile').val('');
			}
		});
    $(".rtBtn").click(e=> {
    	$.ajax({
    		url : "${path}/report/reportCon",
    		type : "post",
    		data : {"productNo":$(e.target).val()},
    		dataType : "json",
    		success : data => {
    			console.log(data);
    			$("#staticBackdrop input#productName").val(data["reportProduct"]["productName"]);
    			$("#staticBackdrop input#reportReason").val(data["reportReason"]);
    			$("#staticBackdrop div#reportImage").html("");
    			let label = $("<label>");
    			label.attr({"for":"exampleFormControlTextarea1","class":"form-label"});
    			label.text("첨부이미지");
    			$("#staticBackdrop div#reportImage").html(label);
    			$("#staticBackdrop div#reportImage").append("<br>");
    			for(let i=0; i<data["reportImages"].length; i++) {
    				let reportImg = data["reportImages"][i];
    				let imgSrc = "${path}/resources/upload/report/" + reportImg["fileName"];
    				let img = $("<img>");
    				img.attr({"src":imgSrc,"width":"135","height":"135"});
    				img.css({"margin-left":"15"});
	    			$("#staticBackdrop div#reportImage").append(img);
    			}
    			$("#staticBackdrop input#exampleFormControlTextarea").val(data["reportResult"]);
    			$(e.target).next().click();
    		}
    	});
    });
    </script>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />