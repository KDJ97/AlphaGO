<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="teacherList" value="${dataMap.teacherList }" />
<c:set var="cri" value="${pageMaker.cri }" />

<head>

<script
	src="<%=request.getContextPath()%>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/sm_chart.js"></script>
<script
	src="<%=request.getContextPath()%>/resources/assets/libs/rater-js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<style>
table th, td {
	text-align: center;
}
</style>

<script type="text/javascript">
var f1;
var f2;
var f3;
var f4;
function grade_go(sdff){
	
	//var id=$('.teadid').text();
	var subject=$('.subject').text();
	console.log(subject)
	
	if(subject==""){
		alert('강사를 선택해 주세요');
		return;
	}
	
	var sd=$('.sd');
	sd.empty();
	var sa=$('.sa');
	sa.empty();
	var sb=$('.sb');
	sb.empty();
	var sc=$('.sc');
	sc.empty();
	$.ajax({
	
		url:"gradetail.go",
		type:"POST",
		async:false,
		data:{
			"subject":subject
		},
		success:function(data){
			f1=data.avg;
			//sa.text(data.avg1);
			//sb.text(data.avg2);
			//sc.text(data.avg3);
		},
		error:function(){
		//alert("에러");
	},
	dataType:"json"
	});

	$.ajax({
		url:"gradetail1.go",
		type:"POST",
		async:false,
		data:{
			
			"subject":subject
		},
		
		success:function(data){
			//sd.text(data.avg);
			f2=data.avg1;
			//sb.text(data.avg2);
			//sc.text(data.avg3);
		},
		error:function(){
		//alert("에러");
	},
	dataType:"json"
		
		
	});

	
	
$.ajax({
		url:"gradetail2.go",
		type:"POST",
		async:false,
		data:{
			
			"subject":subject
		},
		
		success:function(data){
			
			//sd.text(data.avg);
			//sa.text(data.avg1);
			f3=data.avg2;
			//sc.text(data.avg3);
			
			
		},
		error:function(){
		//alert("에러");
	},
	dataType:"json"
		
		
	});

$.ajax({
	
	url:"gradetail3.go",
	type:"POST",
	 async:false,
	data:{
		
		"subject":subject
	},
	
	success:function(data){
		
		//sd.text(data.avg);
		//sa.text(data.avg1);
		//sb.text(data.avg2);
		f4=data.avg3;
		
		
	},
	error:function(){
	//alert("에러");
},
dataType:"json"
	
});
$('#gradeModalButton').click();

var c1= parseInt(f1);
var c2= parseInt(f2);
var c3= parseInt(f3);
var c4= parseInt(f4);
console.log(c1);
console.log(c2);
console.log(c3);
console.log(c4);

//console.log(fa);

var options = {
 		series : [ {
			name :"평균",
			data : [c1,c2,c3,c4]
		} ],
		chart : {
			width :430,
			height :300,
			type : 'line',
			zoom : {
				enabled : false
			}
		},
		dataLabels : {
			enabled : false
		},
		stroke : {
			curve :'straight'
		},
		title : {
			text : '학기별 성적 평균',
			align : 'left'
		},
		grid : {
			row : {
				colors : ['#f3f3f3', 'transparent' ], // takes an array which will
														// be repeated on columns
				opacity : 0.5
			},
		},
		xaxis : {
			categories : ['1학기중간','1학기기말','2학기중간','2학기기말']
		}
	};

	var chart = new ApexCharts(document.querySelector("#student_grade"), options);
	chart.render();
	
	
}	



</script>



<script>


</script>

</head>




