<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<head>
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
	 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>

<title>공지사항</title>

<body>
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6"></div>


				<div class="col-sm-6">
					<ol class="breadcrumb float-sm-right" style="float: right;">

					</ol>
				</div>
			</div>
		</div>
	</section>

	<section class="content container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card card-outline card-info">
					<div class="card-header">
						<div class="d-flex">
							<div class="me-auto">
								<h4>글등록</h4>
							</div>
							<div>
								<button type="button" class="btn btn-soft-danger"
									style="float: right; margin-right: 10px;" id="cancelBtn"
									onclick="CloseWindow();">취 소</button>
							</div>
							<div>
								<button type="button" style="float: right;"
									class="btn btn-soft-primary" id="registBtn"
									onclick="regist_go();">등 록</button>
							</div>
						</div>

					</div>
					<!--end card-header  -->
					<div class="card-body">
						<form enctype="multipart/form-data" role="form" method="post"
							action="regist.go" name="registForm">

							<div class="form-group">
								<div class="mb-3">
									<label for="writer">작성자</label> <input type="text" id="writer"
										name='writer' readonly class="form-control" value="${loginUser.id }">
								</div>
								<div>
									<select id="category" name="category"
										style="width: 80px; height: 36px; float: left;">
										<option value="수업">수업</option>
										<option value="학원">학원</option>
										<option value="입시">입시</option>
										<option value="기타">기타</option>
									</select>
								</div>
								<div>
									<input type="text" id="title" name='title' class="form-control"
										placeholder="제목을 쓰세요" style="width: 85%;">
								</div>


							</div>
							<br>
							<div class="row">

							<c:if test="${cnt lt 1}">	
								<div class="col-mb-6" style="margin-bottom: 10px;">
									<input type="checkbox" id="top" name="fixed" value="">상단고정

								</div>
							</c:if>
								<div class="col-md-4"></div>
								<div class="col-md-2"></div>
							</div>

							<div class="form-group">

								<textarea class="form-control" name="content" id="content"
									rows="5" placeholder="내용을 작성하세요."></textarea>
							</div>
							<div class="form-group">
								<div class="card card-outline card-success">
									<div class="card-header">
										<h5 style="display: inline; line-height: 40px;">첨부파일 :</h5>
										&nbsp;&nbsp;
										<button class="btn btn-xs btn-primary" onclick="addFile_go();"
											type="button" id="addFileBtn">Add File</button>
									</div>
									<div class="card-footer fileInput"></div>

								</div>
							</div>
						</form>
					</div>

				</div>
				<!--end card-body  -->

			</div>
			<!-- end card -->
		</div>
		<!-- end col-md-12 -->

		<!-- end row -->
	</section>


	<script>
	window.onload=function(){
		summernote_go($('#content'),'<%=request.getContextPath()%>');		
	}	
	
</script>

	<script>
	var dataNum=0;
	
function addFile_go(){
// 	alert('add file btn');

	if($('input[name="uploadFile"]').length >= 5){
		alert("파일추가는 5개까지만 가능합니다.");
		return;
	}

	var div=$('<div>').addClass("inputRow").attr("data-no",dataNum);
	var input=$('<input>').attr({"type":"file","name":"uploadFile"}).css("display","inline");
	div.append(input).append("<button onclick='remove_go("+dataNum+");' style='border:0;outline:0;' class='badge bg-red' type='button'>X</button>");

	$('.fileInput').append(div);
	
	dataNum++;
	
}

function remove_go(dataNum){
// 	alert(dataNum);
	$('div[data-no="'+dataNum+'"]').remove();
}

function regist_go(){
	
	var files = $('input[name="uploadFile"]');
	for(var file of files){
		console.log(file.name+" : "+file.value);
		if(file.value==""){
			alert("파일을 선택하세요.");
			file.focus();
			file.click();
			return
		}
	}
	
	if($("input[name='title']").val()==""){ // form.title.value
		alert("제목은 필수입니다.");
		$("input[name='title']").focus();
		return;
	}
	
	if ($('#top').is(':checked')) {
		$('#top').attr('value',1);
				//alert($('#top').val());
		} else {
		$('#top').attr('value',0);
	}
	
	
	Swal.fire({
	      icon: 'success',
	      title: '등록되었습니다.'
	      
	    }).then((result) => {
  	
  	  
	$("form[role='form']").submit()
	    	  

 		})
	
}
</script>