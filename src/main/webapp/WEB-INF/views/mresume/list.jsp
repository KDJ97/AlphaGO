<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="applyList" value="${dataMap.applyList }" />
<c:set var="cri" value="${pageMaker.cri }" />

<head>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<style>
table th, td {
	text-align: center;
}
</style>
</head>

<body>

	<!-- Content Header (Page header) -->


	<!-- Main content -->

	<div class="card">

		<section class="content-header">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="card-header">
						<h5 style="font-weight: bold;margin:0;padding:0;"><i class="uil-file-info-alt"></i>&nbsp;&nbsp;&nbsp;이력서 조회</h5>
					</div>

					

				</div>
			</div>
		</section>
		<div class="card-header with-border">
			
			<div style="float:left;">
			<button type="button" class="btn btn-primary" id="registBtn"
				onclick="OpenWindow('pdfview.go','이력서 양식',800,800);">이력서 양식</button>
<!-- 				<div  type="button" class="btn btn-warning" onclick="document.getElementById('file').click();">수정</div> -->
				<button class="btn btn-warning" onclick="OpenWindow('modify.go','이력서 수정',500,150);">수정</button>
<!-- 				<form action="upload" id="uploadForm" method="post" enctype="multipart/form-data"> -->
<!-- 			<input type="file" name="file" id="file" style="display:none"/> -->
<!-- 			</form> -->
			</div>
			
			<div id="keyword" class="card-tools"
				style="width:300px; float: right;">
				<div class="input-group">

					<select class="form-control col-md-3" name="perPageNum"
						id="perPageNum" style='display:none;' onchange="list_go(1);">
						<option value="10" ${cri.perPageNum==10 ? 'selected':'' }>정렬개수</option>
						<option value="20" ${cri.perPageNum==20 ? 'selected':'' }>20개씩</option>
						<option value="30" ${cri.perPageNum==30 ? 'selected':'' }>30개씩</option>
						<option value="50" ${cri.perPageNum==50 ? 'selected':'' }>50개씩</option>

					</select> <select class="form-select col-md-3" name="searchType"
						id="searchType">
						<option value="tcw" ${cri.searchType eq 'tcw' ? 'selected':'' }>전
							체</option>
						<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>이름</option>
						<option value="w" ${cri.searchType eq 'w' ? 'selected':'' }>전화번호</option>


					</select> <input class="form-control" type="text" style="width:100px;"
						name="keyword" placeholder="검색어를 입력하세요" value="${cri.keyword }" />
					<span class="input-group-append">
						<button class="btn btn-primary" style="float: right;"
							type="button" id="searchBtn" data-card-widget="search"
							onclick="list_go(1);">
							<i class="fa fa-fw fa-search"></i>
						</button>
					</span>
				</div>
			</div>
		</div>
		<div class="card-body" style="padding:0px;">
			<table class="table table-bordered text-center  table-hover ">
			  <thead>
				<tr style="font-size: 0.95em; background-color:#038edc;color:white;" >
				
					<th style="width: 1%;">이름</th>
					<th style="width:3%;" >제목</th>
					<th style="width: 2%;">전화번호</th>
					<th style="width: 1%;">이력서</th>
					<th style="width: 2%;">문자 보내기</th>


				</tr>
				</thead>
				<%-- <c:forEach items="${pdsList }" var="pds">
						<tr style='font-size:0.85em;'>
							<td>1</td>
							<td id="boardTitle" style="text-align:left;max-width: 100px; overflow: hidden;
										 white-space: nowrap; text-overflow: ellipsis;">
								<a href="javascript:OpenWindow('detail.do?from=list&pno=${pds.pno }','상세보기',800,700);">
									<span class="col-sm-12 ">탄방고 내년 2학기 중간고사</span>
								</a>
							</td>
							<td>
								<c:if test="${!empty pds.attachList }">
									<i class="nav-icon fas fa-file"></i>
								</c:if>
								<c:if test="${empty pds.attachList }">
									<span>-</span>
								</c:if>
							</td>
							<td>김형돈</td>
							<td>${pds.favorite}</td>
							<td>
								<fmt:formatDate value="2022-06-03" pattern="yyyy-MM-dd"/>
							</td>
							<td><span class="badge bg-red">0</span></td>
						</tr>
					</c:forEach>	 --%>
					
						<c:if test="${!empty applyList }">
							<c:forEach items="${applyList }" var="app">
							 
								<tr style='font-size: 0.85em;'>
								    
									<td >${app.applyer }</td>
									<td style="text-align:left;">${app.applyTitle}</td>
									<td>${app.applyerTel.replace('-','-') }</td>
									<td><h5><i class="uil-clipboard-notes" onclick="location.href='getFile.go?applyCode=${app.applyCode}';"></i></h5></td>
									<td><h5><button type="button" class="btn btn-primary"
							data-bs-toggle="modal" style="padding:3px;"data-bs-target="#staticBackdrop">
							Send</button></h5></td>
								</tr>
							</c:forEach>

						</c:if>
						
				<c:if test="${empty applyList }">
						<td colspan='5'>해당학원에 지원한 강사가 없습니다.</td>

				</c:if>

			<%-- 	<tr class="table-white">
					<th><p style="vertical-align: middle;">김형돈</p> <img
						src="<%=request.getContextPath()%>/resources/bootstrap/dist/img/newn.png"
						alt="" width="30px" height="30px"
						style="position: absolute;"></th>
					<th>010-1231-1231</th>
					<th><i class="uil-clipboard-notes"></th>
					<th><button type="button" class="btn btn-soft-primary"
							data-bs-toggle="modal" data-bs-target="#staticBackdrop">
							Send</button></th>


				</tr> --%>
				

			</table>
		</div>
		<div class="card-footer">
			<nav aria-label="pds list Navigation">
				<ul class="pagination justify-content-center m-0">
					<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
				</ul>
			</nav>
		</div>
	</div>






