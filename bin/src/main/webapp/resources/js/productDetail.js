/**
 * 
 */

//비딩금액 버튼 ++
$("#bidButtons>div>button").click(e=>{
   	const plusBidPrice = parseInt($(e.target).val());
   	const inputVal = parseInt($("#bidUnitInput").val());
   	$("#bidUnitInput").val(plusBidPrice+inputVal);
});


const checkBuyNow=(pNo)=>{
	$.ajax({
		url:location.origin+"/product/checkBuyNow",
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