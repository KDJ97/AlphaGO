<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<head>
  <script src="<%=request.getContextPath() %>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
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

  achive_rate();

  function modify(){
	  var date = $('#date').text();
	  location.href='modifyForm.go?date=' + date;
  }

  function chk(box, code){
	  $.ajax({
			type: "POST", //요청 메소드 방식
			url:"<%=request.getContextPath() %>/studyplan/check.go",
			data : {
				"code" : code
			}
		});
	  achive_rate()
  }

  function achive_rate(){
	  var boxCnt = $('input[type="checkbox"]').length;
	  var checked = $('input[type="checkbox"]:checked').length;
	  if(checked == 0){
		  $('#achive-rate').text(0);
		  return;
	  }
	  var rate = checked / boxCnt * 100;
	  $('#achive-rate').text(Math.round(rate * 10) / 10);


  }
  </script>
</head>

<body>

<style type="text/css">
.nav-pills .nav-link.active, .nav-pills .show>.nav-link{
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
				<div class="card-body" style="padding:5px;">
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
				<div class="card-body" style="padding:5px;">
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
				<div class="card-header" style="padding:5px;">
					<div class="row">
						<div class="col-sm-4">
							<!-- <button type="button" class="btn btn-soft-secondary" onclick="">
								<i class="uil uil-angle-left-b"></i>
							</button> -->
						</div>

						<div class="col-sm-4" style="text-align: center;">
						  <h5 id="date" style="line-height: 2.3;margin:auto;">${date}</h5>
						</div>

						<div class="col-sm-4">
							<!-- <button type="button" class="btn btn-soft-secondary"
									onclick="" style="float:right;">
								<i class="uil uil-angle-right-b"></i>
							</button> -->
						</div>
					</div>
				</div>
				<!-- card-header 끝 -->

				<!-- card-body 시작 -->
				<div class="card-body" style="padding:5px;">
					<div>
						<h6 style="float:left;"></h6>
						<button type="button" onclick="modify()" class="btn btn-purple" style="float:right;margin:3px;">
						수정</button>
					</div>

					<table class="table table-hover" style="text-align: center;">
						<thead>
							<tr>
								<th style="width: 110px;">과목</th>
								<th>학습 계획</th>
								<th style="width: 110px;">학습결과</th>
							</tr>
						</thead>
						<tbody style="vertical-align: middle;">
						  <c:forEach items="${planList }" var="plan">
							<tr>
								<td>
								  <c:if test="${plan.subjectCode eq 1 }">
   									 <span class="badge bg-danger font-size-16" >국어</span>
								  </c:if>
								  <c:if test="${plan.subjectCode eq 2 }">
   									 <span class="badge bg-warning font-size-16" >수학</span>
								  </c:if>
								  <c:if test="${plan.subjectCode eq 3 }">
   									 <span class="badge bg-success font-size-16" >사회</span>
								  </c:if>
								  <c:if test="${plan.subjectCode eq 4 }">
   									 <span class="badge bg-primary font-size-16" >과학</span>
								  </c:if>
								  <c:if test="${plan.subjectCode eq 5 }">
   									 <span class="badge bg-purple font-size-16" >영어</span>
								  </c:if>
								</td>
								<td>
									${plan.studyPlan }
								</td>
								<td>
								  <input ${plan.studyResult eq 0 ? "" : "checked" }
									  onclick="chk(this, ${plan.planCode })" class="form-check-input" type="checkbox" style="width: 25px; height: 25px;">
								</td>
							</tr>
						  </c:forEach>
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
						 ${planer.studyTime }&nbsp;&nbsp;H
						</div>
					  </td>
					  <td style="vertical-align: middle;">
					    <span id="achive-rate">0</span>%
					  </td>
					</tr>
					<tr id="tb-p">
						<td colspan="2">자기평가</td>
					</tr>
					<tr>
						<td colspan="2">
						  ${planer.feedback }
						</td>
					</tr>
				</table>
			</div>
			<!-- 오른쪽 card 끝 -->
		</div>
		<!-- 오른쪽 div 끝 -->
	</div>

</body>










