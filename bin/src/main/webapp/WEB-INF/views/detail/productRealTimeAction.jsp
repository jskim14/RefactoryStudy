<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		height: 630px;
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
<body>
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
						<i class="fas fa-eye fa-lg"></i><span>155</span>
					</div>
					<p>경매 남은 시간 : <span>00</span>분 <span>00</span>초</p>
				</div>
				<h3>Apple MacBook Pro 16 Inch Intel Core i7 16GB</h3>
				<div id="img-con">
					<div id="img-con-first">
						<img src="https://images.stockx.com/images/Apple-MacBook-Pro-16-Inch-Intel-Core-i7-16GB-RAM-512GB-SSD-AMD-Radeon-Pro-5300M-Mac-OS-MVVJ2LL-A-Space-Gray.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1634321432" width="400px" height="300px">
					</div>
					<div id="img-list-con" style="width:400px;">
						<div style="border:2px solid black; box-sizing: border-box;">
							<img src="https://images.stockx.com/images/Apple-MacBook-Pro-16-Inch-Intel-Core-i7-16GB-RAM-512GB-SSD-AMD-Radeon-Pro-5300M-Mac-OS-MVVJ2LL-A-Space-Gray.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&dpr=2&trim=color&updated_at=1634321432" width="70x" height="70x">
						</div>
						<div>
							<img src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/mbp16-silver-select-202110_GEO_KR?wid=1808&hei=1686&fmt=jpeg&qlt=80&.v=1633657514000" width="70x" height="70x">
						</div>
						<div>
							<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6Hz-Zf4wAPRHuPk4EH2rhUvYpWk0dneJgAA&usqp=CAU" width="70x" height="70x">
						</div>
						<div>
							<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-l95EhXBxIo20EP2lw_bj_kEbjxvTTsZc4w&usqp=CAU" width="70x" height="70x">
						</div>
					</div>
				</div>
				<div id="price">
					<p>현재입찰가 : <span id="nowPrice">50,000</span></p>
				</div>
				<div>
					나의 잔액 : <span style="font-weight: bold;"><fmt:formatNumber type="currency" value="${loginMember.balance }"/>원</span>
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
				<div style="background-color: white; color: red;"><h5>SYSTEM : 경매시간 00분35초 남았습니다.</h5></div>
				<div style="background-color: white;"><h5>daeyeol님이 110,000원에 응찰!</h5></div>
				<div style="background-color: white;"><h5>dabin님이 150,000원에 응찰!</h5></div>
				<div style="background-color: white; color: red;"><h5>SYSTEM : 경매시간 00분05초 남았습니다.</h5></div>
				<div style="background-color: white; color: red;"><h5>SYSTEM : 경매가 종료됩니다.</h5></div>
				<div style="background-color: #41B979; color:white;"><h5>dabin님에게 150,000원에 최종 낙찰되었습니다.</h5></div>
				
				
				<div style="background-color: white; color: red;"><h5>SYSTEM : 경매시간 00분35초 남았습니다.</h5></div>
				<div style="background-color: white;"><h5>daeyeol님이 110,000원에 응찰!</h5></div>
				<div style="background-color: white;"><h5>dabin님이 150,000원에 응찰!</h5></div>
				<div style="background-color: white; color: red;"><h5>SYSTEM : 경매시간 00분05초 남았습니다.</h5></div>
				<div style="background-color: white; color: red;"><h5>SYSTEM : 경매가 종료됩니다.</h5></div>
				<div style="background-color: #41B979; color:white;"><h5>dabin님에게 150,000원에 최종 낙찰되었습니다.</h5></div>
				<div style="background-color: white; color: red;"><h5>SYSTEM : 경매시간 00분35초 남았습니다.</h5></div>
				<div style="background-color: white;"><h5>daeyeol님이 110,000원에 응찰!</h5></div>
				<div style="background-color: white;"><h5>dabin님이 150,000원에 응찰!</h5></div>
				<div style="background-color: white; color: red;"><h5>SYSTEM : 경매시간 00분05초 남았습니다.</h5></div>
				<div style="background-color: white; color: red;"><h5>SYSTEM : 경매가 종료됩니다.</h5></div>
				<div style="background-color: #41B979; color:white;"><h5>dabin님에게 150,000원에 최종 낙찰되었습니다.</h5></div>
			</div>
		</div>
	</div>
	<script>
		const socket = new WebSocket("ws://localhost:9090/ws/chat");
		$("#sendBtn").click(e=> {
			/* let price = $("#msg").val();
			let nowPrite = $("#nowPrice").text();
			price = Number(price);
			nowPrite = Number(nowPrite);
			console.log(price + " : " + typeof(price) + nowPrite + " " + typeof(nowPrite));
			console.log(price>nowPrite);
			if(price>nowPrite) {
				send();				
			}else {
				alert("현재입찰가보다 낮은가격입니다. 다시 입력해주세요.");
			} */
			let price = $("#inputPrice").val();
			send(price);
		});
		function send(price) {
			socket.send(JSON.stringify({"nickName":"${loginMember.nickName}","price":price}));
		}
		socket.onmessage = message=> {
			console.log(message);
			$("#chat").append($("<h5>").html(message.data));
 			$("#chat").append($("<h5>").html(message.data["nickName"] + "님이 " + message.data["price"] + "원으로 입찰!"));
		}
		$("#img-list-con>div>img").click(e=> {
			let imgSrc = $(e.target).attr("src");
			$("#img-list-con>div").css({"border":"2px solid white","box-sizing":"border-box"});
			$(e.target).parent().css({"border":"2px solid black","box-sizing":"border-box"});
			$("#img-con-first").find("img").attr("src",imgSrc);
		});
	</script>
</body>
</html>