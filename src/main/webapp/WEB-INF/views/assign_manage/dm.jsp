<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<head>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
window.onload=function(){
	summernote_go($('#content'),'<%=request.getContextPath()%>');
}
</script>
<script>
function note_subsmit(){
	
   	if(!$("input[name='to']").val() || $("input[name='to']").val() == ""){
   		alert("받는 사람을 설정해야합니다.");
   		$("input[name='to']").focus();
   		return;
   	}

   	if(!$("input[name='title']").val() || $("input[name='title']").val()==""){
   		alert("제목을 입력해주세요");
   		$("input[name='title']").focus();
   		return;
   	}

	 Swal.fire({
	      icon: 'success',
	      title: '전송 되었습니다.'

	    }).then((result) => {
			$("form").submit();
  		})
}
<c:if test="${from eq 'send' }">
	window.close();
</c:if>
</script>
</head>
<body>

<div class="card">
    <div class="card-header justify-content-between d-flex align-items-center">
        <h4 class="card-title">쪽지 보내기</h4>
        <a class="btn btn-sm w-lg btn-primary" onclick="note_subsmit()">전송</a>
    </div><!-- end card header -->
    <div class="card-body">
      <form action="<%=request.getContextPath() %>/assignManage/send.go" method="post">
      <div class="row gx-3 gy-2 align-items-center">
            <div class="col-12">
                <div class="mb-3">
	              <label for="receive-list">받는사람</label>
	              <input name="to" type="text" class="form-control" id="receive-list" value="${id }" readonly="readonly" >
         	    </div>
            </div>
            <!-- end col -->
	</div>

            <div class="form-floating mb-3">
                <input name="title" type="text" class="form-control" id="floatingTitle"
                    placeholder="제목">
                <label for="floatingTitle">제목</label>
            </div>
            <textarea name="content" id="content"></textarea>
            </form>
        </div><!-- end cardbody -->
</div><!-- end card -->

</body>
</html>