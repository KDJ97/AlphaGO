<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<style>
.mb-5 {
	margin-bottom: 1rem !important;
}

#timeTable td:hover {
	background-color: #6666FF;
}

.flipped {
	background-color: #6666FF;
}

#secTimeTable td, th {
	padding: 0.5rem 0.75rem;
}
</style>
<script
	src="<%=request.getContextPath()%>/resources/assets/js/pages/form-wizard.init.js"></script>
<script src="<%=request.getContextPath()%>/resources/assets/js/app.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/js/dj_classRegist.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>

</head>
<body>
	<c:set var="classList" value="${dataMap.classList }"></c:set>
	<c:set var="roomList" value="${dataMap.roomList }"></c:set>
	<c:set var="pageMaker" value="${dataMap.pageMaker }"></c:set>
	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-header">수업 개설</div>
				<!-- end card header -->
				<div class="card-body">
					<!-- form 시작 -->
					<form action="#">
						<div class="row">
							<div class="col-md-2"
								style="margin: auto; text-align: center; padding-bottom: 15px;">
								<button type="button" class="btn btn-primary w-sm" id="prevBtn"
									onclick="nextPrev(-1)" style="display: none;">Previous</button>
							</div>
							<div class="col-md-8">
								<ul class="wizard-nav md-12"
									style="margin-bottom: 1rem !important;">
									<li class="wizard-list-item">
										<div class="list-item active">
											<div class="step-icon" data-bs-toggle="tooltip"
												data-bs-placement="top" title=""
												data-bs-original-title="Seller Details">
												<i class="uil uil-list-ul"></i>
											</div>
										</div>
									</li>
									<li class="wizard-list-item">
										<div class="list-item">
											<div class="step-icon" data-bs-toggle="tooltip"
												data-bs-placement="top" title=""
												data-bs-original-title="Company Document">
												<i class="uil uil-clipboard-notes"></i>
											</div>
										</div>
									</li>

									<li class="wizard-list-item">
										<div class="list-item">
											<div class="step-icon" data-bs-toggle="tooltip"
												data-bs-placement="top" title=""
												data-bs-original-title="Bank Details">
												<i class="uil uil-university"></i>
											</div>
										</div>
									</li>
								</ul>
							</div>

							<div class="col-md-2"
								style="margin: auto; text-align: center; padding-bottom: 15px;">
								<button type="button" class="btn btn-primary w-sm ms-auto"
									id="nextBtn" onclick="setText();classSubmit();nextPrev(1);">Next</button>
							</div>
						</div>
						<!-- wizard-nav -->

						<div class="wizard-tab" style="display: block;">
							<!-- row 시작 -->
							<div class="row">
								<!-- 수업 상세 시작 -->
								<div class="col-md-12" style="margin-top: 10px;">
									<div class="card">
										<div class="row">
											<div class="col-sm-12" style="padding-top: 5px;">
												<span class="badge bg-warning"
													style="font-size: 1.0em;margin-left: 10px;margin-bottom: 5px;"> 수업 상세</span>
											</div>
										</div>
										
										<!-- 수업상세 테이블 시작 -->
										<div class="col-sm-12" style="padding-left: 10px;padding-right: 10px;">
										<table class="table"
											style="vertical-align: middle;text-align: center; padding-left: 20px; padding-right: 20px;">
											<tr>
												<td scope="col"
													style="background-color: #038edc; color: white;">수업명</td>
												<td colspan="5"><input type="text" id="dcname"class="form-control"
													name="className" style="width: 99%; text-align: center;"
													placeholder="수업명을 입력하세요."></td>
											</tr>
											<tr class="">
												<td style="background-color: #038edc; color: white;"
													scope="col">과목명</td>
												<td><select onchange="getSubDetail(this);"
													class="form-select" id="dcsub" style="text-align: center;">
														<option value="">과목</option>
														<option class="subj" value="1">국어</option>
														<option class="subj" value="2">수학</option>
														<option class="subj" value="5">영어</option>
														<option class="subj" value="3">사회</option>
														<option class="subj" value="4">과학</option>
												</select> 
												<input type="hidden" name="subjectCode" id="sjcode" value=""></td>
												<td style="background-color: #038edc; color: white;"
													scope="col">과목영역</td>
												<td><select class="form-select"	onchange="getSubDeVal(this);" id="subdetail"
													style="text-align: center;">
													<option value="">과목 영역</option>
													</select> 
												<input type="hidden" name="subdetailCode"id="subdetail_code" value=""></td>
												<td scope="col"
													style="background-color: #038edc; color: white;">학년</td>
												<td><select onchange="getGrade(this);"
													class="form-select" id="dcperson"
													style="text-align: center;">
														<option value="" id="deGrade">학년</option>
														<option value="1">1학년</option>
														<option value="2">2학년</option>
														<option value="3">3학년</option>
												</select> <input type="hidden" name="classGrade" id="cGrade" value="">
												</td>
											</tr>
											<tr class="">
												<td scope="col"
													style="background-color: #038edc; color: white;">정원</td>
												<td><input type="text" name="stuCnt" id="stu_cnt"class="form-control"
													placeholder="정원을 입력하세요"	style="width: 85%; text-align: center;float:left;">
													<p style="margin: 0;padding-top: inherit;"> 명</p></td>
												<td scope="col"
													style="background-color: #038edc; color: white;">금액</td>
												<td>
													<div>
													<input type="text" name="classPrice" id="dcprice"
															class="form-control"style="width: 85%; text-align: center;float:left;"
															placeholder="산정 금액을 입력하세요.">
													<p style="padding-top: 12px;margin: 0;"> 원</p>
													</div>
												</td>
												<td style="background-color: #038edc; color: white;"
													scope="col">수업수준</td>
												<td>
												<select onchange="getClassRank(this);"
													class="form-select" id="class_rank"
													style="text-align: center;">
														<option value="">수준</option>
														<option value="A">A</option>
														<option value="B">B</option>
														<option value="C">C</option>
												</select>
