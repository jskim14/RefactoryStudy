<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp" />
<section style="padding-bottom: 5%; width: 100%;">
	<div style="height: 140px;"></div>
	<div id="carouselExampleIndicators" class="carousel slide"
		data-bs-ride="carousel" style="margin-bottom: 5%;">
		<div class="carousel-indicators">
			<c:forEach items="${specialProductList }" var="sp" varStatus="sta">
				<c:if test="${sta.count == 1 }">
					<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="${sta.index }" class="active" aria-current="true"
					aria-label="Slide ${sta.count }"></button>
				</c:if>
				<c:if test="${sta.count != 1 }">
					<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="${sta.index }" aria-label="Slide ${sta.count }"></button>
				</c:if>
			</c:forEach>
		</div>
		<div class="carousel-inner">
			<c:forEach items="${specialProductList }" var="sp" varStatus="sta">
			<c:if test="${sta.count == 1 }">
				<div class="carousel-item active">
					<img src="${path}/resources/upload/product/${sp.bannerImageName}" class="d-block w-100 proImg"
						alt="..." width="100%" style="cursor: pointer;">
					<button style="display: none;" onclick="moveDetail(this.value);" value="${sp.productNo }"></button>
				</div>
			</c:if>
			<c:if test="${sta.count != 1 }">
				<div class="carousel-item">
					<img src="${path}/resources/upload/product/${sp.bannerImageName}" class="d-block w-100 proImg"
						alt="..." width="100%" style="cursor: pointer;">
					<button style="display: none;" onclick="moveDetail(this.value);" value="${sp.productNo }"></button>
				</div>
			</c:if>
			</c:forEach>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
	<div id="list-con">
		<h4><strong>DeadLine imminent</strong></h4>
		<h6 style="color:gray;">???????????? ??????</h6>
		<div>
			<c:if test="${not empty deadLine }">
			<ul style="overflow: hidden;">
				<c:forEach var="p" items="${deadLine }">
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
								<p>
									<strong style="font-size: 18px">${p.productName }</strong><br>
									<c:if test="${p.nowBidPrice != null }">
									???????????????&nbsp;<span class="price1"><fmt:formatNumber value="${p.nowBidPrice }"/></span>???<br>
									</c:if>
									<c:if test="${p.nowBidPrice == null }">
									???????????????&nbsp;<span class="price1"><fmt:formatNumber value="${p.minBidPrice }"/></span>???<br>
									</c:if>
									<fmt:parseNumber value="${p.nowBidPrice}" var="nowBidPrice"/>
									<fmt:parseNumber value="${p.buyNowPrice}" var="buyNowPrice"/>
									<c:choose>
										<c:when test="${nowBidPrice<buyNowPrice }" >
											???????????????&nbsp;<span class="price2"><fmt:formatNumber value="${p.buyNowPrice }"/></span>???<br>
										</c:when>
										<c:when test="${nowBidPrice>=buyNowPrice }">
											??????????????????<br>
										</c:when>
										<c:otherwise>
											??????????????????<br>
										</c:otherwise>
									</c:choose>
									?????????&nbsp;<strong>${p.seller.nickName }</strong>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
			<button id="deadLineBtn">?????????</button>
			</c:if>
			<c:if test="${empty deadLine }">
			<h3 style="text-align: center; padding: 20px 20px;">?????? ???????????? ????????? ????????????.</h3>
			</c:if>
		</div>
		<h4><strong>New In</strong></h4>
		<h6 style="color:gray;">?????? ?????? ??????</h6>
		<div>
			<c:if test="${not empty latest }">
			<ul style="overflow: hidden;">
				<c:forEach var="p" items="${latest }">
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
								<p>
									<strong style="font-size: 15px">${p.productName }</strong><br>
									<c:if test="${p.nowBidPrice != null }">
									???????????????&nbsp;<span class="price1"><fmt:formatNumber value="${p.nowBidPrice }"/></span>???<br>
									</c:if>
									<c:if test="${p.nowBidPrice == null }">
									???????????????&nbsp;<span class="price1"><fmt:formatNumber value="${p.minBidPrice }"/></span>???<br>
									</c:if>
									<fmt:parseNumber value="${p.nowBidPrice}" var="nowBidPrice"/>
									<fmt:parseNumber value="${p.buyNowPrice}" var="buyNowPrice"/>
									<c:choose>
										<c:when test="${nowBidPrice<buyNowPrice }" >
											???????????????&nbsp;<span class="price2"><fmt:formatNumber value="${p.buyNowPrice }"/></span>???<br>
										</c:when>
										<c:when test="${nowBidPrice>=buyNowPrice }">
											??????????????????<br>
										</c:when>
										<c:otherwise>
											??????????????????<br>
										</c:otherwise>
									</c:choose>
									?????????&nbsp;<strong>${p.seller.nickName }</strong>
							</div>
						</a>
					</li>
				</c:forEach>
			</ul>
			<button id="latestBtn">?????????</button>
			</c:if>
			<c:if test="${empty latest }">
			<h3 style="text-align: center; padding: 20px 20px;">?????? ?????? ????????? ????????? ????????????.</h3>
			</c:if>
		</div>
		<h4><strong>New Highest Bids</strong></h4>
		<h6 style="color:gray;">????????? ?????? ??????</h6>
		<div>
		<ul>
			<c:forEach var="p" items="${highPrice }">
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
								<p>
									<strong style="font-size: 15px">${p.productName }</strong><br>
									<c:if test="${p.nowBidPrice != null }">
									???????????????&nbsp;<span class="price1"><fmt:formatNumber value="${p.nowBidPrice }"/></span>???<br>
									</c:if>
									<c:if test="${p.nowBidPrice == null }">
									???????????????&nbsp;<span class="price1"><fmt:formatNumber value="${p.minBidPrice }"/></span>???<br>
									</c:if>
									<fmt:parseNumber value="${p.nowBidPrice}" var="nowBidPrice"/>
									<fmt:parseNumber value="${p.buyNowPrice}" var="buyNowPrice"/>
									<c:choose>
										<c:when test="${nowBidPrice<buyNowPrice }" >
											???????????????&nbsp;<span class="price2"><fmt:formatNumber value="${p.buyNowPrice }"/></span>???<br>
										</c:when>
										<c:when test="${nowBidPrice>=buyNowPrice }">
											?????????????????????<br>
										</c:when>
										<c:otherwise>
											??????????????????<br>
										</c:otherwise>
									</c:choose>
									?????????&nbsp;<strong><c:out value="${p.seller.nickName }"/></strong>
							</div>
						</a>
					</li>
				</c:forEach>
		</ul>
		<button id="highPirceBtn" style="margin-bottom: 30px;">?????????</button>
		</div>
	</div>
	<button id="wsBtn" onclick="websocket();" style="display: none;">??????</button>
	<div style="padding-left: 6.7%; background-color: #EAEBEF; margin-top:80px; margin-bottom:80px;">
		<div id="banner-con">
			<div style="margin-left:100px;">
				<a href="${path }/cs/noticeList"><img src="${path}/resources/images/banner1.png"
					alt="" width="200px" height="100%"></a>
			</div>
			<div>
				<a href="${path }/member/sellerrank"><img src="${path}/resources/images/banner2.png"
					alt="" width="200px" height="100%"></a>
			</div>
			<div>
				<a href="javascript: goInsert();"><img src="${path}/resources/images/banner3.png"
					alt="" width="200px" height="100%"></a>
			</div>
		</div>
	</div>
