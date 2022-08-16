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
							style="margin-right: 10px; font-size: 1.3em;"></i>과제 수정
					</h5>
					<button type="button" class="btn btn-soft-secondary"
						style="width: 60px; margin-right: 5px;height: 33px;line-height: 6px;" onclick="history.go(-1)">취소</button>
					<button type="button" class="btn btn-soft-danger"
						style="width: 60px;margin-right: 5px;height: 33px; line-height: 6px;" onclick="submit_go('remove.go','${attach.assignCode}');">삭제</button>	
					<button type="button" class="btn btn-soft-purple"
						style="width: 85px;height: 33px; line-height: 6px;" onclick="modify_submit()">수정완료</button>
				</div>
				<br>
			<form enctype="multipart/form-data" role="form" method="post"
				action="modify.go" name="modifyForm">
				<div class="form-group">
				<input type="hidden" name="assignCode" value="${assign.assignCode}">
					<textarea class="form-control" name="content" id="content" rows="5">${attach.content }</textarea>
					
					<c:if test="${empty attach.filename }">
						<div class="mb-3">
							<input class="form-control form-control-sm" name="uploadFile"
								id="formFileSm" type="file">
						</div> 
					</c:if>					
					<c:if test="${!empty attach.filename }">
						<div class="mb-3" id="showw" style="display:none;">
							<input class="form-control form-control-sm" name="uploadFile"
								id="formFileSm" type="file">
						</div> 
						<li class="attach-item thumb${assign.assignCode }" style="list-style: none;" file-name="${attach.filename }" target-ano="${assign.assignCode}"> 
							<div class="mailbox-attachment-info "> 첨부파일 : 
	 							<a class="mailbox-attachment-name" name="attachedFile" 
	 								attach-fileName="${attach.filename }" attach-no="${assign.assignCode }" 
									href="<%=request.getContextPath()%>/assign/getAttachFile.do?assignCode=${assign.assignCode}"> 
									<i class="fas fa-paperclip"></i> ${attach.filename }&nbsp;&nbsp;	
									<button type="button"
										onclick="removeFile_go('thumb${assign.assignCode}');return false;"
										style="border: 0; outline: 0;" class="badge bg-soft-purple">X</button>
								</a>
	 						</div> 
						</li>
					</c:if>	
				</div>
				
			</form>
		</div>
	</div>
<script>	
	function submit_go(url, assignCode) {
		location.href = url + "?assignCode=" + assignCode;
	}
</script>

<script>
var ll = '${from}';
<c:if test="${from eq 'remove'}" >
	alert("삭제되었습니다.");
</c:if>
</script>
	<script>
	function modify_submit() {
// 		var test = null;
		
// 		if($('#showw').show()) {
// 			test = "hello";
// 			alert(test);
// 		}
		
// 		$.ajax({
// 			url : "modify.go",
// 			type : "POST",
// 			data : {
// 				"test" : test
// 			},
// 			success : function(data) {
		
// 			},
// 			error : function() {
// 				alert("err");
// 			}
// 		});

		var form = $('form[name="modifyForm"]');

	
	 
	   
	 Swal.fire({
		      icon: 'success',
		      title:'수정 되었습니다',
		     
		    }).then((result) => {

   
		    	form.submit();
  
		})

	}

	function remove_go(dataNum) {
		//alert(dataNum);
		

		$('div[data-no="' + dataNum + '"]').remove();
	}

	function removeFile_go(className) {
		//alert("X btn");
		var li = $('li.' + className);

		if (!confirm(li.attr("file-name") + "을 정말 삭제하시겠습니까?")) {
			return;
		}
		$('#showw').show();

		li.remove();

		var input = $('<input>').attr({
			"type" : "hidden",
			"name" : "deleteFile",
			"value" : li.attr("target-ano")
		});
		$('form[role="form"]').prepend(input);
	}

	function addFile_go() {
		//alert("add file btn");

		var attachedFile = $('a[name="attachedFile"]').length; //기존파일
		var inputFile = $('input[name="uploadFile"]').length; //추가된 파일

		var div = $('<div>').addClass("inputRow").attr("data-no", dataNum);
		var input = $('<input>').attr({
			"type" : "file",
			"name" : "uploadFile"
		}).css("display", "inline");
		div.append(input).append(
						"<button onclick='remove_go("
								+ dataNum
								+ ");' style='border:0;outline:0;' class='badge bg-red' type='button'>X</button>");

		$('.fileInput').append(div);

		dataNum++;
	}
</script>
</body>
