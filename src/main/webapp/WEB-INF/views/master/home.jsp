<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
	<!-- apexchart - 그래프 -->
	<script src="<%= request.getContextPath()%>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
	
	<!-- calendar -->
	<script src="<%= request.getContextPath()%>/resources/js/main.js"></script>
	<script src="<%= request.getContextPath()%>/resources/js/ko.js"></script>
<%-- 	<script src="<%= request.getContextPath()%>/resources/js/counsert_calender.js"></script> --%>
	<!-- common js -->
	<script src="<%= request.getContextPath()%>/resources/js/dj_master.js"></script>
	 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>

<body>
	<!-- 첫줄 row 시작 -->
	<div class="row">
		<!-- 왼쪽 wrapper 시작 -->
		<div class="col-lg-6" style="padding: 2px;">
			<!-- 원생수 카드 시작 -->
			<div class="card" style="margin-bottom: 5px;">
				<div class="card-header"
					style="background-color: #038edc; color: white; padding: 0;">
					<p style="font-weight: bold; padding: 5px; margin: auto;padding-left: 15px;">원생수
						확인</p>
				</div>

				<div class="card-header" style="padding: 3px; text-align: center;">
					<ul class="nav nav-pills col-md-12" id="pills-tab" role="tablist"
						style="padding-left: 40px;">
						<li class="nav-item col-sm-4" role="presentation">
							<button class="nav-link active" id="pills-home-tab"
								data-bs-toggle="pill" data-bs-target="#pills-home" type="button"
								role="tab" aria-controls="pills-home" aria-selected="true">전체
								원생수</button>
						</li>
						<li class="nav-item col-sm-4" role="presentation">
							<button class="nav-link" id="pills-profile-tab"
								data-bs-toggle="pill" data-bs-target="#pills-profile"
								type="button" role="tab" aria-controls="pills-profile"
								aria-selected="false">과목별 원생수</button>
						</li>
						<li class="nav-item col-sm-4" role="presentation">
							<button class="nav-link" id="pills-contact-tab"
								data-bs-toggle="pill" data-bs-target="#pills-contact"
								type="button" role="tab" aria-controls="pills-contact"
								aria-selected="false">학교별 원생수</button>
						</li>
					</ul>
				</div>
				<!-- chart 시작 -->
				<div class="tab-content card-body" id="pills-tabContent" style="padding:2px;">
					<div class="tab-pane fade show active" id="pills-home"
						role="tabpanel" aria-labelledby="pills-home-tab">
						<div id="allcnt_chart" class="col-sm-12"></div>
					</div>
					<div class="tab-pane fade" id="pills-profile" role="tabpanel"
						aria-labelledby="pills-profile-tab">
						<div id="subcnt_chart" class="col-sm-12"></div>
					</div>
					<div class="tab-pane fade" id="pills-contact" role="tabpanel"
						aria-labelledby="pills-contact-tab">
						<div id="schoolcnt_chart" class="col-sm-12"></div>
					</div>
				</div>
				<!-- card-body chart 끝 -->
			</div>
			<!-- 원생수 카드 끝 -->

			<!-- 상담신청목록 시작 -->
			<div class="card task-box col-lg-12" style="margin-bottom: 5px;height:180px;overflow-y:auto;">
				<div class="card-header"
					style="background-color: #038edc; color: white; padding: 0;">
					<p style="float:left;font-weight: bold; padding: 5px; margin: auto;padding-left: 15px;">상담신청
						목록</p>
					<button type="button" id="counseltBtn" onclick="selectCounseltList();"style="float:right;background-color: rgba(0,0,0,0);border:none;height: 30px;">
					<i class="uil-redo"></i></button>
				</div>
				<table class="table table-hover" style="text-align: center;margin: 0;">
					<thead>
						<tr style="background-color: #038edc; color: white;">
							<th style="padding:5px;">원생명</th>
							<th style="padding:5px;">상담시간</th>
							<th style="padding:5px;">승인</th>
						</tr>
					</thead>
					<tbody id="counseltTarget">
					</tbody>
				</table>
			</div>
			<!-- 상담신청 목록 끝 -->
			
	<!-- 상담 연기 Modal -->
	<div class="modal fade" id="delayModal" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-primary">
					<h5 class="modal-title" id="staticBackdropLabel" style="color:white;">
						<i class="uil-comment-alt-message">메시지</i>
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<!-- end card header -->
					<div class="card-body">
						<form>
							<div class="col-sm-6">
								<span class="badge bg-primary" style="font-size: 1.2em;">
									받는사람 </span>
							</div>
							<div class="col-sm-4">
								<input type="text" placeholder="010-9647-0026"
									class="form-control" id="horizontal-firstname-input">
							</div>
							<div class="col sm-6">
								<span class="badge bg-danger"
									style="width: 100%; font-size: 1.2em;">연기 사유</span>
							</div>
							<!-- end row -->
							<textarea class="form-control " placeholder="내용을 입력하세요"
								id="smscontent" style="height: 100px"></textarea>
							<!-- end row -->
							<button type="button" class="btn btn-primary"
								style="float: right;" onclick="cancel_go()">Send</button>
							<div class="row justify-content-end">
								<div class="col-sm-9">
									<div class="form-check mb-4"></div>

								</div>
								<!-- end col -->
							</div>
							<!-- end row -->
						</form>
						<!-- end form -->
					</div>
				</div>
			</div>
		</div>
	</div>
			


			<!-- 지원 모집 시작 -->
			<div class="card task-box col-lg-12" style="margin-bottom: 5px;height:180px;overflow: auto;">
				<div class="card-header" style="background-color: #038edc; color: white; padding: 0;">
					<p style="float: left;font-weight: bold; padding: 5px; margin: auto;padding-left: 15px;">모집 지원
						목록</p>
					<button type="button" style="float:right;background-color: rgba(0,0,0,0);border:none;height: 30px;">
					<i class="uil-redo"></i></button>
				</div>
				<table class="table table-hover" style="text-align: center;margin: 0;">
					<thead>
						<tr style="background-color: #038edc; color: white;">
							<th style="padding:5px;">이름</th>
							<th style="padding:5px;">전화번호</th>
							<th style="padding:5px;">이력서</th>
						</tr>
					</thead>
					<tbody id="applyListTarget">
					</tbody>
				</table>
			</div>
			<!-- 상담신청 목록 끝 -->
		</div>
		<!-- 왼쪽 wrapper 끝  -->

		<div class="col-lg-6" style="padding: 2px;">
			<!-- 강사근태관리 시작 -->
			<div class="card task-box col-lg-12" style="margin-bottom: 5px;height:180px;overflow: auto;">
				<div class="card-header"
					style="background-color: #038edc; color: white; padding: 0;">
					<p style="float:left;font-weight: bold; padding: 5px; margin: auto;">강사 근태
						관리</p>
					<button type="button" id="attendBtn" onclick="selectTeacherAttendList();" style="float:right;background-color: rgba(0,0,0,0);border:none;height: 30px;margin-right: 7px;">
					<i class="uil-redo"></i></button>
				</div>
				<table class="table table-hover" style="text-align: center;margin: 0;">
					<thead>
						<tr style="background-color: #038edc; color: white;">
							<th style="padding: 5px;">강사명</th>
							<th style="padding: 5px;">전화번호</th>
							<th style="padding: 5px;">출근시간</th>
							<th style="padding: 5px;">퇴근시간</th>
							<th style="padding: 5px;">상태</th>
						</tr>
					</thead>
					<tbody id="teacherAttendTarget"><!-- 핸들바스 강사 근태 타겟 -->
					</tbody>
				</table>
			</div>
			<!-- 강사근태관리 끝 -->

			<!-- 상담 캘린더 시작 -->
			<div class="card task-box col-lg-12" style="margin-bottom: 5px;">
				<div class="card-header"
					style="background-color: #038edc; color: white; padding: 0;">
					<p style="font-weight: bold; padding: 5px; margin: auto;">상담 일정
						캘린더</p>
				</div>
				<div id="hd-calendar"
					style="padding: 5px; background-color: white;"></div>
			</div>
		</div>

	</div>
	<!-- row 끝 -->

	<!--Calender Modal -->
	<div class="modal fade" id="datailCalendar" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #86a8d9;">
					<h5 class="modal-title" id="staticBackdropLabel" style=" color: white;">상담 일정 상세</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-sm-12" style="margin: 3px;">
							<div class="col-sm-4" style="float:left;">구분 :</div>
							<div class="col-sm-8"style="float:right;">
								<select class="form-select">
									<option value="study">학업</option>
									<option value="counsert">진로</option>
								</select>
							</div>
						</div>
						<div class="col-sm-12" style="margin: 3px;">
							<div class="col-sm-4"style="float:left;">상담일 :</div>
							<div class="col-sm-8"style="float:right;">
								<input class="form-control" type="text" name="" id=""
									value="">
							</div>
						</div>
						<div class="col-sm-12" style="margin: 3px;">
							<div class="col-sm-4"style="float:left;">시작시간 :</div>
							<div class="col-sm-8"style="float:right;">
								<input class="form-control" type="text" name="" id=""
									value="">
							</div>
						</div>
						<div class="col-sm-12" style="margin: 3px;">
							<div class="col-sm-4"style="float:left;">종료시간 :</div>
							<div class="col-sm-8"style="float:right;">
								<input class="form-control" type="text" name="" id=""
									value="">
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-warning" id="btn-modify-event">수정</button>
					<button type="button" class="btn btn-danger" id="btn-delete-event">삭제</button>
				</div>
			</div>
		</div>
	</div>

