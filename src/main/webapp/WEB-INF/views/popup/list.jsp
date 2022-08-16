<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/dist/js/adminlte.min.js"></script>
<!-- common -->
<script src="<%=request.getContextPath()%>/resources/js/common.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/popup.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>

<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">
<script>
window.onload=function(){
   summernote_go($('#content'),'<%=request.getContextPath()%>');
	}
</script>

<style>
h5{
	padding-bottom: 10px;
	padding-left: 10px;
}
table tr:hover{
		background-color: #dcdcdc;
	}
</style>

</head>
<body>
<c:set var="popupList" value="${dataMap.popupList }"/>
<c:set var="pageMaker" value="${dataMap.pageMaker }"/>
	<div class="row">
			<div>
				<div class="card-header" style="">
				<h5 style="font-weight:bold;padding:0;margin:0;"><i class="uil-notebooks"></i>&nbsp;&nbsp;&nbsp;홍보관리</h5>
				</div>
			</div>
	</div>
		<!-- Main content -->
		<div class="row" style="margin-top:10px;">
			<div class="col-md-6">
				<h5 style="font-weight: bold;">팝업 목록</h5>

			<div class="card" style="margin-left: 5px;">
				<div class="row" style="margin-bottom: 5px;">
					<div class="col-sm-12 input-group" style="">
						<select class="form-select"
							aria-label="Default select example" name="searchType"
							id="searchType">
							<option value="tc" ${param.searchType eq 'tc' ? 'selected':'' }>전체</option>
							<option value="t" ${param.searchType eq 't' ? 'selected':'' }>제목</option>
							<option value="c" ${param.searchType eq 'c' ? 'selected':'' }>내용</option>
						</select>
						<!-- keyword -->
						<input class="form-control" type="text" name="keyword"
							placeholder="검색어를 입력하세요." value="${param.keyword }"
							>
						<button class="btn btn-primary" type="button" id="searchBtn"
							 data-card-widget="search" onclick="list_go(1);">
							<i class="fa fa-fw fa-search"></i>
						</button>
					</div>
				</div>
				<table class="table" style="text-align: center; font-size: small;">
					<tr style="background-color: #038edc; color: white;">
						<th>제목</th>
						<th>등록일</th>
						<th>사용기간</th>
						<th>파일</th>
						<th>사용</th>
					</tr>
					<c:forEach var="popup" items="${popupList }">
						<fmt:formatDate var="regdate" value="${popup.regdate }" pattern="yyyy-MM-dd"/>
						<fmt:formatDate var="startDate" value="${popup.startDate }" pattern="yyyy-MM-dd"/>
						<fmt:formatDate var="endDate" value="${popup.endDate }" pattern="yyyy-MM-dd"/>
						<tr onclick="popupDetail(this);">
							<td style="display:none;">${popup.popcode }</td>
							<td>${popup.title }</td>
							<td>${regdate }</td>
							<td>${startDate }<br>~${endDate }</td>
							<td>
								<c:if test="${popup.popcount > 0 }">
								<i class="uil-file-download fa-lg"> </i>
								</c:if>
								<c:if test="${popup.popcount <= 0 }">
								-
								</c:if>
							</td>
							<td
								style="display: flex; align-items: center; justify-content: center;">
							<c:if test="${popup.inuse eq 'Y'}">
								<button type="button" id="" class="btn btn-primary"
									style="width: 20px; height: 20px; font-size: small; display: flex; align-items: center; justify-content: center;">
									${popup.inuse }
								</button>
							</c:if>
							<c:if test="${popup.inuse eq 'N'}">
								<button type="button" id="" class="btn btn-danger"
									style="width: 20px; height: 20px; font-size: small; display: flex; align-items: center; justify-content: center;">
									${popup.inuse }
								</button>
							</c:if>
							</td>
						</tr>
					</c:forEach>
				</table>
				<!-- pagination -->
				<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
			</div>
		</div>

			<div class="col-sm-1"
				style="display: flex; justify-content: center; align-items: center;">
				<i style="font-size: 50px;" class="uil-angle-double-right"></i>
			</div>
			
			<div class="col-md-5">
				<h5 style="font-weight: bold;">팝업 등록</h5>
				<!-- form start -->
				<div class="card" id="popupForm" style="margin-right:5px;">
					<div class="card-body" style="padding: 10px;">
					<!-- 팝업 폼 시작 -->
						<form role="form" enctype="multipart/form-data" class="form-horizontal" method="post">
						<div class="card-header" style="padding: 2px;">
							<div class="row">
								<div class="col-sm-9"></div>
								<div class="col-sm-3" style="padding-left:30px;">
									<button type="button" id="registBtn" onclick="regist_go();"
										class="btn btn-primary">등&nbsp;록</button>
								</div>

							</div>
						</div>
						<div class="form-group row" style="display: inherit;">
							<label class="form-check-label" for="formCheck2">
							<span style="color: red; font-weight: bold;">*</span>사용체크</label> 
							<input class="form-check-input inuse" id="inuse" type="checkbox">
							<input type="hidden" name="inuse" value="">
						</div>
						<div class="form-group row">
								<label for="title" class="col-sm-2" style="font-size: em;">
									<span style="color: red; font-weight: bold;">*</span>제목
								</label>
								<div class="col-sm-10 input-group-sm">
									<input name="title" onkeyup="" type="text" class="form-control"
										id="title" placeholder="제목을 입력하세요.">
								</div>
							</div>

							<div class="form-group row">
								
								<div class="col-sm-12">
									<div class="form-group">
										<label>
										<span style="color: red; font-weight: bold;">*</span>
										내용</label>
										<textarea class="form-control" id="content" name="content" rows="2"></textarea>
									</div>
								</div>
							</div>
						
							<div class="form-group row">
								<label for="date" class="col-sm-3" style="font-size:;">
								<span style="color: red; font-weight: bold;">*</span>
									시작일</label>
								<div class="col-sm-9 input-group-sm">
									<input name="startDate" type="date" class="form-control" id="startDate"
										placeholder="">
								</div>
							</div>
							
							<div class="form-group row">
								<label for="date" class="col-sm-3" style="font-size:;">
								<span style="color: red; font-weight: bold;">*</span>
									마감일</label>
								<div class="col-sm-9 input-group-sm">
									<input name="endDate" type="date" class="form-control" id="endDate"
										placeholder="">
								</div>
							</div>

							<div class="form-group">								
								<div class="card card-outline card-success">
									<div class="card-header" style="padding: 0; padding-left: 10px;">
										<h6 style="display:inline;line-height:40px;">첨부파일 : </h6>
										&nbsp;&nbsp;<button class="btn btn-xs btn-primary"
										onclick="addFile_go();"	type="button" id="addFileBtn">Add File</button>
									</div>									
									<div class="card-footer fileInput">
									</div>
								</div>
							</div>

						</form>
						<!-- 팝업 폼 마무리 -->
					</div>
					<!-- register-card-body -->
				</div>
			</div>

		</div>
		
