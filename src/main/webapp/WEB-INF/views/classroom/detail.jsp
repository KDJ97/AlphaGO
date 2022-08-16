<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<style>
.table>:not(caption)>*>* {
	padding: 0.5rem 0.5rem;
}

.card-header {
	padding: 0.5rem 1rem;
}
</style>
<script>
function detail_go(tr){
	var classCode = $(tr).find('td:eq(0)').text();
	console.log("classCode : " + classCode);
	OpenWindow('<%=request.getContextPath()%>/classlist/detail.go?classCode='+classCode,'수업 상세', 1000, 900);
}
</script>
</head>

<body>
	<c:set var="pageMaker" value="${dataMap.pageMaker }" />
	<c:set var="classList" value="${dataMap.classList }" />
	<div class="row">
		<div class="col-md-12">
			<div class="card">
				<!-- card-header 시작 -->
				<div class="card-header">
					<h6 class="card-title">강의실 상세</h6>
				</div>
				<!-- card-header 끝 -->

				<!-- 검색 및 등록 시작-->
				<!-- 검색 -->
				<div class="row">
					<div class="col-sm-6" style="margin-top: 30px;padding-right: 40px;padding-left: 40px;">
						<button class="btn btn-warning" id="modifyBtn" onclick="modify_go();">수정</button>
						<button class="btn btn-danger" id="removeBtn">삭제</button>
					</div>
					<div class="col-sm-6">
						<div class="col-sm-6 input-group" id="keyword"
							style="float: right; margin-top: 30px; padding-right: 40px;">
							<!-- keyword -->
							<select class="form-select " style="float: left; width: 20%;"
								aria-label="Default select example" name="searchType"
								id="searchType">
								<option value="nst" ${cri.searchType eq 'all' ? 'selected':'' }>전체</option>
								<option value="n" ${cri.searchType eq 'n' ? 'selected':'' }>강사명</option>
								<option value="cn" ${cri.searchType eq 'cn' ? 'selected':'' }>수업명</option>
								<option value="sn" ${cri.searchType eq 'sn' ? 'selected':'' }>과목명</option>
								<option value="sdn" ${cri.searchType eq 'sdn' ? 'selected':'' }>과목영역명</option>
							</select> <input class="form-control col-sm-6 " type="text" name="keyword"
								placeholder="검색어를 입력하세요." value="${param.keyword }"
								style="width: 40%;"> <span class="input-group-append">
								<button class="btn btn-primary" type="button"
									id="searchBtn" style="float: right;" data-card-widget="search"
									onclick="list_go(1,'detail.go?roomCode=${dataMap.roomCode}')">
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>
						</div>
					</div>
				</div>
				<!-- 검색 및 등록 끝 -->

				<!-- card-body 시작 -->
				<div class="card-body" style="padding-top: 0;">
					<!-- table 시작 -->
					<div class="col-md-12">
						<p style="font-size: small;margin-top: 5px; margin-bottom: 3px;">* 수업 목록을 클릭해 수업 상세 정보를 확인하세요 *</p>
						<input type="hidden" id="roomCodeVal" value="${dataMap.roomCode }">
						<table class="table  table-hover" style="text-align: center;">
							<thead style="background-color: #038edc; color: white;">
								<tr>
									<th>과목명</th>
									<th>영역</th>
									<th>수업명</th>
									<th>강사명</th>
									<th>기간</th>
									<th>수준</th>
									<th>정원</th>
								</tr>
							</thead>
							<tbody>
							<c:if test="${not empty classList }">
								<c:forEach var="classvo" items="${classList }">
									<tr onclick="detail_go(this);">
										<td style="display: none;">${classvo.classCode }</td>
										<td>${classvo.subjectName }</td>
										<td>${classvo.subdetailName }</td>
										<td>${classvo.className }</td>
										<td>${classvo.name }</td>
										<td>${classvo.startDate }~${classvo.endDate }</td>
										<td>${classvo.classRank }</td>
										<td>${classvo.stuCnt}명</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty classList }">
								<tr>
									<td colspan="7">해당 수업실에서 진행되는 수업이 없습니다.</td>
								</tr>
							</c:if>
							</tbody>
						</table>
						<!-- pagination -->
						<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
					</div>

				<div class="row" style="margin-top: 5px;">
					<div class="col-sm-6">
					<p style="font-size: small;margin-bottom: 2px;">* 오늘의 수업 목록 → 수업을 클릭해 오늘의 해당 수업 시간을 확인하세요 *</p>
					<table class="table  table-hover" style="text-align: center;">
							<thead style="background-color: #038edc; color: white;">
								<tr>
									<th>과목명</th>
									<th>영역</th>
									<th>수업명</th>
									<th>강사명</th>
									<th>수준</th>
									<th>정원</th>
								</tr>
							</thead>
							<tbody id="dayClassTarget">
							<!-- 핸들바스 -->
								<tr>
									<td colspan="6">해당 수업실에서 오늘의 수업이 없습니다.</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="col-sm-6">
					<p style="font-size: small;margin-bottom: 2px;">* 오늘의 시간표 *</p>
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
									<th style="background-color: #038edc; color: white;font-size:x-small;">${cnt+1}교시(${cnt+9}:00~${cnt+10}:00)</th>
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
		</div>
	</div>
	
