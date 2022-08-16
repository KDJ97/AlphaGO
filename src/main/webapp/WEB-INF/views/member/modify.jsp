<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style type="text/css">
.card{
    margin-bottom: 10px;
}
h5.card-title {
	font-weight: bold;
	padding-top: 3px;
}
</style>


<script type="text/javascript">
var val_check = false;
$(function(){
	mailSelect('on');

	$('div#pictureView').css({
		'background-image' : 'url(<%=request.getContextPath()%>/member/getPicture.do?id=${loginUser.id})',
		'background-position' : 'center',
		'background-size' : 'cover',
		'background-repeat' : 'no-repeat'
	});

});

function isSame() {
	if(val_check){
		$('#passWord_check').attr("pattern", $('#passWord').val());
	}
}

function modifyBtn(){
 		// 둘다 비어있으면 비밀번호 변경안함
			if($('#passWord_check').val() == '' && $('#passWord').val() == ''){
				//location.href='detail.go';
				modify_submit();
				return;
			}

	 Swal.fire({
	      icon: 'success',
	      title: '개인정보가 수정되었습니다.'

	    }).then((result) => {


    			var form = document.getElementById("needs-validation");
    			 if (form.checkValidity() == false) {
    		        event.preventDefault();
    		        event.stopPropagation();
    		        form.classList.add("was-validated");
    			      val_check = true;
    			      isSame();
    		      }else{
    				//location.href='detail.go';
    		    	modify_submit();
    		      }


   		})



}

function mailSelect(on) {
	var v_select = $('select[name=mail_select]').val();
	if(!on){
		$('#mail2').val(v_select);
	}
	if(v_select == ''){
		//readonly 해제
		$('#mail2').attr("readonly",false);
	}else{
		$('#mail2').attr("readonly",true);
	}
}
</script>


<script type="text/javascript">
function openSelectModel(btn){
	var id = $(btn).parent().prev().attr('id');
	window.open("selectUni.go?id="+id, "uniSearch", "width=500,height=600,left=800,top=200");
}

function selectUniCode(id, val){
	$('#'+id).val(val);
}

function searchAddress(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            $('#address').val(data.address)
        }
    }).open({
        left: 800,
        top: 200
    });
}
</script>

<script type="text/javascript">
function modify_submit(){
	var newForm = $('<form></form>');
	newForm.attr("name","newForm");
	newForm.attr("method","post");
	newForm.attr("action","modify.go");

	newForm.append($('<input/>', {type: 'hidden', name: 'id', value: '${loginUser.id}' }));

	//비밀번호 변경했는가?
	if(val_check){
		var v_pwd = $('#passWord_check').val();
		newForm.append($('<input/>', {type: 'hidden', name: 'pwd', value: v_pwd }));
	}else{
		newForm.append($('<input/>', {type: 'hidden', name: 'pwd', value:'${loginUser.pwd}' }));
	}

	//전화번호 값이 모두 있을때
	if($('#phone2').val().trim() != '' && $('#phone3').val().trim() != ''){
		var v_phone = $("#phone1").val() + "-" + $('#phone2').val().trim()  + "-" + $('#phone3').val().trim();
		newForm.append($('<input/>', {type: 'hidden', name: 'phone', value: v_phone }));
	}

	//부모 전화번호 값이 모두 있을때
	if($('#p_phone2').val().trim() != '' && $('#p_phone3').val().trim() != ''){
		var v_prentPhone = $("#p_phone1").val() + "-" + $('#p_phone2').val().trim()  + "-" + $('#p_phone3').val().trim();
	newForm.append($('<input/>', {type: 'hidden', name: 'parentPhone', value: v_prentPhone }));
	}

	var v_email = $('#mail1').val().trim() + "@" + $('#mail2').val().trim();
	newForm.append($('<input/>', {type: 'hidden', name: 'email', value: v_email }));

	var v_add = $('#address').val().trim();
	newForm.append($('<input/>', {type: 'hidden', name: 'address', value: v_add }));

	var v_detailAdd = $('#detailAddress').val().trim();
	newForm.append($('<input/>', {type: 'hidden', name: 'detailAddress', value: v_detailAdd }));

	var v_u1 = $('#fuUni').val();
	var v_u2 = $('#suUni').val();
	var v_u3 = $('#tuUni').val();
	newForm.append($('<input/>', {type: 'hidden', name: 'fuUni', value: v_u1 }));
	newForm.append($('<input/>', {type: 'hidden', name: 'suUni', value: v_u2 }));
	newForm.append($('<input/>', {type: 'hidden', name: 'tuUni', value: v_u3 }));

	//사진 데이터가 있는가?
	if($('input[name="picture"]').val()){
		newForm.append($('<input/>', {type: 'hidden', name: 'picture', value: $('input[name="picture"]').val() }));
	}else{
		newForm.append($('<input/>', {type: 'hidden', name: 'picture', value: '${loginUser.picture}' }));
	}

	newForm.appendTo('body');

	newForm.submit();
}
</script>

