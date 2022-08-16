<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
function regist_go(){
	
		
	Swal.fire({
	      icon: 'success',
	      title: '질문이 등록되었습니다.',
	      text : '해당 강사에게 쪽지가 전송되었습니다.'
	    }).then((result) => {
	
	  
		$("form[role='form']").submit()
	    	

		})
}

function closeBtn(wno, problemCode) {
	opener.detail(wno, problemCode);
	window.close();
}
</script>
</head>
<div class="card">
	<div class="card-body" style="min-height:650px;">
		<div class="card-header" style="padding: 5px;">
			<div class="d-flex">
	            <div class="me-auto">
	            	<div class="d-flex justify-content-start">
		         	   <h5 style="font-weight:bold;margin-right: 15px;">문제질문 </h5>
                    </div>
	            </div>
	            <c:if test="${empty wrongDetail.question }">
	            	<div><button type="button" style="height: 30px;line-height: 6px;margin-top: -11px;margin-right: 5px;" class="btn btn-purple" onclick="regist_go()">질문등록</button></div>
	            </c:if>
	            <div><button type="button" style="height: 30px;line-height: 6px;margin-top: -11px;" class="btn btn-secondary" onclick="closeBtn(${wrongDetail.wno}, ${wrongDetail.problemCode })">닫기</button></div>
	        </div>  
        </div>  
		<div class="card-body">
			<div class="form-floating mb-3" style="border-radius: 10px;">
				<p ><span style="font-weight: bold;font-size:1.2em;">${wrongDetail.examName }</span> | ${wrongDetail.className }</p>
				<div>
					${wrongDetail.pronum }. ${wrongDetail.problemContent }<br><br>
					<p>
						<c:if test="${wrongDetail.lproblem eq '객관식'}">
							<c:if test="${wrongDetail.problemAnswer eq 1 }">
									● <span style="font-weight:bold">${wrongDetail.none }</span><br>
									② ${wrongDetail.ntwo }<br>
									③ ${wrongDetail.ntree }<br>
									④ ${wrongDetail.nfour }<br>
									⑤ ${wrongDetail.nfive }	
							</c:if>
							<c:if test="${wrongDetail.problemAnswer eq 2 }">
									① ${wrongDetail.none }<br>
									● <span style="font-weight:bold">${wrongDetail.ntwo }</span><br>
									③ ${wrongDetail.ntree }<br>
									④ ${wrongDetail.nfour }<br>
									⑤ ${wrongDetail.nfive }	
							</c:if>
							<c:if test="${wrongDetail.problemAnswer eq 3 }">
									① ${wrongDetail.none }<br>
									② ${wrongDetail.ntwo }<br>
									● <span style="font-weight:bold">${wrongDetail.ntree }</span><br>
									④ ${wrongDetail.nfour }<br>
									⑤ ${wrongDetail.nfive }	
							</c:if>
							<c:if test="${wrongDetail.problemAnswer eq 4 }">
									① ${wrongDetail.none }<br>
									② ${wrongDetail.ntwo }<br>
									③ ${wrongDetail.ntree }<br>
									● <span style="font-weight:bold">${wrongDetail.nfour }</span><br>
									⑤ ${wrongDetail.nfive }	
							</c:if>
							<c:if test="${wrongDetail.problemAnswer eq 5 }">
									① ${wrongDetail.none }<br>
									② ${wrongDetail.ntwo }<br>
									③ ${wrongDetail.ntree }<br>
									④ ${wrongDetail.nfour }<br>
									● <span style="font-weight:bold">${wrongDetail.nfive }</span>	
							</c:if>									
						</c:if>
						<c:if test="${wrongDetail.lproblem eq '주관식' }">
							<p style="font-weight:bold">답 | ${wrongDetail.problemAnswer }</p>
						</c:if>
					</p>
					<hr>	
				</div>
			</div>
			<div class="row gx-1 gy-2 align-items-center">
				<form enctype="multipart/form-data" role="form" method="post"
					action="question.go" name="questionForm">
					<div class="form-floating">
						<input type="hidden" name="wno" value="${wrongDetail.wno}">
						<input type="hidden" name="examCode" value="${wrongDetail.examCode}">
						<c:if test="${!empty wrongDetail.question }">
							<div class="bg-soft-secondary" style="min-height: 180px;padding: 10px;">
								<img style="width: 40px;height: 40px;" class="rounded-circle header-profile-user" src="/ddit/member/getPicture.go?id=${wrongDetail.id }" alt="Header Avatar">
								<span style="font-weight: bold;">${sName.name }님</span>
								<hr style="margin: 10px;color:black">
								<span class="badge rounded-pill bg-primary" style="font-weight:bold;margin-right: 5px;font-size: 1.0em;margin-left: 17px;">Q.</span>						
								<span>${wrongDetail.question }</span>
							</div>
							<hr>
							<div style="min-height:100px">
								<c:if test="${!empty wrongDetail.answer }">
									<div class="bg-soft-secondary"
										style="min-height: 180px; padding: 10px;">
										<img style="width: 40px; height: 40px;"
											class="rounded-circle header-profile-user"
											src="/ddit/member/getPicture.go?id=${tName.get(0).id }"
											alt="Header Avatar"> <span style="font-weight: bold;">${tName.get(0).name } 강사</span>
										<hr style="margin: 10px; color: black">
										<span class="badge rounded-pill bg-danger"
											style="font-weight: bold; margin-right: 5px; font-size: 1.0em; margin-left: 17px;">A.</span>
										<span>${wrongDetail.answer }</span>
									</div>			
								</c:if>
								<c:if test="${empty wrongDetail.answer }">
									<div class="bg-soft-secondary"
										style="min-height: 180px; padding: 10px;">
										<img style="width: 40px; height: 40px;"
											class="rounded-circle header-profile-user"
											src="/ddit/member/getPicture.go?id=${tName.get(0).id }"
											alt="Header Avatar"> <span style="font-weight: bold;">${tName.get(0).name } 강사</span>
										<hr style="margin: 10px; color: black">
										<span class="badge rounded-pill bg-danger"
											style="font-weight: bold; margin-right: 5px; font-size: 1.0em; margin-left: 17px;">A.</span>
										<span>답변 대기 중입니다.</span>
									</div>	
								</c:if>
							</div>
						</c:if>
						<c:if test="${empty wrongDetail.question }">
							<textarea class="form-control bg-light text-dark" name="question"
							placeholder="Leave a comment here" id="floatingTextarea2"
							style="height: 180px; resize: none"></textarea>
							<label for="floatingTextarea2" class="text-dark">내용</label>
						</c:if>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
