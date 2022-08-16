<%@page import="java.util.Collections"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <c:set var="pageMaker" value="${dataMap.pageMaker }" /> --%>
<%--  <c:set var="cri" value="${dataMap.pageMaker.cri }" /> --%>
 <c:set var="teattendList" value="${dataMap.teattendList }" />
  <c:set var="classteacherList" value="${data.classteacherList}" />
  
 
 

<head>
<script
	src="<%=request.getContextPath()%>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/sm_chart.js"></script>

<script>
		

	
    var options = {
                series: [${dayMap.day1}, ${dayMap.day2}, ${dayMap.day3}, ${dayMap.day4}, ${dayMap.day5}],
                labels:['출근', '결근', '지각', '외출', '조퇴'],
          	  colors: ['#038edc', '#f34e4e', '#f7cc53', '#564ab1', '#74788d'],
                chart: {
                type: 'donut',
              },
              responsive: [{
                breakpoint: 480,
                options: {
                  chart: {
                    width: 200
                  },
                  legend: {
                    position: 'bottom'
                  }
                }
              }]
              };

              var chart = new ApexCharts(document.querySelector("#chart_donut1"), options);
              chart.render();
		
		</script>
</head>

<body>


<div class="card">
			<div class="row">
			<h3 style="font-weight: bold; margin-top:20px;">
				<i class="uil-clock" style="padding:10px;">출결조회</i>
			</h3>
	
				<div class="col-md-12" style="padding:0px;">

					<div id="chart_donut1" class="col-md-4"
						style="width: 330px; height: 150px; float: left;"></div>
						
						
						<div class="col-md-8"  style="float: right;">
						<span class="badge bg-warning"
							style="font-size: 1.0em; float: left; ">강사 상세</span>
				<table class="table table-bordered text-center">
				
					<thead>
						<tr style="font-size: 0.95em; background-color: #038edc; color: white; padding:0px;">
							<th  style="font-weight: bold;  padding:0px;">이름</th>
							<th  style="font-weight: bold; padding:0px;">전화번호</th>
							<th style="font-weight: bold; padding:0px;">출근시간</th>
							<th style="font-weight: bold; padding:0px;">퇴근시간</th>
						</tr>
				</thead>
					
						<tr style="padding:0px; font-size:1.1em;">
							
							<td style="padding:0px;" >
							  ${abc.name }
							</td>
							<td style="padding:0px;">
							 ${abc.phone }
							</td>
							<td style="padding:0px;">
 							${abc.attendTime}
 							</td>
							<td style="padding:0px;" >
							 ${abc.outTimes}
							</td>
						</tr>
				
					<!-- end tbody-->
				</table>
				<!-- end table-->
			</div>
					<div class="col-md-8" style="float:right; padding:0px;">
				<span class="badge bg-warning"
							style="font-size: 1.0em; float: left; ">오늘의 수업</span>
			<table class="table table-bordered text-center">
			
					<thead>
						<tr style="font-size: 0.95em; background-color: #038edc; color: white; padding:0px;">
							<th  style="font-weight:bold; width:10%; padding:0px;">수업이름</th>
							<th style="font-weight:bold; width:5%; padding:0px;">수업시작시간</th>
							<th style="font-weight:bold; width:5%; padding:0px;">수업종료시간</th>
						</tr>
				</thead>
					<c:forEach items="${classteacherList }" var="clas">
						<tr style="padding:0px; font-size:1.1em; padding:0px;">
							
							<td style="padding:0px;">
							   ${clas.className }  
							</td>
							<td style="padding:0px;" >
							 ${clas.startTime }  
							</td>

							<td style="padding:0px;">
							 ${clas.endTime }  
							</td>
						</tr>
				</c:forEach>
						
				<c:if test="${empty classteacherList }">
						<td colspan='3'>해당강사의 오늘 수업이 없습니다.</td>

				</c:if>
					<!-- end tbody-->
				</table>
			
			
			</div>
		
						
						
					<div class="col-md-8" style="float: right;">
						<span class="badge bg-warning"
							style="font-size:1.0em; float: left; ">출결 상태</span>
						<table class="table table-bordered text-center ">
						
							<thead>
								<tr
									style="font-size: 0.95em; background-color: #038edc; color: white; padding:0px;">
									<th style="width: 5%; padding:0px;">출근일</th>
									<th style="width: 5%; padding:0px;">결근일</th>
									<th style="width: 5%; padding:0px;">지각일</th>
									<th style="width: 5%; padding:0px;">외출일</th>
									<th style="width: 5%; padding:0px;">조퇴일</th>
									<th style="width: 5%; padding:0px;">출근율</th>

								</tr>
							</thead>

							<tr class="table-white" style="font-size:1.1em; padding:0px;">
								
						<th scope="row" style="padding:0px;">${dayMap.day1 }일</th>
							<td style="padding:0px;">${dayMap.day2 }일</td>
							<td style="padding:0px;">${dayMap.day3 }일</td>
							<td style="padding:0px;">${dayMap.day4 }일</td>
							<td style="padding:0px;">${dayMap.day5 }일</td>
							<td style="padding:0px;">
								<c:if test="${dayMap.day1 eq 0 and dayMap.day2 eq 0 and dayMap.day3 eq 0 and dayMap.day4 eq 0 and dayMap.day5 eq 0}">-</c:if>
								<c:if test="${dayMap.day1 ne 0 or dayMap.day2 ne 0 or dayMap.day3 ne 0 or dayMap.day4 ne 0 or dayMap.day5 ne 0}">
								  <fmt:formatNumber value="${(dayMap.day1 / (dayMap.day1+dayMap.day2+dayMap.day3+dayMap.day4+dayMap.day5))*100 }" pattern="00.0"/>
								</c:if>
								%
							</td>

							</tr>


						</table>
  

					</div>

				</div>
				
			</div>
 			
		

				
			