<!-- 이미지 업로드 -->
<script type="text/javascript">
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


	//업로드 확인변수 초기화(사진변경)
	form.find('[name="checkUpload"]').val(0);

	document.getElementById('inputFileName').value = picture.files[0].name;
	//$('#inputFileName').val(picture.files[0].name)

	if (picture.files && picture.files[0]) {
		var reader = new FileReader();

		reader.onload = function(e) {
			$('div#pictureView').css({
				'background-image' : 'url(' + e.target.result + ')',
				'background-position' : 'center',
				'background-size' : 'cover',
				'background-repeat' : 'no-repeat'
			});
		}

		reader.readAsDataURL(picture.files[0]);
	}

}

function upload_go() {
	//alert('upload btn click')

	if (!$('input[name="pictureFile"]').val()) {
		alert('사진을 선택하세요.')
		$('input[name="pictureFile"]').click();
		return;
	}

	if ($('input[name="checkUpload"]').val() == 1) {
		alert("이미 업로드 된 사진입니다.");
		return;
	}

	var formData = new FormData($('form[role="imageForm"]')[0]);

	$.ajax({
		url : "picture.go",
		data : formData,
		type : "post",
		processData : false,
		contentType : false,
		success : function(data) {
			//업로드 확인변수 세팅
			$('input[name="checkUpload"]').val(1);
			//저장된 파일명 저장.
			$('input#oldFile').val(data);//변경시 삭제될 파일명
			$('input[name="picture"]').val(data);
			alert("사진이 업로드 되었습니다.");

		},
		error : function(error) {
			alert("현재 사진 업로드가 불가합니다.\n 관리자에게 연락바랍니다.");
		}
	})

}
</script>



