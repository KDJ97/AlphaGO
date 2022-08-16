<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style>
.form-check{
	display: inline-block;
}
.row{
--bs-gutter-x: 20px;
}
</style>
</head>
<body>
	<!-- Modal-body 시작! -->
	<!-- 강의실 등록 -->
	<!-- 등록 Modal -->
	<div class="card" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="card-body">
			<div class="row">
				<div class="card-header">
					<h5 class="modal-title" id="staticBackdropLabel">강의실 등록</h5>
				</div>
				<div class="row">
					<form role='form' action="roomregist.go" method="post"
						id="sendForm" enctype="application/json">
						<div class="row mb-3">
							<label for="roomNo" class="col-sm-2 col-form-label">호수</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="room_no"
									name="roomNo" style="width:80%;float:left;"> 
									<span class="input-group-append-sm">
									<button type="button" class="btn btn-warning" style="float:right;"
										onclick="roomCheck_go();">중복체크</button>
								</span>
							</div>
						</div>
						<div class="row mb-3">
							<label for="usePrpose" class="col-sm-2 col-form-label">사용목적</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="use_purpose"
									name="usePurpose">
							</div>
						</div>
						<div class="row mb-3">
							<label for="capacity" class="col-sm-2 col-form-label">수용인원</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="capacity"
									name="capacity">
							</div>
						</div>
						<div class="row mb-3" style="--bs-gutter-x: 0;">
							<div class="col-sm-2">
							<label for="fixture" class="col-form-label">비품</label>
							</div>
							<div class="col-sm-10" style="display: inline-flex;">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="FXT_01"> <label
										class="form-check-label" for="FXT_01"> 의자</label> <input
										type="hidden" id="fx1" name="fx1" value="N">
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox"id="FXT_02"> <label
										class="form-check-label" for="FXT_02"> 책상 </label> <input
										type="hidden" id="fx2" name="fx2" value="N">
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox"id="FXT_03"> <label
										class="form-check-label" for="FXT_03"> 프로젝터</label> <input
										type="hidden" id="fx3" name="fx3" value="N">
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="FXT_04"> <label
										class="form-check-label" for="FXT_04"> 화이트보드 </label> <input
										type="hidden" id="fx4" name="fx4" value="N">
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="FXT_05"> <label
										class="form-check-label" for="FXT_05"> 스크린</label> <input
										type="hidden" id="fx5" name="fx5" value="N">
								</div>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="FXT_06"> <label
										class="form-check-label" for="FXT_06"> 소화기</label> <input
										type="hidden" id="fx6" name="fx6" value="N">
								</div>
							</div>
						</div>
						<div class="row input-group mb-3">
								<div class="col-sm-3">
									<div class="input-group input-group-sm">
										<label for="inputFile" class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
										<input id="inputFileName" style="height: fit-content;" class="form-control" type="text" name="picture" readonly/>
										<span class="input-group-append-sm">											
											<button type="button" class="btn btn-info btn-sm btn-append" onclick="upload_go();">업로드</button>											
										</span>
									</div>
								</div>
								<div class="col-sm-9">
								<div class="mailbox-attachment-icon has-img" id="pictureView" style="border: 1px solid green; height: 200px;"></div>
								</div>
							<br />
						  </div>
						
						<!-- <button type="submit" class="btn btn-primary">Sign in</button> -->
					</form>
				</div>
				<!-- Modal-body 끝! -->

				<div class="row card-footer">
					<div class="col-sm-8" style="float:left"></div>
					<div class="col-sm-4" style="float:right">
					<button type="button" id="roomCloseBtn" class="btn btn-secondary" style="float:right;margin-left: 3px;"onclick="window.close();">닫기</button>
					<button type="button" id="roomRegistBtn" class="btn btn-primary"style="float:right" onclick="regist_go();">등록</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 등록 끝 -->
	
	<form role="imageForm" action="upload/picture" method="post" enctype="multipart/form-data">
		<input id="inputFile" name="pictureFile" type="file" class="form-control" style="display:none;" onchange="picture_go();">
		<input id="oldFile" type="hidden" name="oldPicture" value="" />
		<input type="hidden" name="checkUpload" value="0" />	
	</form>
	
<head>
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
   
   //업로드 확인변수 초기화 (사진변경)
   form.find('[name="checkUpload"]').val(0);	
   document.getElementById('inputFileName').value=picture.files[0].name;
 	
   
   
   if (picture.files && picture.files[0]) {
		var reader = new FileReader();
		
		reader.onload = function (e) {
			 $('div#pictureView').css({'background-image':'url('+e.target.result+')',
                 'background-position':'center',
                 'background-size':'cover',
                 'background-repeat':'no-repeat'
                 });
		}
		reader.readAsDataURL(picture.files[0]);
	}
}

