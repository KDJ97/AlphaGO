<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="dataVO" value="${dataMap.dataVO }"  />
<c:set var="timetable" value="${dataMap.timetable }"  />
<c:set var="classPlanVO" value="${dataMap.classPlanVO }"  />
<c:set var="weekPlan" value="${dataMap.weekPlan }"  />
<c:set var="homeworkPlan" value="${dataMap.homeworkPlan }"  />


<head>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
//input에 숫자만 받기 위한 메서드
function checkNumber(event) {
  if(event.key === '.' 
	     || event.key === '-'
	     || event.key >= 0 && event.key <= 9) {
	    return true;
	  }
	  return false;
}
</script>
<script>
$(function(){
	//등록된 수업계획서 등록할때  새로 추가해서 생긴 행의 X버튼 눌렀을때 
	$('#registed').on('click','.newXbt',function(){
		$(this).parent().parent().remove();
	})
	$('#registedHW').on('click','.newXbt',function(){
		$(this).parent().parent().remove();
	})
})
</script>

<script>
$(function(){
	//등록되어있던 weekplan의 X버튼 눌렀을때 삭제
	$('body').on('click','.oldXbt1',function(){
		var wpno = $(this).attr('id');
		//console.log(wpno);
		var trId = $(this).parent().parent();
		
		$.ajax({
			url: "<%=request.getContextPath()%>/tclass/deleteWeekPlan",
			data:{"wpno" : wpno},
			method:"GET",
			success:function(){
				alert("삭제완료!");
				trId.remove();
			},
			error:function(){
				alert("삭제실패.. 관리자에게 문의하세요.");
			}
		})
	})

	//등록되어있던 homeworkplan의 X버튼 눌렀을때 삭제
	$('body').on('click','.oldXbt2',function(){
		var homeworkplan = $(this).attr('id');
		var parentTr = $(this).parent().parent();
		
		$.ajax({
			url: "<%=request.getContextPath()%>/tclass/deleteHomeworkPlan",
			data:{"homeworkplan" : homeworkplan},
			method:"GET",
			success:function(){
				alert("삭제완료!");
				parentTr.remove();
			},
			error:function(){
				alert("삭제실패.. 관리자에게 문의하세요.");
			}
		})
	})
})
</script>

<!-- 수정버튼 눌렀을때 -->
<script>
var ppp=false;
var ppp2=false;
var ppp3=false;
var ppp4=false;
var ppp5=false;

