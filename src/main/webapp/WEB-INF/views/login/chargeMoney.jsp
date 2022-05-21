<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <link rel="stylesheet" href="${path}/resources/css/productDetail.css">
    <link rel="stylesheet" href="${path}/resources/css/inputStyle.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${path}/resources/css/index.css">
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <title>Document</title>
</head>
<body style="background:#EBECF0">
	<div class="container-fluid p-3">
		<div class="row">
			<div class="col-12 d-flex justify-content-center">
				<h3>e-money 충전</h3>
			</div>
		</div>
		<div class="col-12 my-3" style="background:white; width:99%; height:80px; box-shadow:0px 0px 10px 2px lightgray; border-radius:8px; padding:8px 20px;">
			<div class="col-3">
				<span>현재 잔고</span>
			</div>
			<div class="col-9">
				<span style="font-size:26px;"><fmt:formatNumber value="${member.balance }" type="number"/>원</span>
			</div>
		</div>
		<div class="row">
			<div class="col-12 my-3">
				<input type="text" id="moneyInput" name="money"  placeholder="금액을 입력해주세요." class="form-control form-control-lg">
			</div>
		</div>
		<div class="row my-2">
			<div class="col-12 d-flex justify-content-center">
				<div id="buttons" class="btn-group w-100" role="group">
					<button type="button" class="btn btn-outline-primary" value="10000">+1만원</button>
					<button type="button" class="btn btn-outline-primary" value="50000">+5만원</button>
					<button type="button" class="btn btn-outline-primary" value="100000">+10만원</button>
					<button type="button" class="btn btn-outline-primary" value="1000000">+100만원</button>
				</div>
			</div>
		</div>
		
		
		<div class="row">
			<div class="col-12">
				<span>충전수단</span>
			</div>
			<div class="col-12 mt-2">
				<select id="payWithSelect" class="form-select" id="">
					<option value="kakao" selected>카카오페이</option>
					<option value="" disabled>-</option>
					<option value="" disabled>-</option>
				</select>
			</div>
		</div>
		<div class="row">
			<div class="col-12 fixed-bottom" style="padding-bottom:20px;">
				<button type="button" class="btn btn-warning w-100" onclick="exeCharge()">충전하기</button>
			</div>
		</div>
	</div>
<script>
	function exeCharge(){
		const selectVal = $('#payWithSelect').val();
		console.log('exeCharge');

		const payAmount = $('#moneyInput').val();

		switch(selectVal){
			case 'kakao': kakaoPay(payAmount); break;
			//case '':break;
			//case '':break;

		}

	}

	function kakaoPay(amount){
		$.ajax({
			url:"${path}/member/kakaoPay",
			dataType:'json',
			data:{'amount':amount},
			success: (data)=>{
				console.log(data);
				
				$.ajax({
					url:"${path}/member/kakaoSuccess",
					dataType:'json',
					data:{'amount':amount},
					success:(data)=>{
						console.log(data);
						if(data){
							alert('충전성공');
						}else{
							alert('ERROR(SERVER)-관리자에게 문의 하세요');
						}

						window.close();
					},
					error:()=>{
						alert('충전실패');
					}
				});



				//location.href = data['next_redirect_pc_url'];
			},
			error:(error)=>{
				alert(error);
			}
		});
	}



	
	Number.prototype.format = function(){
	    if(this==0) return 0;
	 
	    var reg = /(^[+-]?\d+)(\d{3})/;
	    var n = (this + '');
	 
	    while (reg.test(n)) n = n.replace(reg, '$1' + ',' + '$2');
	 
	    return n;
	};
	
	String.prototype.stringNumberToInt = function(){
		if(this==0) return 0;
		
		let strNum = this;
		
		return parseInt(strNum.replace(/,/g,'')); 
	};
	
	
	$("#buttons>button").click(e=>{
	   	const plusBidPrice = parseInt($(e.target).val());
	   	const inputVal = $("#moneyInput").val().stringNumberToInt();
	   	let sum = inputVal + plusBidPrice;
	   	$("#moneyInput").val(sum.format());
	});
	
	$("#moneyInput").keyup(e=>{
		
		let keyCode = e.keyCode;
		console.log(keyCode);
		if ( keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 39 ) { 
			return; 
		} else { //숫자만 입력
			 e.target.value = e.target.value.replace(/[^0-9]/g, ""); 
		}
	
	
		const inputVal = $("#moneyInput").val().stringNumberToInt();
		$("#moneyInput").val(inputVal.format());
	});

</script>	
</body>
</html>