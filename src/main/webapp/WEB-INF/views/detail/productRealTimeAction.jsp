<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NBIF 실시간 경매</title>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
</head>
<style>
	* {
		margin:0 auto;
		padding: 0;
		text-align: center;
	}
	img {
		object-fit: cover;
	}
	#container {
		width: 100%;
	}
	header {
		background: black;
		height: 60px;
		width: 100%;
		color: white;
		text-align: center;
		vertical-align: middle;
		display:flex;
	}
	header>h2>span {
		position: relative;
		top: 10px;
	}
	header>h2 {
		margin-top: 10px;
	}
	#section-con {
		display: flex;
	}
	#section-left {
		width: 60%;
		display: block;
	}
	#section-right {
		width: 40%;
		background-color: #FFF496;
		height: 639px;
		overflow-y:scroll;
		padding-top: 10px;
	}
	#first-con{
		display: flex;
		font-weight: bold;
		padding-top: 20px;
		padding-bottom: 20px;
	}
	#first-con>div>i {
		margin-right: 10px;
	}
	#first-con>p>span {
		color : #2E5BFA;
	}
	#img-list-con {
		display: flex;
		text-align: center;
	}
	#img-list-con>div,#img-list-con>div>img {
		cursor: pointer;
	}
	#img-list-con>div>img {
		margin: 3px 10px 3px 10px;
	}
	#img-list-con>div {
		border:2px solid white;
		box-sizing: border-box;
	}
	#img-con {
		padding-bottom: 20px;
		padding-top: 20px;
	}
	#price {
		background-color: red;
	/* 	#41B979; */
		width: 250px;
		height: 30px;
		color: white;
		font-weight: bold;
		border-radius: 5px;
		font-size: 20px;
		margin-bottom: 15px;
	}
	#price>p {
		padding-top: 1px;
	}
	#inputPrice {
		border:none;
		width:120px;
		height: 23px;
		font-weight: bolder;
	}
	input#inputPrice:focus {
		outline: none;
	}
	#sendBtn {
		width: 50px;
		height: 30px;
		border-radius: 10px;
		background-color: #41B979;
		color: white;
		border: none;
		font-weight: bold;
		cursor: pointer;
	}
	#section-right>div {
		width: 400px;
		height: 30px;
		border-radius: 10px;
		margin-bottom: 10px;
	}
	#section-right>div>h5 {
		text-align: left;
		margin-left: 10px;
		padding-top: 5px;
	}
	#section-right::-webkit-scrollbar {
		width:16px;
	}
	#section-right::-webkit-scrollbar-thumb{
	    height: 10%;
	    background-color: #C4C4C4;
	    border-radius: 10px;    
	}
	#section-right::-webkit-scrollbar-track{
	    background-color: rgba(0,0,0,0);
	}
</style>
<body oncontextmenu="return false">
	<div id="container">
		<header>
		<h2>
		<span><img src="${pageContext.request.contextPath}/resources/images/live-streaming.png" width="30px" height="30px"></span>
Special Action</h2>
		</header>
		<div id="section-con">
			<div id="section-left">
				<div id="first-con">
					<div>
						<i class="fas fa-eye fa-lg"></i><span id="userCount">155</span>
					</div>
					<p>경매 남은 시간 : <span id="timeMin"></span>분 <span id="timeSec"></span>초</p>
				</div>
				<h3><c:out value="${productOne.productName }" /></h3>
				<div id="img-con">
					<div id="img-con-first">
						<img src="${path }/resources/upload/product/${ productOne.images.get(0).imageName}" width="400px" height="300px">
					</div>
					<div id="img-list-con" style="width:400px;">
						<c:forEach var="p" items="${productOne.images }" varStatus="status">
						<c:if test="${status.count == 1 }">
							<div style="border:2px solid black; box-sizing: border-box;">
								<img src="${path }/resources/upload/product/${p.imageName }" width="70x" height="70x">
							</div>
						</c:if>
						<c:if test="${status.count != 1 }">
							<div>
								<img src="${path }/resources/upload/product/${p.imageName }" width="70x" height="70x">
							</div>
						</c:if>
						</c:forEach>
					</div>
				</div>
				<div id="price">
					<p>현재입찰가 : <span id="nowPrice"><fmt:formatNumber value='${productOne.minBidPrice }'/></span></p>
				</div>
				<div>
					나의 잔액 : <span id="balance" style="font-weight: bold;"><fmt:formatNumber value="${loginMember.balance }"/>원</span>
				</div>
				<div style="padding-top:10px; display:flex;">
					<div style="border:3px solid #C4C4C4; border-radius:20px; width:150px; margin-right:20px;">
						<input type="text" id="inputPrice" name="inputPrice">
					</div>
					<div style="margin-left:0;">
						<button id="sendBtn">입력</button>
					</div>
				</div>
			</div>
			<div id="section-right">
			</div>
		</div>
	</div>
<script>
function send(price) {
	socket.send(JSON.stringify({ "nickName": "${loginMember.nickName}", "price": price }));
}

function endProductAction (nickName,price) {
	$.ajax({
		url : "${path}/product/endProductAction",
		data : {"nickName":nickName,"price":price,"productNo":"${productOne.productNo}"},
		success : data => {
			$("#inputPrice").attr("readonly","readonly");
			$("#sendBtn").off("click");
			alert(data + "5초후 창이 꺼집니다.");
			setTimeout(()=> {
				opener.send(nickName);
				window.close();
	        },5000);
		}
	});
}
function noEvent() {
    if (event.keyCode == 116) {
        event.keyCode= 2;
        return false;
    }
    else if(event.ctrlKey && (event.keyCode==78 || event.keyCode == 82))
    {
        return false;
    }
}
document.onkeydown = noEvent;

const url = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}";
</script>
<script src="${path }/resources/js/realtimeaction.js"></script>
</body>
</html>