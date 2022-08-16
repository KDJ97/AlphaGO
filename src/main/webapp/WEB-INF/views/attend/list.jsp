<%@page import="java.util.Collections"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageMaker" value="${dataMap.pageMaker }" />
 <c:set var="cri" value="${dataMap.pageMaker.cri }" />
 <c:set var="attendList" value="${dataMap.attendList }" />

<head>
	<script src="<%=request.getContextPath() %>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
<!-- chart -->
<script type="text/javascript">


var jobForm = $('#jobForm');
if(<%=request.getParameter("month")%>){
	jobForm.append($('<input/>', {type: 'hidden', name: 'month', value:'<%=request.getParameter("month")%>' }));
}

var options = {
	  series: [${dayMap.day1}, ${dayMap.day2}, ${dayMap.day3}, ${dayMap.day4}, ${dayMap.day5}],
	  labels: ['출석', '결석', '지각', '외출', '조퇴'],
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

var chart = new ApexCharts(document.querySelector("#chart_donut"), options);
chart.render();

</script>
</head>
<body>
	<div class="card">
		<div class="card-body">
			<h5 style="font-weight: bold;">
				<i class="uil-unlock-alt" style="margin-right: 10px;"></i>출결조회
			</h5>
			<div class="col-md-4" style="width: 350px; height: 255px; float: left;">
				<div id="chart_donut"></div>
			</div>

			<div class="table-responsive mt-4 mb-2">
				<table class="table mb-0" style="text-align: center;">
					<thead class="table-light">
						<tr>
							<th class="bg-purple text-white" style="font-weight: bold;">일시</th>
							<th class="bg-purple text-white" style="font-weight: bold;">등원시간</th>
							<th class="bg-purple text-white" style="font-weight: bold;">하원시간</th>
							<th class="bg-purple text-white" style="font-weight: bold;">출결시간</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">
							  <c:set var="now" value="<%=new java.util.Date()%>" />
							  <fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>
							</th>
							<td>
							  <c:if test="${empty today.inTime }">-</c:if>
							  <c:if test="${!empty today.inTime }">
							     <fmt:formatDate value="${today.inTime }" pattern="HH:mm"/>
							  </c:if>
							</td>
							<td>
							  <c:if test="${empty today.outTime }">-</c:if>
							  <c:if test="${!empty today.outTime }">
							     <fmt:formatDate value="${today.outTime }" pattern="HH:mm"/>
							  </c:if>
							</td>

							<td>
							  <c:if test="${empty today.attendanceStatus }"><span class="text-muted">미출석</span></c:if>
							  <c:if test="${today.attendanceStatus eq 0 }"><span class="text-primary">등원</span></c:if>
							  <c:if test="${today.attendanceStatus eq 1 }"><span class="text-primary">출석</span></c:if>
							  <c:if test="${today.attendanceStatus eq 2 }"><span class="text-danger">결석</span></c:if>
							  <c:if test="${today.attendanceStatus eq 3 }"><span class="text-warning">지각</span></c:if>
							  <c:if test="${today.attendanceStatus eq 4 }"><span class="text-purple">외출</span></c:if>
							  <c:if test="${today.attendanceStatus eq 5 }"><span class="text-dark">조퇴</span></c:if>
							</td>
						</tr>
					</tbody>
					<!-- end tbody-->
				</table>
				<!-- end table-->
			</div>
			<div class="table-responsive mb-5">
				<table class="table mb-0" style="text-align: center;">

					<thead class="table-light">
						<tr>
							<th class="bg-purple text-white" style="font-weight: bold;">출석일</th>
							<th class="bg-purple text-white" style="font-weight: bold;">결석일</th>
							<th class="bg-purple text-white" style="font-weight: bold;">지각일</th>
							<th class="bg-purple text-white" style="font-weight: bold;">외출일</th>
							<th class="bg-purple text-white" style="font-weight: bold;">조퇴일</th>
							<th class="bg-purple text-white" style="font-weight: bold;">출석률</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">${dayMap.day1 }일</th>
							<td>${dayMap.day2 }일</td>
							<td>${dayMap.day3 }일</td>
							<td>${dayMap.day4 }일</td>
							<td>${dayMap.day5 }일</td>
							<td>
								<c:if test="${dayMap.day1 eq 0 and dayMap.day2 eq 0 and dayMap.day3 eq 0 and dayMap.day4 eq 0 and dayMap.day5 eq 0}">-</c:if>
								<c:if test="${dayMap.day1 ne 0 or dayMap.day2 ne 0 or dayMap.day3 ne 0 or dayMap.day4 ne 0 or dayMap.day5 ne 0}">
								  <fmt:formatNumber value="${(dayMap.day1 / (dayMap.day1+dayMap.day2+dayMap.day3+dayMap.day4+dayMap.day5))*100 }" pattern="00.0"/>
								</c:if>
								%
							</td>
						</tr>
					</tbody>
					<!-- end tbody-->
				</table>
				<!-- end table-->
			</div>
			<hr>
			<div class="dropdown" style="margin-bottom: 5px;">
				<button class="btn btn-soft-secondary dropdown-toggle" type="button"
					id="dropdownMenuButton1" data-bs-toggle="dropdown"
					style="width: 130px;" aria-expanded="false">
					<c:if test="${empty param.month}">전체</c:if>
					<c:if test="${param.month eq '1'}">1개월</c:if>
					<c:if test="${param.month eq '3'}">3개월</c:if>
					<i class="mdi mdi-chevron-down" style="margin-left: 10px;"></i>
				</button>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
					<li><a class="dropdown-item" href="<%=request.getContextPath()%>/attend/list.go">전체</a></li>
					<li><a class="dropdown-item" href="<%=request.getContextPath()%>/attend/list.go?month=1">1개월</a></li>
					<li><a class="dropdown-item" href="<%=request.getContextPath()%>/attend/list.go?month=3">3개월</a></li>
				</ul>
			</div>
			<div class="table-responsive mt-2">
				<table class="table mb-1" style="text-align: center;">
					<thead class="table-light">
						<tr>
							<th class="bg-purple text-white" style="font-weight: bold;">일자</th>
							<th class="bg-purple text-white" style="font-weight: bold;">등원시간</th>
							<th class="bg-purple text-white" style="font-weight: bold;">하원시간</th>
							<th class="bg-purple text-white" style="font-weight: bold;">출결상태</th>
						</tr>
					</thead>
					<tbody>

					  <c:forEach items="${attendList }" var="attend">
						<tr>
							<th scope="row">
							  <fmt:formatDate value="${attend.regDate}" pattern="yyyy-MM-dd"/>
							</th>
							<td>
							  <c:if test="${empty attend.inTime }">-</c:if>
							  <c:if test="${!empty attend.inTime }">
							     <fmt:formatDate value="${attend.inTime }" pattern="HH:mm"/>
							  </c:if>
							</td>
							<td>
							  <c:if test="${empty attend.outTime }">-</c:if>
							  <c:if test="${!empty attend.outTime }">
							     <fmt:formatDate value="${attend.outTime }" pattern="HH:mm"/>
							  </c:if>
							</td>
							<td>
							  <c:if test="${empty attend.attendanceStatus }"><span class="text-muted">미출석</span></c:if>
							  <c:if test="${attend.attendanceStatus eq 0 }"><h4><span class="badge bg-primary">등원</span></h4></c:if>
							  <c:if test="${attend.attendanceStatus eq 1 }"><h4><span class="badge bg-primary">출석</span></h4></c:if>
							  <c:if test="${attend.attendanceStatus eq 2 }"><h4><span class="badge bg-danger">결석</span></h4></c:if>
							  <c:if test="${attend.attendanceStatus eq 3 }"><h4><span class="badge bg-warning">지각</span></h4></c:if>
							  <c:if test="${attend.attendanceStatus eq 4 }"><h4><span class="badge bg-purple">외출</span></h4></c:if>
							  <c:if test="${attend.attendanceStatus eq 5 }"><h4><span class="badge bg-dark">조퇴</span></h4></c:if>
							</td>
						</tr>
					  </c:forEach>
					</tbody>
					<!-- end tbody-->
				</table>
				<!-- end table-->
			</div>
			<!-- pagination -->
			<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
		</div>

	</div>
</body>
