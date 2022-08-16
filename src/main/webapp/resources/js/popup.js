//파일 인풋 추가
var dataNum = 0;

function addFile_go(){
	//alert("add file btn");

	if($('input[name="uploadFile"]').length>=3){
		alert("파일 추가는 3개까지만 가능합니다.");
		return;
	}
	
	var div=$('<div>').addClass("inputRow").attr("data-no",dataNum);
	var input=$('<input>').attr({"type":"file","name":"uploadFile"}).css("display","inline");
	div.append(input).append("<button onclick='remove_go("+dataNum+");' style='border:0;outline:0;' class='badge bg-red' type='button'>X</button>");
	
	$('.fileInput').append(div);
	
	dataNum++;
}
//파일 인풋 삭제
function remove_go(dataNum){
// 	alert(dataNum);
	$('div[data-no="'+dataNum+'"]').remove();
}

//popup regist
function regist_go(){
	var bool = true;
	
	if($('#inuse').is(':checked')==true){
		$.ajax({
			url:"getCount.go",
			async:false,
			success:function(res){
				if(res>0){
					bool = false;
				}
			},
			error:function(error){
				console.log(error.status);
			}
		});//ajax끝
	}//if끝
//	if(bool==false)	{
//		alert("이미 사용중인 팝업이 있습니다. 수정 후 등록 해주십시오.");
//		return;
//	}
	
	//체크박스 체크유무에 따른 값주기
	if($('#inuse').is(':checked')==true){
		$('input[name="inuse"]').attr('value','Y');
	}else{
		$('input[name="inuse"]').attr('value','N');
	}

	var files = $('input[name="uploadFile"]');
	for(var file of files){
		console.log(file.name+" : "+file.value);
		if(file.value==""){
			alert("파일을 선택하세요.");
			file.focus();
			file.click();
			return;
		}
	}
	
	if($("input[name='title']").val()==""){
		alert("제목은 필수입니다.");
		$("input[name='title']").focus();
		return;
	}
	if($("input[name='content']").val()==""){
		alert("내용은 필수입니다.");
		$("input[name='content']").focus();
		return;
	}
	if($("input[name='startDate']").val()==""){
		alert("시작일은 필수입니다.");
		$("input[name='startDate']").focus();
		return;
	}
	if($("input[name='endDate']").val()==""){
		alert("종료일은 필수입니다.");
		$("input[name='endDate']").focus();
		return;
	}
	
	if($("input[name='startDate']").val() > $("input[name='endDate']").val()){
		alert("시작일은 종료일보다 클 수 없습니다.");
		$("input[name='startDate']").focus();
		return;
	}
	
	$("form[role='form']").attr("action","regist.go");
	$("form[role='form']").submit();
}

//상세에서 파일 삭제
function removeFile_go(className){
	//alert("X btn");
	var li = $('li.'+className);

	if(!confirm(li.attr("file-name")+"을 정말 삭제하시겠습니까?")){
		return;
	}

	li.remove();

	var input=$('<input>').attr({"type":"hidden",
		 "name":"deleteFile",
		 "value":li.attr("target-ano")
		});
	$('form[role="form"]').prepend(input);

}

//팝업 상세에서 수정 
function modify_go(){
	var bool=true;
	if($('#inuse').is(':checked')==true){
		$.ajax({
			url:"getCount.go",
			async:false,
			success:function(res){
				if(res>0){
					bool=false;
				}
			},
			error:function(error){
				console.log(error.status);
			}
		});//ajax끝
	}//if끝
	
	if(bool==false) {
		alert("이미 사용중인 팝업이 있습니다. 수정 후 등록 해주십시오.");
		return;
	}
	
	//체크박스 체크유무에 따른 값주기
	if($('#inuse').is(':checked')==true){
		$('input[name="inuse"]').attr('value','Y');
	}else{
		$('input[name="inuse"]').attr('value','N');
	}
	
	var files = $('input[name="uploadFile"]');
	for(var file of files){
		console.log(file.name+" : "+file.value);
		if(file.value==""){
			alert("파일을 선택하세요.");
			file.focus();
			file.click();
			return;
		}
	}
	
	if($("input[name='title']").val()==""){
		alert("제목은 필수입니다.");
		$("input[name='title']").focus();
		return;
	}
	if($("input[name='content']").val()==""){
		alert("내용은 필수입니다.");
		$("input[name='content']").focus();
		return;
	}
	if($("input[name='startDate']").val()==""){
		alert("시작일은 필수입니다.");
		$("input[name='startDate']").focus();
		return;
	}
	if($("input[name='endDate']").val()==""){
		alert("종료일은 필수입니다.");
		$("input[name='endDate']").focus();
		return;
	}
	
	if($("input[name='startDate']").val() > $("input[name='endDate']").val()){
		alert("시작일은 종료일보다 클 수 없습니다.");
		$("input[name='startDate']").focus();
		return;
	}
	
	$("form[role='form']").attr("action","modify.go");
	$("form[role='form']").submit();
	
}

//팝업 삭제
function remove_go(){
	
	confirm("정말 삭제 하시겠습니까?");
	
	$("form[role='form']").attr("action","remove.go");
	$("form[role='form']").submit();
}


$('#inuse').change(function(){
	//체크박스 체크유무에 따른 값주기
	if($('#inuse').is(':checked')==true){
		$.ajax({
			url:"getCount.go",
			success:function(res){
				if(res>0){
					alert('이미 사용중인 팝업이 존재합니다!');
//					Swal.fire({
//						  icon: 'error',
//						  title: 'Oops...',
//						  text: '이미 사용중인 팝업이 존재합니다!'
//						})
				}
			},
			error:function(error){
				
			}
		});//ajax끝
	}//if끝
})

//function checkInuse(){
//	if($('#inuse').is(':checked')==true){
//		$.ajax({
//			url:"getCount.go",
//			success:function(res){
//				if(res>0){
//					alert('이미 사용중인 팝업이 존재합니다!');
//				}
//			},
//			error:function(error){
//				
//			}
//		});//ajax끝
//	}//if끝
//}

















