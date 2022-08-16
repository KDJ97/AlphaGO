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


function picture_go(){
	//alert("file change");
	
   var form = $('form[role="imageForm"]');
   var picture = form.find('[name=pictureFile]')[0];
   
   //이미지 확장자 jpg 확인
   var fileFormat = picture.value.substr(picture.value.lastIndexOf(".")+1).toUpperCase();
	if(!(fileFormat=="JPG" || fileFormat=="JPEG")){
   		alert("이미지는 jpg/jpeg 형식만 가능합니다.");
   		picture.value="";      
   		return;
	} 

	//이미지 파일 용량 체크
   if(picture.files[0].size>1024*1024*1){
      alert("사진 용량은 1MB 이하만 가능합니다.");
      picture.value="";
      return;
   };
   
   //업로드 확인변수 초기화(사진변경)
   form.find('[name="checkUpload"]').val(0);
   
   document.getElementById('inputFileName').value = picture.files[0].name;
   //$('#inputFileName').val(picture.files[0].name)
   
   if(picture.files && picture.files[0]){
	   var reader = new FileReader();
	   
	   reader.onload = function (e){
		   $('div#pictureView').css(
			   {
			   'background-image' : 'url('+ e.target.result+')',
			   'background-position' : 'center',
			   'background-size' : 'cover',
			   'background-repeat' : 'no-repeat'
			   }
		   );
	   }
	   
	   reader.readAsDataURL(picture.files[0]);
   }
   $('#pictureView').val('');
}

function upload_go(){
	//alert('upload btn click')
	
	if(!$('input[name="pictureFile"]').val()){
		alert('사진을 선택하세요.')
		$('input[name="pictureFile"]').click();
		return;
	}
	
	if($('input[name="checkUpload"]').val() == 1){
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
		
		success : function(data){
		  //업로드 확인변수 세팅
		  $('input[name="checkUpload"]').val(1);
		  //저장된 파일명 저장.
		  $('input#oldFile').val(data);//변경시 삭제될 파일명
		  $('form[role="form"] input[name="picture"]').val(data);
		  alert("사진이 업로드 되었습니다.");
			
		},
		error:function(error){
			alert("현재 사진 업로드가 불가합니다.\n 관리자에게 연락바랍니다.");
		}
	})
	
}

 var checkedID="";
  function idCheck_go(){
	 //alert("id check btn click");
	 
 	 var input_ID=$('input[name="id"]');
	 
 	 if(!input_ID.val()){
		 alert("아이디를 입력하시오");
 		 input_ID.focus();
 		 return;
 	 }
 	 $.ajax({
 		 url:"idCheck.go?id="+input_ID.val().trim(),
 		 method:"get",  success:function(result){
 			 if(result.toUpperCase()=="DUPLICATED"){
 				 alert("중복된 아이디 입니다.");
 				 $('input[name="id"]').focus();
 			 }else{
 				 alert("사용가능한 아이디 입니다.");
 				 checkedID=input_ID.val().trim();
 				 $('input[name="id"]').val(input_ID.val().trim());
				 
 			 }
			 
 		 },
 		 error:function(error){
 			 alert("시스템장애로 가입이 불가합니다."); 		 }
		 
		 
 	 });
	 
	 
	 
 }
 
 function regist_go(){
	//alert("regist btn click");
// 	var uploadCheck=$('input[name="checkUpload"]').val();
// 	if(uploadCheck=="0"){
// 		alert("사진업로드는 필수 입니다.");
// 		return;
// 	}
     
// 	if(!$('input[name="id"]').val()){
// 		alert("아이디는 필수입니다.");
// 		return;
		
// 	}
// 	if($('input[name="id"]').val()!=checkedID){
// 		alert("아이디는 중복 확인이 필요합니다.");
// 		return;
// 	}
// 	if(!$('input[name="pwd"]').val()){
// 		alert("패스워드는 필수입니다.");
// 		return;
// 	}
// 	if(!$('input[name="name"]').val()){
// 		alert("이름은 필수입니다.");
// 	}
	var form=$('form[role="form"]');
	form.attr({"method":"post",
	           "action":"registStudent.go"	
	});
	
	Swal.fire({
	      icon: 'success',
	      title: '등록 되었습니다.'
	      
	    }).then((result) => {
	
	  
	    	form.submit();

		})
	
	
	
// 	 var id = $('input[name=id]').val();
// 	 console.log(id);

// 	$.ajax({
// 		url : "sendsmss.go",
// 		type : "POST",
// 		async:false,
// 		contentType :'application/json',
// 		data : {
			
			
// 			"id":id
// 		},
// 		success : function(data) {
		

// 		},
// 		error : function(error) {
// 			alert("error : " + error.status);
// 		},
// 		dataType : 'json'

// 	});
}