<!-- 													<input type="text" id="class_rank" name="classRank" -->
<!-- 														value="" placeholder="A/B/C"class="form-control" -->
<!-- 														style="text-align: center;"> -->
												</td>
											</tr>
										</table>
										</div>
									</div>
									<!-- 수업상세 테이블 끝 -->
									<!-- 수업 상세 끝 -->
								</div>
								<!-- card 끝 -->
							</div>
							<!-- row 끝 -->
<!-- 							<hr> -->
							<div class="row">
								<div class="col-md-12">
									<div class="card">
										<div class="row">
											<div class="col-sm-5" style="float: left;">
												<div class="card-header">
													<span class="badge bg-warning"
														style="font-size: 1.0em;">강사 선택</span>
												</div>
												<!-- header끝 -->
												<div class="col-sm-12"
													style="margin-top: 5px; text-align: center; padding-left: 10px; padding-right: 10px;">
													<div class="col-sm-12"style="height:210px;overflow: auto;">
														<table class="table table-hover">
															<thead style="background-color: #038edc; color: white;">
																<tr>
																	<th>과목</th>
																	<th>강사명</th>
																</tr>
															</thead>
															<tbody id="teacherList">
																<tr>
																	<td>-</td>
																	<td>-</td>
																</tr>
																<tr>
																	<td>-</td>
																	<td>-</td>
																</tr>
																<tr>
																	<td>-</td>
																	<td>-</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>


											<div class="col-sm-1"
												style="float: left; display: flex; justify-content: center; align-items: center;">
												<i style="font-size: 50px;" class="uil-angle-double-right"></i>
											</div>


											<div class="col-sm-6" style="float: right;">
												<div class="card-header">
													<span class="badge bg-warning"
														style="font-size: 1.0em;">강사 상세</span>
												</div>
												<div class="card-body">
													<table class="table" id="teacherDetail"
														style="text-align: center;">
														<tr>
															<th style="background-color: #038edc; color: white;">이름</th>
															<td>-</td>
															<th style="background-color: #038edc; color: white;">과목</th>
															<td>-</td>
														</tr>
														<tr>
															<th style="background-color: #038edc; color: white;">전공</th>
															<td>-</td>
															<th style="background-color: #038edc; color: white;">번호</th>
															<td>-</td>
														</tr>
														<tr>
															<th colspan="4"
																style="background-color: #038edc; color: white;">자격증</th>
														</tr>
														<tr>
															<td colspan="4">-</td>
														</tr>
													</table>
												</div>
											</div>
										</div>
									</div>
									<!-- card 끝 -->
								</div>
							</div>

						</div>
						<!-- wizard-tab -->

						<div class="wizard-tab" style="display: none;">
							<div class="card">
								<div class="row">
									<div class="col-md-12">
										<div class="col-md-3" style="float: left;">
											<div class="card-header"
												style="background-color: #038edc; color: white;">
												<i class="uil-list-ul"></i> <span>수업기간/강의실 선택</span>
											</div>
											<!-- table div 시작 -->
											<div>
												<table class="table"
													style="font-size: 0.9em; text-align: center;">
													<tr>
														<td
															style="background-color: #038edc; color: white; width: 50%;">시작일</td>
														<td style="width: 50%;"><input id="startDate"
															name="startDate" type="date" class="form-control">
														</td>
													</tr>
													<tr>
														<td style="background-color: #038edc; color: white;">종료일</td>
														<td><input id="endDate" name="endDate" type="date"
															class="form-control"></td>
													</tr>
													<tr>
														<td style="background-color: #038edc; color: white;">강의실</td>
														<td>
														<select	onchange="javacript:calcTimeByRoom(this);"
															id="selectRoom" class="form-select"	style="text-align: center;">
																<option value="">호수</option>
																<c:forEach var="room" items="${roomList }">
																	<option value="${room.roomCode }">${room.roomNo}</option>
																</c:forEach>
														</select>
														</td>
													</tr>
												</table>
											</div>
											<!-- table div 끝 -->
											<!-- 설명 div 시작 -->
											<div class="accordion" id="accordionExample">
												<div class="accordion-item">
													<h2 class="accordion-header" id="headingOne">
														<button class="accordion-button fw-medium" style="background-color:#f7cc53; color:white;" type="button"
															data-bs-toggle="collapse" data-bs-target="#collapseOne"
															aria-expanded="true" aria-controls="collapseOne">
															사용방법</button>
													</h2>
													<div id="collapseOne"
														class="accordion-collapse collapse show"
														aria-labelledby="headingOne"
														data-bs-parent="#accordionExample" style="">
														<div class="accordion-body">
															<ul>
																<li>시작일과 종료일을 선택한다.</li>
																<li>수업을 진행할 강의실을 선택한다.</li>
																<li>수업을 진행할 시간을 시간표에서 선택한다.</li>
																<li>선택한 시간과 기간을 기반으로 시수를 자동 계산해줍니다.</li>
															</ul>
														</div>
													</div>
												</div>
											</div>
											<!-- 설명 div 끝 -->
										</div>

										<div class="col-md-9" style="float: right; padding-left: 5px;">
											<table id="timeTable" class="timeTable"
												style="width: 100%; height: 600px; font-size: 0.8em; hover:; border-spacing: 1px; border-collapse: separate; text-align: center;">
												<tr>
													<th colspan="1"
														style="width: 30%; background-color: #038edc; color: white;">현재시수</th>
													<th id="setTotal" colspan="7">-</th>
													<td style="display: none;"><input type="hidden"
														name="totalTime" id="totalTime"></td>
												</tr>
												<tr style="background-color: #038edc; color: white;">
													<th></th>
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
														<th style="background-color: #038edc; color: white;">${cnt+1}교시(${cnt+9}:00~${cnt+10}:00)</th>
														<td onclick="calcTime(this);setColor(this);"><span
															style="display: none;">1</span></td>
														<td onclick="calcTime(this);setColor(this);"><span
															style="display: none;">2</span></td>
														<td onclick="calcTime(this);setColor(this);"><span
															style="display: none;">3</span></td>
														<td onclick="calcTime(this);setColor(this);"><span
															style="display: none;">4</span></td>
														<td onclick="calcTime(this);setColor(this);"><span
															style="display: none;">5</span></td>
														<td onclick="calcTime(this);setColor(this);"><span
															style="display: none;">6</span></td>
														<td onclick="calcTime(this);setColor(this);"><span
															style="display: none;">0</span></td>
													</tr>
												</c:forEach>
											</table>
										</div>
									</div>
								</div>
							</div>

						</div>
						<!-- wizard-tab -->

						<div class="wizard-tab" style="display: none;">
							<div class="row">
								<div class="col-md-12">
									<!-- card 시작 -->
									<p style="font-size: small;">* 개설할 수업을 확인하신 후 저장하세요. *</p>
									<div class="card" style="margin-bottom: 0;">
										<table class="table"
											style="text-align: center; margin-bottom: 0;">
											<tr>
												<th style="background-color: #038edc; color: white;">수업명</th>
												<td id="class_name" colspan="5">-</td>
												<th style="background-color: #038edc; color: white;">강의금액</th>
												<td id="class_price">-</td>
											</tr>
											<tr>
												<th style="background-color: #038edc; color: white;">과목</th>
												<td id="subject_name">-</td>
												<th style="background-color: #038edc; color: white;">과목영역</th>
												<td id="subdetail_name">-</td>
												<th style="background-color: #038edc; color: white;">시작일</th>
												<td id="start_date">-</td>
												<th style="background-color: #038edc; color: white;">종료일</th>
												<td id="end_date">-</td>
											</tr>
											<tr>
												<th style="background-color: #038edc; color: white;">수준</th>
												<td id="class_grade" colspan="3">-</td>
												<th style="background-color: #038edc; color: white;">정원</th>
												<td id="class_capacity">-</td>
												<th style="background-color: #038edc; color: white;">시수</th>
												<td id="total_time">-</td>
											</tr>
											<tr>
												<th style="background-color: #038edc; color: white;">강의실</th>
												<td id="classroom_no" colspan="3">-</td>
												<th style="background-color: #038edc; color: white;">강사명</th>
												<td id="teacher_name">-</td>
												<th style="background-color: #038edc; color: white;">학년</th>
												<td id="member_grade">-</td>
											</tr>
										</table>
									</div>
									<!-- card 끝 -->

									<!-- card 시작 -->
									<div class="card">
										<table class="table timeTable" id="secTimeTable"
											style="font-size: 0.8em; border-spacing: 1px; border-collapse: separate; text-align: center;">
											<tr style="background-color: #038edc; color: white;">
												<td style="width: 30%;"></td>
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
													<th style="background-color: #038edc; color: white;">${cnt+1}교시(${cnt+9}:00~${cnt+10}:00)</th>
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
									<!-- card 끝 -->
								</div>
							</div>
						</div>
						<!-- wizard-tab -->
					</form>
					<!-- form 끝 -->
				</div>
			</div>
		</div>
		<!-- end col -->
	</div>
