<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="teacherattendList" value="${dataMap.teacherattendList }" />
<c:set var="cri" value="${pageMaker.cri }" />

<head>
<style>
table th, td {
	text-align: center;
}
</style>
<script
	src="<%=request.getContextPath()%>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/sm_chart.js"></script>

</head>
<script>


</script>


<body>

	<!-- Content Header (Page header) -->


	<!-- Main content -->

	<div class="row">
		<div class="card">

			<section class="content-header" style="padding: 0px;">
				<div class="container-fluid" style="padding: 0px;">
					<div class="row mb-2">
						<div class="card-header">
							<h5 style="margin:0;padding:0; font-weight:bold;"><i class="uil-clock"></i>&nbsp;&nbsp;&nbsp;강사 출결 조회</h5>
						</div>



					</div>
				</div>
			</section>
			<div class="card-header with-border">
				<span class="badge bg-primary" style="font-size: 1.2em;">오늘의 출결상태</span>

				<div id="keyword" class="card-tools"
					style="width: 300px; float: right;">
					<div class="input-group">

						<select class="form-control col-md-3" name="perPageNum"
							id="perPageNum" style='display: none;' onchange="list_go(1);">
							<option value="5" ${cri.perPageNum==5 ? 'selected':'' }>정렬개수</option>
							<option value="10" ${cri.perPageNum==10 ? 'selected':'' }>10개씩</option>
							<option value="30" ${cri.perPageNum==30 ? 'selected':'' }>30개씩</option>
							<option value="50" ${cri.perPageNum==50 ? 'selected':'' }>50개씩</option>

						</select> <select class="form-select col-md-3" name="searchType"
							id="searchType">
							<option value="tcw" ${cri.searchType eq 'tcw' ? 'selected':'' }>전체</option>
							<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>이름</option>
							<option value="w" ${cri.searchType eq 'w' ? 'selected':'' }>전화번호</option>


						</select> <input class="form-control" type="text" style="width: 100px;"
							name="keyword" placeholder="검색어를 입력하세요." value="${cri.keyword }" />
						<span class="input-group-append">
							<button class="btn btn-primary" style="float: right;"
								type="button" id="searchBtn" data-card-widget="search4"
								onclick="list_go(1);">
								<i class="fa fa-fw fa-search"></i>
							</button>
						</span>
					</div>
				</div>
			</div>
			<div class="card-body" style="padding: 0px;">
				<table class="table table-bordered text-center  table-hover ">

					<thead>
						<tr
							style="font-size: 0.95em; background-color: #038edc; color: white;">
							<th style="width: 3%;">이름</th>
							<th style="width: 3%;">전화번호</th>
							<th style="width: 3%;">출근시간</th>
							<th style="width: 3%;">퇴근시간</th>
							<th style="width: 3%;">출결상태</th>

						</tr>
					</thead>
					<c:if test="${!empty teacherattendList }">
						<c:forEach items="${teacherattendList }" var="teaa">

							<tr style='font-size: 0.85em;' onclick="OpenWindow('detail.go?id=${teaa.id}','상세출력',1000,1000);">
							<td style="display:none;"><input type="hidden" name="id" value="${teaa.id }" ></td>
								<td>${teaa.name }</td>
								<td>${teaa.phone }</td>
								<td>${teaa.attendTime}</td>
								<td>${teaa.outTimes}</td>
								<c:if test="${teaa.attendanceStatus eq 1 }">
										
									<td>
									<h5><span class="badge bg-primary">출근</span></h5>
									</td>
								</c:if>

								<c:if test="${teaa.attendanceStatus eq 2 }">
									
												<td>
									<h5><span class="badge bg-danger">결근</span></h5>
									</td>
									
								</c:if>
								<c:if test="${teaa.attendanceStatus eq 3 }">
												<td>
									<h5><span class="badge bg-warning">지각</span></h5>
									</td>
									
								</c:if>
								<c:if test="${teaa.attendanceStatus eq 4 }">
									<td>
										<h5><span class="badge bg-purple">외출</span></h5>
									</td>
								</c:if>
								<c:if test="${teaa.attendanceStatus eq 5 }">
									<td>
										<h5><span class="badge bg-dark">조퇴</span></h5>
									</td>
								</c:if>

							</tr>
						</c:forEach>

					</c:if>

				<c:if test="${empty teacherattendList }">
						<td colspan='6'>오늘의 강사 출결 리스트가 없습니다.</td>

				</c:if>

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

		

<!-- <!-- <script> --> 
	
<!-- // 	function attenddetail_go(teat){ -->
		
<!-- // 		var id=teat.children[0].children[0].value; -->
<!-- // 		console.log(id); -->
		
<!-- // 		var intime=$('.intime'); -->
<!-- // 		intime.empty(); -->
<!-- // 		var outtime=$('.outtime'); -->
<!-- // 		outtime.empty(); -->
<!-- // 		var attendanceStatus=$('.attendanceStatus'); -->
<!-- // 		attendanceStatus.empty(); -->
<!-- // 		var regdate=$('.regdate'); -->
<!-- // 		regdate.empty(); -->
		
		
<!-- // 		$.ajax({ -->
		
<!-- // 			url:"detail.go", -->
<!-- // 			type:"POST", -->
<!-- // 			data:{ -->
				
<!-- // 				"id":id -->
<!-- // 			}, -->
<!-- // 			success:function(data){ -->
				
<!-- // 				intime.html(data.inTime); -->
<!-- // 				outtime.html(data.outTime); -->
<!-- // 				attendanceStatus.html(data.attendanceStatus); -->
<!-- // 				regdate.html(regdate); -->
				
				
<!-- // 			}, -->
<!-- // 			error:function(){ -->
<!-- // 			alert("에러"); -->
<!-- // 		}, -->
<!-- // 		dataType:"json" -->
			
			
<!-- // 		}); -->
		
		
		
<!-- // 	} -->
	
	
<!-- 	</script> -->



		<!-- Main content -->
</body>