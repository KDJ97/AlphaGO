<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<c:set var="subDetailList" value="${data.subnamecode}" />
<c:set var="subAreaList" value="${data.subAreaList }" />
<c:set var="subject" value="${data.subject }" />


<script>
	function picture_go() {
		//alert("file change");

		var form = $('form[role="imageForm"]');
		var picture = form.find('[name=pictureFile]')[0];

		//이미지 확장자 jpg 확인
		var fileFormat = picture.value.substr(
				picture.value.lastIndexOf(".") + 1).toUpperCase();
		if (!(fileFormat == "JPG" || fileFormat == "JPEG")) {
			alert("이미지는 jpg/jpeg 형식만 가능합니다.");
			picture.value = "";
			return;
		}

		//이미지 파일 용량 체크
		if (picture.files[0].size > 1024 * 1024 * 1) {
			alert("사진 용량은 1MB 이하만 가능합니다.");
			picture.value = "";
			return;
		}
		;

		//업로드 확인변수 초기화 (사진변경)
		form.find('[name="checkUpload"]').val(0);
		document.getElementById('inputFileName').value = picture.files[0].name;

		if (picture.files && picture.files[0]) {

			var reader = new FileReader();

			reader.onload = function(e) {
				$('div#pictureView').css({
					'background-image' : 'url(' + e.target.result + ')',
					'background-position' : 'center',
					'background-size' : 'contain',
					'background-repeat' : 'no-repeat'
				});
			}
			
			
			
			
			reader.readAsDataURL(picture.files[0]);
		}
	}
</script>

<script type="text/javascript">
	//취소
	function resetgo() {
		var form = $('form[role="imageForm"]');
		var picture = form.find('[name=pictureFile]')[0];
		$('#inputFile').val("");
		$('#pictureView').css('background-image', 'url("")');
		$('#pictureView2').css('background-image', 'url("")');
		$('#ign').show();
		$('#imginsert').css("display", "none");
		$('#pictureView').css("display", "none");
		$('#pictureView2').css("display", "none");

		$('#dap').html("");
		$('#sol').html("");
		$('#maincontent').html("");
		$('#1').html("");
		$('#2').html("");
		$('#3').html("");
		$('#4').html("");
		$('#5').html("");
		$('#floatingTextarea2').val("");
		$('#oneN').val("");
		$('#twoN').val("");
		$('#treeN').val("");
		$('#fourN').val("");
		$('#fiveN').val("");
		$('#floatingTextarea3').val("");
		
	}
</script>


<script>
	//미리보기
	function previewgo() {

		var form = $('form[role="imageForm"]');
		var picture = form.find('[name=pictureFile]')[0];

		if (undefined == picture.files[0]) {
			$("#pictureView2").css("display", "none");

		} else {
			$("#pictureView2").css("display", "");
		}
		if (picture.files && picture.files[0]) {

			var reader = new FileReader();

			reader.onload = function(e) {
				$('div#pictureView2').css({
					'background-image' : 'url(' + e.target.result + ')',
					'background-position' : 'center',
					'background-size' : 'cover',
					'background-repeat' : 'no-repeat'
				});
			}

			reader.readAsDataURL(picture.files[0]);
		}

		//문제 내용
		var maincontent = $('#floatingTextarea2').val();

		//답
		var dap = $("input[name='problemAnswer']:checked").val();

		//1번보기
		var onen = $('#oneN').val();

		//2번보기
		var twon = $('#twoN').val();

		//3번보기
		var treen = $('#treeN').val();

		//4번보기
		var fourn = $('#fourN').val();

		//5번보기
		var fiven = $('#fiveN').val();

		//해설
		var sol = $('#floatingTextarea3').val();

		$('#maincontent').html(maincontent);
		$('#1').html(onen);
		$('#2').html(twon);
		$('#3').html(treen);
		$('#4').html(fourn);
		$('#5').html(fiven);
		var ddd = "";
		if (dap == '1') {
			ddd = '①' + onen;

		}
		if (dap == '2') {
			ddd = '②' + twon;
		}
		if (dap == '3') {
			ddd = '③' + treen;
		}
		if (dap == '4') {
			ddd = '④' + fourn;
		}
		if (dap == '5') {
			ddd = '⑤' + fiven;
		}
		$('#dap').html(ddd);
		$('#sol').html(sol);
	}
</script>
<script>
	function imginsertgo() {

		$('#ign').hide();
		$('#imginsert').css("display", "");
		$('#pictureView').css("display", "");
		//	$('#gbody').css("display","");
	}
</script>
<script>
	function cancelgo() {

		$('#inputFile').val("");

		$('#pictureView').css('background-image', 'url("")');
		
		$('#ign').show();
		$('#imginsert').css("display", "none");
		$('#pictureView').css("display", "none");

	}
