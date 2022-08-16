<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
window.onload=function(){
	summernote_go($('#content'),'<%=request.getContextPath()%>');
}
</script>

<script type="text/javascript">
function remove_go(dataNum){
	//alert(dataNum);
	$('div[data-no="' + dataNum + '"]').remove();
}

function removeFile_go(className){
	//alert("X btn");
	var li = $('li.'+className);

	if(!confirm(li.attr("file-name")+"을 정말 삭제하시겠습니까?")){
		return;
	}

	li.remove();

	var input=$('<input>').attr({"type":"hidden",
		 "name":"deleteFile",
		 "value":li.attr("target-ano")
		});
	$('form[role="form"]').prepend(input);
	
	
}

var dataNum=0;

function addFile_go(){
	//alert("add file btn");

	var attachedFile=$('a[name="attachedFile"]').length; //기존파일
	var inputFile=$('input[name="uploadFile"]').length;	 //추가된 파일
	var attachCount=attachedFile+inputFile; //기존파일 + 추가된파일 개수

	if(attachCount >=5){
		alert("파일추가는 5개까지만 가능합니다.");
		return;
	}

	var div=$('<div>').addClass("inputRow").attr("data-no",dataNum);
	var input=$('<input>').attr({"type":"file","name":"uploadFile"}).css("display","inline");
	div.append(input).append("<button onclick='remove_go("+dataNum+");' style='border:0;outline:0;' class='badge bg-red' type='button'>X</button>");

	$('.fileInput').append(div);

	dataNum++;
}

//submit =============================================
function modify_submit(){
	//alert("modify btn click");
	var form = $('form[name="modifyForm"]');

	//유효성 체크
	if($("input[name='title']").val()==""){
		alert(input.name+"은 필수입니다.");
		$("input[name='title']").focus();
		return;
	}

	//파일 첨부확인
	var files = $('input[name="uploadFile"]');
	for(var file of files){
		console.log(file.name+" : "+file.value);
		if(file.value==""){
			alert("파일을 선택하세요.");
			file.focus();
			return false;
		}
	}

	if ($('#top').is(':checked')) {
		$('#top').attr('value',1);
				//alert($('#top').val());
		} else {
		$('#top').attr('value',0);
	}

	Swal.fire({
	      icon: 'success',
	      title: '수정 되었습니다.'
	      
	    }).then((result) => {
	
	  
	    	form.submit();

		})
	
}
</script>
</head>


<title>공지사항 수정페이지</title>

<body>
<body>
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6"></div>


				<div class="col-sm-6"></div>
			</div>
		</div>
	</section>

	<!-- Main content -->
	<section class="content container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card card-outline card-primary">
					<div class="card-header">
						<div class="d-flex">
							<div class="me-auto">
								<h4>공지사항 수정</h4>
							</div>
							<div>
								<button type="button" class="btn btn-soft-danger"
									style="float: right; margin-right: 10px;" id="cancelBtn"
									onclick="CloseWindow();">취 소</button>
							</div>
							<div>
								<button type="button" class="btn btn-warning" id="modifyBtn"
									onclick="modify_submit();">수 정</button>
							</div>
						</div>
					</div>
					<!--end card-header  -->
					<div class="card-body">
						<form enctype="multipart/form-data" role="form" method="post"
							action="modify.go" name="modifyForm">
							<input type="hidden" name="lCode" value="${notice.lcode }" />

							<div class="form-group">
								<label for="writer">작성자</label> <input type="text" id="writer"
									readonly name="writer" class="form-control"
									value="${notice.writer }">
							</div>
							<div class="form-group mt-3 mb-3">
								<span>제목</span><br>

								<c:if test="${notice.category eq '수업' }">
									<select id="category" name="category"
										style="width: 80px; height: 36px; float: left;">
										<option value="수업" selected>수업</option>
										<option value="학원">학원</option>
										<option value="입시">입시</option>
										<option value="기타">기타</option>
									</select>
								</c:if>
								<c:if test="${notice.category eq '학원' }">
									<select id="category" name="category"
										style="width: 80px; height: 36px; float: left;">
										<option value="수업">수업</option>
										<option value="학원" selected>학원</option>
										<option value="입시">입시</option>
										<option value="기타">기타</option>
									</select>
								</c:if>
								<c:if test="${notice.category eq '입시' }">
									<select id="category" name="category"
										style="width: 80px; height: 36px; float: left;">
										<option value="수업">수업</option>
										<option value="학원">학원</option>
										<option value="입시" selected>입시</option>
										<option value="기타">기타</option>
									</select>
								</c:if>
								<c:if test="${notice.category eq '기타' }">
									<select id="category" name="category"
										style="width: 80px; height: 36px; float: left;">
										<option value="수업">수업</option>
										<option value="학원">학원</option>
										<option value="입시">입시</option>
										<option value="기타" selected>기타</option>
									</select>
								</c:if>
								<input type="text" id="title" value="${notice.title }"
									name='title' class="form-control" style="width: 85%;">
							</div>
								<c:if test="${notice.fixed eq 1 }">
									<div class="form-group" style="float: right;">
										<input type="checkbox" name="fixed" id="top" value="" checked>
										<label for="fixed">상단고정</label>
									</div>
								</c:if>
								
								<c:if test="${cnt lt 1}">	
									<c:if test="${notice.fixed eq 0 }">
										<div class="form-group" style="float: right;">
											<input type="checkbox" name="fixed" id="top" value="">
											<label for="fixed">상단고정</label>
										</div>
									</c:if>
								</c:if>	
							<div class="form-group">
								<label for="content">내 용</label>
								<textarea id="content" name="content">${notice.content }</textarea>
							</div>

							<div class="form-group">
								<div class="card card-outline card-success">
									<div class="card-header">
										<h3 style="display: inline; line-height: 40px;">첨부파일 :</h3>
										&nbsp;&nbsp;
										<button class="btn btn-primary" onclick="addFile_go()"
											type="button" id="addFileBtn">Add File</button>
									</div>
									<div class="card-footer fileInput">
										<ul
											class="mailbox-attachments d-flex align-items-stretch clearfix">

											<c:forEach items="${notice.attachList }" var="attach">
												<li class="attach-item thumb${attach.ano }"
													file-name="${attach.fileName }" target-ano="${attach.ano }">
													<div class="mailbox-attachment-info ">
														<a class="mailbox-attachment-name" name="attachedFile"
															attach-fileName="${attach.fileName }"
															attach-no="${attach.ano }"
															href="<%=request.getContextPath()%>/notice/getFile.do?ano=${attach.ano }">
															<i class="fas fa-paperclip"></i> ${attach.fileName }&nbsp;&nbsp;
															<button type="button"
																onclick="removeFile_go('thumb${attach.ano}');return false;"
																style="border: 0; outline: 0;" class="badge bg-red">X</button>
														</a>
													</div>
												</li>

											</c:forEach>
										</ul>
										<br />
									</div>
								</div>
							</div>


						</form>
					</div>
					<!--end card-body  -->

					<!--end card-footer  -->
				</div>
				<!-- end card -->
			</div>
			<!-- end col-md-12 -->
		</div>
		<!-- end row -->
	</section>
	<!-- /.content -->


</body>