</script>






</head>
<body>
	<div class="d-flex justify-content-between mb-2">
		<h5 style="font-weight: bold;">
			<i class="uil-unlock-alt" style="margin-right: 10px;"></i>원생 등록
		</h5>
		<div class="d-flex justify-content-end">
			<button type="button" class="btn btn-secondary"
				style="height: 30px; line-height: 12px; margin-right: 5px;"
				 onclick="CloseWindow();">취소</button>
			<button type="button" class="btn btn-primary" style="height: 30px; line-height: 12px;"
				onclick="regist_go();">등록하기</button>
		</div>
	</div>
	<div class="row">
		<form role="form" class="form-horizontal" action="registStudent.go" method="post" enctype="multipart/form-data">								
		<div class="col-sm-4" style="padding: 0px;">
			<div class="card">
				<div class="card-body">
					<div style="text-align: center;">
 						<div class="rounded-circle" id="pictureView"
										style="border: 1px solid lightgrey; height: 150px; width: 150px; margin: 0 auto;"></div>

						<div class="d-flex align-items-start mt-3 mb-3">

							<!-- 이미지 업로드 -->
							  <input type="hidden" name="picture" />
							<label for="inputFile" style="margin-left:90px;"class=" btn btn-secondary btn-sm btn-flat input-group-addon">파일선택</label>
							  <input id="inputFileName" class="form-control form-control-sm" type="text"
								  style="width: 166px; " name="tempPicture" disabled />
							  <button onclick="upload_go();"
							  	type="button" class="btn btn-primary" style=" height: 28px; line-height: 10px; width: 55px;">등록</button>


								<!-- 사진 url 숨기기 -->
							  	<input type="hidden" name="captureView" value=""> 
						

						</div>
						  <button onclick="OpenWindow('webcapture.go','사진찍기',500,650);"
							  	type="button" class="btn btn-success" style="margin-left:10px; height: 28px; line-height: 10px; width: 100px;">사진찍기</button>

						
					</div>
						<div class="mt-3 mb-3">
						<label class="form-label"style="font-weight: bold; margin-right: 35px;">이름</label>
						<div class="col-sm-9 input-group-sm">								
								<input class="form-control" name="name" type="text" class="form-control" id="name"
										placeholder="이름을 입력하세요"
										onkeyup="this.value=this.value.trim();" />
							</div>
						<hr style="margin: 5px 0 0 0;">
					</div>
					
					<div class="mb-3">
						<label class="form-label" style="font-weight: bold; margin-right: 21px;">학교</label>
									<div class="col-sm-9  input-group-sm">								
								
								<select name="schoolName" id="schoolName"  class="form-select" style="font-size:0.9em;">
									<option value="">선택</option>
									<option value="배재고">배재고</option> 
									<option value="대전고">대전고</option>
									<option value="대전외국어고">대전외고</option>
									<option value="대전과학고">대전과학고</option> 
									<option value="대전중앙고">대전중앙고</option>
									<option value="대전용산고">대전용산고</option>
									<option value="대덕고">대덕고</option> 
									<option value="노은고">노은고</option>

									
								</select>	
							</div>
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-3">
						<label class="form-label" style="font-weight: bold; margin-right: 35px;">학년</label>
					<div class="col-sm-9 input-group-sm">
								<select name="grade" id="grade"  class="form-select" style="font-size:0.9em;">
									<option value="">선택</option>
									<option value="1">1학년</option>
									<option value="2">2학년</option>
									<option value="3">3학년</option>
								</select>
												
							</div>
						<hr style="margin: 5px 0 0 0;">
					</div>
					
					<div class="mt-3 mb-3">
						<label class="form-label"style="font-weight: bold; margin-right: 35px;">학부모 이름</label>
						<div class="col-sm-9 input-group-sm">								
								<input class="form-control" name="parentName" type="text" class="form-control" id="name"
										placeholder="이름을 입력하세요"
										onkeyup="this.value=this.value.trim();" />
							</div>
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-2">
						<label class="form-label" style="font-weight: bold; margin-right: 35px;">권한</label>
							<div class="col-sm-9 input-group-sm">
								<select name="authority" id="authority"  class="form-select" style="font-size:0.9em;">
									<option value="">선택</option>
									<option value="ROLE_STUDENT">원생</option>
									<option value="ROLE_TEACHER">강사</option>
									
								</select>
												
							</div>
							<hr style="margin: 5px 0 0 0;">
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-8">


					<div class="card" >
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-7">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-primary text-white">
										01</div>
								</div>
							</div>
							<div class="flex-grow-1">
								<h5 class="card-title">&nbsp;&nbsp;&nbsp;연락처 정보</h5>
							</div>
						</div>
						<div class="card-body">
							<div class="mb-2">
								<div class="d-flex align-items-start"
									style="text-align: center;">
									<label class="form-label" style="font-weight: bold; margin-top: 5px; margin-right: 68px;">
										원생 연락처
									</label>
									<select id="phone"  name="phone"
										class="form-select" style="height: 40px; width: 20%;">
										<option value="">-선택-</option>
										<option value="010">010</option>
										<option value="016">016</option>
										<option value="019">019</option>
									</select>
									<span style="margin: 6px;">-</span>
									<input id="phone"
										type="text"  name="phone" class="form-control" style="width: 20%; height: 40px;">
									<span style="margin: 6px;">-</span>
									<input id="phone"
										type="text"   name="phone" class="form-control" style="width: 20%; height: 40px;">
								</div>
							</div>
							  	
							  
					
								<div class="d-flex align-items-start"
									style="text-align: center;">
									<label class="form-label" style="font-weight: bold; margin-top: 5px; margin-right: 68px;">
										부모 연락처
									</label>
									<select id="phone"  name="parentPhone"
										class="form-select" style="height: 40px; width: 20%;">
										<option value="">-선택-</option>
										<option value="010">010</option>
										<option value="016">016</option>
										<option value="019">019</option>
									</select>
									<span style="margin: 6px;">-</span>
									<input id="phone"
										type="text"   name="parentPhone" class="form-control" style="width: 20%; height: 40px;">
									<span style="margin: 6px;">-</span>
									<input id="phone"
										type="text"   name="parentPhone" class="form-control" style="width: 20%; height: 40px;">
								</div>
							</div>
						
						</div>
					
						
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-primary text-white">
										02</div>
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
									<input id="address" name="address" class="form-control" type="text" style="width: 233px; height: 30px;" placeholder="주소 검색"  readonly />
									<button onclick="searchAddress()"
										class="btn btn-primary" style="float: left; height: 30px; line-height: 10px;" type="button" >
									  <i class="fa fa-fw fa-search"></i>
									</button>
								</div>
							</div>
							<div>
							  <div class="d-flex align-items-start" style="text-align: center;">
								<label class="form-label" style="font-weight: bold; margin-top: 3px; margin-right: 83px;">상세주소</label>
								<input name="detailAddress"id="detailAddress" type="text" class="form-control" style="width: 45%; height: 30px;">
							  </div>
							</div>
						</div>
					</div>
					</div>
				</form>
			
				</div>
					<form role="imageForm" action="upload/picture" method="post" enctype="multipart/form-data">
					  <input id="inputFile" name="pictureFile" type="file" onchange="picture_go()" class="form-control" style="display: none;">
					  <input id="oldFile" type="hidden" name="oldPicture" value="" />
					  <input type="hidden" name="checkUpload" value="0" />
					</form>
</body>
