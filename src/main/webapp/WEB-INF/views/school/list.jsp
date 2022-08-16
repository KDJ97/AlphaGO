<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=920b14d2add732f9bc7f785681c1a295&libraries=services"></script>
	<script src="<%=request.getContextPath() %>/resources/js/kakaoMap.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
	<!-- apexchart - 그래프 -->
	<script src="<%= request.getContextPath()%>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
	<!-- 막대 비교 그래프 함수 모음 -->
	<script src="<%=request.getContextPath() %>/resources/js/schoolChart.js"></script>
</head>
<body>
<c:set var="schoolList" value="${dataMap.schoolList }"/>

	<div class="row">
		<div class="col-lg-12">
			<div class="card">
				<div class="card-header">
					<h5 style="font-weight: bold;margin:0;padding:0;"><i class="uil-building"></i>&nbsp;&nbsp;&nbsp;고등학교 목록</h5>
				</div>
				<!-- card-body 시작 -->
				<div class="card-body">
					<div class="row">
					<div class="col-md-12"
						style="text-align: center; padding-left: 50px; padding-right: 50px;">
					</div>
					<div class="col-md-5" style="margin-top: 42px;">
						<div class="col-sm-12 input-group" style="">
							<select class="form-select" style=""
								aria-label="Default select example" name="searchType"
								id="searchType">
								<option value="nrl" ${cri.searchType eq 'nrl' ? 'selected':'' }>전체</option>
								<option value="n" ${cri.searchType eq 'n' ? 'selected':'' }>학교명</option>
								<option value="r" ${cri.searchType eq 'r' ? 'selected':'' }>등급</option>
								<option value="l" ${cri.searchType eq 'l' ? 'selected':'' }>주소</option>
							</select>
							<input class="form-control col-sm-6" type="text" name="keyword"
								placeholder="검색어를 입력하세요." style="width: auto;" value="${param.keyword }"
								style=""> <span	class="input-group-append">
								<button class="btn btn-primary" type="button"
									id="searchBtn" style=""
									data-card-widget="search" onclick="list_go(1);">
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>
						</div>

						<div>
							<table class="table table-hover" id="schoolTable"
								style="text-align: center; margin-top: 10px; vertical-align: middle;">
								<thead style="background-color: #038edc; color: white;">
									<tr>
										<th style="padding:5px;">학교명</th>
										<th style="padding:5px;">학생비율</th>
										<th style="padding:5px;">등급</th>
										<th style="padding:5px;">정보보기</th>
									</tr>
								</thead>
								<tbody>
								<c:forEach var="school" items="${schoolList }">
									<tr onclick="getSchoolDetail(this);">
										<td style="display:none;">${school.schoolCode }</td>
										<td style="padding:5px;">${school.schoolName }</td>
										<td style="padding:5px;"><fmt:formatNumber value="${school.schoolPercent }" pattern="0.0" />%</td>
										<td style="padding:5px;">${school.schoolRank }</td>
										<td style="padding:5px;">
										<button type="button" class="btn btn-warning"
											onclick="event.cancelBubble=true;OpenWindow('<%=request.getContextPath()%>/school/detail.go?schoolCode=${school.schoolCode}','학교 상세',700,700);">
											<i class="uil-map-marker-alt"></i></button>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						<!-- pagination -->
						<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
						</div>
					</div>
					
					<div class="col-sm-1" style="display: flex; justify-content: center; align-items: center;">
						<i style="font-size: 50px;" class="uil-angle-double-right"></i>
					</div>
					
					<div class="col-md-6" style="margin-top: 50px;" id="handleTarget">
					</div>
				</div>
				<!-- card-body 끝 -->
				
			</div>
			<!-- card 끝 -->
			</div>
		</div>
	</div>
	
<head>
<script type="text/javascript">
	window.onload = function(){
		firstMemberList();
	}
