<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script src="https://unpkg.com/gridjs/dist/gridjs.umd.js"></script>
<link href="https://unpkg.com/gridjs/dist/theme/mermaid.min.css" rel="stylesheet" type="text/css">
</head>
<body>
<script type="text/javascript">
function regist_go(){
	OpenWindow('registForm.go','수업 등록',1000,900);
}
function detail_go(tr){
	var classCode = $(tr).find('td:eq(0)').text();
	console.log("classCode : " + classCode);
	OpenWindow('detail.go?classCode='+classCode,'수업 상세', 1000, 900);
}
</script>
<c:set var="classList" value="${dataMap.classList }"/>
<c:set var="pageMaker" value="${dataMap.pageMaker }"/>

	<div class="row">
		<div class="col-lg-12">
			<!-- card 시작 -->
			<div class="card" style="margin-bottom:2px;">
				<!-- card-header 시작 -->
				<div class="card-header">
					<h5 style="font-weight:bold;margin:0;padding:0;"><i class="uil-files-landscapes"></i>&nbsp;&nbsp;&nbsp;수업 관리</h5>
				</div>
				<!-- card-header 끝 -->

				<!-- card-body 시작 -->
				<div class="card-body" style="padding: 0.9rem 0.9rem;padding-bottom: 0;">

					<!-- 검색 및 등록 시작-->
					<!-- 검색 -->
					<div class="row">
						<div class="col-sm-6">
							<button type="button" onclick="regist_go();" class="btn btn-primary" style="margin-left: 3px;">등록</button>
						</div>
						<div class="col-sm-6">
							<div class="col-sm-6 input-group" id="keyword"
								style="float: right; ">
								<!-- keyword -->
									<select class="form-select " style="float: left;width: 20%;"
										aria-label="Default select example" name="searchType"
										id="searchType">
										<option value="nst" ${cri.searchType eq 'nst' ? 'selected':'' }>전체</option>
										<option value="n" ${cri.searchType eq 'n' ? 'selected':'' }>수업명</option>
										<option value="s" ${cri.searchType eq 's' ? 'selected':'' }>과목</option>
									</select>
									<input class="form-control col-sm-6 " type="text" name="keyword"
										placeholder="검색어를 입력하세요." value="${param.keyword }"
										style="width: 40%; "> <span
										class="input-group-append">
										<button class="btn btn-primary" type="button"
											id="searchBtn" style="float: right;"
											data-card-widget="search" onclick="list_go(1);">
											<i class="fa fa-fw fa-search"></i>
										</button>
									</span>
								</div>
							</div>
						</div>
					<!-- 검색 및 등록 끝 -->
				</div>
				<!-- card-body 끝 -->

				<!-- card-body list시작 -->
				<div class="card-body" style="padding: 0.9rem 0.9rem;">
					<!-- table 시작 -->
					<div class="col-md-12">
						<p style="font-size: small;">* 수업 목록을 클릭해 수업 상세 정보를 확인하세요 *</p>
						<table class="table table-hover" style="text-align: center;">
							<thead style="background-color: #038edc; color: white;">
								<tr>
									<th>과목명</th>
									<th>영역</th>
									<th>수업명</th>
									<th>강사명</th>
									<th>수업기간</th>
									<th>수준</th>
									<th>수강생수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="classvo" items="${classList }">
									<tr onclick="detail_go(this);">
										<td style="display:none;">${classvo.classCode }</td>
										<td>${classvo.subjectName }</td>
										<td>${classvo.subdetailName }</td>
										<td style="text-align: left;">${classvo.className }</td>
										<td>${classvo.name }</td>
										<td>${classvo.startDate }~${classvo.endDate }</td>
										<td>${classvo.classRank }</td>
										<td>${classvo.stuCnt}명</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- pagination -->
						<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
					</div>
				</div>
			</div>
			<!-- class detail 시작 -->
			<div class="row">
				<!-- 수업 종료일이 얼마 남지 않은 리스트 -->
				<div class="col-sm-6" style="padding-right: 0;">
					<div class="card">
					<div class="card-header"style="padding:5px;">
						<h6 style="margin: 0;margin-left:5px;"><i class="uil-book-alt"></i> 이번 달 수업종료 예정 목록</h6>
					</div>
						<table class="table table-hover"style="margin:0;">
							<colgroup>
								<col width="15%">
								<col width="70%">
								<col width="15%">
							</colgroup>
							<thead style="background-color: #038edc; color: white;text-align: center;">
								<tr>
									<th style="padding:5px;">영역</th>
									<th style="padding:5px;">수업명</th>
									<th style="padding:5px;">종료일</th>
								</tr>
							</thead>
						</table>
						<div style="max-height:150px;overflow-y:scroll;">
						<table class="table table-hover" style="margin:0;font-size:0.8em;">
							<colgroup>
								<col width="15%">
								<col width="70%">
								<col width="15%">
							</colgroup>
							<tbody id="end-class-target" style="">
							</tbody>
						</table>
						</div>
					</div>
				</div>
				<!-- 수업 시작일이 얼마 남지 않은 리스트 -->
				<div class="col-sm-6" style="padding-right: 0;">
					<div class="card">
					<div class="card-header"style="padding:5px;">
						<h6 style="margin: 0;margin-left:5px;"><i class="uil-book-open"></i> 이번 달 수업시작 예정 목록</h6>
					</div>
						<table class="table table-hover"style="margin:0;">
							<colgroup>
								<col width="15%">
								<col width="70%">
								<col width="15%">
							</colgroup>
							<thead style="background-color: #038edc; color: white;text-align: center;">
								<tr>
									<th style="padding:5px;">영역</th>
									<th style="padding:5px;">수업명</th>
									<th style="padding:5px;">시작일</th>
								</tr>
							</thead>
						</table>
						<div style="max-height:150px;overflow-y:scroll;">
						<table class="table table-hover" style="margin:0;font-size: 0.8em;">
							<colgroup>
								<col width="15%">
								<col width="70%">
								<col width="15%">
							</colgroup>
							<tbody id="start-class-target">
							</tbody>
						</table>
						</div>
					</div>
				</div>
			</div>
			<!-- row2 끝 -->
			
		</div>
	</div>

