<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="${path }/resources/css/msgbox.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>NBIF 쪽지함</title>
</head>
<body style="margin:0;">
	<div id="btn-contaier">
		<button class="msgBoxBtn" onclick="pageMove(this.value);" value="receiv">받은쪽지함</button>
		<button class="msgBoxBtn" onclick="pageMove(this.value);" value="send">보낸쪽지함</button>
		<button class="msgBoxBtnActive" onclick="pageMove(this.value);" value="sendMsg">쪽지보내기</button>
	</div>
	<div id="container">
		<div id="view-con" style="height: 42px; padding-right: 30px;">
		<button class="view-btn view-btn-right" style="margin-left: 10px; width:70px;" onclick="sendMsg();">보내기</button>
		</div>
 		<div style="background-color: white; width:650px; height:404px; padding-top: 10px;">
 		<table id="view-tbl" style="width: 650px; text-align: center; border-collapse: collapse; border-top: 2px solid #d3d3d3; max-width: 650px;  text-align: left;">
 			<tr>
 				<th style="width:100px; height:50px; padding-left: 10px;">받는사람</th>
 				<td style="height:50px;"><input type="text" id="receiver" value="${member != null?member.nickName:'' }" placeholder="닉네임을 입력해주세요." style="width: 200px; padding-left: 5px;"></td>
 			</tr>
 			<tr>
 				<td colspan="2" style="padding:10px 10px 10px 10px;">
 					<div id="textArea">
 						<textarea id="msgContent" id="content" rows="10" cols="80"></textarea>
 						<div style="text-align: right; padding-right:5px;">
 							<span>0 / 150자</span>
 						</div>
 					</div>
 				</td>
 			</tr>
 		</table>
		</div>
	</div>
	<script>
		const pageMove=(value)=> {
			if(value!='sendMsg') {
				location.assign("${path}/member/messagebox?memberNo=${loginMember.memberNo}&msgbox=" + value);
			}else {
				location.assign("${path}/sendMessage");
			}
		}
		$("#msgContent").keyup(e=> {
			let areaVal = $(e.target).val();
			if(areaVal.length > 150) {
				$(e.target).next().find("span").html(areaVal.length + " / 150자");
				$(e.target).val(areaVal.substr(0,150));
				alert("글자 수는 150자를 넘을 수 없습니다.");
				$(e.target).next().find("span").html($(e.target).val().length + " / 150자");
			}else {
				$(e.target).next().find("span").html(areaVal.length + " / 150자");
			}
		});
		const sendMsg=()=> {
			if($("#receiver").val()!="" && $("#content").val()!="") {
				$.ajax({
					url : "${path}/member/sendMessageEnd",
					type : "post",
					data : {"receiver":$("#receiver").val(),"senderNo":"${loginMember.memberNo}","msgContent":$("#msgContent").val()},
					success : data => {
						if(data) {
							alert("쪽지를 성공적으로 보냈습니다.");
							opener.send($("#receiver").val());
							location.replace("${path}/member/messagebox?memberNo=${loginMember.memberNo}&msgbox=send");
						}else {
							alert("쪽지 전송 실패");
						}
					}
				});
			}else if($("#receiver").val()=="") {
				alert("쪽지를 받은 상대를 입력해주세요.");
			}else if($("#content").val()=="") {
				alert("쪽지 내용을 입력해주세요.");
			}
		}
	</script>
</body>
</html>