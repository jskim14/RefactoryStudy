const socket = new WebSocket(url + "/ws/chat");
let min;
let sec;
socket.onmessage = message => {
	console.log(message.data);
	if (message.data.indexOf("min") != -1) {
		let time = JSON.parse(message.data);
		min = time["min"];
		sec = time["sec"];
	} else if (message.data.indexOf("nickName") != -1) {
		let mem = JSON.parse(message.data);
		console.log(mem);
		if (typeof mem == 'object') {
			$("#section-right").html('');
			for (let i = 0; i < mem.length; i++) {
				let chat = mem[i];
				if (chat["nickName"] != null) {
					let userDiv = $("<div>");
					userDiv.css("background-color", "white");
					userDiv.attr("class", "user");
					let h5 = $("<h5>");
					let span = $("<span>");
					span.attr({ "class": "nickName" });
					span.html(chat["nickName"]);
					let span2 = $("<span>");
					span2.attr({ "class": "price" });
					span2.html(numberFormat(chat["price"]))
					h5.append(span);
					h5.append("님이 ");
					h5.append(span2);
					h5.append("원에 응찰!");
					userDiv.append(h5);
					$("#section-right").append(userDiv);
					$("#nowPrice").html(numberFormat(chat["price"]));
				}
			}
		}
	} else if (typeof JSON.parse(message.data) == "number") {
		$("#userCount").html(message.data);
	}
}
$("#sendBtn").click(e => {
	let price = $("#inputPrice").val();
	let nowPrice = $("#nowPrice").text();
	let balance = $("#balance").text();
	nowPrice = stringFormat(nowPrice);
	balance = stringFormat(balance);
	price = Number(price);
	nowPrice = Number(nowPrice);
	balance = Number(balance);
	if (price < balance) {
		if (price > nowPrice) {
			send(price);
			$("#inputPrice").val('');
		} else {
			alert("현재입찰가보다 낮은가격입니다. 다시 입력해주세요.");
			$("#inputPrice").val('');
			$("#inputPrice").focus();
		}
	} else {
		alert("보유잔액이 부족합니다.");
	}
});
$("#img-list-con>div>img").click(e => {
	let imgSrc = $(e.target).attr("src");
	$("#img-list-con>div").css({ "border": "2px solid white", "box-sizing": "border-box" });
	$(e.target).parent().css({ "border": "2px solid black", "box-sizing": "border-box" });
	$("#img-con-first").find("img").attr("src", imgSrc);
});
var timer = setInterval(() => {
	if (sec == 0) {
		if (min == 0) {
			clearInterval(timer);
			$("#timeMin").html(min < 10 ? "0" + min : min);
			$("#timeSec").html(sec < 10 ? "0" + sec : sec);
			let nickName = $("#section-right>div:last-child>h5>.nickName").text();
			let price = $("#section-right>div.user:last-child>h5>.price").text();
			let userDiv = $("<div>");
			userDiv.css("background-color", "#41B979");
			userDiv.attr("id","endUser");
			let h5 = $("<h5>");
			h5.html(nickName + "님에게 " + price + "원에 최종 낙찰되었습니다!")
			h5.css({ "color": "white" });
			userDiv.append(h5);
			$("#section-right").append(userDiv);
			let systemDiv = $("<div>");
			systemDiv.css("background-color", "white");
			let systemH5 = $("<h5>");
			systemH5.html("System Message : 경매가 종료되었습니다.");
			systemH5.css({ "color": "red" });
			systemDiv.append(systemH5);
			$("#section-right").append(systemDiv);
			endProductAction(nickName,stringFormat(price));
		} else {
			sec = 59;
			min = min - 1;
		}
	} else {
		sec = sec - 1;
		$("#timeMin").html(min < 10 ? "0" + min : min);
		$("#timeSec").html(sec < 10 ? "0" + sec : sec);
	}
	socket.send(JSON.stringify({ "min": min, "sec": sec }));
}, 1000);
function numberFormat(num) {
	if (num == 0) return 0;

	var reg = /(^[+-]?\d+)(\d{3})/;
	var n = (num + '');

	while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');

	return n;
};

function stringFormat(num) {
	if (num == 0) return 0;

	let strNum = num;

	return parseInt(strNum.replace(/,/g, ''));
};
