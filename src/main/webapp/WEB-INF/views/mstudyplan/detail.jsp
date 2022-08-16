<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:set var="dataVO" value="${dataMap.dataVO }"  />
<c:set var="timetable" value="${dataMap.timetable }"  />
<c:set var="classPlanVO" value="${dataMap.classPlanVO }"  />
<c:set var="weekPlan" value="${dataMap.weekPlan }"  />
<c:set var="homeworkPlan" value="${dataMap.homeworkPlan }"  />
	<div class="modal-content">
		<div class="modal-header">
			<h5 class="modal-title" id="exampleModalLabel">수업계획서</h5>
		</div>
		<div class="modal-body" id="regiModal">
			<div id="regiTable1">
			<table style="height:10px;" class="table table-bordered text-center" >
				<tr>
					<th style="background-color: #99CCFF;color:black; font-weight:bold;">과목명<input id="clCode" type="hidden" value="${dataVO.classCode}"></th>
					<td class="subName">${dataVO.subjectName}</td>
					<td style="background-color: #99CCFF;color:black; font-weight:bold;">수업시수</td>
					<td>${dataVO.totalTime}H</td>
				</tr>
				<tr>
					<td style="background-color: #99CCFF;color:black; font-weight:bold;">수업명</td>
					<td>${dataVO.className}</td>
					<td style="background-color: #99CCFF;color:black; font-weight:bold;">강사명</td>
					<td>${dataVO.name}</td>
				</tr>
				<tr>
					<td style="background-color: #99CCFF;color:black; font-weight:bold;">시작일</td>
					<td>${fn:substring(dataVO.startDate,0,10)}</td>				
					<td style="background-color: #99CCFF;color:black; font-weight:bold;">종료일</td>
					<td>${fn:substring(dataVO.endDate,0,10)}</td>
				</tr>
			</table>
			</div>

			<table id="regiTable2" class="table table-bordered text-center">
				<tr>
      			<td style="background-color: #99CCFF;color:black; font-weight:bold; width:50%;">수업시간</td>
      			<td style="background-color: #99CCFF;color:black; font-weight:bold; width:50%;">강의실</td>
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
  			<table  class="table table-bordered">
  				<tr>
      				<td style="text-align:center;background-color: #99CCFF;color:black; font-weight:bold; width:10%;">교재</td>
      				<td style="width:90%;">${classPlanVO.textbook}</td>
      			</tr>
      			<tr>
      				<td style="text-align:center;background-color: #99CCFF;color:black; font-weight:bold;ver99CCFFl-align: middle">수업개요</td>
      				<td style="text-align:left;">${fn:replace(classPlanVO.cphead, '', '<br>')}</td>
    			</tr>
    		</table>
			</div>

			<div id="registed">
			<table id="addTable1" style="height:20px;" class="table table-bordered text-center">
      			<tr style="height:20px;">
	      			<th style="width:10%; background-color: #99CCFF;color:black; font-weight:bold;">주차</th>
	      			<th style="width:90%; background-color: #99CCFF;color:black; font-weight:bold;">수업계획</th>
      			</tr>
      			<c:forEach items="${weekPlan }" var="weekPlan">
	      			<tr>
		      			<td>${weekPlan.week}</td>
		      			<td id="cpno${weekPlan.cpno}" style="text-align:left;">
		      			${weekPlan.content}
		      			</td>
	      			</tr>
      			</c:forEach>
      	      	</table>
			</div>

			<div id="registedHW">
			<table id="addTable2" class="table table-bordered text-center">
      			<tr>
	      			<th style="width:10%; background-color: #99CCFF; color:black;font-weight:bold;">No</th>
	      			<th style="width:90%; background-color: #99CCFF; color:black;font-weight:bold;">과제계획</th>
	      		</tr>
	      		<c:forEach items="${homeworkPlan }" var="homeworkPlan">
		      		<tr>
		      			<td>${homeworkPlan.no}</td>
		      			<td style="text-align:left;">${homeworkPlan.content}</td>
		      		</tr>
	      		</c:forEach>
      			</table>
			</div>

		</div>
		<div class="modal-footer">
			<c:if test="${dataVO.cpcheck eq '1'}">
			<button id="tempSave" value="3" onclick="ClassPlanConfirm(this);" type="button" class="btn btn-primary">승인</button>
			<button id="modifyBtn" value="2" onclick="ClassPlanConfuse(this);" type="button" class="btn btn-danger">반려</button>
			<button type="button" class="btn btn-secondary"
				 id="modalClose1" onclick="window.close();">닫기</button>
			</c:if>
			<c:if test="${dataVO.cpcheck eq '3'}">
			<button type="button" class="btn btn-secondary"
				 id="modalClose1" onclick="window.close();">닫기</button>
			</c:if>
		</div>
	</div>
	<form role="form" name="classVO">
		<input type="hidden" value="" id="classCode" name="classCode">
		<input type="hidden" value="" id="cpcheck" name="cpcheck">
	</form>
	<form id="sendConfuse">
		<input type="hidden" value="" id="classCode" name="classCode">
		<input type="hidden" value="" id="cpcheck" name="cpcheck">
		<input type="hidden" value="" id="teacherId" name="id">
		<input type="hidden" value="" id="className" name="className">
	</form>
	