</script>
<script>
var subDetailCode="";
var dsubject
$(function(){
	dsubject=$('#subjectSelect :selected').text();
	subDetailCode=$('#subjectSelect :selected').val();
	classpogSearchgo3();
	
	$('#subjectSelect').on('change',function(){
		dsubject=$('#subjectSelect :selected').text();
		subDetailCode=$('#subjectSelect :selected').val();
	   
		
		classpogSearchgo3();
	})
	
	
})

</script>
<script>
function classpogSearchgo3(){
    
     
	$.ajax({
		url : '<%=request.getContextPath()%>/rteacher/dsubjectSearch',
		type : 'get',
		data : {'name' : dsubject,"detailCode":subDetailCode},
	    success : function(res){
	    	var str="";
	    	
	         if(res.length<1){
	        	str+="  <option value=''>아무것도 없다</option>" 
	         }
	         else{
	             $.each(res,function(i,v){
	            	str+="<option value='"+v.subjectProccess+"'>"+v.subunitName+"</option>" 
	  		   })
	         }
	        $('#danSelect').html(str);
			   	
		},
		error : function(xhr){
			//alert("상태 : " + xhr.status + " 체크");
			alert("오류");
		},
		dataType : 'json'
	});
}



</script>




<script>
function insertgo(){
	//alert("등록 버튼을 눌렀습니다.");
	
	Swal.fire({
	      icon: 'success',
	      title: '문제가 출제되었습니다.'
	      
	    }).then((result) => {
		  if (result.value) {

				if($('input[name="pictureFile"]').val()){
					
				     var formData = new FormData($('form[role="imageForm"]')[0]);

					$.ajax({
						url:"<%=request.getContextPath()%>/rteacher/picture.go",
						data:formData,
						type:"post",
					    processData:false,
				        contentType:false,
				        success:function(data){
				        	        
				       		    	  $('#pickpicture').val(data);
				       		    	$('#probleminsertgo').submit();
				    	
				        },
				        error:function(error){
				          alert("현재 사진 업로드가 불가합니다.\n 관리자에게 연락바랍니다.");
				        }
					});
				}
				else{
					$('#probleminsertgo').submit();
				}
				
		  }
		})
	
	

	
}

</script>
<script>
$(function(){
	$('#processSelect').on("change",function(){
		location.href="problemcreateJ.go";
	})
})

</script>


<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>
<link
	href="/ddit/resources/assets/libs/choices.js/public/assets/styles/choices.min.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<form role="form" class="form-horizontal" action="problemCreatego" method="post" id="probleminsertgo">
		<div class="row gx-3 gy-2">
			<div class="col-6" style="float: left;">
				<div class="card">
					<div class="card-body" style="padding: 15px;">
						<div class="d-flex mb-2">
							<div class="me-auto d-flex justify-content-start">
								<h5
									style="font-weight: bold; margin-top: 2px; margin-bottom: 15px;">
									<i class="uil-book-open" style="margin-right: 10px;"></i>문제 출제
								</h5>
								<span class="badge rounded-pill bg-info"
									style="font-size: 1.0em; margin: 0px 0px 11px 10px;">${subject}</span>
							</div>

							<div>
								<button type="button" class="btn btn-soft-secondary"
									style="height: 30px; line-height: 5px; margin-right: 5px;"
									onclick="resetgo();">취소</button>
							</div>
							<div>
								<button type="button" class="btn btn-soft-warning"
									style="height: 30px; line-height: 5px; margin-right: 5px;"
									onclick="previewgo();">미리보기</button>
							</div>
							<div>
								<button type="button" class="btn btn-soft-success"
									style="height: 30px; line-height: 5px; margin-right: 5px;"
									onclick="insertgo();">완료</button>
							</div>
						</div>

						<div class="d-flex justify-content-start" id="">

							<label class="form-label" for="formrow-firstname-input"
								style="font-weight: bold; margin: 2px 15px 0px 0px;">세부
								과목</label> 
								<select class="form-select col-md-3" id="subjectSelect"
								style="width: 130px; height: 30px; font-size: 0.7em;" name="subdetailCode">
							  <c:forEach items="${subDetailList}" var="class2">
