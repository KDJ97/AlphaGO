<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




<head>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
<script>
window.onload=function(){
	summernote_go($('#content'),'<%=request.getContextPath()%>');
}
</script>
</head>

<title>질문등록</title>

<body>
   <!-- Content Header (Page header) -->
    <section class="content-header">
    	<div class="container-fluid">
    		<div class="row md-2">
    			<div class="col-sm-6">
	      			<h1>질문게시판</h1>
	      		</div>


	       		<div class="col-sm-6">
			      <ol class="breadcrumb float-sm-right"  style="float:right;">
			        <li class="breadcrumb-item"><a href="list.go"><i class="fa fa-dashboard"></i>질문게시판</a></li>
			        <li class="breadcrumb-item active">질문등록</li>
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
						<div class="col-sm-6" style="float:left;">
							<h4>질문글등록</h4>
						</div>
						<div class="col-sm-6" style="float:right;">
							<div style="float:right;">
								<button type="button" class="btn btn-soft-primary" id="registBtn" onclick="regist_go();">등 록</button>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button type="button" class="btn btn-soft-danger" id="cancelBtn" onclick="GoHistory();">취 소</button>
							</div>
						</div><!--end card-footer  -->
					</div><!--end card-header  -->
					<div class="card-body">
						<form enctype="multipart/form-data" role="form" method="post" action="regist.go" name="registForm">
							<div class="form-group">
								<label for="writer">작성자</label>
								<input type="text" id="writer" readonly
									name="writer" class="form-control" value="${loginUser.id }">
							</div>
							<hr>
							<div class="col-sm-3" style="float:left;">
								<label for="teacher">강사선택</label>
								<select class="form-select" style="width:95%;" name="" id="" onchange="">
									<option value="">강사를 선택하세요</option>
									<option value="강사id">강사명</option>
									<option value="강사id">강사명</option>
									<option value="강사id">강사명</option>
								</select>
							</div>
							<div class="col-sm-6"style="float:left;">
								<label for="teacher">수업선택</label>
								<select class="form-select" style="width:95%;" name="" id="" onchange="">
									<option value="">수업을 선택하세요</option>
									<option value="수업id">수업명</option>
									<option value="수업id">수업명</option>
									<option value="수업id">수업명</option>
								</select>
							</div>
							<div class="col-sm-3 form-group" style="float:right;">
								<label for="teacher">작성일</label>
								<input readonly type="date" class="form-control"style="width:95%;">
							</div>
							<br>
							<div class="form-group">
								<label for="title">제 목</label>
								<input type="text" id="title" name='title' class="form-control" placeholder="제목을 쓰세요">
							</div>
							<div class="form-group">
								<label for="content">내 용</label>
								<textarea class="form-control" name="content" id="content" rows="5"
									placeholder="1000자 내외로 작성하세요."></textarea>
							</div>
							<div class="form-group">
								<div class="card card-outline card-success">
									<div class="card-header">
										<h5 style="display:inline;line-height:40px;">첨부파일 : </h5>
										&nbsp;&nbsp;<button class="btn btn-xs btn-soft-primary"
										onclick="addFile_go();"	type="button" id="addFileBtn">Add File</button>
									</div>
									<div class="card-footer fileInput">
									</div>
								</div>
							</div>
						</form>
					</div><!--end card-body  -->

				</div><!-- end card -->
			</div><!-- end col-md-12 -->
		</div><!-- end row -->
    </section>




<script>
var dataNum = 0;

function addFile_go(){
	//alert("add file btn");

	if($('input[name="uploadFile"]').length>=5){
		alert("파일 추가는 5개까지만 가능합니다.");
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
			return;
		}
	}

	if($("input[name='title']").val()==""){
		alert("제목은 필수입니다.");
		$("input[name='title']").focus();
		return;
	}

	$("form[role='form']").submit();

}

</script>
</body>














