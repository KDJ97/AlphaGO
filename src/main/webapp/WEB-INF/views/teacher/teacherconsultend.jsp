<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="pdsList" value="${dataMap.pdsList }" />
<c:set var="cri" value="${pageMaker.cri }" />

<head>
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
					<div class="col-sm-6">
						<h1 style="margin-top: 20px;">상담 일지</h1>
					</div>

					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right"
							style="float: right; margin-top: 20px;">
							<li class="breadcrumb-item"><a href="studentlist.go"><i
									class="fa fa-dashboard"></i>원생 관리</a></li>
							<li class="breadcrumb-item active">상담 일지</li>
						</ol>
					</div>

				</div>
			</div>
		</section>
		<div class="card-header with-border">
              	  <span class="badge" style="font-size:1.2em;background:#8BDDA8;">상담 완료 내역</span>
			<div id="keyword" class="card-tools"
				style="width: 450px; float: right;">
				<div class="input-group">

					<select class="form-control col-md-3" name="perPageNum"
						id="perPageNum">
						<option value="10" ${cri.perPageNum==10 ? 'selected':'' }>정렬개수</option>
						<option value="20" ${cri.perPageNum==20 ? 'selected':'' }>20개씩</option>
						<option value="30" ${cri.perPageNum==30 ? 'selected':'' }>30개씩</option>
						<option value="50" ${cri.perPageNum==50 ? 'selected':'' }>50개씩</option>

					</select> <select class="form-control col-md-3" name="searchType"
						id="searchType">
						<option value="tcw" ${cri.searchType eq 'tcw' ? 'selected':'' }>전
							체</option>
						<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>구분</option>
						<option value="w" ${cri.searchType eq 'w' ? 'selected':'' }>신청자</option>
						<option value="c" ${cri.searchType eq 'c' ? 'selected':'' }>상담일</option>


					</select> <input class="form-control" type="text" style="width: 130px;"
						name="keyword" placeholder="검색어를 입력하세요." value="${cri.keyword }" />
					<span class="input-group-append">
						<button class="btn btn-soft-success" style="float: right;"
							type="button" id="searchBtn" data-card-widget="search"
							onclick="list_go(1);">
							<i class="fa fa-fw fa-search"></i>
						</button>
					</span>
				</div>
			</div>
		</div>
		<div class="card-body">
			<table class="table table-bordered text-center  table-hover ">
			  <thead>
				<tr style="font-size: 0.95em; background-color:#8BDDA8;color:white;">
					<th style="width: 5%;">NO</th>
					<th style="width: 10%;">상담일</th>
					<th style="width: 5%;">상담 구분</th>
					<th style="width: 8%;">신청자</th>
					<th style="width: 8%;">상담 신청자</th>
					<th style="width: 8%;">일지 작성 여부</th>

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

				<tr class="table-white">
					<th>1</th>
					<th>2022-02-04</th>
					<th>수업</th>
					<th>김형돈</th>
					<th>부모님</th>
					<th><button type="button" class="btn btn-soft-danger">미완료</button></th>


				</tr>
				<tr class="table-white">
					<th>2</th>
					<th>2022-02-04</th>
					<th>진로</th>
					<th>이수민</th>
					<th>부모님</th>
					<th><button type="button" class="btn btn-soft-primary">완료</button></th>

				</tr>
				<tr class="table-white">
					<th>3</th>
					<th>2022-02-04</th>
					<th>진로</th>
					<th>강동주</th>
					<th>부모님</th>
					<th><button type="button" class="btn btn-soft-primary">완료</button></th>

				</tr>

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




	<!-- Main content -->

	<div class="card">
		<div class="card-header with-border">
				  <span class="badge badge-soft-primary" style="font-size:1.2em;">상담 신청 상세 내용</span>

			<button type="button" class="btn btn-success" style="float: right;"
				id="deleteBtn" onclick="">저장</button>


			<div id="keyword" class="card-tools"
				style="width: 450px; float: right;">
				<div class="input-group"></div>
			</div>
		</div>
		<div class="card-body">
			<table class="table table-bordered text-center   ">

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

				<tr class="table-white">
					<th style="width: 10%; font-size: 0.7em; background-color:#8BDDA8;color:white;" >상담구분</th>
					<th style="width: 13%;">진로</th>
					<th style="width: 10%; font-size: 0.7em; background-color:#8BDDA8;color:white;" >신청일</th>
					<th style="width: 13%;"><input type="date" value=""></th>
					<th style="width: 10%; font-size: 0.7em; background-color:#8BDDA8;color:white;" >신청시간</th>
					<th colspan='3'>12:00</th>





				</tr>
				<tr class="table-white">

					<th class="table-primary" style="font-size: 0.7em; background-color:#8BDDA8;color:white;">신청자</th>
					<th>김형돈</th>
					<th class="table-primary" style="font-size: 0.7em; background-color:#8BDDA8;color:white;">연락처</th>
					<th>010-2132-2312</th>
					<th class="table-primary" style="font-size: 0.7em; background-color:#8BDDA8;color:white;">신청 대상자</th>
					<th>부모님</th>
					<th class="table-primary" style="font-size: 0.7em; background-color:#8BDDA8;color:white;">연락처</th>
					<th>010-2312-3213</th>



				</tr>
				<tr class="table-white">
					<th class="table-primary" style="font-size: 0.7em; background-color:#8BDDA8;color:white; ">학교</th>
					<th>대덕고</th>
					<th class="table-primary" style="font-size: 0.7em; background-color:#8BDDA8;color:white;">학년</th>
					<th>고3</th>
					<th class="table-primary" style="font-size: 0.7em; background-color:#8BDDA8;color:white;" rowspan='2'>후속조치</th>
					<th colspan='3' rowspan='2'><textarea class="form-control"
							placeholder="내용을 입력하세요" id="floatingTextarea2"
							style="height: 80px"></textarea></th>


				</tr>

				<tr class="table-white">
					<th class="table-primary" style="font-size: 0.7em; background-color:#8BDDA8;color:white;">상담내용</th>
					<th colspan='3'><textarea class="form-control"
							placeholder="내용을 입력하세요" id="floatingTextarea2"
							style="height: 40px"></textarea></th>









				</tr>





			</table>
		</div>

	</div>


	<c:if test="${from eq 'regist' }">
		<script>
			alert("등록되었습니다.");
			window.close();
			window.opener.location.reload();
		</script>
	</c:if>


</body>