<body>

	<!-- Content Header (Page header) -->


	<!-- Main content -->

	<div class="card">
		<div class="col-sm-12">
			<div class="col-sm-5" style="float: left;">
				<section class="content-header">
					<div class="container-fluid">
						<div class="row mb-2">
							<div class="card-header">
								<h5 style="margin:0;padding:0; font-weight:bold;"><i class="uil-user-check"></i>&nbsp;&nbsp;&nbsp;강사 조회</h5>
							</div>


						</div>
					</div>
				</section>
				<div class="card-header with-border">

					<button type="button" class="btn btn-primary" id="registBtn"
						onclick="OpenWindow('registTeacher.go','강사등록',540,680);">강사등록</button>
					<div id="keyword" class="card-tools"
						style="width: 250px; float: right;">
						<div class="input-group">

							<select class="form-control col-md-3" name="perPageNum"
								id="perPageNum" onchange="list_go(1);" style='display: none;'>
								<option value="10" ${cri.perPageNum==10 ? 'selected':'' }>개수</option>
								<option value="20" ${cri.perPageNum==20 ? 'selected':'' }>20개씩</option>
								<option value="30" ${cri.perPageNum==30 ? 'selected':'' }>30개씩</option>
								<option value="50" ${cri.perPageNum==50 ? 'selected':'' }>50개씩</option>

							</select> <select class="form-select col-md-3" name="searchType"
								id="searchType">
								<option value="tcw" ${cri.searchType eq 'tcw' ? 'selected':'' }>전체</option>
								<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>이름</option>
								<option value="w" ${cri.searchType eq 'w' ? 'selected':'' }>과목</option>
								<option value="c" ${cri.searchType eq 'c' ? 'selected':'' }>전화번호</option>


							</select> <input class="form-control" type="text" style="width: 40px;"
								name="keyword" placeholder="검색어 입력" value="${cri.keyword }" />
							<span class="input-group-append">
								<button class="btn btn-primary" style="float: right;"
									type="button" id="searchBtn" data-card-widget="search"
									onclick="list_go(1);">
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>
						</div>
					</div>
				</div>

				<div class="card-body" style="padding: 0px;">
					<table class="table table-bordered text-center  table-hover ">
						<thead>
							<tr
								style="font-size: 0.95em; background-color: #038edc; color: white;">
								<th style="width: 3%;">이름</th>
								<th style="width: 3%;">과목</th>
								<th style="width: 5%;">전화번호</th>



							</tr>
						</thead>
						<c:if test="${!empty teacherList }">
							<c:forEach items="${teacherList }" var="tea">

								<tr style='font-size: 0.85em;' onclick="teadetail_go(this)">
									<td style="display: none;"><input type="hidden" name="id"
										value="${tea.id }"></td>
									<td>${tea.name }</td>
									<td>${tea.subject }</td>
									<td>${tea.phone}</td>

								</tr>
							</c:forEach>
						</c:if>

					</table>
				</div>
				<div class="card-footer">
					<nav aria-label="teacher list Navigation">
						<ul class="pagination justify-content-center m-0">
							<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
						</ul>
					</nav>
				</div>
			</div>




			<!-- Main content -->

			<div class="col-sm-7" style="float: right; padding: 5px;">

				<div class="card">
					<div class="card-header">
						<h5 style="margin:0;padding:0; font-weight:bold;">
							<i class="uil-book-reader"></i>&nbsp;&nbsp;&nbsp;강사 정보 상세보기

						<button type="button" style="float: right; margin-left: 5px;"
							class="btn btn-danger" id="deleteBtn"
							onclick="deletetea_go(this)">삭제</button>

						<button type="button" onclick="grade_go('${tea.id }')"
							style="float: right;" class="btn btn-warning">학생들 성적 증감률</button>
						<button type="button" id="gradeModalButton" style="display: none"
							data-bs-toggle="modal" data-bs-target="#staticBackdrop"></button>


						<button type="button" style="float: right; margin-right: 10px;"
							class="btn btn-success" id="classreview" onclick="classend_go()">강사후기</button>
						<button type="button" id="reviewModalButton" style="display: none"
							data-bs-toggle="modal" data-bs-target="#staticBackdrop2"></button>
						</h5>

					</div>
					<div class="card-body d-flex justify-content-center">
						<div class="table-responsive" style="width: 578px;">
							<table class="table table-bordered  mb-0">
								<tbody>
									<tr>
										<td rowspan="3" style="width: 150px;">
											<div id="pictureView" class="manPicture" data-id="${tea.id }"
												style="border: 1px solid black; height: 150px; width: 100px; margin: 0 auto;"></div>

										</td>
										<td
											style="width: 100px; background: #038edc; color: white; font-weight: bold;">아이디</td>
										<td class="teaid"></td>
									</tr>
									<tr>
										<td scope="row"
											style="background: #038edc; color: white; font-weight: bold;">이름</td>
										<td class="teaname"></td>
									</tr>
									<tr>
										<td scope="row"
											style="background: #038edc; color: white; font-weight: bold;">전화번호</td>
										<td class="teaphone"></td>
									</tr>
									<tr>
										<td></td>
										<td scope="row"
											style="background: #038edc; color: white; font-weight: bold;">등록일</td>
										<td class="regdate"></td>
									</tr>
								</tbody>
								<!-- end tbody -->
							</table>
							<!-- end table -->
							<table class="table table-bordered mb-0">
								<tbody>
									<tr>
										<td scope="row"
											style="width: 131px; background: #038edc; color: white; font-weight: bold;">출근시간</td>
										<td class="attend_time"></td>
										<td scope="row"
											style="width: 131px; background: #038edc; color: white; font-weight: bold;">퇴근시간</td>
										<td class="out_time"></td>
									</tr>
									<tr>
										<td scope="row"
											style="width: 131px; background: #038edc; color: white; font-weight: bold;">과목</td>
										<td class="subject"></td>
										<td scope="row"
											style="width: 131px; background: #038edc; color: white; font-weight: bold;">시급</td>
										<td class="timepay"></td>
									</tr>
								</tbody>
								<!-- end tbody -->
							</table>
							<!-- end table -->

							<hr>

							<table class="table table-bordered mb-0">

								<tr>
									<th scope="row" colspan="3"
										style="background: #038edc; color: white; font-weight: bold;">강사
										경력</th>
								</tr>
							</table>


							<!-- 코멘트  -->
							<!-- 강사 경력 핸들바스 -->
							<div class="shadow p-3 mb-3 bg-light rounded" id="career"
								style="height: 139px;"></div>





						</div>
					</div>


				</div>


			</div>
		</div>
	</div>

	<div class="modal fade" id="staticBackdrop2" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<h5 style="margin-bottom: 15px; font-weight: bold;">
						<i class="uil-chat-info" style="margin-right: 10px;"></i>수강평
					</h5>

					<div>
						<select class="form-select"
							onchange="javascript:myListener(this);"
							id="class-select-template" aria-label="Default select example">
							<!-- 핸들바스 뿌리는 공간 -->
							
						</select>
					</div>





					<div class="card">
						<div class="card-body">

							<!-- 과목 핸들바스 -->
							<div id="class-subject-template"></div>
							<!-- 이름 핸들바스 -->

							<p id="class-name-template"></p>

							<!-- 전체후기리스트  핸들바스-->
							<div id="class-reviewlist-template"></div>

						</div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">닫기</button>

					</div>
				</div>
			</div>
		</div>
	</div>




	<!-- 학생 증감률 모달 -->


	<!-- Button trigger modal -->


	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header " style="background-color: #038edc;">





					<h5 class="modal-title " id="staticBackdropLabel"
						style="color: white;"><i class="uil-graph-bar"></i>&nbsp;&nbsp;&nbsp;수강을 듣는 학생들의 학기별 성적 평균</h5>


					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">

					<div class="tab-pane fade show active col-sm-12" id="pills-home"
						role="tabpanel" aria-labelledby="pills-home-tab">


						<div id="student_grade" class="col-sm-12"></div>

						<div class="sd"></div>
						<div class="sa"></div>
						<div class="sb"></div>
						<div class="sc"></div>


					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>

				</div>
			</div>
		</div>
	</div>


	<c:if test="${from eq 'regist' }">
		<script>
			alert("등록되었습니다.");
			window.close();
			window.opener.location.reload();
		</script>
	</c:if>

	<script>
	
	function teadetail_go(teaid){
		
		var id=teaid.children[0].children[0].value;
		console.log(id);
		
		var teaid=$('.teaid');
		teaid.empty();
		var teaname=$('.teaname');
		teaname.empty();
		var teaphone=$('.teaphone');
		teaphone.empty();
		var regdate=$('.regdate');
		regdate.empty();
		var attend_time=$('.attend_time');
		attend_time.empty();
		var out_time=$('.out_time');
		out_time.empty();
		var timepay=$('.timepay');
		timepay.empty();
		var subject=$('.subject');
		subject.empty();
		
		
		$.ajax({
		
			url:"teadetail.go",
			type:"POST",
			async:false,
			data:{
				
				"id":id
			},
			success:function(data){
				//전화번호
				var new_phone;
				if(data.phone==null){
					new_phone="-";
				}else{
					new_phone=data.phone;
				}
				teaphone.text(new_phone);
				
				//과목
				var new_subject;
				if(data.subject==null){
					new_subject="-";
				}else{
					new_subject=data.subject;
				}
				subject.text(new_subject);
				
				//출근시간
				var new_attendtime;
				if(data.attendTime==null){
					new_attendtime="-";
				}else{
					new_attendtime=data.attendTime;
				}
				attend_time.text(new_attendtime);
				
				//퇴근시간
				var new_outtimes;
				if(data.outTimes==null){
					new_outtimes="-";
				}else{
					new_outtimes=data.outTimes;
				}
				out_time.text(new_outtimes);
				
				//시급
 				var new_timepay;
 				
 				if(data.timepay==null){
					new_timepay="-";
 				}else{
					new_timepays=data.timepay;
 				}
				timepay.text(new_timepay);
				
				
				 var ab=number_format(data.timepay);
				 timepay.text(ab);
				console.log(data);
				var dt=time(data.regDate);
				teaid.text(data.id);
				teaname.text(data.name);
				//teaphone.text(data.phone);
				regdate.text(dt);
				//subject.text(data.subject);
				//attend_time.text(data.attendTime);
				//out_time.text(data.outTimes);
				//timepay.text(data.timepay);
				TeacherPictureThumb("<%=request.getContextPath()%>");
				
				
			},
			error:function(){
			//alert("에러");
		},
		dataType:"json"
			
			
		});
		
		
		$.ajax({
			
			url:"teacareer.go",
			type:"POST",
			async:false,
			data:{
				
				"id":id
			},
			success:function(data){
				console.log(data);
				if(data.length>0){
					printData(data,$('#career'),$('#class-career-template'));
				}else if(data.length<1){
					printData(data,$('#career'),$('#class-career-none-template'));
				}
				
			},
			error:function(){
			//alert("에러");
		},
		dataType:"json"
			
			
		});
		
		
		
	}
	
	
	</script>

	<script>