<!-- <input class="form-control"  -->
<!-- 					style="float: right; margin-left: 5px; width: 20%;" type="month" -->
<!-- 					value="2022-08" id="example-month-input"> -->
<div  style="height: 550px; overflow: auto">
<span class="badge bg-warning"
							style="font-size: 1.0em; float: left; margin-left:10px;">최근 출결 상태</span>
				<table class="table table-bordered text-center  table-hover ">
				
					<thead>
					
						<tr
							style="font-size: 0.95em; background-color: #038edc; color: white;">

							<th style="width: 5%;">일자</th>
							<th style="width: 5%;">출근시간</th>
							<th style="width: 5%;">퇴근시간</th>
							<th style="width: 5%;">출결상태</th>
							


						</tr>
					</thead>


	
						<c:forEach items="${teattendList }" var="teaat">

							<tr style='font-size: 0.85em;'>
							
						
								 <td><fmt:formatDate pattern="yyyy/MM/dd" value="${teaat.regDate }"/></td>
								 <td><fmt:formatDate pattern="HH:MM" value="${teaat.inTime }" /></td>
								 <td><fmt:formatDate pattern="HH:MM" value="${teaat.outTime }" /></td>
								
								<c:if test="${teaat.attendanceStatus eq 1 }">
									<td>
										<h5><span class="badge bg-primary">출근 </span></h5>
									</td>
								</c:if>

								<c:if test="${teaat.attendanceStatus eq 2 }">
									<td>
										<h5><span class="badge bg-danger">결근</span></h5>
									</td>
								</c:if>
								<c:if test="${teaat.attendanceStatus eq 3 }">
									<td>
										<h5><span class="badge bg-warning">지각</span></h5>
									</td>
									
									
								</c:if>
								<c:if test="${teaat.attendanceStatus eq 4 }">
									<td>
										<h5><span class="badge bg-purple">외출</span></h5>
									</td>
								</c:if>
								<c:if test="${teaat.attendanceStatus eq 5 }">
									<td>
										<h5><span class="badge bg-dark">조퇴</span></h5>
									</td>
								</c:if>

							</tr>
						</c:forEach>

					
						
				

				</table>

			</div>
<!-- 			<div class="card-footer"> -->
<!-- 				<nav aria-label="pds list Navigation"> -->
<!-- 					<ul class="pagination justify-content-center m-0"> -->
<%-- 						<%@ include file="/WEB-INF/views/common/pagination.jsp"%> --%>
<!-- 					</ul> -->
<!-- 				</nav> -->
<!-- 			</div> -->


		</div>
		
		
	

</body>
