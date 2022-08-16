<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<c:set var="room" value="${dataMap.room }"/>
<c:set var="fixtList" value="${dataMap.fixtList }"/>

	<div class="card" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="card-body">
			<div class="row">
				<div class="card-header">
					<h5 class="modal-title" id="staticBackdropLabel">강의실 수정</h5>
				</div>
				<div class="row">
					<form role='form' action="" method="post"
						id="sendForm" enctype="multipart/form-data">
						<div class="row mb-3">
							<label for="roomNo" class="col-sm-2 col-form-label">호수</label>
							<div class="col-sm-10">
								<input type="hidden" name="roomCode" id="roomCode" value="${room.roomCode }"> 
								<input type="text" class="form-control" id="room_no"
									name="roomNo" style="width:100%;float:left;" value="${room.roomNo }"> 
									<span class="input-group-append-sm">
								</span>
							</div>
						</div>
						<div class="row mb-3">
							<label for="usePrpose" class="col-sm-2 col-form-label">사용목적</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="use_purpose"
									name="usePurpose" value="${room.usePurpose }">
							</div>
						</div>
						<div class="row mb-3">
							<label for="capacity" class="col-sm-2 col-form-label">수용인원</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="capacity"
									name="capacity" value="${room.capacity}">
							</div>
						</div>
						<div class="row mb-3" style="--bs-gutter-x: 0;">
							<div class="col-sm-2">
							<label for="fixture" class="col-form-label">비품</label>
							</div>
							<div class="col-sm-10" style="display: inline-flex;">
								<div class="form-check">
								<c:if test="${room.fx1 eq 'Y' }">
									<input class="form-check-input" type="checkbox" id="FXT_01" checked> <label
										class="form-check-label" for="FXT_01"> 의자</label> <input
										type="hidden" id="fx1" name="fx1" value="Y">
								</c:if>
								<c:if test="${room.fx1 ne 'Y' }">
									<input class="form-check-input" type="checkbox" id="FXT_01"> <label
										class="form-check-label" for="FXT_01"> 의자</label> <input
										type="hidden" id="fx1" name="fx1" value="N">
								</c:if>
								</div>
								<div class="form-check">
								<c:if test="${room.fx2 eq 'Y' }">
									<input class="form-check-input" type="checkbox"id="FXT_02" checked> <label
										class="form-check-label" for="FXT_02"> 책상 </label> <input
										type="hidden" id="fx2" name="fx2" value="Y">
								</c:if>
								<c:if test="${room.fx2 ne 'Y' }">
									<input class="form-check-input" type="checkbox"id="FXT_02"> <label
										class="form-check-label" for="FXT_02"> 책상 </label> <input
										type="hidden" id="fx2" name="fx2" value="N">
								</c:if>
								</div>
								<div class="form-check">
								<c:if test="${room.fx3 eq 'Y' }">
									<input class="form-check-input" type="checkbox"id="FXT_03" checked> <label
										class="form-check-label" for="FXT_03"> 프로젝터</label> <input
										type="hidden" id="fx3" name="fx3" value="Y">
								</c:if>
								<c:if test="${room.fx3 ne 'Y' }">
									<input class="form-check-input" type="checkbox"id="FXT_03"> <label
										class="form-check-label" for="FXT_03"> 프로젝터</label> <input
										type="hidden" id="fx3" name="fx3" value="N">
								</c:if>
								</div>
								<div class="form-check">
								<c:if test="${room.fx4 eq 'Y' }">
									<input class="form-check-input" type="checkbox" id="FXT_04" checked> <label
										class="form-check-label" for="FXT_04"> 화이트보드 </label> <input
										type="hidden" id="fx4" name="fx4" value="Y">
								</c:if>
								<c:if test="${room.fx4 ne 'Y' }">
									<input class="form-check-input" type="checkbox" id="FXT_04"> <label
										class="form-check-label" for="FXT_04"> 화이트보드 </label> <input
										type="hidden" id="fx4" name="fx4" value="N">
								</c:if>
								</div>
								<div class="form-check">
								<c:if test="${room.fx5 eq 'Y' }">
									<input class="form-check-input" type="checkbox" id="FXT_05" checked> <label
										class="form-check-label" for="FXT_05"> 스크린</label> <input
										type="hidden" id="fx5" name="fx5" value="Y">
								</c:if>
								<c:if test="${room.fx5 ne 'Y' }">
									<input class="form-check-input" type="checkbox" id="FXT_05"> <label
										class="form-check-label" for="FXT_05"> 스크린</label> <input
										type="hidden" id="fx5" name="fx5" value="N">
								</c:if>
								</div>
								<div class="form-check">
								<c:if test="${room.fx6 eq 'Y' }">
									<input class="form-check-input" type="checkbox" id="FXT_06" checked> <label
										class="form-check-label" for="FXT_06"> 소화기</label> <input
										type="hidden" id="fx6" name="fx6" value="Y">
								</c:if>
								<c:if test="${room.fx6 ne 'Y' }">
									<input class="form-check-input" type="checkbox" id="FXT_06"> <label
										class="form-check-label" for="FXT_06"> 소화기</label> <input
										type="hidden" id="fx6" name="fx6" value="N">
								</c:if>
								</div>
							</div>
						</div>
						<div class="row input-group mb-3">