//금액 콤마 찍기
function number_format(num){
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
}

</script>



	<script>
	
	function classend_go(teaid){
		var id=$('.teaid').text();
		console.log(id);
		
		if(id==""){
			alert('강사를 선택해 주세요');
			return;
		}
		
				$.ajax({
				
					url:"classend.go",
					type:"POST",
					async:false,
					data:{
						"id":id
					},
					success:function(data){
						
					
						console.log(data);
						if(data.length>0){
							printData(data,$('#class-select-template'),$('#class-list-template'));
							//printData(data,$('#class-name-template'),$('#class-names-template'));
							//printData(data,$('#class-subject-template'),$('#class-subjects-template'));
						}else if(data.length<1){
							printData(data,$('#class-select-template'),$('#class-none-list-template'));
		
						}
						
						
					},
					error:function(error){
					alert("error:"+error.status);
				},
				dataType:"json"
					
					
				});
				
				//수업 후기 ajax 처음에 전체리스트
				$.ajax({
					
					url:"classreview.go",
					type:"POST",
					async:false,
					data:{
						"id":id
					},
					success:function(data){
						console.log(data);
						if(data.length>0){
							printData(data,$('#class-reviewlist-template'),$('#class-alllist-template'));
							onloadStar2(data);
						}else if(data.length<1){
							printData(data,$('#class-reviewlist-template'),$('#class-none-alllist-template'));
						}
							//console.log(data[i].starScore);
						
					},
					error:function(error){
					
				},
				dataType:"json"
					
					
				});
				
				
				//처음에 전체별점평균 
				var allavgstar=$('.allavgstar');
		// 		allavgstar.empty();
				var asa=$('.asa');
			$.ajax({
					
					url:"allavgstar.go",
					type:"POST",
					async:false,
					data:{
						"id":id
					},
					success:function(data){
						//console.log("starScore : " + data.avg4);
						console.log(data);
						onloadStar(data.avg4);
		 				//allavgstar.text(data.avg4);
						asa.text(data.avg4);
					},
					error:function(error){
					
				},
				dataType:"json"
					
				});
			
				$('#reviewModalButton').click();
			
			}
			
	</script>
	<script>
