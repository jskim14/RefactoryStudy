<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
    section{
       padding:200px 10%;
       min-height:800px;
    }
    #menu-div{display:flex; flex-wrap: wrap; justify-content: space-around; padding-top:30px;}
    .menu-box{
    width:220px; height:300px; justify-content:space-around; border-radius:20px; background:dimgray;
	border:solid 1px none; color:white; font-size:22px; font-weigth:bold;
	box-shadow:0px 0px 10px 2px lightgray;}
	.menu-box:hover{background:yellow;color:black;}
</style>

     <section>
     	<h2 style="text-align:center;"><i class="fas fa-box-check"></i>관리자 메뉴</h2><br><hr>
     	<div id="menu-div">
	 		<button type="button" class="menu-box" onclick="location.assign('${path}/admin/productManage');">
	 			물품 승인<br><br>
	 			<i class="fas fa-check" style="font-size:5rem;"></i>
	 		</button>
	 		<button type="button" class="menu-box" onclick="location.assign('${path}/admin/specialProductEnroll');">
	 			실시간 경매 물품 등록<br><br>
	 			<i class="fas fa-gavel" style="font-size:5rem;"></i>
	 		</button>
	 		<button type="button" class="menu-box" onclick="location.assign('${path}/report/reportList');">
	 			물품 신고 관리<br><br>
	 			<i class="far fa-angry" style="font-size:5rem;"></i>
	 		</button>
	 		<button type="button" class="menu-box" onclick="location.assign('${path}/admin/memberManagement');">
	 			회원관리<br><br>
	 			<i class="fas fa-users" style="font-size:5rem;"></i>
	 		</button>
 		</div>
     </section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>