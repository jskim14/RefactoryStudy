/**
 * 
 */


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


$("#bidButtons>div>button").click(e=>{
   	const plusBidPrice = parseInt($(e.target).val());
   	const inputVal = $("#bidUnitInput").val().stringNumberToInt();
   	let sum = inputVal + plusBidPrice;
   	$("#bidUnitInput").val(sum.format());
});

$("#bidUnitInput").keyup(e=>{
	
	let keyCode = e.keyCode;
	console.log(keyCode);
	if ( keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 39 ) { 
		return; 
	} else { //숫자만 입력
		 e.target.value = e.target.value.replace(/[^0-9]/g, ""); 
	}


	const inputVal = $("#bidUnitInput").val().stringNumberToInt();
	$("#bidUnitInput").val(inputVal.format());
});



const checkBuyNow=(pNo,isLogin)=>{
	if(!isLogin){
		alert("로그인 후 이용가능합니다.");
		return;
	}
	$.ajax({
		url:path + "/product/checkBuyNow",
		data:{productNo:pNo},
		method:"GET",
		dataType:"json",
		success:result=>{
			//data-bs-toggle="modal" data-bs-target="#biddingModal
			console.log(result);
			if(!result){
				//$("<button>").attr({"data-bs-toggle":"modal","data-bs-target":"#buyNowModal"}).click();
				$("#buyNowModalBtn").click();
			}else{
				alert("이미 낙찰된 상품입니다.");
			}
		}
	});
};





const bid=(pNo)=>{
	const userInputPrice = $("#bidUnitInput").val().stringNumberToInt();
	
	$.ajax({
		url:path + "/product/bid",
		data:{userBidPrice:userInputPrice,productNo:pNo},
		dataType:"json",
		success:data=>{
			console.log("data");
			alert(data['result']);
			location.reload();
		}
	})
}

$('#normalAddressRadio').change(e=>{
	$('#shipAddress').removeClass('pick');
	$('#normalAddress').addClass('pick');
});

$('#shipAddressRadio').change(e=>{
	$('#normalAddress').removeClass('pick');
	$('#shipAddress').addClass('pick');
});



function newAddressInput(){
	$('#shipAddressRadio').click();
	$('#shipAddress').attr({readonly:false}).val("").focus();
}