<!-- 모달 -->

<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-primary">
					<h5 class="modal-title"  id="staticBackdropLabel" ><span style="color:white;"><i class="uil-comment-alt-message">메시지</i></span></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">


					<!-- end card header -->
					<div class="card-body">

						<form>

							<div class="col-sm-6">
								<span class="badge bg-primary" style="font-size: 1.2em;">
									받는사람 </span>
							</div>
							<div class="row mb-3">




								<div class="col-sm-4">
									<input type="text" placeholder="010-9647-0026"
										class="form-control" id="horizontal-firstname-input">
								</div>
							</div>
							<!-- end row -->


					
					

							<div class="col sm-6">
								<span class="badge bg-primary"
									style="font-size: 1.2em;">내용</span>

							</div>
							<!-- end row -->
							<textarea class="form-control" placeholder="내용을 입력하세요"
								id="contents" style="height: 100px"></textarea>
							<!-- end row -->
							<button type="button" class="btn btn-primary"
								style="float: right;" onclick="send_message()">Send</button>
							<div class="row justify-content-end">
								<div class="col-sm-9">
									<div class="form-check mb-4"></div>

								</div>
								<!-- end col -->
							</div>
							<!-- end row -->
						</form>
						<!-- end form -->
					</div>
				</div>
			</div>

		</div>




	</div>

<script>
	function send_message() {
			
			
			
			
		var content=$('#contents').val();
		
		
		Swal.fire({
		      icon: 'success',
		      title: '메시지가 전송되었습니다.'
		      
		    }).then((result) => {
			  if (result.value) {
				  $.ajax({
						url : "sendsmssss.go",
						type: "POST",
						async:false,
						contentType : 'application/json',
						data : {
							
							
							
						},
						success : function(data) {
							//alert("메시지가 전송되었습니다.");
							window.location.reload();

						},
						error : function(error) {
							//alert("메시지가 전송되었습니다.");
							window.location.reload();
						},
						dataType : 'json'

					});
					
			  }
			})
		
			
			

		}
	</script>

<script>

$("#modify").click( () => {

$("#file").click();

})
</script>


</body>