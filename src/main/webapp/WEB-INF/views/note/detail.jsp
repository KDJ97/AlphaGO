<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
	<script type="text/javascript">
	//권한별 색상지정
	var btns = $('.btn-authority');
	var active = $('a.active');
	var badge = $('.badge');

	var authority = '${sessionScope.loginUser.authority}';
	var btn_class = '';
	var text_color = '';
	var bg_class = '';

	if(authority =='ROLE_STUDENT'){
		btn_class = 'btn-purple';
		text_color = '#564ab1';
		bg_class = 'bg-purple';
	}
	if(authority =='ROLE_TEACHER'){
		btn_class = 'btn-success';
		text_color = '#51d28c';
		bg_class = 'bg-success';
	}
	if(authority == 'ROLE_MASTER'){
		btn_class = 'btn-primary';
		text_color = '#038edc';
		bg_class = 'bg-primary';
	}

	for(var i = 0; i < btns.length; i++){
		btns.eq(i).removeClass('btn-purple');
		btns.eq(i).addClass(btn_class);

	}
	for(var i = 0; i < badge.length; i++){
		badge.eq(i).removeClass('bg-purple');
		badge.eq(i).addClass(bg_class);

	}
	active.css('color', text_color);
	</script>
</head>

<div class="row">
    <div class="col-12">
        <div class="page-title-box d-flex align-items-center justify-content-between">
            <h4 class="mb-0">쪽지함</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">쪽지함</a></li>
                    <li class="breadcrumb-item active">쪽지</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">
    <div class="col-12">
        <!-- Left sidebar -->
        <div class="email-leftbar card">
          <button type="button" class="btn btn-authority w-100 fw-semibold">
                         쪽지 보내기
          </button>
          <div class="mail-list mt-4">
            <c:if test="${from eq 'reciveList' }">
              <a href="reciveList.go" class="active">
                <i class="bx bxs-inbox font-size-16 align-middle me-2"></i> 받은쪽지함
                <c:if test="${reciveCnt > 0 }">
	                <span class="ms-1 float-end">(${reciveCnt })</span>
                </c:if>
              </a>
              <a href="sendList.go">
                <i class="bx bx-mail-send font-size-16 align-middle me-2"></i>보낸쪽지함
              </a>
            </c:if>
            <c:if test="${from eq 'sendList' }">
              <a href="reciveList.go">
                <i class="bx bxs-inbox font-size-16 align-middle me-2"></i> 받은쪽지함
                <c:if test="${reciveCnt > 0 }">
	                <span class="ms-1 float-end">(${reciveCnt })</span>
                </c:if>
              </a>
              <a href="sendList.go" class="active">
                <i class="bx bx-mail-send font-size-16 align-middle me-2"></i>보낸쪽지함
              </a>
            </c:if>
          </div>


      </div>
        <!-- End Left sidebar -->
        <!-- Right Sidebar -->
        <div class="email-rightbar mb-3">

            <div class="card">
              <div class="btn-toolbar p-3 d-flex flex-row-reverse  " role="toolbar">
                <button type="button" class="btn btn-danger" onclick="javascript:location.href='delete.go?code=${dm.dmCode}&div=${dm.dmDiv }'"><i class="far fa-trash-alt"></i>&nbsp;삭제하기</button>
              </div>

               <div class="card-body">

                 <div class="d-flex align-items-start mb-4">
                   <c:if test="${from eq 'sendList' }">
                     <div class="flex-shrink-0 me-3">
						<span class="badge bg-purple">받는 사람</span>
                     </div>
                     <div class="flex-shrink-0 me-3">
                         <img class="rounded-circle avatar-sm" src="<%=request.getContextPath() %>/resources/assets/images/users/avatar-2.jpg" alt="Generic placeholder image">
                     </div>

                     <div class="flex-grow-1">
                         <h5 class="font-size-14 my-1">${receiver.name }</h5>
                         <small class="text-muted">${receiver.email }</small>
                     </div>
                   </c:if>
                   <c:if test="${from eq 'reciveList' }">
                    <div class="flex-shrink-0 me-3">
						<span class="badge bg-purple">보낸 사람</span>
                     </div>
                     <div class="flex-shrink-0 me-3">
                         <img class="rounded-circle avatar-sm" src="<%=request.getContextPath() %>/resources/assets/images/users/avatar-2.jpg" alt="Generic placeholder image">
                     </div>

                     <div class="flex-grow-1">
                         <h5 class="font-size-14 my-1">${sender.name }</h5>
                         <small class="text-muted">${sender.email }</small>
                     </div>
                   </c:if>
                 </div>
                 <hr>

                 <h4 class="mt-0 mb-4 font-size-16">${dm.dmTitle }</h4>

                 <p class="text-muted">
                   ${dm.dmContent }
                 </p>

              </div>

            </div>
            <!-- end card -->
        </div><!-- End email-rightbar -->

    </div>
    <!-- end Col-9 -->

</div>