<head>
<script>
<c:if test="${from eq 'regist' }">
	alert("정상 등록되었습니다.");
	window.location.reload();
</c:if>
</script>

<script>
<c:if test="${from eq 'modify' }">
	alert("정상 수정되었습니다.");
	window.location.reload();
</c:if>
</script>

<script>
<c:if test="${from eq 'remove' }">
	alert("정상 삭제되었습니다.");
	window.location.reload();
</c:if>
</script>

<script>
//파일 상세정보 가져오기(비동기)
function popupDetail(tr){
	//팝업코드
	var popcode = $(tr).find('td:eq(0)').text();
	var str="";
	//상세보기 요청
	$.ajax({
		url:"detail.go",
		data:{"popcode":popcode},
		success:function(res){
			//핸들바스로 데이터 뿌려주기
//			alert(res);
			printData(res,$('#popupForm'),$('#popup-detail-template'));
			summernote_go($('#content'),'<%=request.getContextPath()%>');
		},
		error:function(error){
			alert("error : " + error.status);
		},
		dataType:"json"
	});
}
</script>

<script>
//핸들바스에서 if문 함수 사용을 위해 registerHelper함수 선언
Handlebars.registerHelper('ifUse', function(inuse) {
		if (inuse == "Y") {
			return "checked";
		}
	});
</script>

