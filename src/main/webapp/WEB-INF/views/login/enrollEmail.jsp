<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section  style="padding: 200px 10%;">
	 <div class="container-fluid" >
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<div class="w-100" style="display: flex; justify-content: center;">
					<h1>회원가입</h1>
				</div>
				
			</div>
			<div class="col-4"></div>
		</div>
		<hr>
		<div class="row mb-3">
			<div class="col-4"></div>
			<div class="col-4" style="text-align:center;">
				<span>이메일 인증 후 회원가입이 진행됩니다.</span><br>
				<span>가입할 이메일 주소와 전송받은 인증번호를 입력해주세요.</span>
			</div>
			<div class="col-4"></div>
		</div>
		<div class="row mb-3">
			<div class="col-4"></div>
			<div class="col-4">
				<div class="row">
					<div class= "col-7">
						<input id="emailText" type="email" class="form-control" placeholder="ex) nbif@naver.com" autofocus>
					</div>
					<div class= "col-5">
						<button type="button" style="width:100%;"class="btn btn-primary btnColor" onclick="sendEmail();">인증번호받기</button>
					</div>
				</div>
			</div>
			<div class="col-4"></div>
		</div>
		<div class="row mb-3">
			<div class="col-4"></div>
			<div class="col-4">
				<div class="row">
					<div class="col-7">
						<input id="checkCode"type="text" class="form-control" placeholder="인증번호를 입력해주세요">
					</div>
					<div class="col-5">
						<button type="button" style="width:100%;"class="btn btn-primary btnColor" onclick="obtainCertification();">인증</button>
					</div>
				</div>
			</div>
			<div class="col-4"></div>
		</div>
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4">
				<button id="goBtn" class="btn btn-primary btnColor" style="width: 100%;" disabled onclick="goToEnrollMember();">회원가입 진행</button>
			</div>
			<div class="col-4"></div>
		</div>
		
		<div class="row my-3 justify-content-center">
			<div class="col-4">
				<button onclick="kakaoEnroll()" type="button" class="btn btn-secondary w-100" style="height: 42px; background:#FEE500; font-size:13px;border:none;color:#624A3D;">
					<img src="${path }/resources/images/kakao.png" style="width:20px;height:20px;padding:0;">
								카카오 ID로 회원가입
				</button>
			</div>
		</div>
	 </div>
</section>
<script>

	function kakaoEnroll(){
		  Kakao.Auth.login({
		      success: function (response) {
				  console.log(response);

				const accessToken = response['access_token'];

		        Kakao.API.request({
		          url: '/v2/user/me',
		          success: function (response) {
		        	  console.log(response)
		        	  console.log(JSON.stringify(response));
					  console.log(response['kakao_account']['id']);
					sendPost2("${path}/member/kakaoEnroll",'id',response['id'],'email',response['kakao_account']['email']);
		        
		          },
		          fail: function (error) {
		            console.log(error)
		          },
		        })
		      },
		      fail: function (error) {
		        console.log(error)
		      },
		    })
		    
	}
	
	 function sendPost2(url,key,param, key2, param2 ){
		  let form = document.createElement('form');
		  form.setAttribute('method','post');
		  form.setAttribute('action',url);
		  document.charset = 'utf-8';

		 
		let hiddenField1 = document.createElement('input');
		hiddenField1.setAttribute('type','hidden');
		hiddenField1.setAttribute('name',key);
		hiddenField1.setAttribute('value',param);
		form.appendChild(hiddenField1);
		
		let hiddenField2 = document.createElement('input');
		hiddenField2.setAttribute('type','hidden');
		hiddenField2.setAttribute('name',key2);
		hiddenField2.setAttribute('value',param2);
		form.appendChild(hiddenField2);
		
		document.body.appendChild(form);
		form.submit();
	  }

	function goToEnrollMember(){
		location.assign('${path}/member/enrollMemberMainView');
	}

 	function obtainCertification(){
		const inputCode = $("#checkCode").val();
		$.ajax({
			url:'${path}/member/certification',
			type:"POST",
			data:{'inputCode':inputCode},
			success:data=>{
				console.log(data);
  				 if(data['result']==true){
					alert('인증 완료'); 
					$('#goBtn').attr({disabled:false});
				}  
 			}
		});
	}
	 

	function sendEmail (){
		let clientEmail = document.getElementById("emailText").value;
		let emailYN = isEmail(clientEmail);

		if(emailYN ==true){
			//alert('이메일 형식입니다');

			$.ajax({
				url:'${path}/member/email',
				type:'POST',
				data:{userEmail:clientEmail},
				success: data=>{
					console.log(data);
					alert(data['result']);
				}
			});
		}else{
			alert("이메일 형식에 맞게 입력해주세요 ");
		}
		
	}

	function isEmail(mail){
		let reqExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		return reqExp.test(mail);
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>