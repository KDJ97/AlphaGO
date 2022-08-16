<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
	<script type="text/javascript">
		function dm_delete() {
				var size =  ${dmList.size() };
				var cnt = 0;
				var chk = false;
				for (var i = 0; i < size; i++) {
					if($("#chk" + i).is(":checked")){
						chk = true;
					    //alert(i + "is 체크 됨");
					    var li = $("#chk" + i).parents("li")
					    var code = li.attr('data-code');
					    //alert(code);
					    $.ajax({
							url: "<%=request.getContextPath() %>/note/delete.go",
					    	data: {
					    		'code' : code,
					    		'div' : 'R'
					    	},
					    	type: "POST",
					    	success: function() {}
						});
					};
				}

				if(chk){
					alert("쪽지가 정상 삭제되었습니다");
			   		location.href = "reciveList.go";
				}else{
					alert("삭제할 쪽지를 선택해주세요");
					return;
				}
			}
	</script>
	<script type="text/javascript">
	//권한별 색상지정
	var btns = $('.btn-authority');
	var active = $('a.active');

	var authority = '${sessionScope.loginUser.authority}';
	var btn_class = '';
	var text_color = '';
	if(authority =='ROLE_STUDENT'){
		btn_class = 'btn-purple';
		text_color = '#564ab1';
	}
	if(authority =='ROLE_TEACHER'){
		btn_class = 'btn-success';
		text_color = '#51d28c';
	}
	if(authority == 'ROLE_MASTER'){
		btn_class = 'btn-primary';
		text_color = '#038edc';
	}

	for(var i = 0; i < btns.length; i++){
		btns.eq(i).removeClass('btn-purple');
		btns.eq(i).addClass(btn_class);

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
                  <li class="breadcrumb-item active">받은쪽지함</li>
              </ol>
          </div>

      </div>
  </div>
</div>
<!-- end page title -->

<div class="row">
    <div class="col-12">
       <div class="email-leftbar card">
          <button type="button" class="btn btn-authority w-100 fw-semibold" onclick="javascript:location.href='registForm.go'">
                         쪽지 보내기
          </button>
          <div class="mail-list mt-4">
              <a href="reciveList.go" class="active">
                <i class="bx bxs-inbox font-size-16 align-middle me-2"></i> 받은쪽지함
                <c:if test="${reciveCnt > 0 }">
	                <span class="ms-1 float-end">(${reciveCnt })</span>
                </c:if>
               </a>
              <a href="sendList.go"><i class="bx bx-mail-send font-size-16 align-middle me-2"></i>보낸쪽지함</a>
          </div>


      </div>
      <!-- End Left sidebar -->

        <!-- Right Sidebar -->
        <div class="email-rightbar mb-3">

            <div class="card">
                <div class="btn-toolbar p-3 d-flex flex-row-reverse  " role="toolbar">
                  <button type="button" class="btn btn-danger" onclick="dm_delete()"><i class="far fa-trash-alt"></i>&nbsp;삭제하기</button>
                </div>
                <ul class="message-list">
                    <c:if test="${!empty dmList }" >
	            		<c:forEach items="${dmList }" var="dm" varStatus="vs">
	     					<li data-code="${dm.dmCode }">
		                        <div class="col-mail col-mail-1">
		                            <div class="checkbox-wrapper-mail">
		                                <input type="checkbox" id="chk${vs.index}">
		                                <label for="chk${vs.index}" class="toggle"></label>
		                            </div>
		                            <a href="detail.go?code=${dm.dmCode }&from=reciveList" class="title">${dm.dmReceiver }</a>
		                            <c:if test="${dm.dmStatus eq 0}">
			                          <span class="badge bg-primary">안읽음</span>
		                            </c:if>
		                            <c:if test="${dm.dmStatus eq 1}">
			                          <span class="badge bg-secondary">읽음</span>
		                            </c:if>
		                        </div>
		                        <div class="col-mail col-mail-2">
		                            <a href="detail.go?code=${dm.dmCode }&from=reciveList" class="subject">${dm.dmTitle }</a>
		                            <div class="date"><fmt:formatDate value="${dm.dmDate }" pattern="MM/dd"/></div>
		                        </div>
		                    </li>
	     				</c:forEach>
	            	</c:if>
	            	<c:if test="${empty dmList }" >
	            	  <li>
	            	     <p style="text-align: center; font-size: 16px; font-weight: bold; color: gray;">받은 메일이 없습니다.</p>
	            	  </li>
	            	</c:if>
                </ul>
            </div><!-- card -->

        </div>
        <!-- End Right Sidebar -->
    </div>
</div><!-- End row -->

