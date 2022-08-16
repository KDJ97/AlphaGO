<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script
	src="<%=request.getContextPath()%>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
<script type="text/javascript">

//------------------------원생 학습계획표 차트---------------------
  var options = {
       series: [{
       name: '평균점수',
     data: [
    	   '${Math.round(scoreDataMap.korAvg)}',
    	   '${Math.round(scoreDataMap.engAvg)}',
    	   '${Math.round(scoreDataMap.mathAvg)}',
    	   '${Math.round(scoreDataMap.socialAvg)}',
    	   '${Math.round(scoreDataMap.scienceAvg)}'
       ]
     }],
       annotations: {

     },
     chart: {
       width: '100%',
       height: 350,
       type: 'bar',
     },
     plotOptions: {
       bar: {
         borderRadius: 10,
         columnWidth: '50%',
       }
     },
     dataLabels: {
       enabled: false
     },
     stroke: {
       width: 2
     },

     grid: {
       row: {
         colors: ['#fff', '#f2f2f2']
       }
     },
     xaxis: {
       labels: {
         rotate: -45
       },
       categories: ['국어', '영어', '수학', '사회', '과학'],
       tickPlacement: 'on'
     },
     yaxis: {
       title: {
         text: '점수',
       },

       max:100
     },
     fill: {
       type: 'gradient',
       gradient: {
         shade: 'light',
         type: "horizontal",
         shadeIntensity: 0.25,
         gradientToColors: undefined,
         inverseColors: true,
         opacityFrom: 0.85,
         opacityTo: 0.85,
         stops: [50, 0, 100]
       },
     }
     };

     var chart = new ApexCharts(document.querySelector("#studychart"), options);
     chart.render();
    //------------------------원생 학습계획표 차트---------------------

  </script>

<script type="text/javascript">
  function delPlan(btn, planCode){
	if(!planCode){
		// DB에 추가 되지 않은 요소
		$(btn).parents('tr').remove();
		return;
	}
	//DB에서 삭제
	$.ajax({
		type: "POST", //요청 메소드 방식
		url:"<%=request.getContextPath()%>/studyplan/delete.go",
		data : {
			"planCode" : planCode
		},
		success : function(result){
			$(btn).parents('tr').remove();
		}
	});

  }

  function addPlan(){
	if($('tr[class=planTr]').length >=5){
		alert("5개이상 추가할 수 없습니다")
		return;
	}


	var addTr = $("#addTr");
	var tr  = '<tr class="planTr">';
		tr +=   '<td>';
		tr +=     '<select class="form-select" style="text-align: center; width:100px;display: inline;">';
		tr +=		'<option value="0">선택</option>';
		tr +=		'<option value="1">국어</option>';
		tr +=		'<option value="2">수학</option>';
		tr +=		'<option value="3">사회</option>';
		tr +=		'<option value="4">과학</option>';
		tr +=		'<option value="5">영어</option>';
		tr +=	  '</select>';
		tr +=   '</td>';
		tr +=   '<td>';
		tr +=	  '<input class="form-control"/>';
		tr +=   '</td>';
		tr +=   '<td>';
		tr +=	  '<input class="form-check-input" type="checkbox" style="width: 25px; height: 25px;">';
		tr +=   '</td>';
		tr +=   '<td>';
		tr +=	  '<button class="btn btn-soft-danger" onclick="delPlan(this)"><i class="uil uil-trash-alt font-size-16"></i></button>';
		tr +=   '</td>';
		tr += '</tr>';

		$(addTr).before(tr);
  }


  function save(){



	//location.href='modify.go';

	//create element (form)
	var newForm = $('<form></form>');
	//set attribute (form)
	newForm.attr("name","newForm");
	newForm.attr("method","post");
	newForm.attr("action","modify.go");

	newForm.append($('<input/>', {type: 'hidden', name: 'date', value: $("#date").text() }));


	// create element & set attribute (input)

	//총 studyPlay 갯수
	var planCnt = $('.planTr').length;
	for(var i = 0; i < planCnt; i++){
		//n번째 tr
		var tr = $('.planTr:eq('+ i +')');

		var planCode = $(tr).attr("data-planCode");
		var subject = $(tr).find('select').val();
		var plan = $(tr).find('input:eq(0)').val();
		var chk = $(tr).find('input:eq(1)').is(':checked');

		if(planCode){
			newForm.append($('<input/>', {type: 'hidden', name: i + 'code', value: planCode }));
			newForm.append($('<input/>', {type: 'hidden', name: i + 'status', value: 'update' }));
		}else{
			newForm.append($('<input/>', {type: 'hidden', name: i + 'status', value: 'insert' }));
		}
		newForm.append($('<input/>', {type: 'hidden', name: i + 's', value: subject }));
		newForm.append($('<input/>', {type: 'hidden', name: i + 'p', value: plan }));
		newForm.append($('<input/>', {type: 'hidden', name: i + 'chk', value: chk }));

		console.log(subject);
		console.log(plan);
		console.log(chk);


	}

	newForm.append($('<input/>', {type: 'hidden', name: 'study_time', value: $('#study_time').val() }));
	newForm.append($('<input/>', {type: 'hidden', name: 'feedback', value: $('#feedback').val().trim() }));


	// append form (to body)
	newForm.appendTo('body');

	// submit form
	//newForm.submit();



	   Swal.fire({
		      icon: 'success',
		      title:'수정 되었습니다',

		    }).then((result) => {


    		newForm.submit()


		})

  }
  </script>

