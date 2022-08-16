<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>

<meta charset="utf-8" />
<title>Sign In</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="Premium Multipurpose Admin & Dashboard Template"
	name="description" />
<meta content="Pichforest" name="author" />
<!-- App favicon -->
<link rel="shortcut icon" href="assets/images/favicon.ico">

<!-- Bootstrap Css -->
<link href="assets/css/bootstrap.min.css" id="bootstrap-style"
	rel="stylesheet" type="text/css" />
<!-- Icons Css -->
<link href="assets/css/icons.min.css" rel="stylesheet" type="text/css" />
<!-- App Css-->
<link href="assets/css/app.min.css" id="app-style" rel="stylesheet"
	type="text/css" />
<!-- sweetalert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

</head>

<head>
<script>
	window.onload = function(){//온로드 함수
		//쿠키를 확인해서 팝업을 띄울지 말지 설정해주어야함
		//쿠키를 꺼내기
		//쿠키값 확인하기
		//있으면 팝업 안띄우고
		//없으면 팝업 띄우기
		<c:if test="${not empty popup}">
			var cookie = getCookie('popup');
			console.log(cookie);
			
			if(cookie!='popEvent'&&cookie==null){
					$('#modalDIV').css("display","block");
					$('#popupClick').click();
			}
		</c:if>
	}
	
	//팝업 모달 닫기 버튼 클릭시 이벤트(쿠키 셋 작업)
	$('.closePopup').on('click', function(){
		var checked = $('#formCheck').is(':checked');//true or false
		if(checked == true){//체크박스에 체크가 되어있으면
			setCookie('popup','popEvent',1);//키:"popup"인 쿠키를 하루동안 셋한다
		}
		
	})
	
	//쿠키 셋메서드
	function setCookie(name, value, exp) {
		  var date = new Date();
		  date.setTime(date.getTime() + exp*24*60*60*1000);
		  document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
	}

// 	setCookie('pop', 'event0405', 7); /* pop=event0405, 7일 뒤 만료됨 */
	//쿠키 겟메서드
	function getCookie(name) {
	  var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	  return value? value[2] : null;
	}

// 	getCookie('pop'); /* 결과: pop0405 */
	
</script>
<style type="text/css">
.card{
   -webkit-box-shadow: 0 0px 0px #eaedf2;
   box-shadow: 0 0px 0px #eaedf2;
}