// 	function clickModal(){
// 		$('#classreview').click();
// 	}
</script>
	<script>
Handlebars.registerHelper('fullName', (starScore) => {
    var res = parseFloat(starScore)*20;
	return res;
});
</script>

	<!-- 모든수업리스트 템플릿 -->
	<script type="text/x-handlebars-template" id="class-alllist-template">
						<div style="margin-right: 10px;">총 평점</div>
							<div class="d-flex justify-content-start">
								<div style="font-weight: bold; margin-left: 10px;"
									class="allavgstar"></div>
									
								<span style="font-weight: bold;"
									class="asa"></span>
							</div>
	{{#each .}}  					
			<div class="bg-light mt-3 mb-2" style="border-radius: 5px; padding: 15px;">
				<p style="font-weight: bold;">{{className}}({{name}})</p>
					<div class="d-flex justify-content-start">
						<div id="reviewScoreRater" class="star-rating disabled allavgstar"  data-rating="{{starScore}}" title="{{starScore}}/5" style="width:{{starScore}}*20%; height: 16px; background-size: 16px;">
						
				
				</div>
					<div style="font-weight: bold; margin-left: 10px;">{{starScore}}</div>
					</div>
	
					<div style="margin-top: 10px;">{{content}}</div>
				</div>
	{{/each}}
</script>

	<!-- 모든수업리스트 없을시 템플릿 -->
	<script type="text/x-handlebars-template"
		id="class-none-alllist-template">

			수강평이 존재하지 않습니다.
	</script>


	<!-- 수업 셀렉트박스 템플릿 -->
	<script type="text/x-handlebars-template" id="class-list-template">

 	{{#each .}}  					 
		<option value="{{classCode}}">{{className}}</option> 
	{{/each}} 
 </script>
 
	<!-- 수업 셀렉트박스 null일시템플릿 -->
	<script type="text/x-handlebars-template" id="class-none-list-template">
				<option>담당하고  있는 수업이 없습니다.</option>
			
	</script>
	<!-- 강사경력  템플릿 -->
	<script type="text/x-handlebars-template" id="class-career-template">

 	{{#each .}}  					 
		{{startDate}}~{{endDate}}:{{cacontent}}<br>
	{{/each}} 
 </script>
 <!-- 강사경력  템플릿이 없을시-->
 <script type="text/x-handlebars-template" id="class-career-none-template">
		<td>
 		해당강사의 경력이 없습니다.
		</td
 </script>

	<!-- 	<!-- 학생이름 템플릿 -->
	<!-- 	<script type="text/x-handlebars-template" id="class-names-template"> -->


	<!--  		{{name}}  -->


	<!--  </script>  -->

	<!-- 	<!-- 클래스이름및 과목명  -->
	<!-- 	<script type="text/x-handlebars-template" id="class-subjects-template"> -->

	<!-- 	{{#each .}}  					 -->
	<!-- 		<p style="font-weight: bold;"> -->

	<!-- 			{{className}} -->
	<!-- 		<span class="badge rounded-pill bg-primary" -->
	<!-- 			style="font-size: 0.8em; padding: 8px; height: 25px; width: 50px; margin-left: 10px;">{{subject}}</span> -->
	<!-- 							</p> -->
	<!-- 	{{/each}} -->


	<!-- </script> -->

	<script>
	function TeacherPictureThumb(contextPath){
		
		
		console.log(contextPath);// -> /ddit
		console.log(document.querySelectorAll('.manPicture'));
		 for(var target of document.querySelectorAll('.manPicture')){
			 var id = $('.teaid').text();
			
	          console.log(id);
			 target.style.backgroundImage="url('"+contextPath+"/mteacher/getPicture.go?id="+id+"')";
			 target.style.backgroundPosition="center";
			 target.style.backgroundRepeat="no-repeat";
			 target.style.backgroundSize="cover";
		}
	}
	
	</script>

	<script>
	 function deletetea_go(deteaid) {
		 
		 
		 
		 var id = $('.teaid').text();
		 console.log(id);
	
		
//			var id=$('td eq:0',stuid).val();
//			console.log(id);
		//var id = $('input[name="id"]').val(); 
		
		/*   var id= $(stuid).find('id');
		console.log(id); */
		Swal.fire({
			  title: '강사를 삭제하시겠습니까?',
			  text: "삭제하시면 다시 복구시킬 수 없습니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '삭제',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
				  
				   Swal.fire({
					  icon: 'success',
				  title: '삭제 되었습니다'
					}).then((result) => {
						if (result.isConfirmed){
							$.ajax({
								url : "removeteacher.go",
								type : "POST",
								data : {
									"id" : id
								},
								success : function(data) {
									
									//alert("삭제되었습니다.")
									window.location.reload();
									
								},
								error : function(error) {
									//alert("error : " + error.status);
								},
							});
						}
					})
			  }else{
				  Swal.fire({
					  icon: 'error',
					  title: '취소하셨습니다',
					  showConfirmButton: false,
					  timer: 1500
					})
			  }
			})
				  
		
	
	}
	
	
	</script>




	<script>
	function time(timeValue){ //Handlbars에 날짜출력함수 등록
     var dateObj=new Date(timeValue);
     var year=dateObj.getFullYear();
     var month=dateObj.getMonth()+1;
     if(month<10){
    	 month="0"+month;
     }
   
     var date=dateObj.getDate();
     if(date<10){
    	 date="0"+date;
     }
     return year+"/"+month+"/"+date;


}
</script>


	<script>
	//select onchange할때마다 후기평 바뀜
  function myListener(obj) {        
	
	var classCode=$(obj).val();
	
	console.log(classCode)
	
	
	//selectbox 로 바꿀때  리스트 바꾸기 classcode로
	$.ajax({
		
		url:"reviewchange.go",
		type:"POST",
		async:false,
		
		data:{
			"classCode":classCode
		},
		success:function(data){
			console.log(data);
			printData(data,$('#class-reviewlist-template'),$('#class-alllist-template'));
			onloadStar2(data);
			
			
			
		},
		error:function(){
		
	},
	dataType:"json"
		
		
	});
	//selectbox 로 바꿀때 별점  classcode로 받아서
	var allavgstar=$('.allavgstar');
	//allavgstar.empty();
	var asa=$('.asa');
	$.ajax({
		
		url:"classnameavgstar.go",
		type:"POST",
		async:false,
		
		data:{
			"classCode":classCode
		},
		success:function(data){
			console.log("data : " + data.avg5);
			onloadStar(data.avg5);
 			asa.text(data.avg5);
 			
			
		},
		error:function(){
		
	},
	dataType:"json"
		
		
	});
	
	
}




	</script>

<script>
function onloadStar(event) {   
	var starRating3 = raterJs( {
		max:5, 
		readOnly:true, 
		rating:parseFloat(event), 
		element:document.querySelector(".allavgstar")
	}); 
}

function onloadStar2(data) {
	for(var i=0;i<data.length;i++){
		console.log("for" + data[i].starScore);
		var starRating3 = raterJs( {
			max:5, 
			readOnly:true, 
			rating:parseFloat(data[i].starScore), 
			element:document.querySelectorAll("#reviewScoreRater")[i]
		}); 
	}
}
//window.addEventListener("load", onload, false); 

</script>




</body>