</section>
<script>
	function goInsert() {
		if(${loginMember == null}) {
			alert(' ???????????? ??????????????????. \n ??? ???????????? ????????? ??? ????????? ???????????????.');
			location.assign('${path}/member/login');
		} else {
			location.assign('${path}/product/insertProduct');
		}
	}

  	const websocket=()=> {
  		open("${path }/product/realtimeaction?productNo=LF100222147","_blank","width=1100, height=700, left=150");
  	}
  	let deadStartNum = 4;
  	let deadFinishNum = 7;
  	$("#deadLineBtn").click(e=> {
  		let div = $(e.target).parent();
  		if(div.children("ul").length>=2) {
  			deadStartNum = deadStartNum + 4;
  			deadFinishNum = deadFinishNum + 4;
  		}
  		$.ajax({
  			url : "${path}/addDeatLine",
  			dataType : "json",
  			data : {"startNum" : deadStartNum , "finishNum" : deadFinishNum},
  			success : data => {
  				if(data!=null) {
  					addList(data,$(e.target));
  				}else {
  					$(e.target).remove();
  				}
  				if(data.length<4) {
						$(e.target).remove();
				}
  			}
  		});
  	});
  	
  	let latestStartNum = 4;
  	let latestFinishNum = 7;
  	$("#latestBtn").click(e=> {
  		let div = $(e.target).parent();
  		if(div.children("ul").length>=2) {
  			latestStartNum = latestStartNum + 4;
  			latestFinishNum = latestFinishNum + 4;
  		}
  		$.ajax({
  			url : "${path}/addLatest",
  			dataType : "json",
  			data : {"startNum" : latestStartNum , "finishNum" : latestFinishNum},
  			success : data => {
  				if(data!=null) {
  					addList(data,$(e.target));
  				}else {
  					$(e.target).remove();
  				}
  				if(data.length<4) {
						$(e.target).remove();
				}
  			}
  		});
  	});
  	let highPirceStartNum = 4;
  	let highPirceFinishNum = 7;
  	$("#highPirceBtn").click(e=> {
  		let div = $(e.target).parent();
  		if(div.children("ul").length>=2) {
  			highPirceStartNum = highPirceStartNum + 4;
  			highPirceFinishNum = highPirceFinishNum + 4;
  		}
  		$.ajax({
  			url : "${path}/addHighPirce",
  			dataType : "json",
  			data : {"startNum" : highPirceStartNum , "finishNum" : highPirceFinishNum},
  			success : data => {
  				if(data!=null) {
  					addList(data,$(e.target));
  				}else {
  					$(e.target).remove();
  				}
  				if(data.length<4) {
						$(e.target).remove();
				}
  			}
  		});
  	});
  	function numberFormat (num) {
  		    if(num==0) return 0;
  		 
  		    var reg = /(^[+-]?\d+)(\d{3})/;
  		    var n = (num + '');
  		 
  		    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
  		 
  		    return n;
  	};
  	function addList(data,btn) {
  		let ul = $("<ul>");
			for(let i=0; i<data.length; i++) {
				let pro = data[i];
				let li = $("<li>");
				li.css("width","25%");
				let a = $("<a>");
				a.attr("href","${path}/product/productDetail?productNo=" + pro["productNo"]);
				let div = $("<div>");
				div.attr("class","goods-box");
				let img = $("<img>");
				let imgSrc;
				if(pro["images"].length!=0) {
					imgSrc = "${path }/resources/upload/product/" + pro["images"][0]["imageName"];
				}else {
					imgSrc = "${path}/resources/images/";
				}
				img.attr({"src":imgSrc,"width":"100%","height":"200","style":"margin-bottom: 12px border-radius: 20px;"});
				let p = $("<p>");
				let strong = $("<strong>");
				strong.append(pro["productName"]);
				p.append(strong);
				p.append("<br>");
				let span = $("<span>");
				span.attr("class","price1");
				if(pro["nowBidPrice"]!=null) {
					span.append(numberFormat(pro["nowBidPrice"]));
					p.append("??????????????? &nbsp;");
					p.append(span);
					p.append("<br>");
				}else {
					span.append(numberFormat(pro["minBidPrice"]));
					p.append("??????????????? &nbsp;");
					p.append(span);
					p.append("<br>");
				}
				let span2 = $("<span>");
				span2.attr("class","price2");
				if(pro["buyNowPrice"]!=null) {
					if(Number(pro["buyNowPrice"])<Number(pro["nowBidPrice"])) {
						p.append("??????????????????");
						p.append("<br>");
					}else {
						span2.append(numberFormat(pro["buyNowPrice"]));
						p.append("??????????????? &nbsp;");
						p.append(span2);
						p.append("<br>");
					}
				}else {
					p.append("??????????????????");
					p.append("<br>");
				}
				p.append("????????? &nbsp;")
				let strong2 = $("<strong>");
				strong2.append(pro["seller"]["nickName"]);
				p.append(strong2);
				div.append(img);
				div.append(p);
				a.append(div);
				li.append(a);
				ul.append(li);
			}
			liList(ul);
			$(btn).prev().after(ul);
  	}
  	function liList(ul) {
  		let num = ul.children().length;
  		for(let i=1; i<=(4-num); i++) {
  			let li = $("<li>");
  			li.css({"border":"none","box-shadow":"none"});
  			ul.append(li);
  		} 
  	}
  	$(".proImg").click(e=> {
  		$(e.target).next().click();
  	});
  	
  	const moveDetail =(proNo)=> {
  		location.assign("${path}/product/productDetail?productNo=" + proNo);
  	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />