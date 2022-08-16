<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="member" value="${member2 }" />
<c:set var="careerVOList" value="${careerVOList }" />

<head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function addressFind_go(){
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			data === 'COMPLETE_CLOSE';
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                	extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                	extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
               
            
            } else {
               
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("address").value = addr + extraAddr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
	
}
</script>
<script>
function ProblemPictureThumb(contextPath){
	
	 for(var target of document.querySelectorAll('.myPicture')){	
		 
		 target.style.backgroundImage="url('"+contextPath+"/teacher/getPicture.go')";
		 target.style.backgroundPosition="center";
		 target.style.backgroundRepeat="no-repeat";
		 target.style.backgroundSize="cover";
	}
}
</script>
<script>
$(function(){
	ProblemPictureThumb('<%=request.getContextPath()%>');
})
</script>
<script>
$('#pwd').keyup(function(){
	var pwd = $('#pwd').val();
	
	if(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{1,}$/.test(pwd)){
		$('#pwdContainMsg').html('&#10004;');
		$('#pwdContainMsg').attr('style','color:blue;font-size:0.8em;margin-top:5px;');
	}else{
		$('#pwdContainMsg').html('영문,숫자,특수문자가 포함되어야 합니다.');
		$('#pwdContainMsg').attr('style','color:red;font-size:0.8em;margin-top:5px;');
	}
})
</script>
<script>
$('.pw').keyup(function(){
	var pwd = $('#pwd').val();
	var pwdCheck = $('#pwdCheck').val();
	
	//console.log("pwd : " + pwd);
	//console.log("pwdCheck : " + pwdCheck);
	
	if(pwd!="" || pwdCheck!=""){
		if(pwd==pwdCheck){
			$('#pwdCheckMsg').html('&#10004;');
			$('#pwdCheckMsg').attr('style','color:blue;font-size:0.8em;margin-top:5px;');
		}else{
			$('#pwdCheckMsg').html('비밀번호가 일치하지 않습니다.');
			$('#pwdCheckMsg').attr('style','color:red;font-size:0.8em;margin-top:5px;');
		}
	}
})

</script>
<script type="text/javascript">
//이메일 입력방식 선택
$('#selectEmail').change(function(){
   $("#selectEmail option:selected").each(function () {
		
		if($(this).val()== '1'){ //직접입력일 경우
			 $("#email2").val('');                        //값 초기화
			 $("#email2").attr("disabled",false); //활성화
		}else{ //직접입력이 아닐경우
			 $("#email2").val($(this).text());      //선택값 입력
			 $("#email2").attr("disabled",false); //비활성화
		}
   });
});
</script>

<script>
//비밀번호 변경 버튼 클릭
var flag=false;
function pwd_go(){
	$('#pwpw').attr('style','display:block');
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
				onclick="history.back();">취소</button>
			<button type="button" class="btn btn-success"
				style="height: 30px; line-height: 12px;"
				onclick="modify_go();">수정완료</button>
		</div>
	</div>
	<form role="form" class="form-horizontal" method="post">
	<div class="row">
		<div class="col-4">
			<div class="card">
				<div class="card-body">
					<div style="text-align: center;">
						<input type="hidden" name="picture" value="${member.picture }" />
						<input type="hidden" name="oldPwd" id="oldPwd" value="${member.pwd }" />
						<div class="myPicture" style="border-radius: 50%; margin:auto; width: 150px; height: 150px;">
						
						</div>
						<div class="mailbox-attachment-info" style="margin-top:10px;">
							<div class="input-group input-group-sm">
								<label for="inputFile" style="height:30px;"
									class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
								<input id="inputFileName" class="form-control" type="text" style="height:30px;"
									name="tempPicture" disabled  value="${member.picture.split('\\$\\$')[1] }"/> <span
									class="input-group-append-sm">
									<button type="button" style="height:30px;"
										class="btn btn-primary btn-sm btn-append"
										onclick="upload_go();">업로드</button>
								</span>
							</div>
						</div>
					</div>
					<div class="mt-3 mb-3">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 35px;">이름</label>${member.name }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-3">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 21px;">아이디</label>${member.id }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-3">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 35px;">전공</label>${member.major }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-3">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 35px;">과목</label>${member.subject }
						<hr style="margin: 5px 0 0 0;">
					</div>
				</div>
			</div>
		</div>
		<div class="col-8">
			<div class="card">
				<div class="card-body">
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-success text-purple">
										01</div>
								</div>
							</div>
							<div class="flex-grow-1">
								<h5 class="card-title">비밀번호 변경&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<button style="display:none;" type="button" id="pwdChangeBtn" onclick="pwd_go();">비밀번호 변경 </button></h5>
							</div>
						</div>
						<div id="pwpw" class="card-body" >
							<div class="mb-2">
								<div class="d-flex align-items-start"
									style="text-align: center;">
									<label class="form-label" for="gen-info-name-input"
										style="font-weight: bold; margin-top: 3px; margin-right:87px;">비밀번호</label>
										<input id="pwd" name="pwd" type="password"
										class="form-control pw" id="gen-info-name-input"
										style="width: 30%; height: 30px; margin-right:3px;">
									<font id="pwdContainMsg" style="color:red; font-size:0.8em;margin:5px 0px 0px 5px;">영문,숫자,특수문자가 포함되어야 합니다.</font>
								</div>
							</div>
							<div>
								<div class="d-flex align-items-start"
									style="text-align: center;">
									<label class="form-label" for="gen-info-name-input"
										style="font-weight: bold; margin-top: 3px; margin-right: 53px;">비밀번호 확인</label>
										<input id="pwdCheck" name="pwdCheck" type="password"
										class="form-control pw" id="gen-info-name-input"
										style="width: 30%; height: 30px; margin-right:3px;">
									<font id="pwdCheckMsg" style="color:red; font-size:0.8em;margin:5px 0px 0px 5px;">비밀번호를 입력하세요.</font>
								</div>
							</div>						
						</div>
						
					</div>
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-success text-purple">
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
									<label class="form-label" for="gen-info-name-input"
										style="font-weight: bold; margin-top: 5px; margin-right: 68px;">핸드폰
										번호</label> 
										
									<select name='select_phone' style="height: 30px;">
										<option value='010' ${loginUser.phone.split("-")[0] eq '010' ? "selected" : "" }>010</option>
										<option value='011' ${loginUser.phone.split("-")[0] eq '011' ? "selected" : "" }>011</option>
										<option value='070' ${loginUser.phone.split("-")[0] eq '070' ? "selected" : "" }>070</option>
									</select><span style="margin: 6px;">-</span>
									<input name="phone" id="phone0" type="hidden" value="" >
									<input name='phone' type="text" value="${fn:split(member.phone,'-')[1]}"
										class="form-control" id="gen-info-name-input"
										style="width: 10%; height: 30px;"><span
										style="margin: 6px;">-</span>
									<input name='phone' type="text" value="${fn:split(member.phone,'-')[2]}"
										class="form-control" id="gen-info-name-input"
										style="width: 10%; height: 30px;">
								</div>
							</div>
							<div>
								<div class="d-flex align-items-start"
									style="text-align: center;margin-bottom: 3px;">
									<label class="form-label" for="gen-info-name-input"
										style="font-weight: bold; margin-top: 3px; margin-right: 68px;">이메일
										주소</label>
									<input name="email" type="text" class="form-control" id="email1" style="width: 20%; height: 30px;" value="${fn:split(member.email,'@')[0]}">
									<span style="margin: 6px;">@</span> 
									<input name="email" type="text" class="form-control"id="email2" style="width: 30%; height: 30px;" value="${fn:split(member.email,'@')[1]}">
									<select id="selectEmail" name='selectEmail' style="width: 20%; height: 30px;">
										<option value='1' selected>직접입력</option>
										<option value='네이버'>naver.com</option>
										<option value='다음'>daum.net</option>
										<option value='gmail'>gmail.com</option>
										<option value='네이트'>nate.com</option>
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
										class="avatar-title rounded-circle bg-success text-purple">
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
									<label class="form-label" for="gen-info-name-input"
										style="font-weight: bold; margin-right: 113px; margin-top: 4px;">주소</label>
									<input class="form-control" type="text" id="address"
										style="width: 350px; height: 30px;" name="address"
										placeholder="주소 검색" value="${member.address }" /> <span
										class="input-group-append" style="height: 30px;">
										<button class="btn btn-light"
											style="float: left; height: 30px; line-height: 10px;"
											type="button" id="searchBtn" data-card-widget="search"
											onclick="addressFind_go();">
											<i class="fa fa-fw fa-search"></i>
										</button>
									</span>
								</div>
							</div>
							<div>
								<div class="d-flex align-items-start"
									style="text-align: center;">
									<label class="form-label" for="gen-info-name-input"
										style="font-weight: bold; margin-top: 3px; margin-right: 77px;">상세
										주소</label> <input name="detailAddress" type="text" class="form-control" value="${member.detailAddress}"
										id="detailAddress" style="width: 45%; height: 30px;">
								</div>
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-success text-purple">
										04</div>
								</div>
							</div>
							<div class="flex-grow-1">
								<h5 class="card-title">경력사항</h5>
							</div>
						</div>
						<div class="card-body">
							<c:forEach items="${careerVOList }" var="careerVO" varStatus="i">
								<div class="d-flex align-items-start mb-2">
									<input name="careerCode" type="hidden" value="${careerVO.careerCode }" />
									<label class="form-label" for="gen-info-name-input"
										style="font-weight: bold; margin-right: 102px; margin-top: 4px;">${i.count }.</label>
									<input name="startDate" class="form-control" type="date" value="<fmt:formatDate value="${careerVO.startDate}" pattern="yyyy-MM-dd"/>" style="padding:0px; width:200px; height: 30px;"/>	
									<input name="endDate" class="form-control" type="date" value="<fmt:formatDate value="${careerVO.endDate}" pattern="yyyy-MM-dd"/>" style="padding:0px; width:200px; height: 30px;" />	
									<input class="form-control" type="text"
										style="width: 510px; height: 30px;" name="cacontent"
										placeholder="이력사항${i.count }" value="${careerVO.cacontent }" /> <span
										class="input-group-append" style="height: 30px;">
									</span>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</form>
	<form role="imageForm" action="upload/picture" method="post"
		enctype="multipart/form-data">
		<input id="inputFile" name="pictureFile" type="file"
			class="form-control" style="display: none;" onchange="picture_go()">
		<input id="oldFile" type="hidden" name="oldPicture" value="" /> <input
			type="hidden" name="checkUpload" value="0" />
	</form>
<script>
	function picture_go(){
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
				$('div.myPicture').css({
					'background-image' : 'url(' + e.target.result + ')',
					'background-position' : 'center',
					'background-size' : 'cover',
					'background-repeat' : 'no-repeat'
				});
			}

			reader.readAsDataURL(picture.files[0]);
		}z
	}
	
	function upload_go(){
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
			url : "<%=request.getContextPath()%>/teacher/picture.go",
			data : formData,
			type : "post",
			processData : false,
			contentType : false,
			success : function(data) {
				//업로드 확인변수 세팅
				$('input[name="checkUpload"]').val(1);
				//저장된 파일명 저장.
				$('input#oldFile').val(data);//변경시 삭제될 파일명
				$('form[role="form"] input[name="picture"]').val(data);
				alert("사진이 업로드 되었습니다.");

			},
			error : function(error) {
				alert("현재 사진 업로드가 불가합니다.\n 관리자에게 연락바랍니다.");
			}
		})
	}
	
	//수정완료 버튼을 눌렀을 때
	function modify_go(){
		
		var pwd = $('#pwd').val();
		var pwdCk = $('#pwdCheck').val();
		var pwdReg = $('#pwdContainMsg').html();
		var pwdCheck = $('#pwdCheckMsg').html();
		var msg = '영문,숫자,특수문자가 포함되어야 합니다.';
		console.log("pwd : " + pwd);
		console.log("pwdCheck : " + pwdCk);
		if(pwd!=''||pwdCk!=''){
			if(pwdReg == msg){
				alert("영문,숫자,특수문자가 포함되어야 합니다.");
				return;
			}
			if(pwdCheck == '비밀번호가 일치하지 않습니다.'){
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}
		}
		
		if(pwd==''||pwdCk==''){
			$('#pwd').val($('#oldPwd').val());
		}
		
		var select_phone = $('select[name=select_phone]').val();
		$('#phone0').val(select_phone);
		
		var form = $('form[role="form"]');
		form.attr({
			"method" : "post",
			"action" : "<%=request.getContextPath()%>/teacher/modify.go"
		});
		form.submit();
	}
	
</script>
</body>
