<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="danwon" value="${data.dan}" />
<c:set var="detailSubj" value="${data.detailSubj}" />
<c:set var="subDetailList" value="${data.subnamecode}" />
<c:set var="subDetailList" value="${data.subnamecode}" />
<c:set var="subAreaList" value="${data.subAreaList }" />
<c:set var="subject" value="${data.subject }" />
<c:set var="problem" value="${dataMap.problem}" />
<c:set var="jimoon" value="${dataMap.jimoon}" />
<c:set var="subAreaList" value="${data2.subAreaList }" />
<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>
<script>
$(function(){
	
	var c=$('#code').val();
    
	ProblemPictureThumb('<%=request.getContextPath()%>',c);
	
})
</script>
<script>

if("${problem.picture}"==""){
	$('#pictureView').css("display","none");
	
}else{
	$('#ign').css('display',"none");
	$('#imginsert').css('display','');
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
function insertgo(){
	
	
	
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
$(function(){
	$('#processSelect').on("change",function(){
		location.href="problemcreateJ.go";
	})
})

</script>




<script>
function backgo(){
	window.history.back();
}

</script>








</head>
<body>
<input type="hidden" id="code"value="${problem.problemCode}">

	
	<form role="form" class="form-horizontal" action="problemModifygo.go" method="post" id="probleminsertgo">
		<div class="row gx-3 gy-2">
		
			<div class="col-6" style="float: left;height:870px;">
				<div class="card">
					<div class="card-body" style="padding: 15px;height:870px;">
						<div class="d-flex mb-2">
							<div class="me-auto d-flex justify-content-start">
								<h5
									style="font-weight: bold; margin-top: 2px; margin-bottom: 15px;">
									<i class="uil-book-open" style="margin-right: 10px;"></i>문제 수정
								</h5>
								<span class="badge rounded-pill bg-info"
									style="font-size: 1.0em; margin: 0px 0px 11px 10px;">${subject}</span>
							</div>

						<div>
								<button type="button" class="btn btn-soft-secondary"
									style="height: 30px; line-height: 5px; margin-right: 5px;"
									onclick="backgo();">뒤로가기</button>
							</div>


							<div>
								<button type="button" class="btn btn-secondary"
									style="height: 30px; line-height: 5px; margin-right: 5px;"
									onclick="resetgo();">리셋</button>
							</div>
							<div>
								<button type="button" class="btn btn-warning"
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
								style="font-weight: bold; margin: 2px 15px 0px 0px;font-size:0.8em;">세부
								과목</label> 
								<select class="form-select col-md-3" id="subjectSelect"
								style="width: 100px; height: 30px; font-size: 0.7em;" name="">
							
							           <option value="${detailSubj}">${detailSubj}</option>

									
									
							</select>
							 <label class="form-label" for="formrow-firstname-input"
								style="font-weight: bold; margin: 2px 15px 0px 44px;font-size:0.8em;">단원
							</label> 
							<select class="form-select col-md-3" id="danSelect1"
								style="width: 120px; height: 30px; font-size: 0.7em;"name="subjectProccess">
								  <option value="${problem.subjectProccess}">${problem.subunitName}</option>
								
							</select>
						</div>
						<hr style="margin: 10px 0px 10px 0px;">
						<div class="d-flex justify-content-start">

							<div>
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 형식</label>
							
								<select class="form-select col-md-3" id="processSelect"
									style="width: 90px; height: 30px; font-size: 0.7em;"name="lproblem">
									
									<option value="객관식" selected="selected">객관식</option>

								</select>

							</div>

							<div style="margin: 0px 35px 0px 35px;">
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 유형</label>
				
									<select class="form-select col-md-3" id="processSelect"
									style="width: 130px; height: 30px; font-size: 0.7em;"name="sano">
								 <c:forEach items="${subAreaList}" var="subarea">
							      								      <option value="${subarea.SANO}">${subarea.SANAME}</option>


									
									</c:forEach> 

								</select>
							</div>
							<div>
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">난이도</label> 
									<select
									class="form-select col-md-3" id="processSelect"
									style="width: 80px; height: 30px; font-size: 0.7em;"name="plevel">
									<option value="하" ${problem.plevel=='하'?'selected':'' }>하</option>
									<option value="중"${problem.plevel=='중'?'selected':'' }>중</option>
									<option value="상"${problem.plevel=='상'?'selected':'' }>상</option>
								</select>
							</div>
						</div>
						<hr style="margin: 10px 0px 15px 0px;">


						<div class="form-floating">



		<button type="button" class="btn btn-soft-success" id="ign"
								onclick="imginsertgo();"
								style="height: 30px; line-height: 5px;  margin-bottom: 10px; float: right;">이미지 추가</button>
													
							<div id="imginsert" style='display: none;'>

								<div class="input-group input-group-sm">
									<div class="col-sm-6"></div>
									<div class="col-sm-6">
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


							<div class="mailbox-attachment-icon has-img view${problem.problemCode}" id="pictureView"
								style="border: 1px solid green; height: 150px; width: 45%; margin: 0 auto; margin-bottom: 10px;">
							</div>


						
							<textarea class="form-control bg-light text-dark"
								placeholder="Leave a comment here" id="floatingTextarea2"
								style="height: 80px; margin-bottom: 10px"name="problemContent">${problem.problemContent}</textarea>
							<label for="floatingTextarea2" class="text-dark"
								style="font-weight: bold;">문제 </label>
						</div>

						<div class="row" style="margin-top: 10px;">
							<div class="col-1">
								<input class="form-check-input" type="radio" name="problemAnswer"
									id="formRadios1" checked style="margin: 12px;" value='1'${problem.problemAnswer=='1'?'checked':''}>
							</div>
							<div class="col-11">
								<div class="form-floating bg-light">
									<input type="text" class="form-control bg-light text-dark"
										id="oneN" placeholder="title" value="${problem.none }"
										style="height: 30px; width: 100%;" name="none"> <label
										for="floatingTitle" class="text-dark"
										style="font-weight: bold; line-height: 4px;">①</label>
								</div>
							</div>
						</div>

						<div class="row" style="margin-top: 10px;">
							<div class="col-1">
								<input class="form-check-input" type="radio" name="problemAnswer"
									id="formRadios2" checked style="margin: 12px;" value='2'${problem.problemAnswer=='2'?'checked':''}>
							</div>
							<div class="col-11">
								<div class="form-floating bg-light">
									<input type="text" class="form-control bg-light text-dark"
										id="twoN" placeholder="title" value="${problem.ntwo }"
										style="height: 30px; width: 100%;" name="ntwo"> <label
										for="floatingTitle" class="text-dark"
										style="font-weight: bold; line-height: 4px;">②</label>
								</div>
							</div>
						</div>
						<div class="row" style="margin-top: 10px;">
							<div class="col-1">
								<input class="form-check-input" type="radio" name="problemAnswer"
									id="formRadios3" checked style="margin: 12px;" value='3'${problem.problemAnswer=='3'?'checked':''}>
							</div>
							<div class="col-11">
								<div class="form-floating bg-light">
									<input type="text" class="form-control bg-light text-dark"
										id="treeN" placeholder="title"
										style="height: 30px; width: 100%;"name="ntree"value="${problem.ntree }"> <label
										for="floatingTitle" class="text-dark"
										style="font-weight: bold; line-height: 4px;">③</label>
								</div>
							</div>
						</div>
						<div class="row" style="margin-top: 10px;">
							<div class="col-1">
								<input class="form-check-input" type="radio" name="problemAnswer"
									id="formRadios4" checked style="margin: 12px;"value='4'${problem.problemAnswer=='4'?'checked':''}>
							</div>
							<div class="col-11">
								<div class="form-floating bg-light">
									<input type="text" class="form-control bg-light text-dark"
										id="fourN" placeholder="title"
										style="height: 30px; width: 100%;"name="nfour"value="${problem.nfour }"> <label
										for="floatingTitle" class="text-dark"
										style="font-weight: bold; line-height: 4px;">④</label>
								</div>
							</div>
						</div>  
						<div class="row" style="margin-top: 10px;">
							<div class="col-1">
								<input class="form-check-input" type="radio" name="problemAnswer"
									id="formRadios5" ${problem.problemAnswer=='5'?'checked':''} style="margin: 12px;" value='5'>
							</div>
							<div class="col-11">
								<div class="form-floating bg-light">
									<input type="text" class="form-control bg-light text-dark"
										id="fiveN" placeholder="title"
										style="height: 30px; width: 100%;"name="nfive"value="${problem.nfive}"> <label
										for="floatingTitle" class="text-dark"
										style="font-weight: bold; line-height: 4px;">⑤</label>
								</div>
							</div>
						</div>


						<hr>
						<div class="form-floating" style="height: 100px; overflow: auto;">
							<textarea class="form-control bg-light text-dark"
								placeholder="Leave a comment here" id="floatingTextarea3"
								style="height: 100px"name="problemSolution">${problem.problemSolution}</textarea>
							<label for="floatingTextarea3" class="text-dark"
								style="font-weight: bold;">해설 </label>
						</div>
					</div>
				</div>
			</div>
			<div class="col-6">
				<div class="card" style="height: 870px;">
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
			<input type="hidden" name="problemCode" value="${problem.problemCode}">
	</form>
	

	<form role="imageForm" action="upload/picture" method="post"
		enctype="multipart/form-data">
		<input id="inputFile" name="pictureFile" type="file"
			class="form-control" style="display: none;" onchange="picture_go();">
		<input id="oldFile" type="hidden" name="oldPicture" value="${problem.picture }" /> <input
			type="hidden" name="checkUpload" value="0" />
	</form>





</body>
</html>