</script>
<script>
function firstMemberList(){
	$.ajax({
		url:'<%=request.getContextPath()%>/school/selectMemberList.go',
		success:function(data){
			console.log(data);
			if(data!=null&&data.length>0){
				printData(data, $('#handleTarget'),$('#allMember-list-template'));
			}else{
				printData(data, $('#handleTarget'),$('#allMember-none-template'));
			}
		},
		error:function(error){
			alert('error : ' + error.status);
		},
		dataType:'json'
	});
}
</script>
<!-- 학교 상세 템플릿 -->
<script type="text/x-handlebars-template"  id="allMember-list-template" >
<div class="col-sm-12" style="height:700px;overflow: auto;">
<button style="float:right;margin-bottom:2px;"type="button" class="btn btn-secondary" onclick="firstMemberList();"><i class="uil-redo"></i></button>
	<table class="table table-hover" style="text-align: center;margin:0;vertical-align: middle;">
		<thead style="background-color:#038edc;color:white;">
			<tr>
				<th style="padding:5px;">이름</th>
				<th style="padding:5px;">번호</th>
				<th style="padding:5px;">학년</th>
				<th style="padding:5px;">등급</th>
				<th style="padding:5px;">성적확인</th>
			</tr>
		</thead>
		<tbody id="memberListTarget">
		{{#each .}}
			<tr onclick="getStudentScore(this);">
				<td style="display:none;">{{id}}</td>
				<td style="padding:5px;">{{name}}</td>
				<td style="padding:5px;">{{phone}}</td>
				<td style="padding:5px;">{{grade}}</td>
				<td style="padding:5px;">{{setDouble acheive}}</td>
				<td style="padding:5px;"><button class="btn btn-warning" type="button" onclick="event.cancelBubble=true;OpenWindow('<%=request.getContextPath()%>/sscore/detail.go?id={{id}}','성적 정보',1000,900)"><i class="uil-book-open"></i></button></td>
			</tr>
		{{/each}}
		</tbody>
	</table>
</div>
</script>
<script type="text/x-handlebars-template"  id="allMember-none-template" >
<div class="col-sm-12" style="height:700px;overflow: auto;">
<button style="float:right;margin-bottom:2px;"type="button" class="btn btn-secondary" onclick="firstMemberList();"><i class="uil-redo"></i></button>
	<table class="table table-hover" style="text-align: center;margin:0;">
		<thead style="background-color:#038edc;color:white;">
			<tr>
				<th>이름</th>
				<th>번호</th>
				<th>학년</th>
				<th>등급</th>
				<th>성적확인</th>
			</tr>
		</thead>
		<tbody id="memberListTarget">
			<tr><td colspan="5">등록된 원생이 없습니다.</td></tr>
		</tbody>
	</table>
</div>
</script>

	<script>
	var sCode;
	function getSchoolDetail(tr){
		var schoolCode = $(tr).find('td:eq(0)').text();
		console.log(schoolCode);
		sCode=schoolCode;//학교코드를 전역변수에 넣는다(이 변수를 사용하는 부분은 이 함수가 실행 되고 나서의 시나리오에 포함되기 때문에 사용가능)
		$.ajax({
			url:'getSchoolDetail.go',
			data:{"schoolCode":schoolCode},
			success:function(data){
				console.log(data);
				if(data.memberList!=null&&data.memberList.length>0){
					printData(data.memberList,$('#handleTarget'),$('#member-list-template'));
				}else{
					printData(data.memberList,$('#handleTarget'),$('#member-none-template'));
				}
				var subjectArr=[];
				var scoreArr=[];
				for(var i=0;i<data.scoreList.length;i++){
					subjectArr.push(data.scoreList[i].subjectName);
					scoreArr.push(parseFloat(data.scoreList[i].myscore.toFixed(2)));
				}
				$('#chart').empty();
				oneBarGraph(scoreArr,subjectArr);//해당학교 과목별 성적 그래프 생성
			},
			error:function(error){
				alert("error : " + error.status);
			},
			dataType:"json"
		});
	}
	</script>	
	<script>
	Handlebars.registerHelper('setDouble', (avgGrade) => {
		var num = parseFloat(avgGrade);
	    return num.toFixed(2);
	});
	</script>
	<!-- 학교 재학생 템플릿 -->
	<script type="text/x-handlebars-template"  id="member-list-template" >
<div class="col-sm-12" style="height:700px;overflow: auto;">
<button style="float:right;margin-bottom:2px;"type="button" class="btn btn-secondary" onclick="firstMemberList();"><i class="uil-redo"></i></button>
	<table class="table table-hover" style="text-align: center;margin:0;vertical-align:middle;">
		<thead style="background-color:#038edc;color:white;">
			<tr>
				<th style="padding:5px;">이름</th>
				<th style="padding:5px;">번호</th>
				<th style="padding:5px;">학년</th>
				<th style="padding:5px;">등급</th>
				<th style="padding:5px;">성적확인</th>
			</tr>
		</thead>
		<tbody id="memberListTarget">
		{{#each .}}
			<tr onclick="getStudentScore(this);">
				<td style="display:none;">{{id}}</td>
				<td style="padding:5px;">{{name}}</td>
				<td style="padding:5px;">{{phone}}</td>
				<td style="padding:5px;">{{grade}}</td>
				<td style="padding:5px;">{{setDouble acheive}}</td>
				<td style="padding:5px;"><button class="btn btn-warning" type="button" onclick="OpenWindow('<%=request.getContextPath()%>/sscore/detail.go?id={{id}}','성적 정보',1000,900)"><i class="uil-book-open"></i></button></td>
			</tr>
		{{/each}}
		</tbody>
	</table>
	<div class="col-sm-12" id="chart"></div>
</div>
	</script> 
	<!-- 학교 재학생 템플릿 -->
	<script type="text/x-handlebars-template"  id="member-none-template" >
<div class="col-sm-12" style="height:700px;overflow: auto;">
<button style="float:right;margin-bottom:2px;"type="button" class="btn btn-secondary" onclick="firstMemberList();"><i class="uil-redo"></i></button>
	<table class="table table-hover" style="text-align: center;margin:0;">
		<thead style="background-color:#038edc;color:white;">
			<tr>
				<th style="padding:5px;">이름</th>
				<th style="padding:5px;">번호</th>
				<th style="padding:5px;">학년</th>
				<th style="padding:5px;">등급</th>
				<th style="padding:5px;">성적확인</th>
			</tr>
		</thead>
		<tbody id="memberListTarget">
			<tr>
				<td colspan="5">해당 학교에 재학생이 없습니다.</td>
			</tr>
		</tbody>
	</table>
	<div class="col-sm-12" id="chart"></div>
</div>
	</script> 
	
	<script>
	function getStudentScore(tr){
		var id = $(tr).find('td:eq(0)').text();//해당 학생 id
		var schoolScoreVO={
			"schoolCode":sCode,
			"id":id
		};
		
		//해당 학생의 성적 데이터를 요청
		$.ajax({
			url:'<%=request.getContextPath()%>/school/getStudentScore.go',
			contentType:'application/json',
			method:'POST',
			data:JSON.stringify(schoolScoreVO),
			success:function(data){
				var scoreList = data.scoreList;
				var scoreByIdList = data.scoreByIdList;
				$('#chart').empty();
				
				var data1 = [];
				var data2 = [];
				var category = [];
				
				for(var i=0;i<scoreList.length;i++){
					category.push(scoreList[i].subjectName);
					data1.push(scoreList[i].myscore.toFixed(2));
				}
				for(var i=0;i<scoreByIdList.length;i++){
					data2.push(scoreByIdList[i].myscore.toFixed(2));
				}
				
				console.log(scoreList);
				console.log(scoreByIdList);
				
				twoBarGraph(data1, data2, category);
			},
			error:function(error){
				alert("error : " + error.status);
			},
			dataType:'json'
		});
	}
	</script>
	
</head>
</body>




















