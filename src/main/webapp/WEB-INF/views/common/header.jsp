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
    <link rel="stylesheet" href="${path }/resources/css/index.css">
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
	 // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
	    Kakao.init('a6cc0c054f4e92252bfaf5be7f936545');
	
	    // SDK 초기화 여부를 판단합니다.
	    console.log(Kakao.isInitialized());
	    
	    let socialFlag = false;
	    
		function kakaoLogin(){
		
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
					sendPost("${path}/member/kakaoLogin",'id',response['id'],'accessToken',accessToken);
		        	/*   Kakao.Auth.authorize({
		    			  redirectUri: location.origin+"/member/kakaoLogin"
		    			 
		    			  
		    			});  */
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
		
		function kakaoLogout() {
		    if (Kakao.Auth.getAccessToken()) {
		      Kakao.API.request({
		        url: '/v1/user/unlink',
		        success: function (response) {
		        	console.log(response)
		        },
		        fail: function (error) {
		          console.log(error)
		        },
		      })
		      Kakao.Auth.setAccessToken(undefined)
		    }
		  }  

		  function sendPost(url,key,param,key2,param2){
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
    </script>
    <title>NBIF | Let's FLEX</title>
    <link rel="icon" type="image/x-icon" href="${path }/resources/images/diamond2.png">
</head>
<body>
	<div class="modal fade" id="msgModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">쪽지가 도착하였습니다.</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body container-fluid">바로 확인하시겠습니까?</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-green" style="width:74px; color: #fff; background-color: #41B979; border-color: #41B979;"
					onclick="msgBoxBtn(${loginMember.memberNo});" data-bs-dismiss="modal" >예</button>
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>
    <div id="container">
        <header>
            <div id="header-container">
                <div id="first-header">
                    <h5><img src="${path}/resources/images/png.png" width="13px" height="13px"><span id="time" style="font-size:12px;">0000. 00. 00. 00: 00: 00</span></h5>

                    <ul>
                     		<li>
	                            <a href="${path }/cs/noticeList">고객센터</a>
	                        </li>
	                        
                    		<c:if test="${admin==null or admin==false}">
		                       	<c:if test="${loginMember == null }">
		                        <li>
		                            <a href="${path}/member/enrollMember">회원가입</a>
		                        </li>
		                        </c:if>
	                            <c:if test="${loginMember != null }">
	                            <li>
	                        		<a href="javascript:msgBox(${loginMember.memberNo });"><i class="far fa-envelope" style="color:white;margin-top:5px;font-size:1.2rem;}">&nbsp;<span style="font-size:1rem;">쪽지함</span></i></a>
	                        	</li>
		                         <li>
		                         <div id="newdropdown">
		                   			<div id="after-login"><c:out value="${loginMember.memberName }"/> 님 ▼</div>
								  <div class="newdropdown-content">
									<a class="newdropdown-item" href="${path }/member/myPage?memberNo=${loginMember.memberNo}">마이페이지</a>
									<a class="newdropdown-item" href="${path}/member/logout">로그아웃</a>  
								  </div>
								</div>
								</li>
								<!--  -->
	                            </c:if>
						 	</c:if>
							<c:if test="${admin!=null and admin==true }">
								<!--관리자 메뉴  -->
								<li><a href="${path }/admin/adminMain">관리자메뉴</a></li>
		                         <li>
		                         <div id="newdropdown">
		                   			<div id="after-login"><c:out value="${loginMember.memberName }"/> 님 ▼</div>
								  <div class="newdropdown-content">
									<a class="newdropdown-item" href="${path}/member/logout">로그아웃</a>  
								  </div>
								</div>
								</li>
							</c:if>
                        	<c:if test="${loginMember == null}">
	                        <li>
	                            <a href="${path}/member/login">로그인</a>
	                        </li>
	                        
                        	</c:if>
                    </ul>
                </div>
                
                <div id="second-header">
                    <h2><a href="${path }/"><img src="${path}/resources/images/NBIF.png" width="120px" height="40px"></a></h2>
                    <ul>
                        <li style="width:200px"><a href="${path }/specialauction">SPECIAL AUCTION</a></li>
                        <li style="width:200px"><a href="${path }/auctions">AUCTION ITEMS</a></li>
                        <li style="display: none; width:400px"><form action="${path }/productSearch" method="get"><input type="search" name="keyword" id="search-bar" placeholder=" Search..."></form></li>
                        <li><a href="javascript:search_btn()"><span><img src="${path}/resources/images/search.png" width="30px" height="30px"></span></a></li>
                        <li style="display: none;"><a href="javascript:search_btn_close()"><span><img src="${path}/resources/images/xxx.png" width="20px" height="20px"></span></a></li>
                    </ul>
                </div>
            </div>
            <script>
            	let loginMember = "${loginMember}";
            	let nickName = "${loginMember.nickName}";
				let path = "${path}";
            	const url = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}";
            </script>
            <script src="${path }/resources/js/messageBox.js"></script>
            <button type="button" class="btn btn-purple" id="msgBoxBtn"
									data-bs-toggle="modal" data-bs-target="#msgModal"
									style="display: none;"></button>
			<script>
				const msgBoxBtn=(memberNo)=> {
					msgBox(memberNo);
				}
			</script>
        </header>