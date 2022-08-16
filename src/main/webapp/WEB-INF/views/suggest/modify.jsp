<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<title>건의게시판</title>

<head>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>ㄴ
<script>
window.onload=function(){
	summernote_go($('#content'),'<%=request.getContextPath()%>');
}
</script>
<script>
function modify_go(){
	var form = document.modifyForm;
	if(form.title.value==""){
		alert("제목은 필수입니다.");
		return;
	}
	if(form.content.value==""){
		alert("내용 X");
		return;
	}
	if(form.writer.value==""){
		alert("로그인 X");
		return;
	}
	
	Swal.fire({
	      icon: 'success',
	      title: '수정되었습니다.'
	      
	    }).then((result) => {
		
			
		form.submit();
	  

		})
	
}
</script>
</head>
<body>


	 <!-- Main content -->
    <section class="content">
		<div class="card">
			<section class="content-header">
	  	<div class="container-fluid">
	  		<div class="row md-2">
	  			<div class="col-sm-6">
	  				<h5 style="margin-bottom: 15px; font-weight: bold; margin-top:20px; margin-left:10px;">
						<i class="uil-clipboard-notes" style="margin-right: 10px;"></i>건의게시판
					</h5>
	  			</div>
	  			<div  class="col-sm-6">
	  				<ol style="float:right; margin:20px;" class="breadcrumb float-sm-right">
			        <li class="breadcrumb-item">
			        	<a href="list.go">
				        	<i class="fa fa-dashboard"></i>건의게시판
				        </a>
			        </li>
			        <li class="breadcrumb-item active">
			        	수정
			        </li>
	    	  </ol>
	  			</div>
	  		</div>
	  	</div>
	</section>
	<hr style="margin-top:0px;">
		<form role="form" method="post" action="modify.go" name="modifyForm">
	  		<div id="keyword" class="card-tools" style="">
					<div class="col-md-12" style="float:left;">
						<input id="title" name="title" placeholder="제목" value="${suggest.title }" style="width:96%; margin-left:20px;" class="form-control" type="text" >
						<input id="writer" name="writer" type="hidden" value="${loginUser.id }" >
						<input id="lcode" name="lcode" type="hidden" value="${suggest.lcode }">
					</div>

			</div>
			<div class="card-body">
				<textarea id="content" name="content" placeholder="내용을 입력하세요" style="width:100%;" rows="20" cols="">
				${fn:escapeXml(suggest.content) }
				</textarea>
			</div>
		</form>	
			<div class="card-footer">
				<button style="float:right; background-color: gray;" class="btn btn-primary col-sm-1" onclick="location.href='list.go'" >취소</button>
				<button style="float:right; margin-right:10px;" class="btn btn-primary" onclick="modify_go();" >수정완료</button>
			</div>

		</div>

    </section>



</body>