<head>
	<script type="text/javascript">
	//원생 클릭시 원생 성적 상세정보 페이지 오픈
	function goMemberInfo(id){
		//새로운 Window창을 Open할 경우 사용되는 함수 ( arg : 주소 , 창타이틀 , 가로 , 세로 )
		OpenWindow('<%=request.getContextPath()%>/sscore/detail.go?id='+id, '원생 성적 정보', 700, 500);
	}
	</script>
<script>
	window.onload=function(){
		$.ajax({
			url:"selectClassByEndDate.go",
			method:'get',
			success:function(res){
				if(res.length>0){
					printData(res, $('#end-class-target'),$('#end-class-template'));
				}else if(res.length<1){
					printData(res, $('#end-class-target'),$('#end-none-template'));
				}
			},
			error:function(error){
				alert("error : " + error.status);
			},
			dataType:'json'
		});
		$.ajax({
			url:"selectClassByStartDate.go",
			method:'get',
			success:function(res){
				if(res.length>0){
					printData(res, $('#start-class-target'),$('#start-class-template'));
				}else if(res.length<1){
					printData(res, $('#start-class-target'),$('#start-none-template'));
				}
			},
			error:function(error){
				alert("error : " + error.status);
			},
			dataType:'json'
		});
	}
</script>
	<script type="text/x-handlebars-template"  id="end-class-template" >
	{{#each .}}	
		<tr onclick="detail_go(this);">
			<td style="display:none;">{{classCode}}</td>
			<td style="padding-left: 4%;">{{subdetailName}}</td>
			<td style="text-align:left;">{{className}}</td>
			<td style="padding-left: 6%;">{{endDate}}</td>
		</tr>
	{{/each}}
	</script>
	<script type="text/x-handlebars-template"  id="end-none-template" >
		<tr>
			<td colspan="3" style="text-align:center;">수업 종료 예정 목록이 없습니다</td>
		</tr>
	</script>	
	<script type="text/x-handlebars-template"  id="start-class-template" >
	{{#each .}}	
		<tr onclick="detail_go(this);">
			<td style="display:none;">{{classCode}}</td>
			<td style="padding-left: 4%;">{{subdetailName}}</td>
			<td style="text-align:left;">{{className}}</td>
			<td style="padding-left: 6%;">{{startDate}}</td>
		</tr>
	{{/each}}
	</script>	
	<script type="text/x-handlebars-template"  id="start-none-template" >
		<tr>
			<td colspan="3" style="text-align:center;">수업 시작 예정 목록이 없습니다</td>
		</tr>
	</script>	
</head>
	
</body>