<c:if test="${from eq 'modify' }">
	<script>
		//alert("수정되었습니다.");
		window.close();
		window.opener.location.reload();
	</script>
</c:if>

<head>
<!-- 수업 리스트 템플릿 -->
<script type="text/x-handlebars-template"  id="class-list-template" >
	{{#each .}}
		<tr onclick="getDayTime(this);">
			<td style="display: none;">{{classCode}}</td>
			<td>{{subjectName}}</td>
			<td>{{subdetailName}}</td>
			<td>{{className}}</td>
			<td>{{name}}</td>
			<td>{{classGrade}}</td>
			<td>{{stuCnt}}</td>
		</tr>
	{{/each}}
</script>
<!-- 수업 리스트 템플릿 -->
<script type="text/x-handlebars-template"  id="class-none-template" >
	<tr>
		<td colspan="6">해당 수업실에서 오늘의 수업이 없습니다.</td>
	</tr>
</script>
<script>
	//onload function
	window.onload = function(){
		var roomCode= $('#roomCodeVal').val();
		console.log(roomCode);
		//해당 강의실에서 진행되는 수업들의 사용시간을 가져온다
		$.ajax({
			url:'<%=request.getContextPath()%>/classroom/getUseRoomTime.go',
			data:{"roomCode":roomCode},
			success:function(data){
				//시간 데이터를 시간표에 표시한다.
				setCantUseRoom(data);
			},
			error:function(error){
				alert("error : " + error.status);
			},
			dataType:'json'
		});
		
		//해당강의실의 오늘 수업이 있는 수업정보 리스트를 가져온다
		$.ajax({
			url:'<%=request.getContextPath()%>/classroom/selectClassListByRoomCodeClassDay.go',
			data:{"roomCode":roomCode},
			success:function(data){
				console.log(data);
				if(data[0].classCode){
					printData(data,$('#dayClassTarget'),$('#class-list-template'));
				}
			},
			error:function(error){
				alert("error : " + error.status);
			},
			dataType:'json'
		})
	};
</script>	

<script>
//오늘의 수업 클릭 시 시간정보를 가져와 시간표에 뿌린다
function getDayTime(tr){
	var classCode = $(tr).find('td:eq(0)').text();
	console.log(classCode);
	var roomCode= $('#roomCodeVal').val();
	console.log(roomCode);
	var classvo = {
			"roomCode":roomCode,
			"classCode":classCode
	}
	
	$.ajax({
		url:'<%=request.getContextPath()%>/classroom/selectClassTimeByRoom.go',
		data:JSON.stringify(classvo),
		contentType:"application/json",
		method:"post",
		success:function(data){
			console.log(data);
			setCantUseRoom(data);
		},
		error:function(error){
			alert("error : " + error.status);
		},
		dataType:'json'
	})
	
}

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
	function modify_go(){
		var roomCode= $('#roomCodeVal').val();
		OpenWindow('modifyForm.go?roomCode='+roomCode,'강의실 수정',500,820);
	}
	</script>

</head>
</body>