</head>

<body>
<style type="text/css">
.nav-pills .nav-link.active, .nav-pills .show>.nav-link {
	background: #564ab1;
}

thead, #tb-p{
    color: white;
    font-weight: bold;
    border-color: transparent;
    background-color: #564ab1;
}

.eclipse{
	width: 200px;
    text-overflow: ellipsis;
    -o-text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
    word-wrap: normal !important;
    display: block;
}
</style>


	<div class="row">
		<!-- 왼쪽 div 시작 -->
		<div class="col-lg-5">
			<!-- 왼쪽 card 시작 -->
			<div class="card">
				<!-- card-header 시작 -->
				<div class="card-header" style="padding: 5px;">
					<h5 style="margin: auto; font-weight: bold;">
						<i class="bx bxs-pin" style="margin-right: 10px;"></i>학습계획표
					</h5>
				</div>
				<!-- card-header 끝 -->
				<!-- card-body 시작 -->
				<div class="card-body" style="padding: 5px;">
					<h6>
						<i class="uil-clock-three"></i> 일정
					</h6>
					<!-- 일정 테이블 시작 -->
					<table class="table table-hover" style="text-align: center;">
						<thead>
							<tr>
								<th>디데이</th>
								<th>날짜</th>
								<th>일정명</th>
							</tr>
						</thead>
						<tbody>
						  <c:forEach items="${scheduleList }" begin="0" end="4" var="schedule">
							<tr>
							   <td>
							     <c:if test="${schedule.Ddays eq 0 }"><span class="badge bg-danger">D-day</span></c:if>
							     <c:if test="${schedule.Ddays ne 0 and schedule.Ddays <= 3 }">
							       <span class="badge bg-warning">D-${schedule.Ddays }</span>
							     </c:if>
							     <c:if test="${schedule.Ddays > 3 }">
							       <span class="badge bg-success">D-${schedule.Ddays }</span>
							     </c:if>
							   </td>
								<td>
								  ${schedule.date }
								</td>
								<td class="eclipse">${schedule.name }</td>
							</tr>
						  </c:forEach>

						</tbody>
					</table>
					<!-- 일정 테이블 끝 -->
				</div>
				<!-- card-body 끝 -->

				<!-- 두번쨰 card-body 시작 -->
				<div class="card-body" style="padding: 5px;">
					<h6>
						<i class="bx bxs-graduation"></i> 학교 성적
					</h6>
					<div id="studychart"></div>
				</div>
				<!-- 두번쨰 card-body 끝 -->
			</div>
			<!-- 왼쪽 card 끝 -->
		</div>
		<!-- 왼쪽 div 끝 -->

		<!-- 오른쪽 div 시작 -->
		<div class="col-lg-7">
			<!-- 오른쪽 card 시작 -->
			<div class="card">
				<!-- card-header 시작 -->
				<div class="card-header" style="padding: 5px;">
					<div class="row">
						<div class="col-sm-4">