</head>
<body>
	<div class="d-flex justify-content-between mb-2">
		<h5 style="font-weight: bold;">
			<i class="uil-unlock-alt" style="margin-right: 10px;"></i>개인정보 수정
		</h5>
		<div class="d-flex justify-content-end">
			<button type="button" class="btn btn-secondary"
				style="height: 30px; line-height: 12px; margin-right: 5px;"
				onclick="location.href='detail.go'">취소</button>
			<button type="button" class="btn btn-purple" style="height: 30px; line-height: 12px;"
				onclick="modifyBtn()">수정완료</button>
		</div>
	</div>
	<div class="row">
		<div class="col-4" style="padding: 0px;">
			<div class="card" style="height: 892px">
				<div class="card-body">
					<div style="text-align: center;">
 						<div class="rounded-circle" id="pictureView"
										style="border: 1px solid lightgrey; height: 150px; width: 150px; margin: 0 auto;"></div>

						<div class="d-flex align-items-start mt-3 mb-3">

							<!-- 이미지 업로드 -->
							  <input type="hidden" name="picture" />
							<label for="inputFile" class=" btn btn-secondary btn-sm btn-flat input-group-addon">파일선택</label>
							  <input id="inputFileName" class="form-control form-control-sm" type="text"
								  style="width: 166px;" name="tempPicture" disabled />
							  <button onclick="upload_go();"
							  	type="button" class="btn btn-purple" style="margin-left:10px; height: 28px; line-height: 10px; width: 55px;">등록</button>

							<form role="imageForm" action="upload/picture" method="post" enctype="multipart/form-data">
							  <input id="inputFile" name="pictureFile" type="file" onchange="picture_go()" class="form-control" style="display: none;">
							  <input id="oldFile" type="hidden" name="oldPicture" value="" />
							  <input type="hidden" name="checkUpload" value="0" />
							</form>

						</div>
					</div>
					<div class="mt-3 mb-3">
						<label class="form-label"style="font-weight: bold; margin-right: 35px;">이름</label>
						${sessionScope.loginUser.name }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-3">
						<label class="form-label" style="font-weight: bold; margin-right: 21px;">아이디</label>
						${sessionScope.loginUser.id }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-3">
						<label class="form-label" style="font-weight: bold; margin-right: 35px;">학교</label>
						${sessionScope.loginUser.schoolName }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-2">
						<label class="form-label" style="font-weight: bold; margin-right: 35px;">학년</label>
						${sessionScope.loginUser.grade }학년
					</div>
				</div>
			</div>
		</div>
		<div class="col-8">


					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-purple text-white">
										01</div>
								</div>
							</div>
							<div class="flex-grow-1">
								<h5 class="card-title">비밀번호 변경</h5>
							</div>
						</div>
						<div class="card-body">
						  <form id="needs-validation" novalidate>
							<div class="row">
							  <div class="col-3">
							      <label for="passWord" style="font-weight: bold;">비밀번호</label>
							  </div>
							  <div class="col-9">
							      <input style="height: 30px;" type="password" class="form-control" onkeyup="isSame()" id="passWord" required pattern="^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$" maxlength="25">
							      <div class="valid-feedback"><!--  Great! --></div>
							      <div class="invalid-feedback">
							       	 영문, 숫자, 특수기호 조합으로 8-25자리 입력해주세요.
							      </div>
							  </div>
							</div>
							<br>
							<div class="row">
							  <div class="col-3">
							      <label for="passWord_check" style="font-weight: bold;">비밀번호 확인</label>
							  </div>
							  <div class="col-9">
							      <input style=" height: 30px;" type="password" class="form-control" id="passWord_check" required pattern="" onkeyup="isSame()" maxlength="25">
							      <div class="valid-feedback"><!-- 비밀번호가 일치합니다 --></div>
							      <div class="invalid-feedback">비밀번호가 일치하지 않습니다</div>
							  </div>
							</div>
						  </form>
						</div>
					</div>
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-purple text-white">
										02</div>
								</div>
							</div>
							<div class="flex-grow-1">
								<h5 class="card-title">연락처 정보</h5>
							</div>
						</div>
						<div class="card-body">
							<div class="mb-2">
								<div class="d-flex align-items-start"
									style="text-align: center;">
									<label class="form-label" style="font-weight: bold; margin-top: 5px; margin-right: 68px;">
										핸드폰 번호
									</label>
									<select id="phone1"
										class="form-select" style="height: 40px; width: 20%;">
										<option value='010' ${loginUser.phone.split("-")[0] eq 010 ? "selected" : ""  }>010</option>
										<option value='011'  ${loginUser.phone.split("-")[0] eq 011 ? "selected" : ""  }>011</option>
										<option value='070'  ${loginUser.phone.split("-")[0] eq 070 ? "selected" : ""  }>070</option>
									</select>
									<span style="margin: 6px;">-</span>
									<input id="phone2"
										type="text" class="form-control" style="width: 20%; height: 40px;" value=" ${loginUser.phone.split('-')[1]}">
									<span style="margin: 6px;">-</span>
									<input id="phone3"
										type="text" class="form-control" style="width: 20%; height: 40px;" value=" ${loginUser.phone.split('-')[2]}">
								</div>
							</div>
							<div class="mb-2">
								<div class="d-flex align-items-start"
									style="text-align: center;">
									<label class="form-label" for="gen-info-name-input"
										style="font-weight: bold; margin-top: 3px; margin-right: 20px;">학부모
										핸드폰 번호</label>
									<select id="p_phone1"
										class="form-select" style="height: 40px; width: 20%;">
										<option value='010' ${loginUser.parentPhone.split("-")[0] eq 010 ? "selected" : ""  }>010</option>
										<option value='011' ${loginUser.parentPhone.split("-")[0] eq 011 ? "selected" : ""  }>011</option>
										<option value='070' ${loginUser.parentPhone.split("-")[0] eq 070 ? "selected" : ""  }>070</option>
									</select>
									<span style="margin: 6px;">-</span>
									<input id="p_phone2"
										type="text" class="form-control" style="width: 20%; height: 40px;" value="${loginUser.parentPhone.split('-')[1]}">
									<span style="margin: 6px;">-</span>
									<input id="p_phone3"
										type="text" class="form-control" style="width: 20%; height: 40px;" value="${loginUser.parentPhone.split('-')[2]}">
								</div>
							</div>
							<div>
								<div class="d-flex align-items-start"
									style="text-align: center;margin-bottom: 3px;">
									<label class="form-label" for="gen-info-name-input"
										style="font-weight: bold; margin-top: 3px; margin-right: 68px;">이메일
										주소</label>
									<input id="mail1"
										type="text" class="form-control" style="width: 20%; height: 40px;" value="${loginUser.email.split('@')[0] }">
									<span style="margin: 6px;">@</span>
									<input id="mail2"
										type="text" class="form-control" style="width: 20%; height: 40px;" value="${loginUser.email.split('@')[1] }">
									&nbsp;&nbsp;
									<select class="form-select" name='mail_select' style="height: 40px; width: 20%;" onchange="mailSelect()">
										<option value=''>직접입력</option>
										<option value='naver.com'  ${loginUser.email.split("@")[1] eq 'naver.com' ? "selected" : ""  } >naver.com</option>
										<option value='daum.net'   ${loginUser.email.split("@")[1] eq 'daum.net' ? "selected" : ""  }>daum.net</option>
										<option value='gmail.com'  ${loginUser.email.split("@")[1] eq 'gmail.com' ? "selected" : ""  }>gmail.com</option>
										<option value='nate.com'   ${loginUser.email.split("@")[1] eq 'nate.com' ? "selected" : ""  }>nate.com</option>
									</select>
								</div>
								<span style="color:orange;s">*</span>
								<span style="font-size:0.8em;">핸드폰번호 기재시 교육정보 및 학습관련 SMS 서비스를 제공합니다.</span>
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-purple text-white">
										03</div>
								</div>
							</div>
							<div class="flex-grow-1">
								<h5 class="card-title">주소 정보</h5>
							</div>
						</div>
						<div class="card-body">
							<div class="mb-2">
								<div class="d-flex align-items-start">
									<label class="form-label" for="gen-info-name-input" style="font-weight: bold; margin-right: 113px; margin-top: 4px;">주소</label>
									<input id="address" class="form-control" type="text" style="width: 233px; height: 30px;" placeholder="주소 검색" value="${loginUser.address }" readonly />
									<button onclick="searchAddress()"
										class="btn btn-purple" style="float: left; height: 30px; line-height: 10px;" type="button" >
									  <i class="fa fa-fw fa-search"></i>
									</button>
								</div>
							</div>
							<div>
							  <div class="d-flex align-items-start" style="text-align: center;">
								<label class="form-label" style="font-weight: bold; margin-top: 3px; margin-right: 83px;">상세주소</label>
								<input id="detailAddress" type="text" class="form-control" style="width: 45%; height: 30px;" value="${loginUser.detailAddress }">
							  </div>
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
												class="avatar-title rounded-circle bg-purple text-white">
										04</div>
								</div>
							</div>
							<div class="flex-grow-1">
								<h5 class="card-title">희망대학</h5>
							</div>
						</div>
						<div class="card-body">
							<div class="d-flex align-items-start mb-2">
								<label class="form-label" for="gen-info-name-input" style="font-weight: bold; margin-right: 102px; margin-top: 4px;">1지망</label>
								<input id="fuUni" value="${loginUser.fuUni }" readonly
									class="form-control" type="text" style="width: 210px; height: 30px;" placeholder="학교 검색" />
								<span class="input-group-append" style="height: 30px;">
								  <button class="btn btn-purple" style="float: left; height: 30px; line-height: 10px;" onclick="openSelectModel(this)" type="button">
									<i class="fa fa-fw fa-search"></i>
								  </button>
								</span>
							</div>
							<div class="d-flex align-items-start mb-2">
								<label class="form-label" for="gen-info-name-input" style="font-weight: bold; margin-right: 102px; margin-top: 4px;">2지망</label>
								<input id="suUni" value="${loginUser.suUni }" readonly
									class="form-control" type="text" style="width: 210px; height: 30px;" placeholder="학교 검색" />
								<span class="input-group-append" style="height: 30px;">
					<button class="btn btn-purple" style="float: left; height: 30px; line-height: 10px;" onclick="openSelectModel(this)"  type="button">
									<i class="fa fa-fw fa-search"></i>
								  </button>
								</span>
							</div>
							<div class="d-flex align-items-start">
								<label class="form-label" for="gen-info-name-input" style="font-weight: bold; margin-right: 102px; margin-top: 4px;">3지망</label>
								<input id="tuUni" value="${loginUser.tuUni }" readonly
									class="form-control" type="text" style="width: 210px; height: 30px;" placeholder="학교 검색" />
								<span class="input-group-append" style="height: 30px;">
								  	  <button class="btn btn-purple" style="float: left; height: 30px; line-height: 10px;" onclick="openSelectModel(this)" type="button">
									<i class="fa fa-fw fa-search"></i>
								  </button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
</body>