//교재,수업개요 수정 
$('.modal-footer').on('click','#modifyBtn',function(){
	var tbInupt = $('#tbInput').val();
	var cpheadTa = $('#cpheadTa').val();
	cpheadTa = cpheadTa.replace(/\r\n|\n/g,'<br>');
	var cpno = $('.cpnos').val();
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/updateClassPlan",
		method:"POST",
		data:{
			"tbInupt" : tbInupt,
			"cpheadTa" : cpheadTa,
			"cpno" : cpno
		},
		success:function(res){
			ppp5=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("수정 성공!");
				window.location.reload();
			}
		},
		error:function(error){
			alert("수정 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})

//weekPlan 등록
$('.modal-footer').on('click','#modifyBtn',function(){
	var inputs = document.querySelectorAll('input.newInput1');
	var tas = document.querySelectorAll('textarea.newTa1');
	var inputArr = [];
	var taArr = [];
	var cpno = $('.cpnos').val();
	//console.log("cpno : " + cpno);
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
	}
	//console.log(inputArr);
	//console.log(taArr);
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/registerWeekPlan",
		method:"POST",
		traditional : true ,  //배열보낼때 쓰라고함
		data:{
			"cpno" : cpno,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("수정 성공!");
				window.location.reload();
			}
		},
		error:function(error){
			alert("수정 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
	
})
//homeworkPlan 등록
$('.modal-footer').on('click','#modifyBtn',function(){
	var inputs = document.querySelectorAll('input.newInput2');
	var tas = document.querySelectorAll('textarea.newTa2');
	var inputArr = [];
	var taArr = [];
	var cpno = $('.cpnos').val();
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
	}
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/registerHomeworkPlan",
		method:"POST",
		traditional : true ,
		data:{
			"cpno" : cpno,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp2=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("수정 성공!");
				window.location.reload();
			}
		},
		error:function(error){
			alert("수정 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})

//weekPlan 수정
$('.modal-footer').on('click','#modifyBtn',function(){
	var wpnos = document.querySelectorAll('input.forWpno');
	var inputs = document.querySelectorAll('input.oldInput1');
	var tas = document.querySelectorAll('textarea.oldTa1');
	var wpnoArr = [];
	var inputArr = [];
	var taArr = [];
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
		wpnoArr[i] = wpnos[i].value;
	}
//		console.log(inputArr);
//		console.log(taArr);
//		console.log(wpnoArr);
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/updateWeekPlan",
		method:"POST",
		traditional : true ,  //배열보낼때 쓰라고함
		data:{
			"wpnoArr" : wpnoArr,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp3=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("수정 성공!");
				window.location.reload();
			}
		},
		error:function(error){
			alert("수정 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})	

//homeworkPlan 수정  forHomeworkplan
$('.modal-footer').on('click','#modifyBtn',function(){
	var homeworkplans = document.querySelectorAll('input.forHomeworkplan');
	var inputs = document.querySelectorAll('input.oldInput2');
	var tas = document.querySelectorAll('textarea.oldTa2');
	var homeworkplanArr = [];
	var inputArr = [];
	var taArr = [];
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
		homeworkplanArr[i] = homeworkplans[i].value;
	}
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/updateHomeworkPlan",
		method:"POST",
		traditional : true ,  //배열보낼때 쓰라고함
		data:{
			"homeworkplanArr" : homeworkplanArr,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp4=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("수정 성공!");
				window.location.reload();
			}
		},
		error:function(error){
			alert("수정 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})

</script>



<!-- 수업계획서 미등록된 수업리스트 눌러서 뜬 창에서 처음 임시저장버튼 눌렀을때 (미제출:0->임시저장:4)    -->
<script>
var ppp=false;
var ppp2=false;
var ppp3=false;
//교재,수업개요 등록 For 임시저장
$('.modal-footer').on('click','#tempSave',function(){
	var tbInupt = $('#tbInput').val();
	var cpheadTa = $('#cpheadTa').val();
	cpheadTa = cpheadTa.replace(/\r\n|\n/g,'<br>');
	var subName = $('.subName').text();
	var classCode = $('#clCode').val();
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/registerTextbookAndCphead",
		method:"POST",
		traditional : true ,
		data:{
			"tbInupt" : tbInupt,
			"cpheadTa" : cpheadTa,
			"classCode" : classCode,
			"subName" : subName
		},
		success:function(res){
			ppp3=true;
			if(ppp&&ppp2&ppp3){
				ppp=false;
				ppp2=false;
				ppp3=false;
				alert("임시저장 되었습니다.");
				window.location.reload();
				opener.location.reload();
			}
		},
		error:function(error){
			alert("임시저장 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})

//weekPlan 등록
$('.modal-footer').on('click','#tempSave',function(){
	var inputs = document.querySelectorAll('input.newInput1');
	var tas = document.querySelectorAll('textarea.newTa1');
	var inputArr = [];
	var taArr = [];
	var cpno = $('.cpnos').val();
	//console.log("cpno : " + cpno);
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
	}
	//console.log(inputArr);
	//console.log(taArr);
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/registerWeekPlan",
		method:"POST",
		traditional : true ,  //배열보낼때 쓰라고함
		data:{
			"cpno" : cpno,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp=true;
			if(ppp&&ppp2&ppp3){
				ppp=false;
				ppp2=false;
				ppp3=false;
				alert("임시저장 되었습니다.");
				window.location.reload();
				opener.location.reload();
			}
		},
		error:function(error){
			alert("임시저장 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
	
})
//homeworkPlan 등록
$('.modal-footer').on('click','#tempSave',function(){
	var inputs = document.querySelectorAll('input.newInput2');
	var tas = document.querySelectorAll('textarea.newTa2');
	var inputArr = [];
	var taArr = [];
	var cpno = $('.cpnos').val();
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
	}
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/registerHomeworkPlan",
		method:"POST",
		traditional : true ,
		data:{
			"cpno" : cpno,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp2=true;
			if(ppp&&ppp2&ppp3){
				ppp=false;
				ppp2=false;
				ppp3=false;
				alert("임시저장 되었습니다.");
				window.location.reload();
				opener.location.reload();
			}
		},
		error:function(error){
			alert("임시저장 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})





</script>
<!-- 수업계획서 미등록된 수업리스트 중 수업계획서제출상태가 미제출이 아닌 버튼 눌러서 뜬 창에서 임시저장버튼 눌렀을때  (제출or반려or임시저장 -> 임시저장:4 )-->
<script>
var ppp=false;
var ppp2=false;
var ppp3=false;
var ppp4=false;
var ppp5=false;

//교재,수업개요 수정 
$('.modal-footer').on('click','#tempSaveUpdate',function(){
	var tbInupt = $('#tbInput').val();
	var cpheadTa = $('#cpheadTa').val();
	cpheadTa = cpheadTa.replace(/\r\n|\n/g,'<br>');
	var cpno = $('.cpnos').val();
	var classCode = $('#clCode').val();
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/updateClassPlanForTempSave",
		method:"POST",
		data:{
			"tbInupt" : tbInupt,
			"cpheadTa" : cpheadTa,
			"classCode" : classCode,
			"cpno" : cpno
		},
		success:function(res){
			ppp5=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("임시저장 되었습니다.");
				window.location.reload();
				opener.location.reload();
			}
		},
		error:function(error){
			//alert("임시저장 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})

//weekPlan 등록
$('.modal-footer').on('click','#tempSaveUpdate',function(){
	var inputs = document.querySelectorAll('input.newInput1');
	var tas = document.querySelectorAll('textarea.newTa1');
	var inputArr = [];
	var taArr = [];
	var cpno = $('.cpnos').val();
	//console.log("cpno : " + cpno);
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
	}
	//console.log(inputArr);
	//console.log(taArr);
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/registerWeekPlan",
		method:"POST",
		traditional : true ,  //배열보낼때 쓰라고함
		data:{
			"cpno" : cpno,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("임시저장 되었습니다.");
				window.location.reload();
				opener.location.reload();
			}
		},
		error:function(error){
			alert("임시저장 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})
//homeworkPlan 등록
$('.modal-footer').on('click','#tempSaveUpdate',function(){
	var inputs = document.querySelectorAll('input.newInput2');
	var tas = document.querySelectorAll('textarea.newTa2');
	var inputArr = [];
	var taArr = [];
	var cpno = $('.cpnos').val();
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
	}
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/registerHomeworkPlan",
		method:"POST",
		traditional : true ,
		data:{
			"cpno" : cpno,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp2=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("임시저장 되었습니다.");
				window.location.reload();
				opener.location.reload();
			}
		},
		error:function(error){
			alert("임시저장 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})

//weekPlan 수정
$('.modal-footer').on('click','#tempSaveUpdate',function(){
	var wpnos = document.querySelectorAll('input.forWpno');
	var inputs = document.querySelectorAll('input.oldInput1');
	var tas = document.querySelectorAll('textarea.oldTa1');
	var wpnoArr = [];
	var inputArr = [];
	var taArr = [];
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
		wpnoArr[i] = wpnos[i].value;
	}
//		console.log(inputArr);
//		console.log(taArr);
//		console.log(wpnoArr);
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/updateWeekPlan",
		method:"POST",
		traditional : true ,  //배열보낼때 쓰라고함
		data:{
			"wpnoArr" : wpnoArr,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp3=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("임시저장 되었습니다.");
				window.location.reload();
				opener.location.reload();
			}
		},
		error:function(error){
			alert("임시저장 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})	

//homeworkPlan 수정  forHomeworkplan
$('.modal-footer').on('click','#tempSaveUpdate',function(){
	var homeworkplans = document.querySelectorAll('input.forHomeworkplan');
	var inputs = document.querySelectorAll('input.oldInput2');
	var tas = document.querySelectorAll('textarea.oldTa2');
	var homeworkplanArr = [];
	var inputArr = [];
	var taArr = [];
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
		homeworkplanArr[i] = homeworkplans[i].value;
	}
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/updateHomeworkPlan",
		method:"POST",
		traditional : true ,  //배열보낼때 쓰라고함
		data:{
			"homeworkplanArr" : homeworkplanArr,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp4=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("임시저장 되었습니다.");
				window.location.reload();
				opener.location.reload();
			}
		},
		error:function(error){
			alert("임시저장 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})


</script>

<!-- 수업계획서 미등록된 수업리스트 중 수업계획서제출상태가 미제출이 아닌 버튼 눌러서 뜬 창에서 제출버튼 눌렀을때  (제출or반려or임시저장 -> 제출:1 )-->
<script>
var ppp=false;
var ppp2=false;
var ppp3=false;
var ppp4=false;
var ppp5=false;

//교재,수업개요 수정 
$('.modal-footer').on('click','#regiCPbtnUpdate',function(){
	var tbInupt = $('#tbInput').val();
	var cpheadTa = $('#cpheadTa').val();
	cpheadTa = cpheadTa.replace(/\r\n|\n/g,'<br>');
	var cpno = $('.cpnos').val();
	var classCode = $('#clCode').val();
		$.ajax({
			url:"<%=request.getContextPath()%>/tclass/updateClassPlanForSubmit",
			method:"POST",
			data:{
				"tbInupt" : tbInupt,
				"cpheadTa" : cpheadTa,
				"classCode" : classCode,
				"cpno" : cpno
			},
			success:function(res){
				ppp5=true;
				if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
					ppp=false;
					ppp2=false;
					ppp3=false;
					ppp4=false;
					ppp5=false;
					//alert("제출 성공!");
					window.close();
					opener.location.reload();
				}
			},
			error:function(error){
				//alert("제출 실패.. 관리자에게 문의하세요.")
				window.location.reload(true);
			}
		});	
})

//weekPlan 등록
$('.modal-footer').on('click','#regiCPbtnUpdate',function(){
	var inputs = document.querySelectorAll('input.newInput1');
	var tas = document.querySelectorAll('textarea.newTa1');
	var inputArr = [];
	var taArr = [];
	var cpno = $('.cpnos').val();
	//console.log("cpno : " + cpno);
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
	}
	//console.log(inputArr);
	//console.log(taArr);
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/registerWeekPlan",
		method:"POST",
		traditional : true ,  //배열보낼때 쓰라고함
		data:{
			"cpno" : cpno,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("제출 성공!");
				window.close();
				opener.location.reload();
			}
		},
		error:function(error){
			alert("제출 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
	
})
//homeworkPlan 등록
$('.modal-footer').on('click','#regiCPbtnUpdate',function(){
	var inputs = document.querySelectorAll('input.newInput2');
	var tas = document.querySelectorAll('textarea.newTa2');
	var inputArr = [];
	var taArr = [];
	var cpno = $('.cpnos').val();
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
	}
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/registerHomeworkPlan",
		method:"POST",
		traditional : true ,
		data:{
			"cpno" : cpno,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp2=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("제출 성공!");
				window.close();
				opener.location.reload();
			}
		},
		error:function(error){
			alert("제출 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})

//weekPlan 수정
$('.modal-footer').on('click','#regiCPbtnUpdate',function(){
	var wpnos = document.querySelectorAll('input.forWpno');
	var inputs = document.querySelectorAll('input.oldInput1');
	var tas = document.querySelectorAll('textarea.oldTa1');
	var wpnoArr = [];
	var inputArr = [];
	var taArr = [];
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
		wpnoArr[i] = wpnos[i].value;
	}
//		console.log(inputArr);
//		console.log(taArr);
//		console.log(wpnoArr);
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/updateWeekPlan",
		method:"POST",
		traditional : true ,  //배열보낼때 쓰라고함
		data:{
			"wpnoArr" : wpnoArr,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp3=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("제출 성공!");
				window.close();
				opener.location.reload();
			}
		},
		error:function(error){
			window.location.reload(true);
		}
	});
})	

//homeworkPlan 수정  forHomeworkplan
$('.modal-footer').on('click','#regiCPbtnUpdate',function(){
	var homeworkplans = document.querySelectorAll('input.forHomeworkplan');
	var inputs = document.querySelectorAll('input.oldInput2');
	var tas = document.querySelectorAll('textarea.oldTa2');
	var homeworkplanArr = [];
	var inputArr = [];
	var taArr = [];
	
	for(var i=0; i<inputs.length; i++){
		inputArr[i] = inputs[i].value;
		taArr[i] = tas[i].value;
		homeworkplanArr[i] = homeworkplans[i].value;
	}
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/updateHomeworkPlan",
		method:"POST",
		traditional : true ,  //배열보낼때 쓰라고함
		data:{
			"homeworkplanArr" : homeworkplanArr,
			"inputArr" : inputArr,
			"taArr" : taArr
		},
		success:function(res){
			ppp4=true;
			if(ppp&&ppp2&&ppp3&&ppp4&ppp5){
				ppp=false;
				ppp2=false;
				ppp3=false;
				ppp4=false;
				ppp5=false;
				alert("제출 성공!");
				window.close();
				opener.location.reload();
			}
		},
		error:function(error){
			alert("제출 실패.. 관리자에게 문의하세요.")
			window.location.reload(true);
		}
	});
})


</script>



<!-- 수업계획서 미등록된 수업리스트 눌러서 뜬 창에서  등록버튼 눌렀을때 (미제출:0->제출:1)-->
<script>
$(function(){
	$('.modal-footer').on('click','#regiCPbtn',function(){
		var tb = $('#tbInput').val();
		var cphd = $('#cpheadTa').val();
		cphd = cphd.replace(/\r\n|\n/g,'<br>');
		var weeks = document.querySelectorAll('input.newInput1');
		var cps = document.querySelectorAll('textarea.newTa1');
		
		var hwnos = document.querySelectorAll("input.newInput2");
		var hwPlans	= document.querySelectorAll("textarea.newTa2");
		
		var subName = $('.subName').text();
		var classCode = $('#clCode').val(); 
		
		var weeksArr = [];
		var cpsArr = [];
		var hwnoArr = [];
		var hwPlanArr = [];
		
		for(var i=0; i<weeks.length; i++){
			//console.log(weeks[i].value);
			weeksArr[i] = weeks[i].value;
			cpsArr[i] = cps[i].value;
		}
		//console.log(weeksArr);
		//console.log(cpsArr);
		
		for(var i=0; i<hwnos.length; i++){
			//console.log(weeks[i].value);
			hwnoArr[i] = hwnos[i].value;
			hwPlanArr[i] = hwPlans[i].value;
		}
		//console.log(hwnoArr);
		//console.log(hwPlanArr);
		
		$.ajax({
			url:"<%=request.getContextPath()%>/tclass/registerClassPlan",
			method:"POST",
			traditional : true ,
			data:{
				"tb" : tb,
				"classCode" : classCode,
				"cphd" : cphd,
				"weeksArr" : weeksArr,
				"cpsArr" : cpsArr,
				"hwnoArr" : hwnoArr,
				"hwPlanArr" : hwPlanArr,
				"subName" : subName
			},
// 			dataType:"json",
			success:function(res){
				alert("제출 완료!");
				window.close();
				opener.location.reload();
			},
			error:function(error){
				alert("제출 실패.. 관리자에게 문의하세요.")
				window.location.reload(true);
			}
		});
		
		
	})
})
</script>





<script>
function addRow() {
	  var i = document.createElement('textarea');
	  i.setAttribute("rows", "1");
	  i.setAttribute("style", "width:95%"); 
	  i.setAttribute("class", "newTa1");
	  
	  var xbt = document.createElement('button');
	  xbt.setAttribute("style", "float:right; height:25px; line-height:0px; text-align:center;");
	  xbt.setAttribute("class", "btn btn-secondary newXbt");
	  xbt.innerText = 'X';
	  
	  var j = document.createElement('input');
	  j.setAttribute("type", "text");
	  j.setAttribute("style", "width:30px;");
	  j.setAttribute("class", "newInput1");
	  j.setAttribute("onKeyup", "this.value=this.value.replace(/[^-0-9]/g,'');");
	  
	  // table element 찾기
	  var table = document.getElementById('addTable1');
	  
	  // 새 행(Row) 추가
	  var newRow = table.insertRow(table.rows.length);
	  newRow.setAttribute("class","newWPtr");
	  //console.log(newRow);
	  
	  // 새 행(Row)에 Cell 추가
	  var newCell1 = newRow.insertCell(0);
	  var newCell2 = newRow.insertCell(1);
	  
	  newCell2.setAttribute("style","text-align:left;");
	  
	  // Cell에 텍스트 추가
	  newCell1.append(j);
	  newCell2.append(i);
	  newCell2.append(xbt);
}
function addRow2() {
	  var i = document.createElement('textarea');
	  i.setAttribute("rows", "1");
	  i.setAttribute("style", "width:95%");  
	  i.setAttribute("class", "newTa2");
	  
	  var xbt = document.createElement('button');
	  xbt.setAttribute("style", "float:right; height:25px; line-height:0px; text-align:center;");
	  xbt.setAttribute("class", "btn btn-secondary newXbt");
	  xbt.innerText = 'X';
	  
	  var j = document.createElement('input');
	  j.setAttribute("type", "text");
	  j.setAttribute("style", "width:30px;");
	  j.setAttribute("class", "newInput2");
	  j.setAttribute("onKeyup", "this.value=this.value.replace(/[^-0-9]/g,'');");
	  // table element 찾기
	  var table = document.getElementById('addTable2');
	  
	  // 새 행(Row) 추가
	  var newRow = table.insertRow(table.rows.length);
			  
	  // 새 행(Row)에 Cell 추가
	  var newCell1 = newRow.insertCell(0);
	  var newCell2 = newRow.insertCell(1);
	  
	  newCell2.setAttribute("style","text-align:left;");
	  
	  // Cell에 텍스트 추가
	  newCell1.append(j);
	  newCell2.append(i);
	  newCell2.append(xbt);
}
</script>

<script>
//textarea <br>태그 \r\n으로 치환
$(function(){
	var cphead = $('#cpheadTa').val()
	console.log(cphead);
	cphead = cphead.split('<br>').join("\r\n");
	console.log(cphead);
	$('#cpheadTa').val(cphead);
	
})
</script>

</head>
<body>
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">수업계획서</h5>
		</div>
		<div class="modal-body" id="regiModal">
			<div id="regiTable1">
			<table style="height:10px;" class="table table-bordered text-center" >
				<tr>
					<th style="background-color: #8BDDA8; font-weight:bold;">과목명<input id="clCode" type="hidden" value="${dataVO.classCode}"></th>
					<td class="subName">${dataVO.subjectName}</td>
					<td style="background-color: #8BDDA8; font-weight:bold;">수업시수</td>
					<td>${dataVO.totalTime}H</td>
				</tr>
				<tr>
					<td style="background-color: #8BDDA8; font-weight:bold;">수업명</td>
					<td>${dataVO.className}</td>
					<td style="background-color: #8BDDA8; font-weight:bold;">강사명</td>
					<td>${dataVO.name}</td>
				</tr>
				<tr>
					<td style="background-color: #8BDDA8; font-weight:bold;">시작일</td>
					<td>${fn:substring(dataVO.startDate,0,10)}</td>				
					<td style="background-color: #8BDDA8; font-weight:bold;">종료일</td>
					<td>${fn:substring(dataVO.endDate,0,10)}</td>
				</tr>
			</table>
			</div>

			<table id="regiTable2" class="table table-bordered text-center">
				<tr>
      			<td style="background-color: #8BDDA8; font-weight:bold; width:50%;">수업시간</td>
      			<td style="background-color: #8BDDA8; font-weight:bold; width:50%;">강의실</td>
	      		</tr>
	      		<c:forEach items="${timetable }" var="timetable">
		      		<tr>
		      		<td style="padding:0px;">${timetable.startTime}~${timetable.endTime}(${timetable.classday})</td>
		      		<td style="padding:0px;">${timetable.roomNo}호</td>
		      		</tr>
	  			</c:forEach>
			</table>

			<div id="regiTable3">
  			<input type="hidden" class="cpnos" value="${classPlanVO.cpno}" />
  			<table  class="table table-bordered text-center">
  				<tr>
      				<td style="background-color: #8BDDA8; font-weight:bold; width:10%;">교재</td>
      				<td style="width:90%;"><input id="tbInput" style="text-align:left; width:100%;" type="text" value="${classPlanVO.textbook}"></td>
      			</tr>
      			<tr>
      				<td style="background-color: #8BDDA8; font-weight:bold; vertical-align: middle;">수업개요</td>
      				<td style="text-align:left;">
      				<textarea id="cpheadTa" rows="5" style="width:100%;">${classPlanVO.cphead}</textarea>
      				</td>
    			</tr>
    		</table>
			</div>

			<div id="registed">
			<table id="addTable1" style="height:20px;" class="table table-bordered text-center">
      			<tr style="height:20px;">
	      			<th style="width:10%; background-color: #8BDDA8; font-weight:bold; vertical-align: middle;">주차</th>
	      			<th style="width:90%; background-color: #8BDDA8; font-weight:bold; vertical-align: middle;">수업계획
	      			<button onclick="addRow();" style="float:right; height:25px; line-height:0px; text-align:center; margin-right:5px;" class="btn btn-secondary">추가</button></th>
      			</tr>
<%--       			<div>${empty weekPlan }</div> --%>
				<c:choose>
      			<c:when test="${!empty weekPlan  }">
      			<c:forEach items="${weekPlan }" var="weekPlan">
	      			<tr>
		      			<td style="vertical-align: middle;"><input class="oldInput1" type="text" style="width:30px;" onKeyPress="return checkNumber(event)" value="${weekPlan.week}" ></td>
		      			<td id="cpno${weekPlan.cpno}" style="text-align:left; vertical-align: middle;">
		      			<textarea class="oldTa1" rows="1" style="width:95%;">${weekPlan.content}</textarea>
		      			<button style="float:right; height:25px; line-height:0px; text-align:center;" id="${weekPlan.wpno}" class="btn btn-secondary oldXbt1">X</button>
		      			<input type="hidden" class="forWpno" value="${weekPlan.wpno}"  >
		      			</td>
	      			</tr>
      			</c:forEach>
      			</c:when>
      			<c:when test="${empty weekPlan }">
      			<c:forEach begin="1" end="${dataVO.totalWeek }" step="1" var="i" >
					<tr>
						<td style="vertical-align: middle;"><input class="newInput1" type="text" style="width:30px;" onKeyPress="return checkNumber(event)" value="${i}"></td>
		      			<td style="text-align:left; vertical-align: middle;">
		      			<textarea class="newTa1" rows="1" style="width:95%;"></textarea>
		      			<button style="float:right; height:25px; line-height:0px; text-align:center;" class="btn btn-secondary newXbt1">X</button>
		      			<input type="hidden" class="forWpno" value=""  >
		      			</td>
					</tr>      			
      			</c:forEach>	
      			</c:when>
      			</c:choose>
      	      	</table>
			</div>

			<div id="registedHW">
			<table id="addTable2" class="table table-bordered text-center">
      			<tr>
	      			<th style="width:10%; background-color: #8BDDA8; font-weight:bold;">No</th>
	      			<th style="width:90%; background-color: #8BDDA8; font-weight:bold;">과제계획
	      			<button onclick="addRow2();" style="float:right; height:25px; line-height:0px; text-align:center; margin-right:5px;" class="btn btn-secondary">추가</button></th>
	      		</tr>
	      		<c:forEach items="${homeworkPlan }" var="homeworkPlan">
		      		<tr>
		      			<td><input class="oldInput2" type="text" style="width:30px;"  onkeypress="return checkNumber(event)" value="${homeworkPlan.no}" ></td>
		      			<td style="text-align:left;">
		      			<textarea class="oldTa2" rows="1" style="width:95%;">${homeworkPlan.content}</textarea>
		      			<button style="float:right; height:25px; line-height:0px; text-align:center;" id="${homeworkPlan.homeworkplan}" class="btn btn-secondary oldXbt2">X</button>
		      			<input type="hidden" class="forHomeworkplan" value="${homeworkPlan.homeworkplan}"  >
		      			</td>
		      		</tr>
	      		</c:forEach>
      			</table>
			</div>

		</div>
		<div class="modal-footer">
			<c:if test="${dataVO.cpcheck ne '3' and dataVO.cpcheck eq '0'}">
			<button id="tempSave" type="button" class="btn btn-warning" style="margin-right:77%;">임시저장</button>
			</c:if>
			<c:if test="${dataVO.cpcheck ne '3' and dataVO.cpcheck ne '0'}">
			<button id="tempSaveUpdate" type="button" class="btn btn-warning" style="margin-right:77%;">임시저장</button>
			</c:if>
			<c:if test="${dataVO.cpcheck eq '3' }">
			<button id="modifyBtn" type="button" class="btn btn-primary">수정</button>
			</c:if>
			<c:if test="${dataVO.cpcheck ne '3' and dataVO.cpcheck eq '0'}">
			<button type="button" class="btn btn-primary" id="regiCPbtn">제출</button>
			</c:if>
			<c:if test="${dataVO.cpcheck ne '3' and dataVO.cpcheck ne '0'}">
			<button type="button" class="btn btn-primary" id="regiCPbtnUpdate">제출</button>
			</c:if>
			<button type="button" class="btn btn-secondary"
				 id="modalClose1" onclick="window.close();">닫기</button>
		</div>
	</div>
</body>
</html>