<!-- 팝업 상세 템플릿 -->
<script type="text/x-handlebars-template"  id="popup-detail-template" >
<div class="card-body" style="padding: 10px;">
	<form enctype="multipart/form-data" role="form" method="post"
		action="" name="modifyForm">
	<div class="card-header" style="padding: 2px;">
		<div class="row">
			<div class="col-sm-6"></div>
				<div class="col-sm-6" style="">
				<button type="button" id="reset" onclick="resetForm();"
						class="btn btn-dark"><i class="uil-redo"></i></button>
				<button type="button" id="registBtn" onclick="modify_go();"
						class="btn btn-warning">수&nbsp;정</button>
				<button type="button" id="cancelBtn" onclick="remove_go();"
						class="btn btn-danger">삭&nbsp;제</button>
				</div>
			</div>
		</div>
		<input type="hidden" name="popcode" value="{{popcode}}" />

		<div class="form-group row" style="display: inherit;">
			<label class="form-check-label" for="formCheck2">
			<span style="color: red; font-weight: bold;">*</span>사용체크</label> 
			<input class="form-check-input inuse" id="inuse" type="checkbox" {{ifUse inuse}}>
			<input type="hidden" name="inuse" value="">
		</div>
		<div class="form-group row">
			<label for="title" class="col-sm-2" style="font-size: em;"> <span
				style="color: red; font-weight: bold;">*</span>제목
			</label>
			<div class="col-sm-10 input-group-sm">
				<input name="title" type="text" class="form-control"
					id="title" placeholder="제목을 입력하세요." value="{{title}}">
			</div>
		</div>
		<div class="form-group row">

			<div class="col-sm-12">
				<div class="form-group">
					<label> <span style="color: red; font-weight: bold;">*</span>
						내용
					</label>
					<textarea class="form-control" id="content" name="content" rows="2">{{content}}</textarea>
				</div>
			</div>
		</div>

		<div class="form-group row">
			<label for="date" class="col-sm-3" style="font-size:;"> <span
				style="color: red; font-weight: bold;">*</span> 시작일
			</label>
			<div class="col-sm-9 input-group-sm">
				<input name="startDate" type="date" class="form-control"
					id="startDate" value="{{startDate}}">
			</div>
		</div>

		<div class="form-group row">
			<label for="date" class="col-sm-3" style="font-size:;"> <span
				style="color: red; font-weight: bold;">*</span> 마감일
			</label>
			<div class="col-sm-9 input-group-sm">
				<input name="endDate" type="date" class="form-control" id="endDate"
					value="{{endDate}}">
			</div>
		</div>

		<div class="form-group" style="margin:0;">
			<div class="card card-outline card-success">
				<div class="card-header" style="padding: 0; padding-left: 10px;">
					<h6 style="display: inline; line-height: 40px;">첨부파일 :</h6>
					&nbsp;&nbsp;
					<button class="btn btn-xs btn-primary" onclick="addFile_go()"
						type="button" id="addFileBtn">Add File</button>
				</div>
				<div class="card-footer fileInput" style="padding:2px;">
					<ul class="mailbox-attachments d-flex align-items-stretch clearfix" style="margin: auto;margin-left: 5px;">

						{{#each attachList}}
							<li class="attach-item thumb{{attachno }}" style="margin: 0;"
								file-name="{{filename }}" target-ano="{{attachno }}">
								<div class="mailbox-attachment-info " style="padding:0;margin: auto;">
									<a class="mailbox-attachment-name" name="attachedFile"
										attach-fileName="{{filename }}" 
										attach-no="{{attachno }}"
										href="<%=request.getContextPath()%>/popup/getFile.go?attachno={{attachno }}">
										<i class="fas fa-paperclip"></i> {{filename }}&nbsp;&nbsp;
										<button type="button"
											onclick="removeFile_go('thumb{{attachno}}');return false;"
											style="border: 0; outline: 0;" class="badge bg-red">X</button>
									</a>
								</div>
							</li>
						{{/each}}
					</ul>
					<br />
				</div>
			</div>
		</div>
	</form>
</div>
<!--end card-body  -->
</script>
<script
	src="<%=request.getContextPath()%>/resources/assets/js/pages/sweet-alerts.init.js"></script>
</head>
</body>