<head>
<script>
	//데이터 넣어줄 태그들
	var dcname = $('#dcname');
	var dcperson = $('#dcperson');//select
	var dcprice = $('#dcprice');
	var dcsub = $('#dcsub');//과목select
	var subdetail = $('#subdetail');//과목영역select
	var stu_cnt = $('#stu_cnt');//정원
	var class_rank = $('#class_rank'); //수업수준

	//학년 SELECT BOX
	var dcpersonChild = dcperson.children('option');
	//과목 SELECT BOX
	var dcsubChild = dcsub.children('option');
	//상세과목 select box
	var dcsubDeChild = subdetail.children('option');

	//과목 선택시 클릭 이벤트(과목영역, 과목에 해당하는 선생님)
	function getSubDetail(op) {
		//과목명 value
		var opVal = $('#dcsub').val();
// 		$('#dcsub').val(opVal);//과목명
// 		console.log($('#dcsub').val());
		console.log(opVal);
		
		if(opVal==""){
			return;
		}

		var str = "";
		console.log(opVal);
		
		//과목 영역을 가져와 뿌려주는 메서드
		$.ajax({
			url : "<%=request.getContextPath()%>/classregist/subDetail.go",
			method : "post",
			data : {
				"opVal" : opVal
			},
			success : function(data) {
				console.log(data);
				if (data) {
					str += "<option value=''>과목 영역</option>";
					for (var i = 0; i < data.length; i++) {
						str += "<option class='subDetailLi' value="+data[i].subdetailCode+">"
								+ data[i].subdetailName + "</option>";
					}
					subdetail.empty();
					subdetail.append(str);
				}
			},
			error : function(error) {
				alert("load error : " + error.status);
			},
			dataType : "json"
		});
		
		//과목 선택 시 해당 과목 강사를 가져오는 메서드
		$.ajax({
			url : "<%=request.getContextPath()%>/classregist/getTeacherList.go",
			data : {
				"subjectName" : opVal
			},
			method : "get",
			success : function(data) {
// 				alert(data);
				printData(data, $('#teacherList'),$('#teacher-list-template'));
			},
			error : function(error) {
// 				alert("error status : " + error.status);
			},
			dataType : "json"
		});
		
	}