<head>
<script>
//승인 버튼 클릭 시 함수
function ClassPlanConfirm(btn){
	var cpcheck=$(btn).val();
	var classCode=${dataVO.classCode};

	Swal.fire({
		  title: '정말 승인하시겠습니까?',
		  text: "승인이후에 수업 개설이 완료됩니다.",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '확인',
		  cancelButtonText: '취소'
		}).then((result) => {
		  if (result.isConfirmed) {
			  Swal.fire({
				  icon: 'success',
				  title: '승인 하였습니다'
				}).then((result) => {
					if (result.isConfirmed){
						$('input[name="classCode"]').val(classCode);
						$('input[name="cpcheck"]').val(cpcheck);
		
						var dataForm = $('form[role="form"]');
						dataForm.attr('action','classPlanConfirm.go');
						dataForm.attr('method','post');
							
						dataForm.submit();
					}
				})
		  }else{
			  Swal.fire({
				  icon: 'error',
				  title: '취소되었습니다',
				  showConfirmButton: false,
				  timer: 1500
				})
		  }
		})
	
	
// 	if(confirm('정말 승인하시겠습니까? 승인하면 수업 개설이 완료됩니다.')){
		
// 		dataForm.submit();
// 	}else  
// 		return false;
}
</script>
<script>
function ClassPlanConfuse(btn){
	var cpcheck=$(btn).val();
	var classCode=${dataVO.classCode};
	var id='${dataVO.id}';
	var className='${dataVO.className}';

	
	Swal.fire({
		  title: '정말 반려하시겠습니까?',
		  text: "반려하면 강사에게 쪽지가 보내집니다.",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '확인',
		  cancelButtonText: '취소'
		}).then((result) => {
		  if (result.isConfirmed) {
			  Swal.fire({
				  icon: 'success',
				  title: '반려 하였습니다'
				}).then((result) => {
					if (result.isConfirmed){
						$('input[name="classCode"]').val(classCode);
						$('input[name="cpcheck"]').val(cpcheck);
						$('input[name="id"]').val(id);
						$('input[name="className"]').val(className);
						
						var dataForm = $('form[id="sendConfuse"]');
						dataForm.attr('action','classPlanConfuse.go');
						dataForm.attr('method','post');
						
						dataForm.submit();
					}
				})
		  }else{
			  Swal.fire({
				  icon: 'error',
				  title: '취소되었습니다',
				  showConfirmButton: false,
				  timer: 1500
				})
		  }
		})
	
	
}
</script>	
</head>
	
</body>


