function upload_go(){
	//alert("upload btn click");
	 if(!$('input[name="pictureFile"]').val()){
	    alert("사진을 선택하세요.");
	    $('input[name="pictureFile"]').click();
	    return;
     }  
     if($('input[name="checkUpload"]').val()==1){
       alert("이미업로드 된 사진입니다.");
       return;      
	}
	
     var formData = new FormData($('form[role="imageForm"]')[0]);
   
     
	$.ajax({
		url:"picture.go",
		data:formData,
		type:"post",
	    processData:false,
        contentType:false,
        success:function(data){
        	//data: 파일명
       	  //업로드 확인변수 세팅
          $('input[name="checkUpload"]').val(1);
          //저장된 파일명 저장.
          $('input#oldFile').val(data); // 변경시 삭제될 파일명	          
          $('form[role="form"] input[name="picture"]').val(data);	    	  
    	  alert("사진이 업로드 되었습니다.");
        },
        error:function(error){
          alert("현재 사진 업로드가 불가합니다.\n 관리자에게 연락바랍니다.");
        }
	});
}

var checkedID ="";
function roomCheck_go(){
	//alert("id check btn click");
	
	var input_rno=$('input[name="roomNo"]');
	
	if(!input_rno.val()){
       alert("강의실 호수를 입력하세요.");
       input_rno.focus();
       return;
	}
	
	 $.ajax({
		 url : "roomCheck.go?roomNo="+input_rno.val().trim(),
    	 method : "get",	
    	 success : function(result){
  		   if(result.toUpperCase() == "DUPLICATED"){
              alert("중복된 호수 입니다.");
              $('input[name="roomNo"]').focus();
           }else{
              alert("사용가능한 호수 입니다.");
              checkedID=input_rno.val().trim();
              $('input[name="roomNo"]').val(input_rno.val().trim());
             
           } 
    	 },
    	 error:function(error){
    	   alert("시스템장애로 가입이 불가합니다.");
    	 }
	 });
}

//강의실 등록 메서드
function regist_go(){
	//alert("regist btn click");
	  var uploadCheck = $('input[name="checkUpload"]').val();   
	   if(uploadCheck=="0"){
	      alert("사진업로드는 필수 입니다");      
	      return;
	   }
	   
	   if(!$('input[name="roomNo"]').val()){
	      alert("호수는 필수입니다.");
	       return;
	   }
	   
	   if($('input[name="roomNo"]').val()!=checkedID){
	      alert("호수는 중복 확인이 필요합니다.");
	      return;
	   }
	   
	   if(!$('input[name="capacity"]').val()){
		      alert("수용인원은 필수입니다.");
		      return;
	   }
		   
	   var form = $('form[role="form"]');
	   form.attr({"method":"post",
		   		  "action":"regist.go"
	   			});	   
	   

	   Swal.fire({
	   	      icon: 'success',
	   	      title: '강의실이 등록되었습니다.'
	   	      
	   	    }).then((result) => {
	     	
	     	  
	   	    	 
	   form.submit();

	    		})
	   
}
</script>
<script>
$("#FXT_01").change(
	function(){
		//체크박스 값에따라 히든값 변경
		if($('#FXT_01').is(":checked")){
			$("#fx1").val('Y');
		}else{
			$("#fx1").val('N');
		}
	}		
)
$("#FXT_02").change(
	function(){
		//체크박스 값에따라 히든값 변경
		if($('#FXT_02').is(":checked")){
			$("#fx2").val('Y');
		}else{
			$("#fx2").val('N');
		}
	}		
)
$("#FXT_03").change(
	function(){
		//체크박스 값에따라 히든값 변경
		if($('#FXT_03').is(":checked")){
			$("#fx3").val('Y');
		}else{
			$("#fx3").val('N');
		}
	}		
)
$("#FXT_04").change(
	function(){
		//체크박스 값에따라 히든값 변경
		if($('#FXT_04').is(":checked")){
			$("#fx4").val('Y');
		}else{
			$("#fx4").val('N');
		}
	}		
)

$("#FXT_05").change(
	function(){
		//체크박스 값에따라 히든값 변경
		if($('#FXT_05').is(":checked")){
			$("#fx5").val('Y');
		}else{
			$("#fx5").val('N');
		}
	}		
)
$("#FXT_06").change(
	function(){
		//체크박스 값에따라 히든값 변경
		if($('#FXT_06').is(":checked")){
			$("#fx6").val('Y');
		}else{
			$("#fx6").val('N');
		}
	}		
)
</script>
</head>
</body>