@font-face {
    font-family: 'MICEGothic Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-01@1.0/MICEGothic Bold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
@font-face {
    font-family: 'MICEGothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-01@1.0/MICEGothic.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
</style>
</head>
<body>
<c:set var="attachList" value="${popup.attachList }"/>

	<div class="authentication-bg min-vh-100" style="background-image: url(<%=request.getContextPath()%>/resources/assets/images/bg.jpg);">
		<div class="bg-overlay bg-black"></div>
		<div class="container">
			<div class="d-flex flex-column min-vh-100 px-3 pt-4">
				<div class="row justify-content-center my-auto">
					<div class="col-lg-10">
						<div class="py-5">
							<div class="card auth-cover-card overflow-hidden" style="border:0px">
								<div class="row g-0">
									<div class="col-lg-6">
										<div class="auth-img"></div>
									</div>
									<!-- end col -->
									<div class="col-lg-6">
										<div
											class="p-4 p-lg-5 bg-purple h-100 d-flex align-items-center justify-content-center">
											<div class="w-100">
											<form role="log"action="login.go" method="post">	
												<div class="col-mb-2">
													 <img
														src="<%=request.getContextPath()%>/resources/images/logo.png"
														style="width: 180px;" alt="">
												
												<select class="form-select"  onchange="javascript:autoLogin(this);" style="width:20%; float:right;background-color: rgba(255,255,255,.1);border: none;">
  													<option selected >선택</option>
  													<option value="ROLE_STUDENT">원생</option>
 													<option value="ROLE_TEACHER">강사</option>
  													<option value="ROLE_MASTER">원장</option>
  													
  													
												</select>
												
													<!-- 원생 -->
													<input type="hidden" class="form-control" name="ids"
															id="ids" value='sisi'>
													<input type="hidden" class="form-control" name="pwds"
															id="pwds" value='sisi'>
													
													<!-- 강사 -->
													<input type="hidden" class="form-control" name="idss"
															id="ids" value='titi'>
													<input type="hidden" class="form-control" name="pwdss"
															id="pwds" value='titi'>
													
													<!-- 원장 -->
													<input type="hidden" class="form-control" name="idsss"
															id="ids" value='mimi'>
													<input type="hidden" class="form-control" name="pwdsss"
															id="pwds" value='mimi'>
													
													
													
												</div>
											</form>
												<div class="text-white-50 mb-4">
													<h5 class="text-white" style="font-family: 'MICEGothic Bold'; position: absolute;left: -288px;top: 160px;font-size:2.0em;font-size: 1.8em;">환영합니다 !</h5>
													<p style="font-family: 'MICEGothic'; position: absolute;left: -287px; top: 200px;color: white;font-size: 1.1em;">알파고를 이용하시려면 로그인해주세요.</p>
												</div>
												
												<form action="login.go" method="post" id="loginForm">
													<div class="row">
														<div class="col-9">
															<div class="form-floating form-floating-custom mb-3">
																<input type="text" class="form-control" name="id"
																	id="input-username" placeholder="Enter User name">
																<label for="input-username">ID</label>
																<div class="form-floating-icon">
																	<i class="uil uil-users-alt"></i>
																</div>
															</div>
															<div class="form-floating form-floating-custom mb-3">
																<input type="password" class="form-control" name="pwd"
																	id="input-password" placeholder="Enter Password">
																<label for="input-password">Password</label>
																<div class="form-floating-icon">
																	<i class="uil uil-padlock"></i>
																</div>
															</div>
														</div>
														<div class="col-3">
															<div>
																<button class="btn btn-light w-100" type="submit" style="height:132px">LOGIN</button>
															</div>
														</div>
													</div>
													<div class="mt-3">
														<button type="button" class="btn w-100" style="border:1px solid white;color:white"
															data-bs-toggle="modal" data-bs-target="#sendPaper">지원서
															보내기</button>
													</div>

													<div class="mt-4 text-center">
														<a href="#"
															class="text-white-50 text-decoration-underline"
															data-bs-toggle="modal" data-bs-target="#idmodal">아이디
															찾기</a>
														&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<a href="auth-resetpassword-cover.html"
															class="text-white-50 text-decoration-underline"
															data-bs-toggle="modal" data-bs-target="#passmodal">비밀번호
															찾기</a>
													</div>
								
												</form>
												<!-- end form -->

												<div class="modal fade bs-example-modal-center"
													id="sendPaper" tabindex="-1" role="dialog"
													aria-labelledby="mySmallModalLabel" aria-hidden="true">
													<div class="modal-dialog modal-dialog-centered">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title"><i class="uil-clipboard-notes"></i>&nbsp;&nbsp;&nbsp;지원서 보내기</h5>
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal" aria-label="Close"></button>
															</div>
															
															<div class="modal-body">
															<form id="uploadForm" name="uploadForm"  method="post" enctype="multipart/form-data">
																<div class="form-floating mb-3">
																	<input type="text"
																		class="form-control bg-light text-dark"
																		id="applyname" name="applyer" placeholder="name"> <label
																		for="floatingName" class="text-dark">이름</label>
																</div>
																<div class="row gx-1 gy-2 align-items-center">
																	<div class="form-floating mb-3 bg-light">
																		<input type="text"
																			class="form-control bg-light text-dark"
																			id="applyphone" name="applyerTel" placeholder="phone"> <label
																			for="floatingPhone" class="text-dark">전화번호</label>
																	</div>
																</div>

																<div class="row gx-1 gy-2 align-items-center">
																	<div class="form-floating mb-3 bg-light">
																		<input type="text"
																			class="form-control bg-light text-dark"
																			id="applytitle" name="applyTitle"placeholder="title"> <label
																			for="floatingTitle" class="text-dark">제목</label>
																	</div>
																</div>
																

																<div class="row gx-1 gy-2 align-items-center">
																	<div class="form-floating">
																		<textarea class="form-control bg-light text-dark"
																			placeholder="Leave a comment here"
																			id="applycontent" name="applyContent" style="height: 150px"></textarea>
																		<label for="floatingTextarea2" class="text-dark">내용</label>
																	</div>
																</div>
																<br>

																<div>
																	<label for="paperFile" class="text-dark">지원서 파일</label><br>
																	<div class="row gx-2 gy-2 align-items-center">
																		<div class="col-7">
																	

																			<input class="form-control " type="file" id="fileInput" name="uploadFile">
																		
																		
																		</div>
																		<div class="col-5">
																			<button type="button" onclick="location.href='getFile.go';" class="btn btn-purple">
																				<i class="uil-arrow-to-bottom" ></i> 지원서 양식 다운로드
																			</button>
																		</div>
																	</div>
																</div>
																<hr>
																<button type="button" onclick="regist_go()"style="float:right;" class="btn btn-warning">
																	제출하기
																</button>
																</form>
															</div>
															
														</div>
														<!-- /.modal-content -->
													</div>
													<!-- /.modal-dialog -->
												</div>
												<!-- /.modal -->

												<div class="modal fade bs-example-modal-center"
													tabindex="-1" role="dialog" id="idmodal"
													aria-labelledby="mySmallModalLabel" aria-hidden="true">
													<div class="modal-dialog modal-dialog-centered">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title">아이디 찾기</h5>
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal" aria-label="Close"></button>
															</div>
															<div class="modal-body">
																<div class="form-floating mb-3">
																	<input type="text"
																		class="form-control bg-light text-dark"
																		id="floatingName" placeholder="name"> <label
																		for="floatingName" class="text-dark">이름</label>
																</div>

																<div class="row gx-1 gy-2 align-items-center">
																	<div class="col-10">
																		<div class="form-floating mb-3 bg-light">
																			<input type="email"
																				class="form-control bg-light text-dark"
																				id="floatingEmail" placeholder="name@example.com">
																			<label for="floatingEmail" class="text-dark">이메일</label>
																		</div>
																	</div>
																	<div class="col-2">
																		<button type="button" class="btn btn-soft-purple"
																			style="height: 55px; margin-bottom: 18px; padding: 5px;"
																			onclick="num_check()">인증번호 전송</button>
																	</div>

																</div>

																<div class="row gx-1 gy-2 align-items-center">
																	<div class="col-10">
																		<div class="form-floating mb-3 bg-light">
																			<input type="text"
																				class="form-control bg-light text-dark"
																				id="floatingNum" placeholder="number"> <label
																				for="floatingNum" class="text-dark">인증번호</label>

																		</div>
																	</div>
																	<div class="col-2">
																		<button type="button" class="btn btn-soft-purple"
																			style="height: 55px; margin-bottom: 18px; padding: 5px;">인증번호
																			확인</button>
																	</div>
																	<p style="margin-left: 10px; color: red;">6:00</p>
																</div>

															</div>
														</div>
														<!-- /.modal-content -->
													</div>
													<!-- /.modal-dialog -->
												</div>
												<!-- /.modal -->

												<div class="modal fade bs-example-modal-center"
													id="passmodal" tabindex="-1" role="dialog"
													aria-labelledby="mySmallModalLabel" aria-hidden="true">
													<div class="modal-dialog modal-dialog-centered">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title">비밀번호 찾기</h5>
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal" aria-label="Close"></button>
															</div>
															<div class="modal-body">
																<div class="form-floating mb-3">
																	<input type="text"
																		class="form-control bg-light text-dark"
																		id="floatingId" placeholder="id"> <label
																		for="floatingId" class="text-dark">아이디</label>
																</div>

																<div class="row gx-1 gy-2 align-items-center">
																	<div class="col-10">
																		<div class="form-floating mb-3 bg-light">
																			<input type="email"
																				class="form-control bg-light text-dark"
																				id="floatingEmail" placeholder="name@example.com">
																			<label for="floatingEmail" class="text-dark">이메일</label>
																		</div>
																	</div>
																	<div class="col-2">
																		<button type="button" class="btn btn-soft-purple"
																			style="height: 55px; margin-bottom: 18px; padding: 5px;"
																			onclick="num_check()">인증번호 전송</button>
																	</div>

																</div>

																<div class="row gx-1 gy-2 align-items-center">
																	<div class="col-10">
																		<div class="form-floating mb-3 bg-light">
																			<input type="text"
																				class="form-control bg-light text-dark"
																				id="floatingNum" placeholder="number"> <label
																				for="floatingNum" class="text-dark">인증번호</label>

																		</div>
																	</div>
																	<div class="col-2">
																		<button type="button" class="btn btn-soft-purple"
																			style="height: 55px; margin-bottom: 18px; padding: 5px;">인증번호
																			확인</button>
																	</div>
																	<p style="margin-left: 10px; color: red;">6:00</p>
																</div>
															</div>
														</div>
														<!-- /.modal-content -->
													</div>
													<!-- /.modal-dialog -->
												</div>
												<!-- /.modal -->

			<div style="display:none" id="modalDIV">
				<!-- popup 모달 클릭 버튼 -->
				<button type="button" id="popupClick" style="display:none;" data-bs-toggle="modal"data-bs-target="#popupModal"></button>
				<c:if test="${not empty popup}"><!-- 팝업이 있을때 -->
					<!-- 팝업 모달 -->
					<div class="modal fade" id="popupModal"
						data-bs-backdrop="static" 
						tabindex="-1" aria-modal="true" role="dialog" style="display: block;">
						<div class="modal-dialog modal-dialog-centered"
							role="document">
							<div class="modal-content" style="border: 3px solid #564ab1;width:400px;">
<!-- 								<div class="modal-header"> -->
<%-- 									<h5 class="modal-title" id="staticBackdropLabel">${popup.title }</h5> --%>
<!-- 									<button type="button" class="btn-close closePopup"  -->
<!-- 										data-bs-dismiss="modal" aria-label="Close"></button> -->
<!-- 								</div> -->
								<!-- end modalheader -->
								<div class="modal-body">
									${popup.content }
								</div>
								<c:if test="${!empty attachList }">
								<div class="form-group col-sm-12">
									<div class="card card-outline card-success">
										<blockquote style="padding: 1px;"
											class="blockquote custom-blockpuote blockpuote-purple rounded mb-0">
											<h6>첨부파일</h6>
										</blockquote>
										<blockquote style="padding:1px"class="blockquote custom-blockpuote blockpuote-outline-purple rounded mb-0">
											<div class="row">
												<c:forEach items="${attachList }" var="attach">
													<div class="col-md-4 col-sm-4 col-xs-12"  style="cursor:pointer;padding-right: 0;" onclick="location.href='<%=request.getContextPath()%>/popup/getFile.go?attachno=${attach.attachno}';">
														<div class="info-box">
														 	<span class="info-box-icon bg-yellow">
																<i class="fa fa-copy"></i>
															</span>
															<div class="info-box-content">
																<span class ="info-box-text">
																	<fmt:formatDate value="${attach.regdate }" pattern="yyyy-MM-dd" />
																</span><br>
																<span class ="info-box-number">${attach.filename }</span>
															</div>
														</div>
													 </div>
												</c:forEach>
											</div>
	                      				  </blockquote>
									</div>
								</div>
								</c:if>
									<!-- end modalbody -->
								<div class="modal-footer">
								<div class="form-check" style="float:left;">
                                    <input class="form-check-input" type="checkbox" id="formCheck" checked="">
                                    <label class="form-check-label" for="formCheck">
                                        	오늘 하루 보지 않기
                                    </label>
                                    <input type="hidden" id="checkId" value="">
                                </div>
									<button type="button" class="btn btn-light closePopup"
										data-bs-dismiss="modal">Close</button>
								</div>
								<!-- end modalfooter -->
							</div>
						</div>
					</div>
				</c:if>
		</div>

											</div>
										</div>
									</div>
									<!-- end col -->
								</div>
								<!-- end row -->
							</div>
							<!-- end card -->

						</div>
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->



			</div>
		</div>
		<!-- end container -->
	</div>
	<!-- end authentication section -->

	<!-- JAVASCRIPT -->
	<script src="assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="assets/libs/metismenujs/metismenujs.min.js"></script>
	<script src="assets/libs/simplebar/simplebar.min.js"></script>
	<script src="assets/libs/feather-icons/feather.min.js"></script>
	<script>
		function num_check() {
			alert('example@example.com 메일로 인증번호가 발송되었습니다.');
			/*  Swal.fire({
					 icon:'Good job!',
					 title:'You clicked the button!',
					 text:'success',
			 }); */
		}
	</script>
	
	
	<script>
function regist_go(){
			
		var myform = document.getElementById('uploadForm');
		var formData = new FormData(myform);
		 
			console.log(formData);
			
			
			Swal.fire({
			      icon: 'success',
			      title: '이력서가 제출되었습니다.'
			      
			    }).then((result) => {
				  if (result.value) {
						$.ajax({
							url : "registapply.go",
							type : "POST",
							processData: false,   
							contentType: false,
							data : formData,
							dataType : "text",
							success : function(data) {
//			 					console.log("data", data);
								if(data=="OK"){
									//alert("제출되었습니다.");
									window.location.reload();
								}
							},
							error : function(error) {
//			 					console.log("error", error)
								//alert("error : " + error.status);
							}
						});
				  }
				})
			
			
		
		}
	
	
	
	
	</script>
	
	<script>
	function autoLogin(auto){
		//console.log(auto);
		//console.log($(auto).val());
		
		var v=$(auto).val();
		
		if(v=="ROLE_STUDENT"){
			var ids = $('input[name=id]').val('sisi');
			var pwds = $('input[name=pwd]').val('sisi');
		}
		
		if(v=="ROLE_TEACHER"){
			var ids = $('input[name=id]').val('titi');
			var pwds = $('input[name=pwd]').val('titi');
		}
		
		if(v=="ROLE_MASTER"){
			var ids = $('input[name=id]').val('mimi');
			var pwds = $('input[name=pwd]').val('mimi');
		}
		
		var form=$('form[id="loginForm"]');

		form.submit();
		
		
		
	}
	</script>
</body>
</html>
