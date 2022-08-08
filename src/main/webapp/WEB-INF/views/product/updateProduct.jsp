<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
<script src="https://cdn.ckeditor.com/ckeditor5/29.1.0/classic/ckeditor.js"></script>
  
<section>
    <div id="totalContainer">
        <div class="pageTitle">
            <span>판매물품수정</span>
        </div>
        <div class="pageMenu">
            <form action="${path }/product/updateProductEnd" method="post" enctype="multipart/form-data">
            <!-- 판매자 -->
            <input type="hidden" name="sellerNo" value="${loginMember.memberNo}" >
            <input type="hidden" name="productNo" value="${p.productNo }">
                <div class="pageMenu-1">
                    <!-- <div class="subTitle">경매설정</div> -->
                    <div class="tit_h3 through "> 
                        <span class="lineSpan">경매설정</span>                   
                    </div>
                    <div class="centerArray">
                        <div class="subMenu">
                            <div class="titleLeft">
                                <span class="subMenuTitle">즉시구매</span><br>
                            </div>
                            <div class="titleRight">
                            <c:if test="${empty p.buyNowPrice}">
                                <label><input class="form-check-input" type="radio" name="flexRadioDefault1" value="N" checked required> 
                                    설정안함
                                </label> &nbsp;
                                <label><input class="form-check-input" type="radio" name="flexRadioDefault1" value="Y"> 
                                    설정
                                </label> 
                                <input type="text" id="inputTyping1" class="form-control inputBox" placeholder="즉시구매가를 입력해주세요" 
                                 style="width: 250px; display:inline; margin-left: 1%" disabled required>
                                 <input type="hidden" name="buyNowPrice">
                                <div class="onlyNumber" style="display: inline; padding: 1%"></div>
                            </c:if>
                            <c:if test="${not empty p.buyNowPrice}">
                            	<label><input class="form-check-input" type="radio" name="flexRadioDefault1" value="N" required> 
                                    설정안함
                                </label> &nbsp;
                                <label><input class="form-check-input" type="radio" name="flexRadioDefault1" value="Y" checked> 
                                    설정
                                </label> 
                                <input type="text" id="inputTyping1" class="form-control inputBox" placeholder="즉시구매가를 입력해주세요" 
                                 style="width: 250px; display:inline; margin-left: 1%" value="${p.buyNowPrice }" required>
                                 <input type="hidden" name="buyNowPrice">
                                <div class="onlyNumber" style="display: inline; padding: 1%"></div>
                            </c:if> 
                            </div>
                        </div>
                        <div class="subMenu">
                            <div class="titleLeft">
                                <span class="subMenuTitle">자동 재경매</span><br>
                            </div>
                            <div class="titleRight">
                            <c:if test="${p.extendYn eq 'N' }">
                                <label><input class="form-check-input" type="radio" name="extendYn" value="N" checked required> 
                                    설정안함
                                </label> &nbsp;
                                <label><input class="form-check-input" type="radio" name="extendYn" id="flexRadioDefault2" value="Y"> 
                                    설정
                                </label>
                                <div class="inputNextSpan"><span style="color:navy">*경매가 유찰될 경우 1회에 한해 자동으로 경매가 재진행 됩니다.</span><br>
                                </div>
                            </c:if>
                            <c:if test="${p.extendYn eq 'Y' }">
                            	<label><input class="form-check-input" type="radio" name="extendYn" value="N" required> 
                                    설정안함
                                </label> &nbsp;
                                <label><input class="form-check-input" type="radio" name="extendYn" id="flexRadioDefault2" value="Y" checked> 
                                    설정
                                </label>
                                <div class="inputNextSpan"><span style="color:navy">*경매가 유찰될 경우 1회에 한해 자동으로 경매가 재진행 됩니다.</span><br>
                                </div>
                            </c:if>
                            </div>
                        </div>
                        <div class="subMenu">
                            <div class="titleLeft">
                                <span class="subMenuTitle">입찰 시작가</span> <!-- minBidPrice -->
                            </div>
                            <div class="titleRight">
                                <input type="text" id="minBidPrice" class="form-control inputBox"
                                placeholder="" style="width: 250px; display:inline;" value="${p.minBidPrice }" required>
                                <input type="hidden" name="minBidPrice">
                                <div id="autionStartInfo" class="inputNextSpan" style="display: inline; padding: 1%;color:navy"><br> *입찰시작가는 즉시구매가보다 높을 수 없습니다. </div>
                            </div>
                        </div>
                        <div class="subMenu">
                            <div class="titleLeft">
                                <span class="subMenuTitle">입찰단위</span>
                            </div>
                            <div class="titleRight"> <!-- script처리 -->
                                <select id="priceUnit" onchange="unitSelect();" class="form-select" name="unit" aria-label="Default select example" style="width: 200px; color: gray; display:inline;" required>
                                    <option selected>---선택하세요---</option>
                                    <option value="1000">1,000원</option>
                                    <option value="5000">5,000원</option>
                                    <option value="10000">10,000원</option>
                                    <option value="50000">50,000원</option>
                                    <option value="100000">100,000원</option>
                                    <option value="typing">직접입력</option>
                                </select>
                                <input type="text" id="inputTyping3" class="form-control inputBox" placeholder="" style="width: 250px; display:inline; margin-left: 1%;" disabled required>
                                <input type="hidden" name="unit" id="inputUnit">
                                <div id="autionUnitInfo" class="inputNextSpan" style="display: inline; padding: 1%; color:navy;"> 
                                	<br>*입찰단위는 입찰시작가보다 클 수 없습니다.
                               	</div>
                            </div>
                        </div>
                        <div class="subMenu">
                            <div class="titleLeft">
                                <span class="subMenuTitle">경매기간</span>
                            </div>
                            <div class="titleRight">
                                <!-- 스타일 각각해야됨 -->
                                시작일 &nbsp;<input type="date"  id="currentDate" class="form-control" style="width: 180px; display:inline;" readonly>&nbsp; <br>
                                종료일 &nbsp;<input type="text" id="maxDate" class="form-control" name="maxDate" placeholder="최대 14일 가능" style="width: 180px; display:inline;" required>&nbsp;
                                마감시간 &nbsp;<input type="time" class="form-control" name="maxTime" style="width: 180px; display:inline;" required>&nbsp;
                                
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    
                </script>

                <div class="pageMenu-1">
                    <!-- <span class="subTitle">물품정보</span><br> -->
                    <div class="tit_h3 through "> 
                        <span class="lineSpan">물품정보</span>                   
                    </div>
                    <div class="centerArray">
                        <div class="subMenu">
                            <div class="titleLeft">
                                <span class="subMenuTitle">카테고리</span>
                            </div>
                            <div class="titleRight"> <!-- script -->
                                <select class="form-select" id="category" name="productCategory" aria-label="Default select example" style="width: 200px; color: gray;" required>
                                    <option selected>---선택하세요---</option>
                                    <option value="FS">패션</option>
                                    <option value="LF">라이프</option>
                                    <option value="TC">테크</option>
                                    <option value="AR">아트</option>
                                </select>
                            </div>
                        </div>
                        <div class="subMenu">
                            <div class="titleLeft">
                                <span class="subMenuTitle">상품명</span>
                            </div>
                            <div class="titleRight"> 
                                <input type="text" class="form-control" name="productName" placeholder="상품명을 입력해주세요. 상품명은 제목으로 입력됩니다." value="${p.productName }" required>
                            </div>
                        </div>
                        <div class="subMenu">
                            <div class="titleLeft">
                                <span class="subMenuTitle">물품설명</span> 
                            </div>
                            <div class="titleRight">
                                <textarea name="productContent" id="classic" class="form-control" style="height: 40rem;"
                                placeholder="상품을 소개할 내용을 적어주세요." required> ${p.productContent } </textarea>
                            </div>
                        </div>
                        <div class="subMenu">
                            <div class="titleLeft">
                                <span class="subMenuTitle">이미지</span>
                            </div>
                            <div class="titleRight"> 
                                <div class="mb-3">
                                    <label for="formFileMultiple" class="form-label">
                                        *사진은 4장까지 등록 가능하며, 첫번째 등록한 사진이 메인사진으로 등록됩니다.
                                    </label>
                                    <input class="form-control" type="file" id="formFileMultiple" name="imageFile" onclick="fileUpload();"
                                    accept=".jpg, .jpeg, .png" multiple required>
                                    <div id="showFiles" style="padding-right:50px"></div>
                                    <div class="img_wrap">
                                    	<img id="img"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-secondary btn-lg btnColor">등록</button>
                        </div>
                    </div>
                </div>
            </form>
            <div class="app">
			</div>
        </div>
    </div>
    <script>
    $("input[name=flexRadioDefault1]").change(e=>{ //즉시구매여부
        if($(e.target).val()=='Y') {
        	$("#inputTyping1").attr("disabled",false);
            $("#inputTyping1").focus();
         }else {
        	$("#inputTyping1").val("");
            $("#inputTyping1").attr("disabled",true); 
            $("#inputTyping1").next().html("");
        } 
    });
        
        $(()=>{
        	$("#priceUnit").val("${p.bidUnit}");
        	$("#category").val("${p.productCategory}");
        });
        
        function unitSelect() {
            if($("#priceUnit").val()=="typing") {
                $("#inputTyping3").attr("disabled",false);
                $("#inputTyping3").focus();
            } else {
                $("#inputTyping3").attr("disabled",true);
            }
        }
        
        function unitSelect() {
	       	 if($("#priceUnit").val()=="typing") {
	             $("#inputTyping3").attr("disabled",false);
	             $("#inputTyping3").focus();
	         } else {
	             $("#inputTyping3").attr("disabled",true);
	             $("#inputTyping3").val("");
	         }
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
		
		$(".inputBox").change(e=>{
    		var numPattern = /([^0-9])/;
    		numPattern = $(e.target).val().match(numPattern);
    		if (numPattern != null) {
    			$(e.target).val("");
    			$(e.target).next().next().html("숫자만 입력이 가능합니다.").css("color","red");
    			return false;
    		} else { //숫자만 입력했을때
//    			let comma = $(e.target).val().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
//    			$(e.target).val(comma);
				var temp = $(e.target).val().stringNumberToInt();
				$(e.target).val(temp.format());
				var temp1 = $(e.target).val().stringNumberToInt();
				$(e.target).next().val(temp1); //hidden에 넣어주는것
    			$(e.target).next().next().html(""); 
				//console.log($("input[name=flexRadioDefault1]").val());
    		}
        })  
      
        /* 입찰시작가, 즉시구매가 값 비교 */
        
        $("#inputTyping1, #minBidPrice").change(e=>{
        	var minBid = Number($("input[name=minBidPrice]").val());
        	var buyNow = Number($("input[name=buyNowPrice]").val());
        	if(minBid != "" && buyNow !="") {
        		if( minBid > buyNow ) {
		        	$("#autionStartInfo").css('color','red').html('입찰시작가가 즉시구매가보다 높습니다.');
		        } else {
		        	$("#autionStartInfo").html("");
		        }
        	}
        });
        
        /* 입찰시작가, 입찰단위 값 비교 */
        
          $("#inputTyping3, #minBidPrice").change(e=>{

	        	var minBid = Number($("input[name=minBidPrice]").val());
	        	var unit = Number($("#inputUnit").val());
	        	if(minBid != "" && unit !="") {
	        		if( minBid < unit ) {
			        	$("#autionUnitInfo").css('color','red').html('입찰단위가 입찰시작가보다 높습니다.');
			        } else {
			        	$("#autionUnitInfo").html("");
			        }
	        	}
        }); 

        $("#currentDate").val(new Date().toISOString().substring(0, 10));
                    
        $(function(){
            $("#maxDate").datepicker({
                dateFormat: "yy-mm-dd",
                minDate: +1,
                maxDate: +14
                });
            })
            
        $("#maxDate").blur(e=>{
        	if($("#maxDate").val() != "" && ($("#maxDate").val() < $("#currentDate").val()) ){
        		alert(" 경매종료일이 시작일보다 이전입니다. \n 날짜를 확인하세요.");
        		$("#maxDate").val("");
        		$("#maxDate").focus();
        	}
        })

        ClassicEditor
            .create( document.querySelector( '#classic' ))
            .catch( error => {
                console.error( error );
            } );
        
        window.onload = function(){
            target = document.getElementById('formFileMultiple');
            target.addEventListener('change', function(){
                fileList = "";
                for(i = 0; i < target.files.length; i++){
                	if(i>3) {
                		alert("물품이미지는 최대 4장입니다.");
                		target.value="";
                		fileList = "";
                	} else {
                    fileList += ('\u00a0\u00a0'+(i+1)+'.  ')+target.files[i].name+'\u00a0\u00a0\u00a0';
                	}
                }
                target2 = document.getElementById('showFiles');
                target2.innerHTML = ("등록된 이미지 : ")+fileList;
            });
        }

        
    </script>
    
    	<!-- 넓이 높이 조절 -->
<style>
        .ck.ck-editor {
            max-width: 100%;
        }
        .ck-editor__editable {
            min-height: 300px;
        }
</style>

    
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>