<%-- 							           <option value="${class2.SUBDETAIL_CODE}">${ class2.SUBDETAIL_NAME}</option> --%>
										<option value="${class2.SUBDETAIL_CODE}">${class2.SUBDETAIL_NAME}</option>
										
									
									</c:forEach> 
							</select>
							 <label class="form-label" for="formrow-firstname-input"
								style="font-weight: bold; margin: 2px 15px 0px 44px;">단원
							</label> 
							<select class="form-select col-md-3" id="danSelect"
								style="width: 150px; height: 30px; font-size: 0.7em;"name="subjectProccess">
								
								
							</select>
						</div>
						<hr style="margin: 10px 0px 10px 0px;">
						<div class="d-flex justify-content-start">

							<div>
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 형식</label>
								<!-- 							<div class="dropdown" style="margin-bottom: 5px;"> -->
								<!-- 								<button class="btn btn-soft-secondary dropdown-toggle" -->
								<!-- 									type="button" id="dropdownMenuButton1" -->
								<!-- 									data-bs-toggle="dropdown" -->
								<!-- 									style="width: 130px; height: 30px; line-height: 10px;" -->
								<!-- 									aria-expanded="false"> -->
								<!-- 									객관식/주관식<i class="mdi mdi-chevron-down" -->
								<!-- 										style="margin-left: 10px;"></i> -->
								<!-- 								</button> -->
								<!-- 								<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1"> -->
								<!-- 									<li><a class="dropdown-item" href="javascript:ggo();">객관식 </a></li> -->
								<!-- 									<li><a class="dropdown-item" href="javascript:jgo();">주관식</a></li> -->
								<!-- 								</ul> -->
								<!-- 							</div> -->
								<select class="form-select col-md-3" id="processSelect"
									style="width: 130px; height: 30px; font-size: 0.7em;"name="lproblem">
									<option value="주관식">주관식</option>
									<option value="객관식" selected="selected">객관식</option>

								</select>

							</div>

							<div style="margin: 0px 35px 0px 35px;">
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 유형</label>
								<!-- 							<div class="dropdown" style="margin-bottom: 5px;"> -->
								<!-- 								<button class="btn btn-soft-secondary dropdown-toggle" -->
								<!-- 									type="button" id="dropdownMenuButton2" -->
								<!-- 									data-bs-toggle="dropdown" -->
								<!-- 									style="width: 130px; height: 30px; line-height: 10px;" -->
								<!-- 									aria-expanded="false"> -->
								<!-- 									문제 유형<i class="mdi mdi-chevron-down" style="margin-left: 10px;"></i> -->
								<!-- 								</button> -->
								<!-- 								<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2"> -->
								<!-- 									<li><a class="dropdown-item" href="#">문학</a></li> -->
								<!-- 									<li><a class="dropdown-item" href="#">비문학</a></li> -->
								<!-- 								</ul> -->
								<!-- 							</div> -->
								<select class="form-select col-md-3" id="processSelect"
									style="width: 130px; height: 30px; font-size: 0.7em;"name="saname">
								 <c:forEach items="${subAreaList}" var="subarea">
							      								      <option value="${subarea.SANAME}">${subarea.SANAME}</option>


									
									</c:forEach> 

								</select>
							</div>
							<div>
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">난이도</label> 
									<select
									class="form-select col-md-3" id="processSelect"
									style="width: 130px; height: 30px; font-size: 0.7em;"name="plevel">
									<option value="하">하</option>
									<option value="중">중</option>
									<option value="상">상</option>
								</select>
							</div>
						</div>
						<hr style="margin: 10px 0px 15px 0px;">


						<div class="form-floating">

							<button type="button" class="btn btn-soft-success" id="ign"
								onclick="imginsertgo();"
								style="height: 30px; line-height: 5px; margin-right: 5px; margin-bottom: 10px; float: right;">이미지
								첨부</button>

							<div id="imginsert" style='display: none;'>

								<div class="input-group input-group-sm">
									<div class="col-sm-8"></div>
									<div class="col-sm-4">
										<button type="button" class="btn btn-soft-danger"
											style="height: 30px; line-height: 5px; margin-right: 5px; float: right;"
											onclick="cancelgo();">취소</button>
										<input id="inputFileName" class="form-control" type="hidden"
											name="tempPicture" disabled /> <span
											class="input-group-append-sm"
											style="margin-right: 10px; float: right;"> <label
											for="inputFile"
											class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
										</span>

									</div>
								</div>
							</div>


							<div class="mailbox-attachment-icon has-img" id="pictureView"
								style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
							</div>


						
							<textarea class="form-control bg-light text-dark"
								placeholder="Leave a comment here" id="floatingTextarea2"
								style="height: 80px; margin-bottom: 10px"name="problemContent"></textarea>
							<label for="floatingTextarea2" class="text-dark"
								style="font-weight: bold;">문제 </label>
						</div>

						<div class="row" style="margin-top: 10px;">
							<div class="col-1">
								<input class="form-check-input" type="radio" name="problemAnswer"
									id="formRadios1" checked style="margin: 12px;" value='1'>
							</div>
							<div class="col-11">
								<div class="form-floating bg-light">
									<input type="text" class="form-control bg-light text-dark"
										id="oneN" placeholder="title"
										style="height: 30px; width: 100%;" name="none"> <label
										for="floatingTitle" class="text-dark"
										style="font-weight: bold; line-height: 4px;">①</label>
								</div>
							</div>
						</div>

						<div class="row" style="margin-top: 10px;">
							<div class="col-1">
								<input class="form-check-input" type="radio" name="problemAnswer"
									id="formRadios2" checked style="margin: 12px;" value='2'>
							</div>
							<div class="col-11">
								<div class="form-floating bg-light">
									<input type="text" class="form-control bg-light text-dark"
										id="twoN" placeholder="title"
										style="height: 30px; width: 100%;" name="ntwo"> <label
										for="floatingTitle" class="text-dark"
										style="font-weight: bold; line-height: 4px;">②</label>
								</div>
							</div>
						</div>
						<div class="row" style="margin-top: 10px;">
							<div class="col-1">
								<input class="form-check-input" type="radio" name="problemAnswer"
									id="formRadios3" checked style="margin: 12px;" value='3'>
							</div>
							<div class="col-11">
								<div class="form-floating bg-light">
									<input type="text" class="form-control bg-light text-dark"
										id="treeN" placeholder="title"
										style="height: 30px; width: 100%;"name="ntree"> <label
										for="floatingTitle" class="text-dark"
										style="font-weight: bold; line-height: 4px;">③</label>
								</div>
							</div>
						</div>
						<div class="row" style="margin-top: 10px;">
							<div class="col-1">
								<input class="form-check-input" type="radio" name="problemAnswer"
									id="formRadios4" checked style="margin: 12px;" value='4'>
							</div>
							<div class="col-11">
								<div class="form-floating bg-light">
									<input type="text" class="form-control bg-light text-dark"
										id="fourN" placeholder="title"
										style="height: 30px; width: 100%;"name="nfour"> <label
										for="floatingTitle" class="text-dark"
										style="font-weight: bold; line-height: 4px;">④</label>
								</div>
							</div>
						</div>  
						<div class="row" style="margin-top: 10px;">
							<div class="col-1">
								<input class="form-check-input" type="radio" name="problemAnswer"
									id="formRadios5" checked style="margin: 12px;" value='5'>
							</div>
							<div class="col-11">
								<div class="form-floating bg-light">
									<input type="text" class="form-control bg-light text-dark"
										id="fiveN" placeholder="title"
										style="height: 30px; width: 100%;"name="nfive"> <label
										for="floatingTitle" class="text-dark"
										style="font-weight: bold; line-height: 4px;">⑤</label>
								</div>
							</div>
						</div>


						<hr>
						<div class="form-floating" style="height: 100px; overflow: auto;">
							<textarea class="form-control bg-light text-dark"
								placeholder="Leave a comment here" id="floatingTextarea3"
								style="height: 100px"name="problemSolution"></textarea>
							<label for="floatingTextarea3" class="text-dark"
								style="font-weight: bold;">해설 </label>
						</div>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div class="card" style="height: 837px;">
					<div class="card-body" style="padding: 15px;">
						<div class="d-flex">
							<p style="font-weight: bold;" class="flex-grow-1">문제 미리보기</p>

						</div>
						<div class="mailbox-attachment-icon has-img" id="pictureView2"
							style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
						</div>

						<div class="bg-light"
							style="padding: 15px; border-radius: 10px; height: 250px; overflow: auto; margin-bottom: 10px;"
							id="preViewContent">
							<div id=maincontent></div>

							<p style="margin-left: 10px; margin-bottom: 0px;">
								①<label id='1'></label><br>②<label id='2'></label><br>③<label
									id='3'></label><br>④<label id='4'></label><br>⑤<label
									id='5'></label>
							</p>
						</div>

						<p style="font-weight: bold; margin-top: 15px;">해설 및 답</p>
						<div class="bg-light"
							style="padding: 15px; border-radius: 10px; height: 300px; overflow: auto;">
							<p>
								정답<span
									style="font-weight: bold; color: red; margin-left: 15px;"
									id="dap"> </span>
							</p>
							<div id="sol"></div>
						</div>

					</div>

				</div>

			</div>
		</div>
		<input type="hidden" name="picture" id="pickpicture">
	</form>
	

	<form role="imageForm" action="upload/picture" method="post"
		enctype="multipart/form-data">
		<input id="inputFile" name="pictureFile" type="file"
			class="form-control" style="display: none;" onchange="picture_go();">
		<input id="oldFile" type="hidden" name="oldPicture" value="" /> <input
			type="hidden" name="checkUpload" value="0" />
	</form>















</body>