<!-- 							<button type="button" class="btn btn-soft-secondary" onclick=""> -->
<!-- 								<i class="uil uil-angle-left-b"></i> -->
<!-- 							</button> -->
						</div>

						<div class="col-sm-4" style="text-align: center;">
							<h5 id="date" style="line-height: 2.3; margin: auto;">${date }</h5>
						</div>

						<div class="col-sm-4">
<!-- 							<button type="button" class="btn btn-soft-secondary" onclick="" -->
<!-- 								style="float: right;"> -->
<!-- 								<i class="uil uil-angle-right-b"></i> -->
<!-- 							</button> -->
						</div>
					</div>
				</div>
				<!-- card-header 끝 -->

				<!-- card-body 시작 -->
				<div class="card-body" style="padding: 5px;">
					<div>
						<h6 style="float:left;">* 최대 5개</h6>
						<button type="button" onclick="save()" class="btn btn-purple" style="float:right;margin:3px;">
						저장</button>
					</div>

					<table class="table table-hover" style="text-align: center;">
						<thead>
							<tr>
								<th style="width: 110px;">과목</th>
								<th>학습 계획</th>
								<th style="width: 100px;">학습결과</th>
								<th style="width: 50px;"></th>
							</tr>
						</thead>
						<tbody style="vertical-align: middle;">
							 <c:forEach items="${planList }" var="plan">
							  <tr class="planTr" data-planCode="${plan.planCode }">
								<td>
								  <select class="form-select" style="text-align: center; width:100px;display: inline;">
									<option value="0" ${plan.subjectCode == 0 ? "selected" : "" }>선택</option>
									<option value="1" ${plan.subjectCode == 1 ? "selected" : "" }>국어</option>
									<option value="2" ${plan.subjectCode == 2 ? "selected" : "" }>수학</option>
									<option value="3" ${plan.subjectCode == 3 ? "selected" : "" }>사회</option>
									<option value="4" ${plan.subjectCode == 4 ? "selected" : "" }>과학</option>
									<option value="5" ${plan.subjectCode == 5 ? "selected" : "" }>영어</option>
								  </select>
								</td>
								<td>
								  <input class="form-control" value="${plan.studyPlan }"/>
								</td>
								<td>
								  <input ${plan.studyResult == 0 ? "" : "checked" }
								  	class="form-check-input" type="checkbox" style="width: 25px; height: 25px;">
								</td>
								<td>
								  <button class="btn btn-danger" onclick="delPlan(this, ${plan.planCode})"><i class="uil uil-trash-alt font-size-16"></i></button>
								</td>
							  </tr>
						  </c:forEach>


							<tr id="addTr">
							<td colspan="4" style="padding:2px;">
							  <button type="button" class="btn btn-purple" style="width:100%;" onclick="addPlan()">
								<i class="uil-plus"></i>
							  </button>
							</td>
						  </tr>
						</tbody>
					</table>
				</div>
				<!-- card-body 끝 -->
			</div>

			<div class="card">
				<table class="table" style="text-align: center;">
					<thead>
						<tr>
							<td>공부시간</td>
							<td>달성률</td>
						</tr>
					</thead>
					<tr>
						<td>
							<div class="col-md-10">
								<input id="study_time" class="form-control" type="number"
									value="${planer.studyTime }"
									style="display: inline; width: 100px; text-align: center;" />&nbsp;&nbsp;&nbsp;H
							</div>
						</td>
						<td style="vertical-align: middle;"><span>-</span>&nbsp;&nbsp;&nbsp;%
						</td>
					</tr>
					<tr id="tb-p">
						<td colspan="2">자기평가</td>
					</tr>
					<tr>
						<td colspan="2">
						  <textarea id="feedback" class="form-control" placeholder="내용을 입력하세요." style="resize: none; height: 100px;">${planer.feedback }</textarea>
						</td>
					</tr>
				</table>
			</div>
			<!-- 오른쪽 card 끝 -->
		</div>
		<!-- 오른쪽 div 끝 -->
	</div>

</body>










