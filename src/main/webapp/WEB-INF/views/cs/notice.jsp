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
    #cs-title{text-align: center;}
    .accordion_area .btn_toggle{display:block;width:80%;height:30px;padding:0 0px;background:#fff;font-size:16px;text-align:left;line-height:30px;box-sizing:border-box}
	.accordion_area .content_area{display:none;padding:10px;background:#f4f4ff}
	.accordion_area .content_area.act{display:block; width:80%;}
	.page-item.active .page-link {
    z-index: 3;
    color: #fff;
    background-color: #41B979;
    border-color: #41B979;
	}	
	.page-item.active .page-link {
	    z-index: 3;
	    color: #fff;
	    background-color: #41B979;
	    border-color: #41B979;
	}
	
	.page-link:hover {
	    z-index: 2;
	    color: #41B979;
	    background-color: #e9ecef;
	    border-color: #dee2e6;
	}
	
	.page-link {
	    position: relative;
	    display: block;
	    color: #41B979;
	    text-decoration: none;
	    background-color: #fff;
	    border: 1px solid #dee2e6;
	}
</style>

        <section>
            
            <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                <button type="button" id="btn1" class="btn btn-outline-dark" onclick="location.assign('${path }/cs/noticeList');">공지사항</button>
                <button type="button" id="btn2" class="btn btn-outline-dark" onclick="location.assign('${path }/cs/qnaList');">1:1 문의</button>
            </div>
              
            <div id="cs-title">
            	<h2 id="title">공지사항</h2>
            </div>
            <c:if test="${loginMember.memberNo eq '5' }">
            	<div style="float:right;"> 
					<button type="button" class="btn btnColor btn-primary" data-bs-toggle="modal"
						data-bs-target="#staticBackdrop">공지 등록</button>
				<!-- 모달창 -->
					<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
						data-bs-keyboard="false" tabindex="-1"
						aria-labelledby="staticBackdropLabel" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
							<form name="reportForm" action="${path }/cs/insertNotice" method="POST">
								<div class="modal-header">
									<h5 class="modal-title" id="staticBackdropLabel"
										style="color: black;">공지사항 등록</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" style="color: black;">
									<div class="mb-3">
										<label for="exampleFormControlInput1" class="form-label">제목</label>
										<input type="text" class="form-control" name="noticeTitle"
											id="exampleFormControlInput1" placeholder="제목을 작성하세요" required>
									</div>
									<div class="mb-3">
										<label for="exampleFormControlTextarea1" class="form-label">내용</label>
										<textarea class="form-control" id="exampleFormControlTextarea1" name="noticeContent"
											rows="3"></textarea>
									</div>
									<input type="hidden" name="memberNo" value="${loginMember.memberNo }">
								</div>
								
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">닫기</button>
									<button type="submit" class="btn btn-warning">등록</button>
								</div>
								</form>
							</div>
						</div>
					</div>
            	</div>
            		<br>
            </c:if>
            <br>
            
            <table class="table table-hover">
            	<thead id="thead">
            		 <tr>
	            		<th style="text-align:center; width:100px; font-weight: bold;" class="table-dark">#</th>
	            		<th style="min-width:200px; font-weight: bold;" class="table-dark">제목</th>
	            		<th style="text-align:center; min-width:130px; font-weight: bold;" class="table-dark">작성일</th>
	            		<c:if test="${loginMember.memberNo eq '5' }">
	            			<th style="font-weight: bold;" class="table-dark">삭제</th>
	            		</c:if>
            		</tr> 
            	</thead>
            	
            	<tbody id="cslist">
            	<c:forEach items="${noticeList }" var="n">
            		<tr>
            			<td style="text-align:center; width:100px;"><c:out value="${n.noticeNo}"/></td>
            			<td>
            				<span class="title" style="cursor: pointer; font-weight: bold;"><c:out value="${n.noticeTitle }"/></span>
            			</td>
            			<td style="text-align:center; width:250px;"><c:out value="${n.noticeWriteDate}"/></td>
            			<c:if test="${loginMember.memberNo eq '5' }">
            			<td style="width:100px;">

            			</td>
	            		</c:if>
            			
            		</tr>
            		<tr class="content" style="display:none; width:100%;">
            			<td style="text-align:center; width:100px;"></td>
            			<td style="max-width:500px;"><c:out value="${n.noticeContent }"/></td>
            			<td style="text-align:center; width:250px;"></td>
            			<c:if test="${loginMember.memberNo eq '5' }">
            			<td>
            			            			<button type="button" class="btn btn-outline-danger" style="height:30px;width:50px;padding:0; "
            				  id="delete">삭제</button>
            			</td>
            			</c:if>
            		</tr>
            	</c:forEach>
            		
            	</tbody>
            </table>
            
             <div style="margin-top:100px;">
            	${pageBar }
            </div>
            
        </section>
        <script>
        	$("#btn1").addClass("active");
        	
        	$("#delete").click(function(){
        		if(confirm("정말 삭제하시겠습니까? ")){
        			location.assign('${path}/cs/deleteNotice?noticeNo=${n.noticeNo}');
        		}
        	});
        	
          	$(".title").click(e=> {
          		$(".content").hide();
          		$("td").css({"backgroundColor":"white","color":"black"});
        		let tr = $(e.target).parents("tr").next("tr");
        		$(e.target).parents("tr").children().css({"backgroundColor":"#778899","color":"white"});
        		tr.show();
        	});
        </script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>