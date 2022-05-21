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
		<button class="${msgbox == 'receiv'?'msgBoxBtnActive':'msgBoxBtn'}" onclick="pageMove(this.value);" value="receiv">받은쪽지함</button>
		<button class="${msgbox != 'receiv'?'msgBoxBtnActive':'msgBoxBtn'}" onclick="pageMove(this.value);" value="send">보낸쪽지함</button>
		<button class="msgBoxBtn" onclick="pageMove(this.value);" value="">쪽지보내기</button>
	</div>
	<div id="container">
		<div id="view-con" style="height: 42px; padding-right: 30px;">
		<c:if test="${msgbox == 'receiv' }">
		<button class="view-btn" onclick="viewBtn(this.value);" value="pre">이전</button>
		<button class="view-btn view-btn-right" style="margin-left: 10px;" onclick="viewBtn(this.value);" value="delete">삭제</button>
		<button class="view-btn view-btn-right" onclick="viewBtn(this.value);" value="reply">답장</button>
		</c:if>
		<c:if test="${msgbox != 'receiv' }">
		<button class="view-btn" onclick="viewBtn(this.value);" value="pre">이전</button>
		<button class="view-btn view-btn-right" style="margin-left: 10px;" onclick="viewBtn(this.value);" value="delete">삭제</button>
		</c:if>
		</div>
 		<div style="background-color: white; width:650px; height:404px; padding-top: 10px;">
 		<table id="view-tbl" style="width: 650px; text-align: center; border-collapse: collapse; border-top: 2px solid #d3d3d3; max-width: 650px;  text-align: left;">
 			<tr>
 				<c:if test="${msgbox == 'receiv'}">
 				<th style="width:100px; padding-left: 10px;">보낸사람</th>
 				<td><c:out value="${messageOne.sender.nickName }" /></td>
 				</c:if>
 				<c:if test="${msgbox != 'receiv'}">
 				<th style="width:100px; padding-left: 10px;">받는사람</th>
 				<td><c:out value="${messageOne.receiver.nickName }" /></td>
 				</c:if>
 			</tr>
 			<tr>
 				<c:if test="${msgbox == 'receiv'}">
 				<th style="width:100px; padding-left: 10px; border-bottom: 2px solid #d3d3d3;">받은날짜</th>
 				</c:if>
 				<c:if test="${msgbox != 'receiv'}">
 				<th style="width:100px; padding-left: 10px; border-bottom: 2px solid #d3d3d3;">보낸날짜</th>
 				</c:if>
 				<td style="border-bottom: 2px solid #d3d3d3;"><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${messageOne.msgsendDate }"/></td>
 			</tr>
 			<tr>
 				<td colspan="2" style="padding-left: 10px; padding-top: 30px;">
 					<c:out value="${messageOne.msgContent }" />
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
				location.assign("${path}/member/sendMessage");
			}
		}
		
		const viewBtn=(value)=> {
			if(value=='pre') {
				location.assign("${path}/member/messagebox?memberNo=${loginMember.memberNo}&msgbox=${msgbox}");
			}else if(value=='reply') {
				location.assign("${path}/member/sendMessage?nickName=${messageOne.sender.nickName }");
			}else {
				if(confirm("정말 삭제하시겠습니까?")) {
					$.ajax({
						url : "${path}/member/deleteMessageBox",
						type : "post",
						data : {"msgNoOne":"${messageOne.msgNo}","msgbox":"${msgbox}"},
						success : data => {
							if(data) {
								alert("쪽지를 삭제하였습니다.");
								location.replace("${path}/member/messagebox?memberNo=${loginMember.memberNo}&msgbox=${msgbox}")
							}else{
								alert("쪽지삭제에 실패하였습니다. 다시 시도해주세요.");
							}
						}
					});
				}
			}
		}
	</script>
</body>
</html>