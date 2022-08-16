<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="classVOList" value="${dataMap.classVOList }" />

<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="<%=request.getContextPath()%>/resources/assets/libs/dropzone/min/dropzone.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
<script>
window.onload=function(){
	summernote_go($('#content'),'<%=request.getContextPath()%>');
	}
</script>

<script>
var selectBoxChange = function(value){
	var classCode = value;
	console.log("classCode: " + classCode);
}
</script>

</head>
<body>
	
	<div class="card">
		<section class="content-header">
		  	<div class="container-fluid">
		  		<div class="row md-2">
		  			<div class="col-sm-6">
		  				<h2 style="margin:20px;">과제등록</h2>  				
		  			</div>
		  			<div  class="col-sm-6">
		  				<ol style="float:right; margin:20px;" class="breadcrumb float-sm-right">
				        <li class="breadcrumb-item">
				        	<a href="list.go">
					        	<i class="fa fa-dashboard"></i>수업관리
					        </a>
				        </li>
				        <li class="breadcrumb-item active">
				        	과제등록
				        </li>		        
		    	  </ol>
		  			</div>
		  		</div>
		  	</div>
		</section>
	<hr>
		<div class="card-body">
			<form enctype="multipart/form-data" role="form" method="post" action="regist.go" name="registForm">
				<div class="col-md-12">
					<c:if test="${empty classVOList }">	
						<select class="form-select" style="width:100%;" name="classes" id="classes">
							<option value="" >현재 진행중인 수업이 없습니다</option>
						</select>
					</c:if>
					<c:if test="${!empty classVOList }">
					<select name="cc" class="form-select" onchange="selectBoxChange(this.value);" style="width:100%; " name="classes" id="classes">
						<option value="none" >**수업을 선택하세요 **</option>
						<c:forEach items="${classVOList }" var="classVO">
							<option value="${classVO.classCode }">${classVO.className }</option>
						</c:forEach>
					</select>
					</c:if>
					<input id="title" name="title" placeholder="제목" style="width:100%; margin-top:10px; margin-bottom:10px;" class="form-control" type="text" >
					<label style="width: 51%; margin-bottom: 0px; font-size: 0.8em; font-weight: bold; margin-left:5px;">요청일</label>
					<label style="width: 40%; margin-bottom: 0px; font-size: 0.8em; font-weight: bold;">마감일</label>
					<div>
						<div class="col-md-6" style="float:left;" >
							<input name="startDate" style="width: 95%; float: left;" type="datetime-local" class="form-control"> 
						</div>
						<div class="col-md-6" style="float:left;">
							<input name="endDate" style="width: 97%; margin-bottom:10px; margin-left: 20px;" type="datetime-local" class="form-control">
						</div>	
					</div>
					<div>
						<textarea id="content" name="content" placeholder="내용을 입력하세요" style="width:100%; margin-top:30px;" rows="20" cols="" id="content"></textarea>
					</div>
				</div>
				<div class="col-md-12">
<%-- 				<input type="hidden" name="assignCode" value="${assign.assignCode}"> --%>
					<div class="mb-3">
						<input class="form-control form-control-sm" name="uploadFile" id="formFileSm" type="file">
					</div>
				</div>
			</form>
		</div>
		<div class="card-footer">
			<button style="float:right; background-color: gray;" class="btn btn-primary col-sm-1" onclick="location.href='list.go'" >취소</button>
			<button style="float:right; margin-right:30px;" class="btn btn-primary col-sm-1" onclick="regist_go();" >등록</button>
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

 Swal.fire({
	      icon: 'success',
	      title: '등록되었습니다.'
	      
	    }).then((result) => {
    	
    	  
	$("form[role='form']").submit();

   		})
	//alert("등록 성공하였습니다.");
	
}
</script>
</body>