<!-- 								<div class="col-sm-3"> -->
<!-- 									<div class="input-group input-group-sm"> -->
<!-- 										<input id="oldFile" type="hidden" name="oldPicture" value="" /> -->
<!-- 										<label for="inputFile" onchange="changePicture_go();" class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label> -->
<!-- 										<input id="inputFileName" style="height: fit-content;" class="form-control" type="text" name="picture" -->
<%-- 											value="${room.picture }" readonly/> --%>
<!-- 										<span class="input-group-append-sm">											 -->
<!-- 											<button type="button" class="btn btn-info btn-sm btn-append" onclick="upload_go();">업로드</button>											 -->
<!-- 										</span> -->
<!-- 									</div> -->
<!-- 								</div> -->
								
					<input type="hidden" name="oldPicture"  value=""/>
					<input type="file" id="inputFile" onchange="changePicture_go();" name="picture" style="display:none" />
					<div class="input-group col-md-12">
<!-- 							<div class="manPicture" id="pictureView" style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto; margin-bottom:5px;"></div>														 -->
						<div class="input-group input-group-sm" style="margin-bottom:2px;">
							<label for="inputFile" style="margin: 0;"class=" btn btn-warning btn-sm btn-flat input-group-addon">사진변경</label>
							<input id="inputFileName" class="form-control" type="text" name="tempPicture" disabled
								value="${room.picture }"/>
							<input id="picture" class="form-control" type="hidden" name="uploadPicture" />
						</div>						
					</div>
						<div class="col-sm-12">
								<div class="mailbox-attachment-icon has-img"data-id="${room.roomCode }"  class="roomPicture" id="pictureView" style="border: 1px solid green; height: 200px;"></div>
								</div>
							<br />
						  </div>
						
					</form>
				</div>
				<!-- Modal-body 끝! -->

				<div class="row card-footer">
					<div class="col-sm-8" style="float:left"></div>
					<div class="col-sm-4" style="float:right">
					<button type="button" id="roomCloseBtn" class="btn btn-secondary" style="float:right;margin-left: 3px;"onclick="window.close();">닫기</button>
					<button type="button" id="roomRegistBtn" class="btn btn-warning"style="float:right" onclick="modify_go();">수정</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 등록 끝 -->
	
<!-- 	<form role="imageForm" action="upload/picture" method="post" enctype="multipart/form-data"> -->
<!-- 		<input id="inputFile" name="pictureFile" type="file" class="form-control" style="display:none;" onchange="picture_go();"> -->
<!-- 		<input id="oldFile" type="hidden" name="oldPicture" value="" /> -->
<!-- 		<input type="hidden" name="checkUpload" value="0" />	 -->
<!-- 	</form> -->
	
<head>
<script>
	window.onload = function(){
		var roomCode=$('#roomCode').val();
		RoomPictureThumb('<%=request.getContextPath()%>', roomCode);
	}
	//사용자 사진 출력
	function RoomPictureThumb(contextPath, roomCode){
		console.log(contextPath);// -> /ddit
		console.log(document.querySelectorAll('#pictureView'));
		 for(var target of document.querySelectorAll('#pictureView')){
	          console.log(roomCode);
	          //에러 ---아이디 없음.
			 target.style.backgroundImage="url('"+contextPath+"/classroom/getPicture.go?roomCode="+roomCode+"')";
			 target.style.backgroundPosition="center";
			 target.style.backgroundRepeat="no-repeat";
			 target.style.backgroundSize="cover";
		}
	}
</script>

  <script>
 	 function changePicture_go(){
 		//alert("file change");
 		
 		var picture = $('input#inputFile')[0];
 		
 		var fileFormat = picture.value.substr(picture.value.lastIndexOf(".")+1).toUpperCase();
 		
 		//이미지 확장자 jpg 확인
		if(!(fileFormat=="JPG" || fileFormat=="JPEG")){
			alert("이미지는 jpg 형식만 가능합니다.");
			return;
		} 
		//이미지 파일 용량 체크
		if(picture.files[0].size>1024*1024*1){
			alert("사진 용량은 1MB 이하만 가능합니다.");
			return;
		};
		
		document.getElementById('inputFileName').value=picture.files[0].name;
		
		if (picture.files && picture.files[0]) {
 			var reader = new FileReader();
			 
			 reader.onload = function (e) {
		        	//이미지 미리보기	        	
		        	$('div#pictureView')
		        	.css({'background-image':'url('+e.target.result+')',
						  'background-position':'center',
						  'background-size':'cover',
						  'background-repeat':'no-repeat'
		        		});
		        }
		        
		       reader.readAsDataURL(picture.files[0]);
		}
		
		// 이미지 변경 확인
		$('input[name="uploadPicture"]').val(picture.files[0].name);
 	 }
</script>
<!-- REQUIRED SCRIPTS -->
<script>
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


//강의실 등록 메서드
function modify_go(){
	//alert("regist btn click");   
	   if(!$('input[name="roomNo"]').val()){
	      alert("호수는 필수입니다.");
	       return;
	   }
	   
	   if(!$('input[name="capacity"]').val()){
		      alert("수용인원은 필수입니다.");
		      return;
	   }
		   
	   var form = $('form[role="form"]');
	   form.attr({"method":"post",
		   		  "action":"modify.go"
	   			});	   
	   
	   Swal.fire({
		      icon: 'success',
		      title: '수정 되었습니다.'
		      
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