</body>
<head>
<script src="<%=request.getContextPath()%>/resources/js/example.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>

<script type="text/javascript">
window.onload = function(){
	selectTeacherAttendList();//강사 근태 실행
	selectCounseltList();//상담 신청 목록
	selectMemberCountList();//최근 12개월간의 원생수
	selectSubdetailClassingCountList();//과목별 원생수
	selectSchoolCountBySchoolCodeFromMember();
	selectApplyList();
}
</script>

<script>
function selectApplyList(){
	$.ajax({
		url:"<%=request.getContextPath()%>/master/selectApplyList.go",
		success:function(data){
			console.log(data);
			if(data!=null&&data.length>0){
				printData(data,$('#applyListTarget'),$('#apply-list-template'));
			}else{
				printData(data,$('#applyListTarget'),$('#apply-none-template'));
			}
		},
		error:function(error){
			alert("error : " + error.status);
		},
		dataType:'json'
	});
}
</script>
<script>
// function getApplyFile(applyCode){
// 	$.ajax({
<%-- 		url:"<%=request.getContextPath()%>/master/getFile.go", --%>
// 		data:{"applyCode":applyCode},
// 		success:function(data){
			
// 		},
// 		error:function(error){
// 			alert("error : " + error.status);
// 		}
// 	});
// }
</script>
<!-- 상담 신청 목록 -->
<script type="text/x-handlebars-template" id="apply-list-template">
{{#each .}}
	<tr onclick="" style="cursor: pointer;">
		<td style="padding: 5px;">{{applyer}}</td>
		<td style="padding: 5px;">{{applyerTel}}</td>
		<td style="padding: 5px;"><i onclick="location.href='getFile.go?applyCode={{applyCode}}'" class="uil-file-download"></i></td>
	</tr>
{{/each}}
</script>
<script type="text/x-handlebars-template" id="apply-none-template">
	<tr style="cursor: pointer;">
		<td colspan="3" style="padding: 5px;">모집 지원 목록이 없습니다.</td>
	</tr>
</script>

<script>
//강사 근태 비동기 요청
function selectTeacherAttendList(){
	$.ajax({
		url:"<%=request.getContextPath()%>/master/selectTeacherAttendList.go",
		dataType:'json',
		success:function(data){
			if(data.length>0){
				printData(data, $('#teacherAttendTarget'),$('#teacher-attend-template'));
			}else if(data.length<1){
				printData(data, $('#teacherAttendTarget'),$('#teacher-none-template'));
			}
		},
		error:function(error){
			alert("error : " + error.status);
		}
	});
}
function selectCounseltList(){
	$.ajax({
		url:"<%=request.getContextPath()%>/master/selectCounseltList.go",
		dataType:'json',
		success:function(data){
			if(data.length>0){
				printData(data, $('#counseltTarget'),$('#counselt-list-template'));
			}else if(data.length<1){
				printData(data, $('#counseltTarget'),$('#counselt-none-template'));
			}
		},
		error:function(error){
			alert("error : " + error.status);
		}
	});
}
//전체 원생수 그래프
function selectMemberCountList(){
	$.ajax({
		url:"<%=request.getContextPath()%>/master/selectMemberCountList.go",
		dataType:'json',
		success:function(data){
			console.log(data);
			var arr1 = [];//원생수를 담아줄 배열
			var arr2 = [];//월을 담아줄 배열
			for(var i=0;i<data.length;i++){
				arr1.push(parseInt(data[i].memcnt));//원생수 int로 형변환해서 넣기
				arr2.push(data[i].regdate);
			}
			allMemberCnt(arr1, arr2);
		},
		error:function(error){
			alert("error : " + error.status);
		}
	});
}
//과목별 원생수
function selectSubdetailClassingCountList(){
	$.ajax({
		url:"<%=request.getContextPath()%>/master/selectSubdetailClassingCountList.go",
		dataType:'json',
		success:function(data){
			var arr1=[];
			var arr2=[];
			for(var i=0;i<data.length;i++){
				arr1.push(parseInt(data[i].cnt));//원생수 int로 형변환해서 넣기
				arr2.push(data[i].subdetailName);
			}
			
			donutGraph(arr2, arr1)
			
		},
		error:function(error){
			alert("error : " + error.status);
		}
	});
}
//과목별 원생수
function selectSchoolCountBySchoolCodeFromMember(){
	$.ajax({
		url:"<%=request.getContextPath()%>/master/selectSchoolCountBySchoolCodeFromMember.go",
		dataType:'json',
		success:function(data){
			console.log(data);
			var arr1=[];
			var arr2=[];
			for(var i=0;i<data.length;i++){
				arr1.push(parseInt(data[i].cnt));//원생수 int로 형변환해서 넣기
				arr2.push(data[i].schoolName);
			}
			console.log(arr1);
			console.log(arr2);
			donutGraph2(arr2, arr1)
			
		},
		error:function(error){
			alert("error : " + error.status);
		}
	});
}

</script>	

<!-- 상담 신청 목록 -->
<script type="text/x-handlebars-template" id="counselt-list-template">
{{#each .}}
	<tr style="cursor: pointer;">
		<td style="padding: 5px;">{{name}}</td>
		<td style="padding: 5px;">
		{{meetDate}} {{pcStart}}~{{pcEnd}}
		</td>
		<td style="padding: 5px;">
			<button type="button" class="btn btn-primary btn-rounded" onclick="regist_go(this);"
				style="height: 35px; font-size: small;" value="{{pcCode}}">승인</button>
			<button type="button" class="btn btn-danger btn-rounded" id="delayBtn" data-bs-toggle="modal"
			data-bs-target="#delayModal" style="height: 35px; font-size: small;" value="{{pcCode}}">연기</button>
		</td>
	</tr>
{{/each}}
</script>
<script type="text/x-handlebars-template" id="counselt-none-template">
	<tr style="cursor: pointer;">
		<td colspan="3" style="padding: 5px;">상담 신청 목록이 없습니다.</td>
	</tr>
</script>

<script>
Handlebars.registerHelper('checkAttend', (status) => {//상태 반환 함수
	//"출석상태 1:출석, 2:결석, 3:지각, 4:외출, 5:조퇴, 0:등원"
	var res;
	if(status=='0'){
		res = '등원';
	}else if(status=='1'){
		res = '출근';
	}else if(status=='2'){
		res = '결근';
	}else if(status=='3'){
		res = '지각';
	}else if(status=='4'){
		res = '외출';
	}else if(status=='5'){
		res = '조퇴';
	}
    return res;
});
</script>
<script>
Handlebars.registerHelper('checkAttendColor', (status) => {//상태에 따른 span 클래스명 반환 함수
	//"출석상태 1:출석, 2:결석, 3:지각, 4:외출, 5:조퇴, 0:등원"
	var res;
	if(status=='0'){
		res = 'bg-primary';
	}else if(status=='1'){
		res = 'bg-success';
	}else if(status=='2'){
		res = 'bg-danger';
	}else if(status=='3'){
		res = 'bg-warning';
	}else if(status=='4'){
		res = 'bg-info';
	}else if(status=='5'){
		res = 'bg-purple';
	}
    return res;
});
</script>
<script>
Handlebars.registerHelper('checkTime', (Time) => {
	//"출석상태 1:출석, 2:결석, 3:지각, 4:외출, 5:조퇴, 0:등원"
	var res = Time;
	if(res!=null){
	    return res;
	}else{
		res='-';
		return res;
	}
});
</script>

<script type="text/x-handlebars-template" id="teacher-attend-template">
{{#each .}}
<tr onclick="attendDetail_go(this);" style="cursor: pointer;">
	<td style="display: none;">{{id}}</td>
	<td style="padding: 5px;">{{name}}</td>
	<td style="padding: 5px;">{{phone}}</td>
	<td style="padding: 5px;">{{checkTime inTime}}</td>
	<td style="padding: 5px;">{{checkTime outTime}}</td>
	<td style="padding: 5px;">
		<span style="font-size: 100%;" class="badge {{checkAttendColor attendanceStatus}}">{{checkAttend attendanceStatus}}</span>
	</td>
</tr>
{{/each}}
</script>
<script type="text/x-handlebars-template" id="teacher-none-template">
	<tr style="cursor: pointer;">
		<td colspan="5" style="padding: 5px;">강사 출결 목록이 없습니다.</td>
	</tr>
</script>


<script>
function attendDetail_go(tr){
	var id= $(tr).find('td:eq(0)').text();
	console.log(id);
	OpenWindow('<%=request.getContextPath()%>/mattend/detail.go?id='+id,'강사 출결 조회',1000,900);
}
</script>

<script>
//상담 신청 수락
function regist_go(cBtn){
	var pcCode = $(cBtn).val();
	console.log(pcCode);
	
	var paco={"pcCode":pcCode};
	
	Swal.fire({
	      icon: 'success',
	      title: '승인 되었습니다.'
	      
	    }).then((result) => {
		  if (result.value) {
			  $.ajax({
					url:"<%=request.getContextPath()%>/mconsulting/registcalender",
					data:JSON.stringify(paco),
					method:'POST',
					contentType:'application/json',
					success:function(res){
						//alert("등록이 완료되었습니다.");
						window.location.reload();
					},
					error:function(error){
						alert("error : " + error.status);
					},
					dataType:'json'
				});
				
		  }
		})
}

var delayCode;

$('#delayBtn').on('click', function(){
	delayCode = $('#delayBtn').val();
	console.log(delayCode);
});

function cancel_go(){
	
	var message = $('#smscontent').val();
	console.log(message);
	
	var content = {
			"content":message,
			"pcCode":delayCode		
	};
	
	Swal.fire({
	      icon: 'success',
	      title:'연기 문자가 발송되었습니다.'
	      
	    }).then((result) => {
		  if (result.value) {
			  $.ajax({
					url:'<%=request.getContextPath()%>/mconsulting/sendsms',
					data:JSON.stringify(content),
					contentType:'application/json',
					method:'post',
					success:function(res){
						//alert('연기 문자가 발송되었습니다.');
						window.location.reload();
					},
					error:function(error){
						//alert('연기 문자가 발송되었습니다.');
						window.location.reload();
//			 			alert('error : ' + error.status);
					},
					dataType:'json'
				});
				
		  }
		})
	
	
}
</script>
</head>






















