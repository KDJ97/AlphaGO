<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<script src="<%=request.getContextPath()%>/resources/js/index2.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/index3.js"></script>
<style>
.table>:not(caption)>*>* {
    padding: 5px;
}
</style>
</head>
<body>
	<c:set var="teacher" value="${dataMap.teacher }" />
	<c:set var="careerList" value="${dataMap.careerList }" />
	<c:set var="cerList" value="${dataMap.cerList }" />
	<c:set var="reviewList" value="${dataMap.reviewList }" />
	<c:set var="classReviewList" value="${dataMap.classReviewList }" />
	<c:set var="memberList" value="${dataMap.memberList }" />
	<c:set var="classCode" value="${dataMap.classCode }"/>
	<div class="row">
		<div class="col-md-6">
			<div class="card" style="height: 800px;">
				<!-- 강사 상세 -->
				<div class="card-body" style="padding-bottom: inherit;">
					<div class="col-sm-12">
						<button type="button" style="float:right;"class="btn btn-secondary" data-bs-toggle="modal"data-bs-target="#staticBackdrop2">수업수익</button>
						<button type="button" style="float:right;"class="btn btn-info" data-bs-toggle="modal"data-bs-target="#classTimeTable">시간표</button>
					</div>
					<h6 style="font-style:bold; float:left;margin:0;margin-top: 4px;"><i class="fas fa-address-card"></i>담당 강사</h6>
					<table class="table" id="teacherDetail" style="text-align: center;">
						<tbody>
							<tr>
								<th style="background-color: #038edc; color: white;">이름</th>
								<td>${teacher.name }</td>
								<th style="background-color: #038edc; color: white;">과목</th>
								<td>${teacher.subject }</td>
							</tr>
							<tr>
								<th style="background-color: #038edc; color: white;">전공</th>
								<td>${teacher.major }</td>
								<th style="background-color: #038edc; color: white;">번호</th>
								<td>${teacher.phone }</td>
							</tr>
							<tr>
								<th colspan="4" style="background-color: #038edc; color: white;">경력사항</th>
							</tr>
							<tr>
								<td colspan="4">
								<c:if test="${not empty careerList }">
									<c:forEach var="car" items="${careerList }">
									<fmt:formatDate value="${car.startDate }"/>
									~
									<fmt:formatDate value="${car.endDate }"/>
									${car.cacontent }<br>
									</c:forEach>
									</c:if>
								<c:if test="${empty careerList}">없음</c:if></td>
							</tr>
							<tr>
								<th colspan="4" style="background-color: #038edc; color: white;">자격증</th>
							</tr>
							<tr>
								<td colspan="4"><c:if test="${not empty cerList }">
										<c:forEach var="cer" items="${cerList }">
									${cer.cerName }
								</c:forEach>
									</c:if> <c:if test="${empty cerList }">없음</c:if></td>
							</tr>
							<tr>
								<td colspan="4"style="background-color: #038edc; color: white;">
								강사 후기 평점
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<div id="reviewScoreRater"></div>
										<h6><fmt:formatNumber value="${teacher.reviewScore }" pattern=".0"/></h6>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="modal fade" id="staticBackdrop2"
					data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
					aria-labelledby="staticBackdropLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								
								<h5 class="modal-title"><i class="fas fa-won-sign"></i> 수업 수익</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-sm-6">
										<div class="card">
											<div class="card-header" style="background-color: #6666FF;padding: 4px;">
												<h5 style="color:white;margin: 0;margin-left:5px;">수입</h5>
											</div>
											<div class="card-body">
												<div class="col-sm-12">
													<h6><i class="uil-users-alt"></i> 수강생 수 : ${dataMap.classingCnt}명</h6>
													<h6><i class="fas fa-tag"></i> 수업료 : 
													<fmt:formatNumber value="${dataMap.classPrice }" type="number" pattern="#,###"/>
													</h6>
													<hr>
													<h6><i class="fas fa-plus-circle"></i> 수입 : 
													<fmt:formatNumber value="${dataMap.classTotalPrice }" type="number" pattern="#,###"/>
													</h6>
												</div>
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="card">
											<div class="card-header"
												style="background-color: #FF6666; padding: 4px;">
												<h5 style="color: white; margin: 0; margin-left: 5px;">지출</h5>
											</div>
											<div class="card-body">
												<div class="col-sm-12">
													<h6>
														<i class="fas fa-user-clock"></i> 강사 시급 :
														<fmt:formatNumber value="${dataMap.timepay }"
															type="number" pattern="#,###" />
													</h6>
													
													<h6>
													<i class="uil-users-alt"></i> 수강생 수 : ${dataMap.classingCnt }명
													</h6>
													
													<h6>
													<i class="fas fa-clock"></i> 수업 시수 : ${dataMap.totalTime }시간
													</h6>
													
													<h6>
													<i class="fas fa-book"></i> 교재 : 
														<fmt:formatNumber value="${dataMap.bookPrice }"
															type="number" pattern="#,###" />
													</h6>
													<hr>
													<h6>
													<i class="fas fa-minus"></i> 강사급여 :
													<fmt:formatNumber value="${dataMap.teacherPay }"
															type="number" pattern="#,###" />
													</h6>
													<h6>
													<i class="fas fa-minus"></i> 교재비 :
													<fmt:formatNumber value="${dataMap.bookTotalPrice }"
															type="number" pattern="#,###" />
													</h6>
													<hr>
													<h6>
													<i class="fas fa-minus-circle"></i> 지출 :
													<fmt:formatNumber value="${dataMap.bookTotalPrice + dataMap.teacherPay}"
															type="number" pattern="#,###" />
													</h6>
													<div>
													</div>
												</div>
											</div>
										</div>
									</div>
									
									<div class="col-sm-12">
										<div class="card-footer" >
											<div style="float:right;">
												<c:if test="${dataMap.totalPay>0 }">
												<h6 style="color:blue">
												<i class="fas fa-won-sign"></i>총 합계 : 
												<fmt:formatNumber value="${dataMap.totalPay}"
															type="number" pattern="#,###" />
												</h6>
												</c:if>
												<c:if test="${dataMap.totalPay<=0 }">
												<h6 style="color:red">
												<i class="fas fa-won-sign"></i> 총 합계 : 
												<fmt:formatNumber value="${dataMap.totalPay}"
															type="number" pattern="#,###" /> 원
												</h6>
												</c:if>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<div class="modal fade" id="classTimeTable"
					data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
					aria-labelledby="staticBackdropLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								
								<h5 class="modal-title"><i class="bx bx-table"></i> 수업 시간표</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-sm-12">
										<table class="table timeTable" id="secTimeTable"
											style="font-size: 0.8em; border-spacing: 1px; border-collapse: separate; text-align: center;">
											<tr style="background-color: #038edc; color: white;">
												<td style="width: 20%;"></td>
												<th>월</th>
												<th>화</th>
												<th>수</th>
												<th>목</th>
												<th>금</th>
												<th>토</th>
												<th>일</th>
											</tr>
											<c:forEach begin="0" end="12" step="1" var="cnt">
												<tr id="${cnt+1 }">
													<th
														style="background-color: #038edc; color: white; font-size: x-small;">${cnt+1}교시(${cnt+9}:00~${cnt+10}:00)</th>
													<td><span style="display: none;">1</span></td>
													<td><span style="display: none;">2</span></td>
													<td><span style="display: none;">3</span></td>
													<td><span style="display: none;">4</span></td>
													<td><span style="display: none;">5</span></td>
													<td><span style="display: none;">6</span></td>
													<td><span style="display: none;">0</span></td>
												</tr>
											</c:forEach>
										</table>
									</div>
								</div>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>

				<div class="card-body" style="padding-bottom: inherit;height: 480px;overflow:auto;">
				<h6 style="font-style:bold; float:left;margin:0;margin-top: 4px;"><i class="uil-users-alt"></i>수강 원생 목록</h6>
					<table class="table table-hover" id="teacherDetail" style="text-align: center;">
						<thead>
							<tr style="background-color: #038edc; color: white;">
								<th>이름</th>
								<th>과제 제출율</th>
								<th>수업성적평균</th>
								<th>수업성취도</th>
								<th>성취도등급</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty memberList }">
								<c:forEach var="member" items="${memberList }">
									<tr onclick="OpenWindow('<%=request.getContextPath()%>/sscore/detail.go?id=${member.id}','원생 성적관리',1000,900)">
										<td>${member.name }</td>
										<c:if test="${not empty member.assignAttachPercent }">
										<td><fmt:formatNumber value="${member.assignAttachPercent }" pattern="0.0"/>%</td>
										</c:if>
										<c:if test="${empty member.assignAttachPercent}">
										<td>-</td>
										</c:if>
										<c:if test="${not empty member.scoreAvg }">
										<td><fmt:formatNumber value="${member.scoreAvg }" pattern="0.0"/></td>
										</c:if>
										<c:if test="${empty member.scoreAvg }">
										<td>-</td>
										</c:if>
										<td><fmt:formatNumber value="${member.acheive }" pattern="0.0"/></td>
										<td>${member.totalAcheive }</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
				
			</div>
		</div>
		<!-- 수업후기 -->
		<div class="col-md-6">
			<div class="card">
				<div class="card-body"style="height: 800px;overflow:auto;">
				<c:if test="${not empty classReviewList }">
					<c:forEach var="review" items="${classReviewList }" varStatus="cnt">
						<div class="bg-light mb-2"
							style="border-radius: 5px; padding: 15px;">
							<p style="font-weight: bold;">${review.className } | ${review.name }</p>
							<div class="reviewScoreRater${cnt.index }">
								<div id="reviewScoreRater" class="star-rating disabled" data-rating="${review.starScore}" title="${review.starScore}/5" style="width: 80px; height: 16px; background-size: 16px;"><div class="star-value" style="background-size: 16px; width: ${review.starScore * 20}%;"></div></div>
							</div>
							<div style="font-weight: bold; margin-left: 10px;">${review.starScore }</div>
							<div style="margin-top: 10px;">${review.content }</div>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${empty classReviewList }">
				<div class="bg-light mb-2" style="border-radius: 5px; padding: 15px;">
					<p style="font-weight: bold;">후기가 없습니다.</p>
				</div>
				</c:if>
				</div>
			</div>
		</div>
	</div>

