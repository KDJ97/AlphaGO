<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="subDetailList" value="${data.subnamecode}" />
<c:set var="subAreaList" value="${data.subAreaList }" />
<c:set var="subject" value="${data.subject }" />
<script>
function insertgo(){
	//alert("등록 버튼을 눌렀습니다.");
	
	
	
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

</script>
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


<script>
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

	$('#dap').val("");
	$('#dap2').text("");
	$('#sol').html("");
	$('#maincontent').html("");
	
	$('#floatingTextarea2').val("");
	
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
					'background-size' : 'contain',
					'background-repeat' : 'no-repeat'
				});
			}

			reader.readAsDataURL(picture.files[0]);
		}

		//문제 내용
		var maincontent = $('#floatingTextarea2').val();
			
		//답
		var dap = $('#dap').val();
		
	

		//해설
		var sol = $('#floatingTextarea3').val();
		
		$('#maincontent').html(maincontent);
	
		$('#dap2').html($('#dap').val());
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
$(function(){
	$('#processSelect').on("change",function(){
		location.href="problemcreateJ.go";
	})
})

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














<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>
<link
	href="/ddit/resources/assets/libs/choices.js/public/assets/styles/choices.min.css"
	rel="stylesheet" type="text/css">
<script>
$(function(){
	$('#processSelect').on("change",function(){
		location.href="problemcreateG.go";
	})
})

</script>
</head>
<body>
	<form role="form" class="form-horizontal" action="problemCreatego"
		method="post" id="probleminsertgo">

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
									style="height: 30px; line-height: 5px; margin-right: 5px;"onclick="previewgo();">미리보기</button>
							</div>
							<div>
								<button type="button" class="btn btn-soft-success"
									style="height: 30px; line-height: 5px; margin-right: 5px;"onclick="insertgo();">완료</button>
							</div>
						</div>

						<div class="d-flex justify-content-start">

							<label class="form-label" for="formrow-firstname-input"
								style="font-weight: bold; margin: 2px 15px 0px 0px;">세부
								과목</label>
						<select class="form-select col-md-3" id="subjectSelect"
								style="width: 130px; height: 30px; font-size: 0.7em;" name="subdetailCode">
							  <c:forEach items="${subDetailList}" var="class2">
<%-- 							           <option value="${class2.SUBDETAIL_CODE}">${ class2.SUBDETAIL_NAME}</option> --%>
											<option value="${ class2.SUBDETAIL_CODE}">${ class2.SUBDETAIL_NAME}</option>
										
									
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
								<select class="form-select col-md-3" id="processSelect"
									style="width: 130px; height: 30px; font-size: 0.7em;"name="lproblem">
									<option value="주관식" selected="selected">주관식</option>
									<option value="객관식">객관식</option>

								</select>
							</div>

							<div style="margin: 0px 35px 0px 35px;">
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 유형</label>
									<select class="form-select col-md-3" id="processSelect"
									style="width: 130px; height: 30px; font-size: 0.7em;"name="sanname">
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
								style="height: 120px; margin-bottom: 10px"name="problemContent"></textarea>
							<label for="floatingTextarea2" class="text-dark"
								style="font-weight: bold;">문제 </label>
						</div>
						<div class="form-floating">
							<textarea class="form-control bg-light text-dark"
								placeholder="Leave a comment here" id="dap"
								style="height: 120px"name="problemAnswer"></textarea>
							<label for="floatingTextarea2" class="text-dark"
								style="font-weight: bold;">답 </label>
						</div>

						<hr>
						<div class="form-floating">
							<textarea class="form-control bg-light text-dark"
								placeholder="Leave a comment here" id="floatingTextarea3"
								style="height: 120px"name="problemSolution"></textarea>
							<label for="floatingTextarea2" class="text-dark"
								style="font-weight: bold;">해설 </label>
									
						</div>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div class="card" style="height: 748px;">
					<div class="card-body" style="padding: 15px;">
						<div class="d-flex">
							<p style="font-weight: bold;" class="flex-grow-1">문제 미리보기</p>

						</div>

						<div class="mailbox-attachment-icon has-img" id="pictureView2"
							style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
						</div>
						<div class="bg-light" style="padding: 15px; border-radius: 10px;"id="preViewContent">
					<div id=maincontent></div>
						</div>

						<p style="font-weight: bold; margin-top: 15px;">답</p>
						<div class="bg-light" style="padding: 15px; border-radius: 10px;" >
							<p style="color: red; margin-bottom: 0px;"id='dap2'></p>
						</div>
						<p style="font-weight: bold; margin-top: 15px;">해설</p>
						<div class="bg-light" style="padding: 15px; border-radius: 10px;" id="sol">
						
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

