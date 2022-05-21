<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="${path}/WEB-INF/views/common/header.jsp"/>
        <section style="padding-bottom: 5%;">
            <div style="height: 140px;"></div>
            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" style="margin-bottom: 5%;">
                <div class="carousel-indicators">
                  <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                  <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                  <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                  <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
                </div>
                <div class="carousel-inner">
                  <div class="carousel-item active">
                    <img src="${path}/resources/images/111.png" class="d-block w-100" alt="..." height="400px" width="100%">
                  </div>
                  <div class="carousel-item">
                    <img src="${path}/resources/images/222.png" class="d-block w-100" alt="..." height="400px" width="100%">
                  </div>
                  <div class="carousel-item">
                    <img src="${path}/resources/images/333.png" class="d-block w-100" alt="..." height="400px" width="100%">
                  </div>
                  <div class="carousel-item">
                    <img src="${path}/resources/images/444.png" class="d-block w-100" alt="..." height="400px" width="100%">
                  </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Next</span>
                </button>
              </div>
              <div id="list-con">
                  <h4>DeadLine imminent</h4>
                  <h6>마감임박상품</h6>
                  <ul>
                      <li>
                        <a href="${path }/product/productDetail?productNo=FS2401221">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                      <li>
                        <a href="">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                      <li>
                        <a href="">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                      <li>
                        <a href="">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                  </ul>
                  <h4>DeadLine imminent</h4>
                  <h6>마감임박상품</h6>
                  <ul>
                      <li>
                        <a href="">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                      <li>
                        <a href="">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                      <li>
                        <a href="">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                      <li>
                        <a href="">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                  </ul>
                  <h4>DeadLine imminent</h4>
                  <h6>마감임박상품</h6>
                  <ul>
                      <li>
                        <a href="">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                      <li>
                        <a href="">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                      <li>
                        <a href="">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                      <li>
                        <a href="">
                            <div class="goods-box">
                                <img src="https://image.msscdn.net/images/goods_img/20190723/1100781/1100781_1_500.jpg" width="250" height="200" style="margin-bottom:12px;">
                                <p><strong style="font-size:20px;">레고하우스 심슨</strong><br>
                                    현재입찰가&nbsp <span class="price1">280,000</span> 원<br>
                                    즉시구매가&nbsp <span class="price2">420,000</span> 원<br>
                                    판매자&nbsp <strong>sunny724</strong></p>   
                            </div>
                        </a>
                      </li>
                  </ul>
              </div>
              <button onclick="websocket();">버튼</button>
              <div style="padding-left: 6.7%; background-color: #FFD481;">
                <div id="banner-con">
                    <div><a href=""><img src="${path}/resources/images/banner1.png" alt="" width="230px" height="100%"></a></div>
                    <div><a href=""><img src="${path}/resources/images/banner2.png" alt="" width="230px" height="100%"></a></div>
                    <div><a href=""><img src="${path}/resources/images/banner3.png" alt="" width="230px" height="100%"></a></div>
                </div>
            </div>
        </section>
        <script>
        	const websocket=()=> {
        		open("${path }/product/realtimeaction","_blank","width=1100, height=700, left=150");
        	}
        </script>
<jsp:include page="${path}/WEB-INF/views/common/footer.jsp"/>
