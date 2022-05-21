if(loginMember!="") {
	const socket = new WebSocket(url + "/ws/messagebox");
	socket.onmessage = message => {
		console.log(message.data);
		let msgbox = JSON.parse(message.data);
		if(msgbox["nickName"]==nickName) {
			$("#msgBoxBtn").click();
		}
	}
	function send(nickName) {
		socket.send(JSON.stringify({"nickName":nickName}));
	}
}
function msgBox(memberNo) {
	const url = path + "/member/messagebox?memberNo=" + memberNo;
	open(url,"_blank","width=700 height=500");
} 
