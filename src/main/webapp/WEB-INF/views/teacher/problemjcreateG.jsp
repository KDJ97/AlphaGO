<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="subDetailList" value="${data.subnamecode}" />
<c:set var="subAreaList" value="${data.subAreaList }" />
<c:set var="subject" value="${data.subject }" />
<head>
<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
var page=1;
var prepage=1;
</script>
<script>
function pagegogo(g){
	//페이지 이동 
	//alert($(g).text());
	if(page==$(g).text()){
		return;
	}
	$('.go1').removeClass('page-li page-item go1 active').addClass('page-li page-item go1');
	$(g).closest('.go1').addClass('page-li page-item go1 active');
	var sss="pro"+$(g).text();
	var ssd="pro"+page;
	
	$("#"+sss).css("display","");
	if($('#'+sss+"g").css('display')=="none"){
		$('#'+sss+"j").css("display","");
	}
	
	
	$("#"+sss).css("display","");
	
	$("#"+ssd).css("display","none");
	$('#'+ssd+"j").css("display","none");
	page=$(g).text();
	
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
	function picture_go() {
		//alert("file change");
		var check="#pro"+page+"j";
		var tr="j";
		if($(check).css('display')=="none"){
			var tr="g";
		}
		var form = $('form[role="imageForm"]');
		var picture = form.find('[name=pictureFile'+page+']')[0];

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
		var check="pr"+page+"j";
		//alert(check);
		
	

		if (picture.files && picture.files[0]) {

			var reader = new FileReader();

			reader.onload = function(e) {
				$('div#pictureView'+page+tr).css({
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
		var check="#pro"+page+"j";
		var tr="j";
		if($(check).css('display')=="none"){
			var tr="g";
		}
		var textgo=page+tr;
		var form = $('form[role="imageForm"]');
		var picture = form.find('[name=pictureFile'+page+']')[0];
		$('#inputFile'+page).val("");
		$('#pictureView'+textgo).css('background-image', 'url("")');
		$('#ign'+textgo).show();
		$('#imginsert'+textgo).css("display", "none");
		$('#pictureView'+textgo).css("display", "none");
	
		
			
			$('#dap'+textgo).val("");
			$('#problemContent'+textgo).val("");
			$('#oneN'+textgo).val("");
			$('#twoN'+textgo).val("");
			$('#treeN'+textgo).val("");
			$('#fourN'+textgo).val("");
			$('#fiveN'+textgo).val("");
			$('#solution'+textgo).val("");
		
	
	
	}
</script>


<script>
	//미리보기
	function previewgo(g) {
	//	alert("미리보기");
		
		if(prepage==$(g).text()){
			return;
		}
		
 		if(g==undefined){
 			$('#premaster').closest('.go2').addClass('page-li page-item go2 active');
 		}
 		else{
 			$('.go2').removeClass('page-li page-item go2 active').addClass('page-li page-item go2');
 			$(g).closest('.go2').addClass('page-li page-item go2 active');
 			prepage=$(g).text();
 		}
 		//초기화 비워버리기
 		$('#preProblemContent').html("");
 		$('#preDap').text("");
 		$('#presolution').html("");
 		$('#pre1').text("");
 		$('#pre2').text("");
 		$('#pre3').text("");
 		$('#pre4').text("");
 		$('#pre5').text("");
 		
 		
 		
	$('#prejimoon').html($('#jimoon').val());
	var gac=prepage+"g";
	var ju=prepage+"j";
 	if($('#problemContent'+gac).val()==""){
 		$('#preProblemContent').html("0"+prepage+"."+$('#problemContent'+ju).val());
 		$('#preDap').text($('#dap'+ju).val())
 		$('#presolution').html($('#solution'+ju).val());
 	
 	}
	else{
 		$('#preProblemContent').html("0"+prepage+"."+$('#problemContent'+prepage+"g").val());
 		var pr="problemAnswer"+prepage+'g';
 		var dapdap = $("input[name='"+pr+"']:checked").val();
 		var realdap="";
 		//alert(dapdap);
 	
 		if(dapdap=="1"){
 			realdap="①"+$('#oneN'+gac).val();
 		
 		}
 		if(dapdap=='2'){
 			realdap="②"+$('#twoN'+gac).val();
 		}
 		if(dapdap=='3'){
 			realdap="③"+$('#treeN'+gac).val();
 		}
 		if(dapdap=='4'){
 			realdap="④"+$('#fourN'+gac).val();
 		}
 		if(dapdap=='5'){
 			realdap="⑤"+$('#fiveN'+gac).val();
 		}
 		$('#preDap').html(realdap);
 		$('#presolution').html($('#solution'+gac).val());
 		$('#pre1').text("①"+$('#oneN'+gac).val());
 		$('#pre2').text("②"+$('#twoN'+gac).val());
 		$('#pre3').text("③"+$('#treeN'+gac).val());
 		$('#pre4').text("④"+$('#fourN'+gac).val());
 		$('#pre5').text("⑤"+$('#fiveN'+gac).val());
 		
	}
		
		var form = $('form[role="imageForm"]');
		var picture = form.find('[name=pictureFile'+prepage+']')[0];
			
 		if (undefined == picture.files[0]) {
 			$("#pictureViewPre").css("display", "none");

 		} 
 		else {
 			$("#pictureViewPre").css("display", "");
 			
 		}
		if (picture.files && picture.files[0]) {

			var reader = new FileReader();

			reader.onload = function(e) {
				$('div#pictureViewPre').css({
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
function goch(t){
	//주관식, 객관식 코드	
	var vv1=page+"g";
	var vv2=page+"j";
	
		if($(t).val()=='주관식'){
			$('#pro'+vv1).css('display','none');
			$('#pro'+vv2).css('display','');
			
			$('#inputFile'+page).val("");
			$('#pictureView'+vv1).css('background-image', 'url("")');
			
				
				$('#dap'+vv1).val("");
				$('#problemContent'+vv1).val("");
				$('#oneN'+vv1).val("");
				$('#twoN'+vv1).val("");
				$('#treeN'+vv1).val("");
				$('#fourN'+vv1).val("");
				$('#fiveN'+vv1).val("");
				$('#solution'+vv1).val("");
			
			
		}
		
		
		
		if($(t).val()=='객관식'){
			$('#pro'+vv1).css('display','');
			$('#pro'+vv2).css('display','none');
			
			
			$('#dap'+vv2).val("");
			$('#problemContent'+vv2).val("");
			
			$('#solution'+vv2).val("");
		}
	
	
}
</script>


<script>
	function imginsertgo() {
		var check="#pro"+page+"j";
		var tr="j";
		if($(check).css('display')=="none"){
			var tr="g";
		}
		
		$('#ign'+page+tr).hide();
		$('#imginsert'+page+tr).css("display", "");
		$('#pictureView'+page+tr).css("display", "");
		//	$('#gbody').css("display","");
	}
</script>
<script>
	function cancelgo() {
		
		var check="#pro"+page+"j";
		var tr="j";
		if($(check).css('display')=="none"){
			var tr="g";
		}
		var textgo=page+tr;
		$('#inputFile'+page).val("");
		
		$('#pictureView'+textgo).css('background-image', 'url("")');
	
		$('#ign'+textgo).show();
		$('#imginsert'+textgo).css("display", "none");
		$('#pictureView'+textgo).css("display", "none");

	}
</script>

<script>
function insertgo(){

	
	
var a=false;
var b=false;

	

	if($('input[name="pictureFile1"]').val()){
		
	     var formData = new FormData($('form[role="imageForm"]')[0]);

		$.ajax({
			url:"<%=request.getContextPath()%>/rteacher/picture1.go",
			data:formData,
			type:"post",
		    processData:false,
	        contentType:false,
	        success:function(data){
	        	         a=true;
	       		    	  $('#pickpicture1').val(data);
	       		    	if(a&&b){
	       		    		$('#probleminsertgo').submit();
	       		    	}
	    	
	        },
	        error:function(error){
	          alert("현재 사진 업로드가 불가합니다.\n 관리자에게 연락바랍니다.");
	        }
		});
	}else{
		a=true;
	}
	
	if($('input[name="pictureFile2"]').val()){
		
	     var formData = new FormData($('form[role="imageForm"]')[0]);

		$.ajax({
			url:"<%=request.getContextPath()%>/rteacher/picture2.go",
			data:formData,
			type:"post",
		    processData:false,
	        contentType:false,
	        success:function(data){
	        	        b=true;
	       		    	  $('#pickpicture2').val(data);
	       		   	if(a&&b){
       		    		$('#probleminsertgo').submit();
       		    	}
	    	
	        },
	        error:function(error){
	          alert("현재 사진 업로드가 불가합니다.\n 관리자에게 연락바랍니다.");
	        }
		});
	}else{
		b=true;
	}
	

		
	
		Swal.fire({
	      icon: 'success',
	      title: '문제가 출제되었습니다.'
	      
	    }).then((result) => {
		  if (result.value) {
			   	 
				if(a&&b){
					$('#probleminsertgo').submit();
				}
		 	 }	
		})
	
		
}

</script>



<script>
function modalcancel(){
	$('.go2').removeClass('page-li page-item go2 active').addClass('page-li page-item go2');
	prepage=1;
}
</script>
<script>


</script>


</head>




<body>
<form role="form" class="form-horizontal" action="problemjCreatego" method="post" id="probleminsertgo">
	<div class="row gx-3 gy-2">
		<div class="col-6" style="float: left;">
			<div class="card" style="height: 820px;">
				<div class="card-body" style="padding: 15px;">
					<div class="d-flex mb-2">
						<div class="me-auto d-flex justify-content-start">
							<h5
								style="font-weight: bold; margin-top: 2px; margin-bottom: 15px;">
								<i class="uil-book-open" style="margin-right: 10px;"></i>문제 출제
							</h5>
							<span class="badge rounded-pill bg-info"
								style="font-size: 1.0em; margin: 0px 0px 11px 10px;">수학</span>
						</div>

					</div>

					<div class="d-flex justify-content-start">

						<label class="form-label" for="formrow-firstname-input"
							style="font-weight: bold; margin: 2px 15px 0px 0px;">세부
							과목</label>
						
							<select class="form-select col-md-3" id="subjectSelect"
								style="width: 130px; height: 30px; font-size: 0.7em;" name="subdetailCode">
							  <c:forEach items="${subDetailList}" var="class2">
							           <option value="${class2.SUBDETAIL_CODE}">${ class2.SUBDETAIL_NAME}</option>

									
									</c:forEach> 
							</select>

						<label class="form-label" for="formrow-firstname-input"
							style="font-weight: bold; margin: 2px 15px 0px 44px;">단원
							</label>
<!-- 						<div class="dropdown" style="margin-bottom: 5px;"> -->
<!-- 							<button class="btn btn-soft-secondary dropdown-toggle" -->
<!-- 								type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" -->
<!-- 								style="width: 130px; height: 30px; line-height: 10px;" -->
<!-- 								aria-expanded="false"> -->
<!-- 								시험 범위<i class="mdi mdi-chevron-down" style="margin-left: 10px;"></i> -->
<!-- 							</button> -->
<!-- 							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2"> -->
<!-- 								<li><a class="dropdown-item" href="#">1단원</a></li> -->
<!-- 								<li><a class="dropdown-item" href="#">2단원</a></li> -->
<!-- 							</ul> -->
<!-- 						</div> -->
	<select class="form-select col-md-3" id="danSelect"
								style="width: 150px; height: 30px; font-size: 0.7em;"name="subjectProccess">
								
								
							</select>



					</div>

					<hr style="margin: 10px 0px 15px 0px;">
					<div style="margin-bottom: 5px;">
						<span style="color: orange;">*</span><span> 지문 하나당 문제 2개 출제
							해야합니다.</span>
					</div>
					<div class="form-floating">
						<textarea class="form-control bg-light text-dark"
							placeholder="Leave a comment here" id="jimoon"
							style="height: 640px" name="problemPrint"cols="20" rows="30"></textarea>
						<label for="floatingTextarea2" class="text-dark"
							style="font-weight: bold;">지문 </label>
					</div>


				</div>
			</div>
		</div>
		<div class="col-6">
			
			<div class="card">
				<div class="card-body" style="padding: 15px;">
						<div id="pro1">
						<div class="d-flex" style="margin-bottom: 10px;">
					
							<div class="me-auto d-flex justify-content-start">
								<h5>01.</h5>
							</div>
							<div>
								<button type="button" class="btn btn-soft-secondary"
									style="height: 30px; line-height: 5px; margin-right: 5px;"onclick="resetgo();">취소</button>
							</div>
							<div>
							
							</div>
							
						</div>
						
							
						<div class="d-flex justify-content-start">
		
							<div>
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 형식</label>
							
									<select class="form-select col-md-3" id="processSelect1"
										style="width: 130px; height: 30px; font-size: 0.7em;"name="lproblem1"onchange="goch(this);">
										<option value="주관식">주관식</option>
										<option value="객관식" selected="selected" >객관식</option>
	
									</select>
							</div>
							
							
							
							<div style="margin: 0px 35px 0px 35px;">
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 유형</label>
						
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
										class="form-select col-md-3" 
										style="width: 130px; height: 30px; font-size: 0.7em;"name="plevel1">
										<option value="하">하</option>
										<option value="중">중</option>
										<option value="상">상</option>
									</select>
							</div>
						</div>
						<hr style="margin: 10px 0px 15px 0px;">
					<div id="pro1g">
						<div class="form-floating">
							<button type="button" class="btn btn-soft-success" id="ign1g"
									onclick="imginsertgo();"
									style="height: 30px; line-height: 5px; margin-right: 5px; margin-bottom: 10px; float: right;">이미지
									첨부</button>
	
								<div id="imginsert1g" style='display: none;'>
	
									<div class="input-group input-group-sm">
										<div class="col-sm-8"></div>
										<div class="col-sm-4">
											<button type="button" class="btn btn-soft-danger"
												style="height: 30px; line-height: 5px; margin-right: 5px; float: right;"
												onclick="cancelgo();">취소</button>
											<input id="inputFileName1g" class="form-control" type="hidden"
												name="tempPicture" disabled /> <span
												class="input-group-append-sm"
												style="margin-right: 10px; float: right;"> <label
												for="inputFile1"
												class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
											</span>
	
										</div>
									</div>
								</div>
	
	
								<div class="mailbox-attachment-icon has-img" id="pictureView1g"
									style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
								</div>
	
	
							
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="problemContent1g"
									style="height: 80px; margin-bottom: 10px"name="problemContent1g"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">문제 </label>
							</div>
	
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer1g"
										id="formRadios1" checked style="margin: 12px;" value='1'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="oneN1g" placeholder="title"
											style="height: 30px; width: 100%;" name="none1g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">①</label>
									</div>
								</div>
							</div>
	
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer1g"
										id="formRadios2" checked style="margin: 12px;" value='2'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="twoN1g" placeholder="title"
											style="height: 30px; width: 100%;" name="ntwo1g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">②</label>
									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer1g"
										id="formRadios3" checked style="margin: 12px;" value='3'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="treeN1g" placeholder="title"
											style="height: 30px; width: 100%;"name="ntree1g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">③</label>
									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer1g"
										id="formRadios4" checked style="margin: 12px;" value='4'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="fourN1g" placeholder="title"
											style="height: 30px; width: 100%;"name="nfour1g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">④</label>
									</div>
								</div>
							</div>  
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer1g"
										id="formRadios5" checked style="margin: 12px;" value='5'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="fiveN1g" placeholder="title"
											style="height: 30px; width: 100%;"name="nfive1g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">⑤</label>
									</div>
								</div>
							</div>
	
	
							<hr>
							<div class="form-floating" style="height: 100px; overflow: auto;">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="solution1g"
									style="height: 100px"name="problemSolution1g"></textarea>
								<label for="floatingTextarea3" class="text-dark"
									style="font-weight: bold;">해설 </label>
							</div>
							
						</div>
							
						
							</div>
					
						
					<div id="pro1j" style="display:none;">
							<div class="form-floating">
								<button type="button" class="btn btn-soft-success" id="ign1j"
									onclick="imginsertgo();"
									style="height: 30px; line-height: 5px; margin-right: 5px; margin-bottom: 10px; float: right;">이미지
									첨부</button>
	
								<div id="imginsert1j" style='display: none;'>
	
									<div class="input-group input-group-sm">
										<div class="col-sm-8"></div>
										<div class="col-sm-4">
											<button type="button" class="btn btn-soft-danger"
												style="height: 30px; line-height: 5px; margin-right: 5px; float: right;"
												onclick="cancelgo();">취소</button>
											<input id="inputFileName1j" class="form-control" type="hidden"
												name="tempPicture" disabled /> <span
												class="input-group-append-sm"
												style="margin-right: 10px; float: right;"> <label
												for="inputFile1"
												class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
											</span>
	
										</div>
									</div>
								</div>
	
	
								<div class="mailbox-attachment-icon has-img" id="pictureView1j"
									style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
								</div>
								
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="problemContent1j"
									style="height: 120px; margin-bottom: 10px"name="problemContent1j"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">문제 </label>
							</div>
							<div class="form-floating">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="dap1j"
									style="height: 120px"name="problemAnswer1j"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">답 </label>
							</div>
	
							<hr>
							<div class="form-floating">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="solution1j"
									style="height: 120px"name="problemSolution1j"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">해설 </label>
										
							</div>
							
							
							
						</div>
						
						
						
							<div id="pro2"style="display:none;">
						<div class="d-flex" style="margin-bottom: 10px;">
					
							<div class="me-auto d-flex justify-content-start">
								<h5>02.</h5>
							</div>
							<div>
							<button type="button" class="btn btn-soft-warning"
									data-bs-toggle="modal" data-bs-target=".bs-example-modal-center"
									style="height: 30px; line-height: 5px; margin-right: 5px;" onclick="previewgo();">미리보기</button>
								<button type="button" class="btn btn-soft-success"
									style="height: 30px; line-height: 5px; margin-right: 5px;"onclick="insertgo();">완료</button>
								<button type="button" class="btn btn-soft-secondary"
									style="height: 30px; line-height: 5px; margin-right: 5px;"onclick="resetgo();">취소</button>
							</div>
							<div>
								
							</div>
							<div>
								
							</div>
						</div>
						
						
						<div class="d-flex justify-content-start">
		
							<div>
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 형식</label>
							
									<select class="form-select col-md-3" id="processSelect2"
										style="width: 130px; height: 30px; font-size: 0.7em;"name="lproblem2"onchange="goch(this);">
										<option value="주관식">주관식</option>
										<option value="객관식" selected="selected">객관식</option>
	
									</select>
							</div>
							
							
							
							<div style="margin: 0px 35px 0px 35px;">
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 유형</label>
								
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
										class="form-select col-md-3" 
										style="width: 130px; height: 30px; font-size: 0.7em;"name="plevel2">
										<option value="하">하</option>
										<option value="중">중</option>
										<option value="상">상</option>
									</select>
							</div>
						</div>
						<hr style="margin: 10px 0px 15px 0px;">
					<div id="pro2g">
						<div class="form-floating">
							<button type="button" class="btn btn-soft-success" id="ign2g"
									onclick="imginsertgo();"
									style="height: 30px; line-height: 5px; margin-right: 5px; margin-bottom: 10px; float: right;">이미지
									첨부</button>
	
								<div id="imginsert2g" style='display: none;'>
	
									<div class="input-group input-group-sm">
										<div class="col-sm-8"></div>
										<div class="col-sm-4">
											<button type="button" class="btn btn-soft-danger"
												style="height: 30px; line-height: 5px; margin-right: 5px; float: right;"
												onclick="cancelgo();">취소</button>
											<input id="inputFileName2g" class="form-control" type="hidden"
												name="tempPicture" disabled /> <span
												class="input-group-append-sm"
												style="margin-right: 10px; float: right;"> <label
												for="inputFile2"
												class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
											</span>
	
										</div>
									</div>
								</div>
	
	
								<div class="mailbox-attachment-icon has-img" id="pictureView2g"
									style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
								</div>
	
	
							
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="problemContent2g"
									style="height: 80px; margin-bottom: 10px"name="problemContent2g"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">문제 </label>
							</div>
	
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer2g"
										id="formRadios1" checked style="margin: 12px;" value='1'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="oneN2g" placeholder="title"
											style="height: 30px; width: 100%;" name="none"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">①</label>
									</div>
								</div>
							</div>
	
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer2g"
										id="formRadios2" checked style="margin: 12px;" value='2'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="twoN2g" placeholder="title"
											style="height: 30px; width: 100%;" name="ntwo2g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">②</label>
									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer2g"
										id="formRadios3" checked style="margin: 12px;" value='3'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="treeN2g" placeholder="title"
											style="height: 30px; width: 100%;"name="ntree2g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">③</label>
									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer2g"
										id="formRadios4" checked style="margin: 12px;" value='4'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="fourN2g" placeholder="title"
											style="height: 30px; width: 100%;"name="nfour2g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">④</label>
									</div>
								</div>
							</div>  
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer2g"
										id="formRadios5" checked style="margin: 12px;" value='5'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="fiveN2g" placeholder="title"
											style="height: 30px; width: 100%;"name="nfive2g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">⑤</label>
									</div>
								</div>
							</div>
	
	
							<hr>
							<div class="form-floating" style="height: 100px; overflow: auto;">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="solution2g"
									style="height: 100px"name="problemSolution2g"></textarea>
								<label for="floatingTextarea3" class="text-dark"
									style="font-weight: bold;">해설 </label>
							</div>
							
						</div>
							
						
							</div>
					
						
					<div id="pro2j" style="display:none;">
							<div class="form-floating">
								<button type="button" class="btn btn-soft-success" id="ign2j"
									onclick="imginsertgo();"
									style="height: 30px; line-height: 5px; margin-right: 5px; margin-bottom: 10px; float: right;">이미지
									첨부</button>
	
								<div id="imginsert2j" style='display: none;'>
	
									<div class="input-group input-group-sm">
										<div class="col-sm-8"></div>
										<div class="col-sm-4">
											<button type="button" class="btn btn-soft-danger"
												style="height: 30px; line-height: 5px; margin-right: 5px; float: right;"
												onclick="cancelgo();">취소</button>
											<input id="inputFileName2j" class="form-control" type="hidden"
												name="tempPicture" disabled /> <span
												class="input-group-append-sm"
												style="margin-right: 10px; float: right;"> <label
												for="inputFile2"
												class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
											</span>
	
										</div>
									</div>
								</div>
	
	
								<div class="mailbox-attachment-icon has-img" id="pictureView2j"
									style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
								</div>
								
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="problemContent2j"
									style="height: 120px; margin-bottom: 10px"name="problemContent2j"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">문제 </label>
							</div>
							<div class="form-floating">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="dap2j"
									style="height: 120px"name="problemAnswer2j"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">답 </label>
							</div>
	
							<hr>
							<div class="form-floating">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="solution2j"
									style="height: 120px"name="problemSolution2g"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">해설 </label>
										
							</div>
							
							
							
						</div>  
<!-- 						2번문제끝 -->
						
							<div id="pro3"style="display:none;">
						<div class="d-flex" style="margin-bottom: 10px;">
					
							<div class="me-auto d-flex justify-content-start">
								<h5>03.</h5>
							</div>
							<div>
								<button type="button" class="btn btn-soft-secondary"
									style="height: 30px; line-height: 5px; margin-right: 5px;"onclick="resetgo();">취소</button>
							</div>
							<div>
								
							</div>
							<div>
								
							</div>
						</div>
						
						
						<div class="d-flex justify-content-start">
		
							<div>
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 형식</label>
							
									<select class="form-select col-md-3" id="processSelect3"
										style="width: 130px; height: 30px; font-size: 0.7em;"name="lproblem3"onchange="goch(this);">
										<option value="주관식">주관식</option>
										<option value="객관식" selected="selected">객관식</option>
	
									</select>
							</div>
							
							
							
							<div style="margin: 0px 35px 0px 35px;">
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 유형</label>
								<div class="dropdown" style="margin-bottom: 5px;">
									<button class="btn btn-soft-secondary dropdown-toggle"
										type="button" id="dropdownMenuButton2"
										data-bs-toggle="dropdown"
										style="width: 130px; height: 30px; line-height: 10px;"
										aria-expanded="false">
										문제 유형<i class="mdi mdi-chevron-down" style="margin-left: 10px;"></i>
									</button>
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
										<li><a class="dropdown-item" href="#">문학</a></li>
										<li><a class="dropdown-item" href="#">비문학</a></li>
									</ul>
								</div>
	<!-- 								<select class="form-select col-md-3" id="processSelect" -->
	<!-- 									style="width: 130px; height: 30px; font-size: 0.7em;"name="sano"> -->
	<%-- 								 <c:forEach items="${subAreaList}" var="subarea"> --%>
	<%-- 							           <option value="${ subarea}">${subarea}</option> --%>
	
										
	<%-- 									</c:forEach>  --%>
	
	<!-- 								</select> -->
							</div>
							<div>
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">난이도</label>
	
								
								<select
										class="form-select col-md-3" 
										style="width: 130px; height: 30px; font-size: 0.7em;"name="plevel3">
										<option value="하">하</option>
										<option value="중">중</option>
										<option value="상">상</option>
									</select>
							</div>
						</div>
						<hr style="margin: 10px 0px 15px 0px;">
					<div id="pro3g">
						<div class="form-floating">
							<button type="button" class="btn btn-soft-success" id="ign3g"
									onclick="imginsertgo();"
									style="height: 30px; line-height: 5px; margin-right: 5px; margin-bottom: 10px; float: right;">이미지
									첨부</button>
	
								<div id="imginsert3g" style='display: none;'>
	
									<div class="input-group input-group-sm">
										<div class="col-sm-8"></div>
										<div class="col-sm-4">
											<button type="button" class="btn btn-soft-danger"
												style="height: 30px; line-height: 5px; margin-right: 5px; float: right;"
												onclick="cancelgo();">취소</button>
											<input id="inputFileName3g" class="form-control" type="hidden"
												name="tempPicture" disabled /> <span
												class="input-group-append-sm"
												style="margin-right: 10px; float: right;"> <label
												for="inputFile3"
												class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
											</span>
	
										</div>
									</div>
								</div>
	
	
								<div class="mailbox-attachment-icon has-img" id="pictureView3g"
									style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
								</div>
	
	
							
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="problemContent3g"
									style="height: 80px; margin-bottom: 10px"name="problemContent3g"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">문제 </label>
							</div>
	
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer3g"
										id="formRadios1" checked style="margin: 12px;" value='1'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="oneN3g" placeholder="title"
											style="height: 30px; width: 100%;" name="none3g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">①</label>
									</div>
								</div>
							</div>
	
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer3g"
										id="formRadios2" checked style="margin: 12px;" value='2'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="twoN3g" placeholder="title"
											style="height: 30px; width: 100%;" name="ntwo3g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">②</label>
									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer3g"
										id="formRadios3" checked style="margin: 12px;" value='3'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="treeN3g" placeholder="title"
											style="height: 30px; width: 100%;"name="ntree3g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">③</label>
									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer3g"
										id="formRadios4" checked style="margin: 12px;" value='4'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="fourN3g" placeholder="title"
											style="height: 30px; width: 100%;"name="nfour3g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">④</label>
									</div>
								</div>
							</div>  
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer3g"
										id="formRadios5" checked style="margin: 12px;" value='5'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="fiveN3g" placeholder="title"
											style="height: 30px; width: 100%;"name="nfive3g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">⑤</label>
									</div>
								</div>
							</div>
	
	
							<hr>
							<div class="form-floating" style="height: 100px; overflow: auto;">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="solution3g"
									style="height: 100px"name="problemSolution3g"></textarea>
								<label for="floatingTextarea3" class="text-dark"
									style="font-weight: bold;">해설 </label>
							</div>
							
						</div>
							
						
							</div>
					
						
					<div id="pro3j" style="display:none;">
							<div class="form-floating">
								<button type="button" class="btn btn-soft-success" id="ign3j"
									onclick="imginsertgo();"
									style="height: 30px; line-height: 5px; margin-right: 5px; margin-bottom: 10px; float: right;">이미지
									첨부</button>
	
								<div id="imginsert3j" style='display: none;'>
	
									<div class="input-group input-group-sm">
										<div class="col-sm-8"></div>
										<div class="col-sm-4">
											<button type="button" class="btn btn-soft-danger"
												style="height: 30px; line-height: 5px; margin-right: 5px; float: right;"
												onclick="cancelgo();">취소</button>
											<input id="inputFileName3j" class="form-control" type="hidden"
												name="tempPicture" disabled /> <span
												class="input-group-append-sm"
												style="margin-right: 10px; float: right;"> <label
												for="inputFile3"
												class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
											</span>
	
										</div>
									</div>
								</div>
	
	
								<div class="mailbox-attachment-icon has-img" id="pictureView3j"
									style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
								</div>
								
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="problemContent3j"
									style="height: 120px; margin-bottom: 10px"name="problemContent3j"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">문제 </label>
							</div>
							<div class="form-floating">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="dap3j"
									style="height: 120px"name="problemAnswer3j"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">답 </label>
							</div>
	
							<hr>
							<div class="form-floating">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="solution3j"
									style="height: 120px"name="problemSolution3j"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">해설 </label>
										
							</div>
							
							
							
						</div>
<!-- 						2번문제끝 -->
	<div id="pro4"style="display:none;">
						<div class="d-flex" style="margin-bottom: 10px;">
					
							<div class="me-auto d-flex justify-content-start">
								<h5>04.</h5>
							</div>
							<div>
								<button type="button" class="btn btn-soft-secondary"
									style="height: 30px; line-height: 5px; margin-right: 5px;"onclick="resetgo();">취소</button>
							</div>
							<div>
								
							</div>
							<div>
							<button type="button" class="btn btn-soft-warning"
									data-bs-toggle="modal" data-bs-target=".bs-example-modal-center"
									style="height: 30px; line-height: 5px; margin-right: 5px;" onclick="previewgo();">미리보기</button>
								<button type="button" class="btn btn-soft-success"
									style="height: 30px; line-height: 5px; margin-right: 5px;"onclick="insertgo();">완료</button>
							</div>
								
						</div>
						
						
						<div class="d-flex justify-content-start">
		
							<div>
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 형식</label>
							
									<select class="form-select col-md-3" id="processSelect1"
										style="width: 130px; height: 30px; font-size: 0.7em;"name="lproblem4"onchange="goch(this);">
										<option value="주관식">주관식</option>
										<option value="객관식" selected="selected">객관식</option>
	
									</select>
							</div>
							
							
							
							<div style="margin: 0px 35px 0px 35px;">
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">문제 유형</label>
								<div class="dropdown" style="margin-bottom: 5px;">
									<button class="btn btn-soft-secondary dropdown-toggle"
										type="button" id="dropdownMenuButton2"
										data-bs-toggle="dropdown"
										style="width: 130px; height: 30px; line-height: 10px;"
										aria-expanded="false">
										문제 유형<i class="mdi mdi-chevron-down" style="margin-left: 10px;"></i>
									</button>
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
										<li><a class="dropdown-item" href="#">문학</a></li>
										<li><a class="dropdown-item" href="#">비문학</a></li>
									</ul>
								</div>
	<!-- 								<select class="form-select col-md-3" id="processSelect" -->
	<!-- 									style="width: 130px; height: 30px; font-size: 0.7em;"name="sano"> -->
	<%-- 								 <c:forEach items="${subAreaList}" var="subarea"> --%>
	<%-- 							           <option value="${ subarea}">${subarea}</option> --%>
	
										
	<%-- 									</c:forEach>  --%>
	
	<!-- 								</select> -->
							</div>
							<div>
								<label class="form-label" for="formrow-firstname-input"
									style="font-weight: bold;">난이도</label>
	
								
								<select
										class="form-select col-md-3" 
										style="width: 130px; height: 30px; font-size: 0.7em;"name="plevel4">
										<option value="하">하</option>
										<option value="중">중</option>
										<option value="상">상</option>
									</select>
							</div>
						</div>
						<hr style="margin: 10px 0px 15px 0px;">
					<div id="pro4g">
						<div class="form-floating">
							<button type="button" class="btn btn-soft-success" id="ign4g"
									onclick="imginsertgo();"
									style="height: 30px; line-height: 5px; margin-right: 5px; margin-bottom: 10px; float: right;">이미지
									첨부</button>
	
								<div id="imginsert4g" style='display: none;'>
	
									<div class="input-group input-group-sm">
										<div class="col-sm-8"></div>
										<div class="col-sm-4">
											<button type="button" class="btn btn-soft-danger"
												style="height: 30px; line-height: 5px; margin-right: 5px; float: right;"
												onclick="cancelgo();">취소</button>
											<input id="inputFileName4g" class="form-control" type="hidden"
												name="tempPicture" disabled /> <span
												class="input-group-append-sm"
												style="margin-right: 10px; float: right;"> <label
												for="inputFile4"
												class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
											</span>
	
										</div>
									</div>
								</div>
	
	
								<div class="mailbox-attachment-icon has-img" id="pictureView4g"
									style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
								</div>
	
	
							
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="problemContent4g"
									style="height: 80px; margin-bottom: 10px"name="problemContent4g"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">문제 </label>
							</div>
	
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer4g"
										id="formRadios1" checked style="margin: 12px;" value='1'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="oneN4g" placeholder="title"
											style="height: 30px; width: 100%;" name="none4g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">①</label>
									</div>
								</div>
							</div>
	
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer4g"
										id="formRadios2" checked style="margin: 12px;" value='2'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="twoN4g" placeholder="title"
											style="height: 30px; width: 100%;" name="ntwo4g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">②</label>
									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer4g"
										id="formRadios3" checked style="margin: 12px;" value='3'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="treeN4g" placeholder="title"
											style="height: 30px; width: 100%;"name="ntree4g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">③</label>
									</div>
								</div>
							</div>
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer4g"
										id="formRadios4" checked style="margin: 12px;" value='4'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="fourN4g" placeholder="title"
											style="height: 30px; width: 100%;"name="nfour4g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">④</label>
									</div>
								</div>
							</div>  
							<div class="row" style="margin-top: 10px;">
								<div class="col-1">
									<input class="form-check-input" type="radio" name="problemAnswer4g"
										id="formRadios5" checked style="margin: 12px;" value='5'>
								</div>
								<div class="col-11">
									<div class="form-floating bg-light">
										<input type="text" class="form-control bg-light text-dark"
											id="fiveN4g" placeholder="title"
											style="height: 30px; width: 100%;"name="nfive4g"> <label
											for="floatingTitle" class="text-dark"
											style="font-weight: bold; line-height: 4px;">⑤</label>
									</div>
								</div>
							</div>
	
	
							<hr>
							<div class="form-floating" style="height: 100px; overflow: auto;">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="solution4g"
									style="height: 100px"name="problemSolution4g"></textarea>
								<label for="floatingTextarea3" class="text-dark"
									style="font-weight: bold;">해설 </label>
							</div>
							
						</div>
							
						
							</div>
					
						
					<div id="pro4j" style="display:none;">
							<div class="form-floating">
								<button type="button" class="btn btn-soft-success" id="ign"
									onclick="imginsertgo();"
									style="height: 30px; line-height: 5px; margin-right: 5px; margin-bottom: 10px; float: right;">이미지
									첨부</button>
	
								<div id="imginsert4j" style='display: none;'>
	
									<div class="input-group input-group-sm">
										<div class="col-sm-8"></div>
										<div class="col-sm-4">
											<button type="button" class="btn btn-soft-danger"
												style="height: 30px; line-height: 5px; margin-right: 5px; float: right;"
												onclick="cancelgo();">취소</button>
											<input id="inputFileName4j" class="form-control" type="hidden"
												name="tempPicture" disabled /> <span
												class="input-group-append-sm"
												style="margin-right: 10px; float: right;"> <label
												for="inputFile4"
												class=" btn btn-warning btn-sm btn-flat input-group-addon">파일선택</label>
											</span>
	
										</div>
									</div>
								</div>
	
	
								<div class="mailbox-attachment-icon has-img" id="pictureView4j"
									style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
								</div>
								
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="problemContent4j"
									style="height: 120px; margin-bottom: 10px"name="problemContent4j"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">문제 </label>
							</div>
							<div class="form-floating">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="dap4j"
									style="height: 120px"name="problemAnswer4j"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">답 </label>
							</div>
	
							<hr>
							<div class="form-floating">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="problem4j"
									style="height: 120px"name="problemSolution4j"></textarea>
								<label for="floatingTextarea2" class="text-dark"
									style="font-weight: bold;">해설 </label>
										
							</div>
							
							
							
						</div>
<!-- 						3번문제 끝 -->

						
						
						
						
						</div>
						
						
						
						
						
						
						
						
						
						
						
	<!-- 					페이지1 -->
						<nav aria-label="Navigation">
		<ul id="nav-ul" class="pagination justify-content-center m-0">
			<li class="page-item">
				
			
			
			
				<li class="page-li page-item go1 active" >
					<a class="nav-list page-list-link page-link" onclick='pagegogo(this);'>1</a>
					
					
				</li>
					<li class="page-li page-item go1" >
					<a class="nav-list page-list-link page-link"onclick='pagegogo(this);'>2</a>
					
					
<!-- 				</li> -->
				
<!-- 					<li class="page-li page-item go1" > -->
<!-- 					<a class="nav-list page-list-link page-link"onclick='pagegogo(this);'>3</a> -->
					
					
<!-- 				</li> -->
<!-- 					<li class="page-li page-item go1" > -->
<!-- 					<a class="nav-list page-list-link page-link"onclick='pagegogo(this);'>4</a> -->
					
					
<!-- 				</li> -->
			
			
			
			
			
			
			
		</ul>
	</nav>   
				</div>
			</div>


		</div>

	
	<!--  Large modal example -->
	<div class="modal fade bs-example-modal-center" tabindex="-1" role="dialog"
		aria-labelledby="myLargeModalLabel" aria-hidden="true" >
		<div class="modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="myLargeModalLabel">문제 미리보기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close" onclick="modalcancel();"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-6">
							<div style="border: 1px solid lightgray; padding: 10px;">
								<span style="font-weight: bold;">[지문]</span>
								
<!-- 								지문나오는 곳 -->
								<div id="prejimoon" style="overflow:auto;height:500px;word-break:break-all;">
							
								</div>
							</div>
						</div>
						<div class="col-6">
							<div style="font-weight: bold;">[문제]</div>
								<div class="mailbox-attachment-icon has-img" id="pictureViewPre"
									style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px; display: none;">
								</div>
	
							<div id="preProblemContent">01. 위 발표자의 말하기에 대한 설명으로 적절하지 않은 것은?</div>
							<div id="proGcontent"style="word-break:break-all;">
							<p style="margin-left: 10px;">
								<span id="pre1"></span><br>
								<span id="pre2"></span><br>
								<span id="pre3"></span><br>
								<span id="pre4"> </span><br>
								<span id="pre5"></span><br>
							</p>
							</div>
							<div style="font-weight: bold;">[답]</div>
							<div style="margin-bottom: 15px;">
								<span style="font-weight: bold; color: red;word-break:break-all;"id="preDap">④ 질문하고 답하는
									방식을 사용하여 발표 내용</span>
							</div>
							<div style="font-weight: bold;">[해설]</div>
							<div style="margin-bottom: 10px;"id="presolution">첫해 배치 에는 두 가지 문제가 있었는데요,
								우선 작물의 키를 고려하지 않았다는 점이에요. 해는 동쪽에서 떠서 한낮에 남쪽을 지나 서쪽으로 지고 해가 떠 있는
								반대 방향으로 그림자가 생기죠. 작물은 광합성이 많이 이루어지는 오전부터 한낮까지 그림자의 영향을 최소한으로 받아야
								잘 자랄 수 있어요. 이를 고려해 키가 작은 작물을 동쪽과 남쪽에 배치해야 해요. 해는 동쪽에서 떠서 한낮에 남쪽을
								지나 서쪽으로 지고 해가 떠 있는 반대 방향으로 그림자가 생기죠. 작물은 광합성이 많이 이루어지는 오전부터 한낮까지
								그림자의 영향을 최소한으로 받아야 잘 자랄 수 있어요. 이를 고려해 키가 작은 작물을 동쪽과 남쪽에 배치해야 해요.</div>
							<nav aria-label="Navigation">
								<ul class="pagination justify-content-center m-0">
								

									<li class="page-item go2 active" id="premaster"><a class="page-link"onclick="previewgo(this);">1</a></li>
									<li class="page-item go2"><a class="page-link"onclick="previewgo(this);">2</a></li>
<!-- 									<li class="page-item go2"><a class="page-link"onclick="previewgo(this);">3</a></li> -->
<!-- 									<li class="page-item go2"><a class="page-link"onclick="previewgo(this);">4</a></li> -->


								
								</ul>
							</nav>
						</div>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
	</div>
	<!-- /.modal -->
		<input type="hidden" name="picture1" id="pickpicture1">
			<input type="hidden" name="picture2" id="pickpicture2">
<!-- 				<input type="hidden" name="picture3" id="pickpicture3"> -->
<!-- 					<input type="hidden" name="picture4" id="pickpicture4"> -->
	
	
</form>	
	
	

	
	
	
	<form role="imageForm" action="upload/picture" method="post"
		enctype="multipart/form-data">
		<input id="inputFile1" name="pictureFile1" type="file"
			class="form-control" style="display: none;" onchange="picture_go();">
			<input id="inputFile2" name="pictureFile2" type="file"
			class="form-control" style="display: none;" onchange="picture_go();">
<!-- 			<input id="inputFile3" name="pictureFile3" type="file" -->
<!-- 			class="form-control" style="display: none;" onchange="picture_go();"> -->
<!-- 			<input id="inputFile4" name="pictureFile4" type="file" -->
<!-- 			class="form-control" style="display: none;" onchange="picture_go();"> -->
			
	
	</form>	
	
	
	
	
	
	
	
	
	
	
	
</body>
