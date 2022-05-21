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
</head>
<body style="margin:0;">
	<div id="btn-contaier">
		<button class="${msgbox == 'receiv'?'msgBoxBtnActive':'msgBoxBtn'}" onclick="pageMove(this.value);" value="receiv">받은쪽지함</button>
		<button class="${msgbox != 'receiv'?'msgBoxBtnActive':'msgBoxBtn'}" onclick="pageMove(this.value);" value="send">보낸쪽지함</button>
		<button class="msgBoxBtn" onclick="pageMove(this.value);" value="sendMsg">쪽지보내기</button>
	</div>
	<div id="container">
		<div style="display:flex; ">
 			<h4>&gt; <span><c:out value="${msgbox != 'receiv'?'보낸쪽지함':'받은쪽지함' }" /></span></h4>
 			<c:if test="${msgbox == 'receiv' }">
 			<p>안읽은쪽지 <span><c:out value="${noCheckMsg }" />통</span> / 전체 <span><c:out value="${totalData }"/>통</span></p> 
 			</c:if>
 			<c:if test="${msgbox == 'send' }">
 			<p>보낸쪽지 총 <span><c:out value="${totalData }" /></span>통</p>
 			</c:if>
 			<button onclick="deleteMsg();" style="position: absolute; left:89%; top:9%; width: 50px; background-color: white; color: #41B979; border: none; border-radius: 5px; font-weight: bold;">삭제</button>
 		</div>	
 		<div style="background-color: white; width:650px; height:404px;">
 			<div style="height: 330px; margin-bottom: 20px;">
			<table id="msgList" style="width: 650px; text-align: center; border-collapse: collapse; border-bottom: 2px solid #d3d3d3; max-width: 650px;">
				<thead>
					<tr>
						<th width="25"><input id="checkAll" type="checkbox"></th>
						<th width="310">쪽지내용</th>
						<c:if test="${msgbox == 'receiv' }">
						<th width="105">보낸사람</th>
						</c:if>
						<c:if test="${msgbox != 'receiv' }">
						<th width="105">받는사람</th>
						</c:if>
						<c:if test="${msgbox == 'receiv' }">
						<th width="130">받은날짜</th>
						</c:if>
						<c:if test="${msgbox != 'receiv' }">
						<th width="130">보낸날짜</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${messageList }" var="m">
					<tr>
						<td width="25" class="${m.msgCheckYN == 'N'?'uncheckMsg':'checkMsg' }"><input class="msgNo" type="checkbox" value="${m.msgNo }"></td>
						<c:if test="${msgbox == 'receiv' }">
						<td width="310" style="text-overflow: ellipsis; white-space: nowrap; max-width: 310px; overflow: hidden;">
							<a href="${path }/member/messageboxView?msgNo=${m.msgNo}&msgbox=${msgbox}" class="${m.msgCheckYN == 'N'?'uncheckMsg':'checkMsg' }"><span style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;
	}"><c:out value="${m.msgContent }" /></span></a>
						</td>
						</c:if>
						<c:if test="${msgbox != 'receiv' }">
						<td width="310" style="text-overflow: ellipsis; white-space: nowrap; max-width: 310px; overflow: hidden;"><a href="${path }/member/messageboxView?msgNo=${m.msgNo}&msgbox=${msgbox}" class="checkMsg"><span style="text-overflow: ellipsis; white-space: nowrap; overflow: hidden;"><c:out value="${m.msgContent }" /></span></a></td>
						</c:if>
						<c:if test="${msgbox == 'receiv' }">
						<td width="105" class="${m.msgCheckYN == 'N'?'uncheckMsg':'checkMsg' }"><span><c:out value="${m.sender.nickName}" /></span></td>
						</c:if>
						<c:if test="${msgbox != 'receiv' }">
						<td width="105" class="checkMsg"><span><c:out value="${m.receiver.nickName}" /></span></td>
						</c:if>
						<c:if test="${msgbox == 'receiv' }">
						<td width="130" class="${m.msgCheckYN == 'N'?'uncheckMsg':'checkMsg' }"><span><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${m.msgsendDate }"/></span></td>
						</c:if>
						<c:if test="${msgbox != 'receiv' }">
						<td width="130" class="checkMsg"><span><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${m.msgsendDate }"/></span></td>
						</c:if>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
			${pageBar }
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
		$("#checkAll").change(e=> {
			if($(e.target).is(":checked")) {
				$("tbody input[type=checkbox]").prop("checked",true);
			}else {
				$("tbody input[type=checkbox]").prop("checked",false);
			}
		});
		const deleteMsg=()=> {
			let arr = $(".msgNo");
			let msgNoArr = [];
			for(let i=0; i<arr.length; i++) {
				if(arr[i].checked==true) {
					msgNoArr[i] = arr[i].value;
				}
			}
			if(confirm("정말 삭제하시겠습니까?")) {
				$.ajax({
					url : "${path}/member/deleteMessageBox",
					type : "post",
					data : {"msgNo":msgNoArr,"msgbox":"${msgbox}"},
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
	</script>
</body>
</html>