<head>
<script>
var classCode=${classCode};
// 	alert(classCode);

	$.ajax({
		url:'<%=request.getContextPath()%>/classlist/selectTimeDetailByClassCode.go',
		data:{"classCode":classCode},
		success:function(data){
			//시간 데이터를 시간표에 표시한다.
			setCantUseRoom(data);
		},
		error:function(error){
			alert("error : " + error.status);
		},
		dataType:'json'
	});
</script>
<script>	
	//강의실의 사용불가능한 시간을 체크한다.
	function setCantUseRoom(data){
		//수업 시작일 -> 2022-01-01
		var startDate = $('#startDate').val();
		//수업 종료일 -> 2022-01-01
		var endDate = $('#endDate').val();
		
		$('.timeTable td').css("background-color","");
		$('#secTimeTable td').css("background-color", "");
		
		//선택한 날짜를 date타입으로 형변환(비교를 위해서)
		var start = new Date(startDate);
		var end = new Date(endDate);
		
		for(var i=0;i<data.length;i++){
// 			var useStartDate = data[i].startDate;
// 			var useEndDate = data[i].endDate;
			
// 			var sdate = useStartDate.substring(0,10);
// 			var edate = useEndDate.substring(0,10);
			
// 			var st = new Date(sdate);
// 			var en = new Date(edate);
			
			//선택한 수업 시작일이 진행중인 수업 종료일보다 작으면
// 			if(st<end){
				var period = data[i].ctperiod; //교시
				var yoil = data[i].classday; //요일 코드
				//일요일은 요일코드가 0이고 테이블의 td순서는 7이기 때문에 변환 필요
				if(yoil==0){
					yoil = 7;
				}
// 				console.log(yoil);
//				console.log("일 : " + sunyoil);
				var tr = $('#'+period);
				var distd = tr.find('td:eq('+(yoil-1)+')');
// 				console.log(distd);
				
				//해당 td에 grey로 막아줌
				$(distd).css("background-color","grey");
// 			}
		}
	}//강의실의 사용불가능한 시간 체크 끝!!!!!!!!
	</script>
<script>
var score = ${teacher.reviewScore};
var scoreList = ${classReviewList};
// alert(scoreList.length);
var starRatings;
// console.log(score);
function onload(event) {//별점 onload 함수
	var starRating3 = raterJs( {
		max:5, 
		readOnly:true, 
		rating:parseFloat(score), 
		element:document.querySelector("#reviewScoreRater")
	}); 
	
// 	for(var i=0;i<scoreList.length;i++){
// 		alert(scoreList[i].starScore);
// 		starRatings = raterJs( {
// 			max:5, 
// 			readOnly:true, 
// 			rating:parseFloat(scoreList[i].starScore), 
// 			element:document.querySelector("#reviewScoreRater"+i)
// 		}); 
// 	}
}
window.addEventListener("load", onload, false); 
</script>
</head>
</body>



