</script>


<script>
	//수업리스트 선택 후 강사 선택 후 강사 상세 가져오기
	function teacherDetail(teacher) {
		var id = $(teacher).children('td:eq(0)').text();//선택된 아이디
		console.log(id);
		tId = id;//선택된 아이디 넣어주기
		if(id==""){
			return;
		}
		$.ajax({
			url : "<%=request.getContextPath()%>/classregist/getTeacherDetail.go",
			data : {
				id : id
			},
			method : "get",
			dataType : "json",
			success : function(dataMap) {
				printData(dataMap, $('#teacherDetail'),
						$('#teacher-detail-template'));
				$('#teacher_name').text(dataMap.teacher.name);
			},
			error : function(error) {
				alert("error status : " + error.status);
			}
		})
	}
</script>

<!-- 강사 리스트 템플릿 -->
<script type="text/x-handlebars-template" id="teacher-list-template">
{{#each .}}
	<tr onclick="teacherDetail(this)">
		<td style="display: none;">{{id}}</td>
		<td>{{subject}}</td>
		<td>{{name}}</td>
	</tr>
{{/each}}
</script>

<!-- 강사 상세 템플릿 -->
<script type="text/x-handlebars-template" id="teacher-detail-template">
<table class="table" id="teacherDetail" style="text-align: center;">
	<input type="hidden" name="id" value="{{teacher.id}}">
	<tr>
		<th style="background-color:#038edc;color:white;">이름</th>
		<td>{{teacher.name}}</td>
		<th style="background-color:#038edc;color:white;">과목</th>
		<td>{{teacher.subject}}</td>
	</tr>
	<tr>
	<th style="background-color:#038edc;color:white;">전공</th>
		<td>{{teacher.major}}</td>
		<th style="background-color:#038edc;color:white;">번호</th>
		<td>{{teacher.phone}}</td>
	</tr>
	<tr>
		<th colspan="4" style="background-color:#038edc;color:white;">자격증</th>
	</tr>
	<tr>
		<td colspan="4">
		{{#cerList}}
			{{cerName}}
		{{/cerList}}
		</td>
	</tr>
</table>
</script>
<!-- ------------------------------------------------------------------- -->
<script>
	var classCode = "";//수업코드
	var tId = "";//담당강사 ID
	var startDate;//수업시작일
	var endDate;//수업종료일
	var roomCode;//강의실 코드
</script>

<script>
//다음 버튼이 Next일때만 작동
//Wizard Form 마지막 페이지에 개설 수업 상세를 뿌려주는 작업
function setText(){
	if($('#nextBtn').text()!="Next"){
		return;
	}
	var sjcode = $('#dcsub').val();//과목코드 
	var subdetail = $('#subdetail_code').val();//과목영역코드

	var dcname = $('#dcname').val();//수업명
	var cGrade = $('#cGrade').val();	//대상
	var stu_cnt = $('#stu_cnt').val();	//정원 
	var dcprice = $('#dcprice').val();	//가격
	var class_rank = $('#class_rank').val();//수준 

	var subname;//과목명
	var subdetailName;//과목영역명
	
	var subjectSelect = $('#dcsub').find('option');
	for(var i=0;i<subjectSelect.length;i++){
		if(subjectSelect[i].value==sjcode){
			subname = subjectSelect[i].innerText
		}
	}
	
	var subdetailSelect = $('#subdetail').find('option');
	console.log(subdetailSelect);
	for(var i=0;i<subdetailSelect.length;i++){
		if(subdetailSelect[i].value==subdetail){
			subdetailName = subdetailSelect[i].innerText
		}
	}
	//wizard Form 마지막 페이지에 뿌려주기
	$('#class_name').text(dcname);
	$('#subject_name').text(subname);
	$('#subdetail_name').text(subdetailName);
	$('#member_grade').text(cGrade+"학년");
	$('#class_capacity').text(stu_cnt+"명");
	$('#class_price').text(dcprice+"원");
	$('#class_grade').text(class_rank);
}
	//수업 등록하기 (class 테이블에 먼저 insert, time_detail에 insert)
	//json객체 형식으로 만들어서 stringify써주고 받아서 처리해주면 될듯

	//next버튼이 Submit으로 바뀔때 제출
	function classSubmit() {
		if ($('#nextBtn').text() != 'Next') {
			var startDate = $('#startDate').val();			//시작일
			var endDate = $('#endDate').val();				//종료일
			var totalTime = $('#total_time').text();		//수업시수
			var tid = $('input[name="id"]').val(); 			//강사 아이디
			var subjectCode = $('#dcsub').val();			//과목코드 
			var subdetailCode = $('#subdetail_code').val();	//과목영역코드
			var className = $('#dcname').val();					//수업명
			var classGrade = $('#cGrade').val();			//대상
			var stuCnt = $('#stu_cnt').val();				//정원 
			var classPrice = $('#dcprice').val();			//가격
			var classRank = $('#class_rank').val();			//수준 
			
			if (className == "" || className == null) {
				alert("수업명을 작성하지 않았습니다!");
				return;
			}
			if (subdetailCode == "" || subdetailCode == null) {
				alert("과목 영역이 선택되지 않았습니다!");
				return;
			}
			if (classGrade == "" || classGrade == null) {
				alert("학년이 선택되지 않았습니다!");
				return;
			}
			if (stuCnt == "" || stuCnt == null) {
				alert("정원을 작성하지 않았습니다!");
				return;
			}
			if (classPrice == "" || classPrice == null) {
				alert("가격을 책정하지 않았습니다!");
				return;
			}
			if (classRank == "" || classRank == null) {
				alert("수업수준을 작성하지 않았습니다!");
				return;
			}
			if (tid == "" || tid == null) {
				alert("담당 강사가 선택되지 않았습니다!");
				return;
			}
			if (startDate == "" || startDate == null) {
				alert("수업 시작일이 선택되지 않았습니다!");
				return;
			}
			if (endDate == "" || endDate == null) {
				alert("수업 종료일이 선택되지 않았습니다!");
				return;
			}
			if (totalTime == "" || totalTime == null) {
				alert("수업 시간이 선택되지 않았습니다!");
				return;
			}

			//세번째 페이지 테이블에 선택 시간 색상 채우기
// 			setSecondTable(timetable);
			
			//classCode 전역변수
			//roomCode 전역변수
			//timetable 전역변수(배열)
			
			//수업등록을 위해 작성한 데이터들을 json형태로 담아서 보내준다. 
			var map = {
				"startDate" : startDate,
				"endDate" : endDate,
				"className" : className,
				"id" : tid,
				"totalTime" : totalTime,
				"roomCode" : roomCode,
				"subdetailCode" : subdetailCode,
				"classGrade" : classGrade,
				"stuCnt" : stuCnt,
				"classPrice" : classPrice,
				"classRank" : classRank,
				"timetable" : timetable
			};
			
			Swal.fire({
			      icon: 'success',
			      title: '수업 개설이 완료되었습니다!'
			      
			    }).then((result) => {
				  if (result.value) {
						$.ajax({
							url : "<%=request.getContextPath()%>/classregist/classOpen.go",
							data : JSON.stringify(map),
							contentType : "application/json",
							method : "post",
							success : function(res) {
								//alert("수업 개설이 완료되었습니다!");
								opener.parent.location.reload();
								window.close();
							},
							error : function(error) {
								alert("error : " + error.status);
							},
							dataType : "json"
						});

						
				  }
				})

		
		}
	}
</script>


<script>
	function getGrade(op) {
		// 		console.log(op.value);
		$('#cGrade').val(op.value);
	}

	function getSubDeVal(op) {
		$('#subdetail_code').val(op.value);
	}
</script>

</head>
</body>
















