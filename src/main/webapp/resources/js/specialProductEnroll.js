/**
 * 
 */

$('#bidUnit').change(e=>{
    console.log($(e.target).val());
    if($(e.target).val()=='typing'){
        $('#bidUnitInput').attr("disabled",false);
    }else{
        $('#bidUnitInput').attr("disabled",true);
    }

})




$(()=>{
    $("#startDate").datepicker({
        dateFormat: "yy-mm-dd",
        minDate: 0,
        maxDate: +14
    });

    $('#startTime').timepicker({
        minTime:'09:00am',
        maxTime:'20:00pm',
        timeFormat:'H:i',
        step:60,
      
    });

})
    



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

$("#minBidPrice").keyup(e=>{
	
	let keyCode = e.keyCode;
	console.log(keyCode);
	if ( keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 39 ) { 
		return; 
	} else { //숫자만 입력
		 e.target.value = e.target.value.replace(/[^0-9]/g, ""); 
	}
	const inputVal = $("#minBidPrice").val().stringNumberToInt();
	$("#minBidPrice").val(inputVal.format());
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



 ClassicEditor
 .create( document.querySelector( '#productContent' ))
 .catch( error => {
     console.error( error );
 } );