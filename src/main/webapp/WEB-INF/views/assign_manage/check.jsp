<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<script
	src="<%=request.getContextPath()%>/resources/assets/libs/dropzone/min/dropzone.min.js"></script>

</head>
<body>
	
	<div class="card">
		<div class="card-body">
				<div class="d-flex">
					<h5 style="margin-bottom: 15px; font-weight: bold;"
						class="flex-grow-1">
						<i class="uil-file-alt"
							style="margin-right: 10px; font-size: 1.3em;"></i>${name }의 과제
					</h5>
				</div>
				<br>
			<form enctype="multipart/form-data" role="form" method="post"
				action="modify.go" name="modifyForm">
				<div class="form-group">
				<input type="hidden" name="assignCode" value="${assign.assignCode}">
<%-- 					<textarea class="form-control" name="content" id="content" rows="5">${attach.content }</textarea> --%>
					<div style="border: 1px solid #8BDDA8; height: 400px; overflow: auto;" class="form-control" name="content" id="content" rows="5">${attach.content }</div>
					
										
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


</body>
