<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<script
	src="<%=request.getContextPath()%>/resources/assets/libs/dropzone/min/dropzone.min.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
	
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
window.onload=function(){
	summernote_go($('#content'),'<%=request.getContextPath()%>');
	}
</script>
</head>
<body>
	<div class="card">
		<div class="card-body">
			<h5 style="margin-bottom: 15px; font-weight: bold;">
				<i class="uil-file-blank"
					style="margin-right: 10px; font-size: 1.3em;"></i>${assign.title }
			</h5>
			<hr>
			<p>${assign.content }</p>
			<c:if test="${!empty assign.uploadpath }">
				<div class="list-group-item py-3">
					<div class="d-flex align-items-start">
						<div class="flex-shrink-0 avatar-sm me-3">
							<span
								class="avatar-title bg-light text-primary rounded font-size-20">
								<i class="uil uil-scenery"></i>
							</span>
						</div>
						<div class="flex-grow-1 overflow-hidden">
							<h5 class="font-size-13 text-truncate">
								<a href="getFile.go?assignCode=${assign.assignCode}"
									class="text-dark">${assign.filename }</a>
							</h5>
						</div>
						<div class="flex-shrink-0 ms-2">
							<ul class="list-inline mb-0">
								<li class="list-inline-item"><a
									href="getFile.go?assignCode=${assign.assignCode}"
									class="text-muted font-size-20 px-2"> <i
										class="uil uil-download-alt"></i>
								</a></li>
							</ul>
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<div class="card">
		<div class="card-body">
				<div class="d-flex">
					<h5 style="margin-bottom: 15px; font-weight: bold;"
						class="flex-grow-1">
						<i class="uil-file-alt"
							style="margin-right: 10px; font-size: 1.3em;"></i>과제 제출
					</h5>
					<button type="button" class="btn btn-soft-secondary"
						style="width: 60px; margin-right: 5px;height: 33px;line-height: 6px;" onclick="history.go(-1)">취소</button>
					<button type="button" class="btn btn-soft-purple"
						style="width: 90px;height: 33px; line-height: 6px;" onclick="regist_go()">제출하기</button>
				</div>
				<br>
			<form enctype="multipart/form-data" role="form" method="post"
				action="regist.go" name="registForm">
				<div class="form-group">
				<input type="hidden" name="assignCode" value="${assign.assignCode}">
					<textarea class="form-control" name="content" id="content" rows="5" placeholder="내용을 작성하세요."></textarea>

					<div class="mb-3">
						<input class="form-control form-control-sm" name="uploadFile" id="formFileSm" type="file">
					</div>
				</div>

			</form>
		</div>
	</div>
<script>
function regist_go(){
	
// 	var files = $('input[name="uploadFile"]');
// 	for(var file of files){
// 		console.log(file.name+" : "+file.value);
// 		if(file.value==""){
// 			alert("파일을 선택하세요.");
// 			file.focus();
// 			file.click();
// 			return
// 		}
// 	}
	
// 	if($("input[name='title']").val()==""){ // form.title.value
// 		alert("제목은 필수입니다.");
// 		$("input[name='title']").focus();
// 		return;
// 	}
	//
	 
	   
	   
		 Swal.fire({
			      icon: 'success',
			      title:'제출 되었습니다',
			     
			    }).then((result) => {

	   
			    	$("form[role='form']").submit();
	  
			})
	   //alert("제출에 성공하였습니다.");
	
}
</script>
</body>
