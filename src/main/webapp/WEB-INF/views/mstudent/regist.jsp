<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="<%=request.getContextPath() %>/resources/bootstrap/dist/js/adminlte.min.js"></script>
<!-- common -->
<script src="<%=request.getContextPath() %>/resources/js/common.js" ></script>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/bootstrap/dist/css/adminlte.min.css">
<script>
window.onload=function(){
   summernote_go($('#text'),'<%=request.getContextPath()%>');
}




</script>



</head>
<body>


	<!-- Main content -->
	
	<section class="content register-page">
	<div class="card-body">
		<div class="register-box">
			
			<!-- form start -->
			<div class="card">		
			<div class="login-logo">
    			<div style=""><b>원생 등록</b></div>
  			</div>		
				<div class="register-card-body">
					<form role="form" class="form-horizontal" action="regist.do" method="post">						
						<input type="hidden" name="picture" />
						<div class="input-group mb-3">
							<div class="mailbox-attachments clearfix" style="text-align: center;">
								<div class="mailbox-attachment-icon has-img" id="pictureView" style="border: 1px solid black; height: 200px; width: 140px; margin: 0 auto;"></div>
								<div class="mailbox-attachment-info">
									<div class="input-group input-group-sm">
										<label for="inputFile" class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
										<input id="inputFileName" class="form-control" type="text" name="tempPicture" disabled/>
										<span class="input-group-append-sm">											
											<button type="button" class="btn btn-info btn-sm btn-append" onclick="upload_go();">업로드</button>											
										</span>
									</div>
								</div>
							</div>
							<br />
						  </div>	
<!-- 						  <div class="form-group row"> -->
<!-- 							 <label for="id" class="col-sm-3" style="font-size:0.7em;" > -->
<!-- 							 	<span style="color:red;font-weight:bold;">*</span>아이디</label>	 -->
<!-- 							<div class="col-sm-9 input-group input-group-sm"> -->
<!-- 								<input name="id"  -->
<!-- 									onkeyup="this.value=this.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, &#39;&#39;);" -->
<!-- 								type="text" class="form-control" id="id" placeholder=""> -->
<!-- 								<span class="input-group-append-sm">	 -->
<!-- 									<button type="button" onclick="idCheck_go();"  class="btn btn-primary btn-sm btn-append">중복확인</button> -->
<!-- 								</span>								 -->
<!-- 							</div>								 -->
<!-- 						</div> -->

						<input name="id" type="hidden" class="form-control" id="id"/>
						
						<div class="form-group row">
							<label for="name" class="col-sm-3" style="font-size:0.7em;">
								<span style="color:red;font-weight:bold;">*</span>이 름</label>
							<div class="col-sm-9 input-group-sm">								
								<input class="form-control" name="name" type="text" class="form-control" id="name"
										placeholder="이름을 입력하세요"
										onkeyup="this.value=this.value.trim();" />
							</div>
							
						</div>	
						
						<div class="form-group row">
							<label for="schoolName" class="col-sm-3" style="font-size:0.7em;">
								<span style="color:red;font-weight:bold;">*</span>학교</label>
							<div class="col-sm-9  input-group-sm">								
								
								<select name="schoolName" id="schoolName"  class="form-control" style="font-size:0.9em;">
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
							
						</div>	
						<div class="form-group row">
							<label for="grade" class="col-sm-3" style="font-size:0.7em;" >학년</label>
							<div class="col-sm-9 input-group-sm">
								<select name="grade" id="grade"  class="form-control" style="font-size:0.9em;">
									<option value="">선택</option>
									<option value="1">1학년</option>
									<option value="2">2학년</option>
									<option value="3">3학년</option>
								</select>
												
							</div>
						</div>					
						
						
						<div class="form-group row">
							<label for="authority" class="col-sm-3" style="font-size:0.7em;" >권한</label>
						
						</div>		
						<div class="form-group row">
							<label for="phone" class="col-sm-3 control-label" style="font-size:0.7em;">연락처</label>
							<div class="col-sm-9 ">	
								<div class="input-group-sm">
									<select style="width:75px;" name="phone"  id="phone" class="form-control float-left">
										<option value="">-선택-</option>
										<option value="010">010</option>
										<option value="016">016</option>
										<option value="019">019</option>
										
									</select>							
									<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-&nbsp;</label>										
									<input style="width:68px;" name="phone"   pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" type="text" class="form-control float-left" />
									<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-</label>
									<input style="width:68px;" name="phone"   pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}"type="text" class="form-control float-right" />						
								</div>
							</div>
						</div>
						
						<div class="form-group row">
							<label for="parentName" class="col-sm-3" style="font-size:0.7em;">학부모 이름</label>
							<div class="col-sm-9 input-group-sm">
								<input name="parentName" type="text" class="form-control" id="parentName"
										placeholder="">
							</div>
						</div>
						
						<div class="form-group row">
							<label for="parentPhone" class="col-sm-3 control-label" style="font-size:0.6em;">학부모 연락처</label>
							<div class="col-sm-9">	
								<div class="input-group-sm">
									<select style="width:75px;" name="parentPhone" id="parentPhone" class="form-control float-left">
										<option value="">-선택-</option>
										<option value="010">010</option>
										<option value="016">016</option>
										<option value="019">019</option>
										
									</select>							
									<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-&nbsp;</label>										
									<input style="width:68px;" name="parentPhone" type="text" class="form-control float-left" />
									<label class="float-left" style="padding: 0; text-align: center;">&nbsp;-</label>
									<input style="width:68px;" name="parentPhone" type="text" class="form-control float-right" />						
								</div>
							</div>
						</div>
						
						<div class="card-footer">
							<div class="row">								
								<div class="col-sm-6">
									<button type="button" id="registBtn" onclick="regist_go();" class="btn btn-primary">등&nbsp;&nbsp;록</button>
							 	</div>
							 	
							 	<div class="col-sm-6">
									<button type="button" id="cancelBtn" onclick="CloseWindow();"
										class="btn btn-danger float-right">&nbsp;&nbsp;&nbsp;취 &nbsp;&nbsp;소&nbsp;&nbsp;&nbsp;</button>
								</div>
							
							</div>
						</div>
					</form>					
				</div><!-- register-card-body -->
			</div>
		</div>
		</div>
		
	</section>		<!-- /.content -->

<!-- /.content-wrapper -->

<form role="imageForm" action="upload/picture" method="post" enctype="multipart/form-data">
	<input id="inputFile" name="pictureFile" type="file" class="form-control" style="display:none;" onchange="picture_go()">
	<input id="oldFile" type="hidden" name="oldPicture" value="" />
	<input type="hidden" name="checkUpload" value="0" />	
</form>

<!-- REQUIRED SCRIPTS -->
<script>
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
	           "action":"regist.go"	
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

</body>