<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="<%=request.getContextPath() %>/resources/assets/libs/rater-js/index.js"></script>
<%-- <script src="<%=request.getContextPath()%>/resources/js/index2.js"></script> --%>
<script>
var score;

var starRatinghover = raterJs({
	starSize : 22,
	element : document.querySelector("#rater-onhover"),
	rateCallback : function(e, t) {
		this.setRating(e), t()
		score = e;
		console.log(score)
	},
	onHover : function(e, t) {
		document.querySelector(".ratingnum").textContent = e
	},
	onLeave : function(e, t) {
		document.querySelector(".ratingnum").textContent = t
	}
})

function regist_go() { 
	Swal.fire({
		  title: '정말로 후기를 등록하시겠습니까?',
		  text: "등록 후에는 수정/삭제가 불가능합니다.",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '확인',
		  cancelButtonText: '취소'
		}).then((result) => {
		  if (result.isConfirmed) {
			  Swal.fire({
				  icon: 'success',
				  title: '등록되었습니다.'
				}).then((result) => {
					if (result.isConfirmed){
						$("form[role='form']").append($('<input/>', {type: 'hidden', name: 'starScore', value: score }));
						$("form[role='form']").submit();
					}
				})
		  }else{
			  Swal.fire({
				  icon: 'error',
				  title: '등록이 취소되었습니다.',
				  showConfirmButton: false,
				  timer: 1500
				})
		  }
		})
		
// 	alert("후기가 등록되었습니다.");
// 	$("form[role='form']").submit();
}
</script>
</head>
<div class="card">
	<div class="card-body" style="min-height: 500px;">
		<div class="card-header" style="padding: 5px;">
			<div class="d-flex">
				<div class="me-auto">
					<div class="d-flex justify-content-start">
						<h5 style="font-weight: bold; margin-right: 15px;">수업 후기 등록</h5>
					</div>
				</div>
				<div>
					<button type="button"
						style="height: 30px; line-height: 6px; margin-top: -11px;"
						class="btn btn-purple" onclick="regist_go()">등록</button>
					<button type="button"
						style="height: 30px; line-height: 6px; margin-top: -11px;"
						class="btn btn-secondary" onclick="window.close()">닫기</button>
				</div>
			</div>
		</div>
		<div class="card-body">
			<div class="d-flex justify-content-between">
				<p style="font-weight: bold;">
					${review.className } | ${review.name }
				</p>
				<span class="badge rounded-pill bg-primary"
					style="font-size: 0.8em; padding: 8px; height: 25px; width: 50px; margin-left: 10px;">${review.subjectName }</span>
			</div>
			<div class="d-flex justify-content-start mb-3">
				<span style="margin-right: 10px;margin-top:2px;">평점 입력</span>
				<div dir="ltr">
                    <div id="rater-onhover" class="align-middle"></div>
                    <span class="ratingnum badge bg-info align-middle ms-2"></span>
                </div>
<!-- 				<div id="rater5" class="star-rating" style="width: 80px; height: 16px; background-size: 20px;margin-right:5px;margin-bottom: 10px;"></div> -->
<!-- 				<div id="rater-step" class="star-rating" style="width:160px; height: 32px; background-size: 20px;margin-right: 5px;" title="5/5"></div> -->
			</div>
			<div class="row gx-1 gy-2 align-items-center">
				<form enctype="multipart/form-data" role="form" method="post" action="regist.go" name="registForm">
					<input type="hidden" name="classCode" value="${review.classCode}">
					<div class="form-floating">
						<input class="form-control bg-light text-dark" style="margin-bottom: 15px;"
							placeholder="Leave a comment here" id="floating" name="title"></input>
						<label for="floating" class="text-dark">제목</label>
					</div>	
					<div class="form-floating">
						<textarea class="form-control bg-light text-dark" name="content"
							placeholder="Leave a comment here" id="floatingTextarea2"
							style="height: 300px;resize:none"></textarea>
						<label for="floatingTextarea2" class="text-dark">내용</label>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

