<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="school" value="${scoreData.school }"/>
<c:set var="academy" value="${scoreData.academy }"/>

<head>
	<link href="<%=request.getContextPath() %>/resources/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
	<script src="<%=request.getContextPath() %>/resources/js/main.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/libs/rater-js/index.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>
	<script type="text/javascript">


	// 학교 성적 chart
	var options = {
	  series: [{
	  name: "이전 성적",
	  data: [
		  '${school.korAfter}',
		  '${school.engAfter}',
		  '${school.mathAfter}',
		  '${school.socialAfter}',
		  '${school.scienceAfter}'
		]
	}, {
	  name: "최근 성적",
	  data: [
		  '${school.korNow}',
		  '${school.engNow}',
		  '${school.mathNow}',
		  '${school.socialNow}',
		  '${school.scienceNow}'
	  ]
	}],
	  chart: {
	  type: 'bar',
	  height: 150,
	  width: 210
	},
	plotOptions: {
	  bar: {
	    horizontal: false,
	    dataLabels: {
	      position: 'top',
	    },

	  }
	},
	dataLabels: {
	  enabled: true,
	  offsetX: 0,
	  style: {
	    fontSize: '8px',
	    colors: ['#fff']
	  }
	},
	stroke: {
	  show: true,
	  width: 1,
	  colors: ['#fff']
	},
	tooltip: {
	  shared: true,
	  intersect: false
	},
	xaxis: {
	  categories: ['국어', '영어', '수학', '사회', '과학'],
	},
	yaxis: {
    	max: 100,
    	show: false
    }
	};

	var s_chart = new ApexCharts(document.querySelector("#sch_chart"), options);

	// 학원 성적 chart

	var options = {
			series: [{
				name: "이전 성적",
				data: [
					'${academy.korAfter}',
				    '${academy.engAfter}',
				    '${academy.mathAfter}',
				    '${academy.socialAfter}',
				    '${academy.scienceAfter}'
				]
			}, {
				name: "최근 성적",
				data: [
					'${academy.korNow}',
				    '${academy.engNow}',
				    '${academy.mathNow}',
				    '${academy.socialNow}',
				    '${academy.scienceNow}'
				]
			}],
			chart: {
				type: 'bar',
				height: 150,
				width: 210
			},
			plotOptions: {
				bar: {
					horizontal: false,
					dataLabels: {
						position: 'top',
					},

				}
			},
			dataLabels: {
				enabled: true,
				offsetX: 0,
				style: {
					fontSize: '8px',
					colors: ['#fff']
				}
			},
			stroke: {
				show: true,
				width: 1,
				colors: ['#fff']
			},
			tooltip: {
				shared: true,
				intersect: false
			},
			xaxis: {
				categories: ['국어', '영어', '수학', '사회', '과학'],
			},
			yaxis: {
		    	max: 100,
		    	show: false
		    }
	};

	var a_chart = new ApexCharts(document.querySelector("#acd_chart"), options);


	function s_score(){
		$('#sch_chart').empty();
		$('#acd_chart').empty();
		s_chart.render();
	}

	function a_score(){
		$('#sch_chart').empty();
		$('#acd_chart').empty();
		a_chart.render();
	}


	</script>

	<script>
	//캘린더
	document.addEventListener("DOMContentLoaded", function () {


    /* initialize the calendar */

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();


    var defaultEvents = loadingEvents();
    //일정 불러오기
    function loadingEvents(counsel){
    	var return_value = null;

    	$.ajax({
			url:"<%=request.getContextPath()%>/consulting/calenderData.go",
			method: "get",
			contentType:'application/json',
			async: false,
			success: function(success){
				return_value = success;
			},
			error: function(error){},
			dataType: "json"
    	})
    	return return_value;
    }

    var calendarEl = document.getElementById('my_calendar');


    var calendar = new FullCalendar.Calendar(calendarEl, {
        height: 500,
        editable: false,
        droppable: false,
        selectable: true,
        initialView: 'dayGridMonth',
        themeSystem: 'bootstrap',
        dateClick: function (info) {
           //날짜 클릭
           $.ajax({
	   			url:"<%=request.getContextPath()%>/consulting/getCounseltListByDate.go",
	   			method: "get",
	   			data : {
	   				'date' : info.dateStr
	   			},
	   			success: function(result){
					if(result.length == 0){
						$('#counselt_div').empty();
						$('#counselt_div').html('<p>일정이 없습니다</p>');
						return;
					}
					//핸들바
					printData(result, $('#counselt_div'), $('#print-counselt-template'));

	   			}
       		})

        },
    	events: defaultEvents
    });
    calendar.render();


});

	</script>



<script type="text/javascript">
function goTest(examCode){


	Swal.fire({
		  title: '정말로 시험에 응시하시겠습니까?',
		  text: "응시 후에는 취소가 불가능합니다.",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  confirmButtonText: '확인',
		  cancelButtonText: '취소'
		}).then((result) => {
		  if (result.isConfirmed) {
			  Swal.fire({
				  icon: 'success',
				  title: '시험을 응시합니다'
				}).then((result) => {
					if (result.isConfirmed){
					  window.open('<%=request.getContextPath()%>/exam/detail.go?from=list&examCode='+examCode,'시험지','width=1000,height=980,left=500,top=200,location=no,status=no,scrollbars=yes');
					}
				})
		  }else{
			  Swal.fire({
				  icon: 'error',
				  title: '시험응시에 취소하셨습니다',
				  showConfirmButton: false,
				  timer: 1500
				})
		  }
		})

}
</script>

<!-- 자료실 리스트 등록 해제 -->
<script type="text/javascript">
function registLike(star_div){
	if($(star_div).find('.star-value').css('width') == '0px'){
		//등록
		 $.ajax({
            url:'<%=request.getContextPath()%>/favorite/regist.go',
            data : {
            	'lCode' : $(star_div).attr('data-lCode')
            },
            success:function(data){
            	$(star_div).find('.star-value').attr('data-fno', data.fno);
            	$(star_div).find('.star-value').css('width', '100%');
            }
        })



	}else{

		//해제
		$.ajax({
            url:'<%=request.getContextPath()%>/favorite/remove.go',
            data : {
            	'fno' : $(star_div).find('.star-value').attr('data-fno')
            },
            success:function(data){
            	$(star_div).find('.star-value').removeAttr('data-fno');
			 	$(star_div).find('.star-value').css('width', '0%');
            }
        })
	}
}

function planChk(code) {
	$.ajax({
		type: "POST", //요청 메소드 방식
		url:"<%=request.getContextPath() %>/studyplan/check.go",
		data : {
			"code" : code
		}
	});
}

$('.QR-modal').on('hidden.bs.modal', function () {
	//reload
	location.reload();
})

$('div#pictureView').css({
	'background-image' : 'url(<%=request.getContextPath()%>/member/getPicture.do?id=${loginUser.id})',
	'background-position' : 'center',
	'background-size' : 'cover',
	'background-repeat' : 'no-repeat'
});



var classColoring = [];
var classNameList = [];

function rowSpaning(num){
/* 	var num = 0; */
	var cnt = 0;
	var spanTr = "";
	var el = $('#timeTable td:eq(' + num + ')');
	var removing = "";

	var classCode = 0;

	while(el[0]){
		var tnum = 7 - $(el).parent().next().children('td').length;

		if(spanTr != ""){
			//비어있거나 이전 내용과 같지 않을때는 병합 + 삭제
			if($(el).text().trim() != "" && $(el).text().trim() == $(el).parent().next().children('td').eq(num-tnum).text().trim()){
				removing = el;
				cnt++;
			}else{
				cnt++;
				removing = el;
				classCode = $(spanTr).children('input').val();
				spanTr.attr('rowspan', cnt);

				var url = '"<%=request.getContextPath()%>/tclass/ingDetail.go?classCode=' + classCode +'","수업계획서",1000,1200';
				spanTr.attr('onclick', 'OpenWindow('+url+')');
				cnt = 0;
				spanTr = "";
			}
		}else{

			if($(el).text().trim() != ""){
				cnt++;
				spanTr = el;
				classColoring.push(spanTr[0]);
			}
		}

		//다음으로 넘어감
		el = $(el).parent().next().children('td').eq(num - tnum);

		// 정상 병합을 위한 요소 삭제
		if(removing != ""){
			removing.remove();
			removing = "";
		}

	}

}

function randomBrightColor(){
	var color_r = Math.floor(Math.random() * 127 + 128).toString(16);
    var color_g = Math.floor(Math.random() * 127 + 128).toString(16);
    var color_b = Math.floor(Math.random() * 127 + 128).toString(16);

    return "#" + color_r+color_g+color_b;
}

$(function(){


	setInterval(() => $('b.fw-semibold').text(parent.$('b.fw-semibold').text()) , 100);


	s_score();

	var classNames = [];
	var classColor = [];

//	var colorBgClass = ['table-danger','table-warning','table-info','table-success','table-light'];
	var colorBgClass = ['bg-danger','bg-warning','bg-info','bg-success','bg-light'];
	for(var i=0 ;i < 7; i++){
		rowSpaning(i);
	}
	for(var i=0; i< classColoring.length; i++){
		classNameList.push($(classColoring[i]).text().trim());
	}
	//중복제거
	for (v of classNameList) {
	  if (!classNames.includes(v)) classNames.push(v);
	}
	for(var i=0; i<classNames.length; i++){
		classColor.push(randomBrightColor());
	}


	//클래스 갯수보다 많은 수업 -> 랜덤 컬러링
	for(var i=0; i<classColoring.length; i++){
		for(var j=0; j<classNames.length; j++){
			if($(classColoring[i]).text().trim() == classNames[j]){
				if(classNames.length > colorBgClass.length){
					classColoring[i].style.backgroundColor = classColor[j]
				}else{
					$(classColoring[i]).addClass(colorBgClass[j]);
				}
			}
		}
	}

});


</script>

<script type="text/x-handlebars-template" id="print-counselt-template">
{{#each .}}
  <div class="row">
    <div class="col-6">&nbsp;&nbsp;&nbsp;{{start}} ~ {{end}}</div>
    <div class="col-6" style="text-align: center;">{{name}}</div>
  </div>
  <hr>
{{/each}}
</script>
</head>

<style type="text/css">

.fc-toolbar-title {text-align: center;}
.fc-scrollgrid {margin: 0px auto;}
.fc-toolbar-chunk:nth-child(3){display: none;}

.row>* {
    padding-right: calc(var(--bs-gutter-x) * .3);
    padding-left: calc(var(--bs-gutter-x) * .3);
}
.card{
	margin-bottom: 6px;
}

.profile-bg{
	height: 105px;
}

#timeTable td {
  	width: 100px;
  	vertical-align: middle;
}
#timeTable>:not(caption)>*>* {
    border-width: 0px;
}

.notice_title{
    width: 165px;
    padding: 0 5px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
</style>
	<div class="container-fluid">

                        <div class="mx-n4 mt-n4">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="card mb-0">
                                        <div class="card-body p-0">
                                            <div class="profile-bg position-relative overflow-hidden">
                                                <div class="bg-overlay bg-dark bg-gradient"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- end card -->
                                </div>
                            </div>
                            <!-- end row -->
                        </div>

                        <div class="row">
                            <div class="col-4">
                                <div class="card mt-n5">
                                    <div class="card-body text-center">
                                        <div class="avatar-xl mx-auto mb-4" style="height: 150px; width: 150px;">
											<div class="rounded-circle" id="pictureView" style="height: 150px; width: 150px;"></div>
                                        </div>
										<div class="d-flex mt-3">
                                            <p class="p-2 w-50" style="font-size: 1.2em; font-weight: bold;">${loginUser.name }</p>
                                            <p class="p-2 w-50 text-muted">
                                              <span class="badge rounded-pill badge-outline-purple font-size-16">${loginUser.schoolName }</span>
                                            </p>
                                        </div>
                                        <div><i class="mdi mdi-clock-time-four-outline text-muted font-size-16 align-middle me-1"></i> <span class="align-middle"><b class="fw-semibold font-size-16">10:00</b> 후 자동 로그아웃 </span></div>
                                    </div>
                                    <div class="d-flex border-top p-2">
                                        <div class="flex-grow-1">
                                          <c:if test="${empty classList}">
                                           <div class="p-2 ps-3 text-secondary">휴원</div>
                                          </c:if>
                                          <c:if test="${!empty classList}">
                                              <c:if test="${empty attend}">
	                                            <div class="p-2 ps-3 text-secondary">미출결</div>
                                              </c:if>

                                              <c:if test="${attend.attendanceStatus eq 0 or attend.attendanceStatus eq 1}">
	                                            <div class="p-2 ps-3 text-primary"><b>출석</b></div>
                                              </c:if>

                                              <c:if test="${attend.attendanceStatus eq 2}">
	                                            <div class="p-2 ps-3 text-danger"><b>결석</b></div>
                                              </c:if>

                                              <c:if test="${attend.attendanceStatus eq 3}">
	                                            <div class="p-2 ps-3 text-warning"><b>지각</b></div>
                                              </c:if>

                                              <c:if test="${attend.attendanceStatus eq 4}">
	                                            <div class="p-2 ps-3 text-purple"><b>외출</b></div>
                                              </c:if>

                                              <c:if test="${attend.attendanceStatus eq 5}">
	                                            <div class="p-2 ps-3 text-dark"><b>조퇴</b></div>
                                              </c:if>
										  </c:if>
                                        </div>
                                        <div class="flex-shrink-0">
                                            <button type="button"
                                              <c:if test="${empty classList}">
                                              	disabled
                                              </c:if>
                                            	class="btn btn-purple" data-bs-toggle="modal" data-bs-target=".QR-modal"><i class="mdi mdi-qrcode-scan me-1"></i> QR 출석체크</button>
                                        </div>
                                    </div>
                                </div>
                                <!-- end card -->


                                <!-- MODAL -->
                               <div class="modal fade QR-modal" tabindex="-1" aria-labelledby="mySmallModalLabel" style="display: none;" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered ">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title">QR 출석체크</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                                                    </button>
                                                </div>
                                                <div class="modal-body" style="text-align: center;">
                                                   <img id="QRimg" src="${qrUrl }">
                                            	</div><!-- /.modal-content -->
                                        	</div><!-- /.modal-dialog -->
                                    	</div>
								</div>


                                <div class="card">
                                    <div class="card-body">
                                        <div id="my_calendar"></div>
                                        <br>
                                        <b>상담 일정</b>
                                        <hr>
                                        <div id="counselt_div">
                                          <p>일정이 없습니다</p>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <!-- end col -->

                            <div class="col-8">
                                <div class="mt-4">
                                    <div class="row">
                                        <div class="col-7">
                                            <div class="card">
                                                <div class="card-body">


                                                <ul class="nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
		                                            <li class="nav-item">
		                                                <a class="nav-link active" data-bs-toggle="tab" href="#today1" role="tab" aria-selected="false">
		                                                    <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
		                                                    <span class="d-none d-sm-block font-size-12">오늘의 수업</span>
		                                                </a>
		                                            </li>
		                                            <li class="nav-item">
		                                                <a class="nav-link" data-bs-toggle="tab" href="#today2" role="tab" aria-selected="false">
		                                                    <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
		                                                    <span class="d-none d-sm-block font-size-12">오늘의 과제</span>
		                                                </a>
		                                            </li>
		                                            <li class="nav-item">
		                                                <a class="nav-link" data-bs-toggle="tab" href="#today3" role="tab" aria-selected="false">
		                                                    <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
		                                                    <span class="d-none d-sm-block font-size-12">오늘의 시험</span>
		                                                </a>
		                                            </li>
		                                        </ul>

		                                        <!-- Tab panes -->
		                                        <div class="tab-content text-muted">
		                                            <div class="tab-pane active" id="today1" role="tabpanel">




												<div class="row mt-3">
                                                    <div class="col-9">
	                                                    <h5 class="card-title mb-4">
	                                                    	<span class="font-size-11" style="color: gray;">
	                                                    	  &nbsp;&nbsp;&nbsp;
	                                                    	  <c:set var="now" value="<%=new java.util.Date()%>" />
	                                                    	  <fmt:formatDate value="${now }" pattern="MM월 dd일(E)"/>
	                                                    	</span>
	                                                    </h5>
                                                    </div>
                                                    <div class="col-3 text-end">
                                                      <button type="button" class="btn btn-purple btn-sm" data-bs-toggle="modal" data-bs-target=".timetable-modal">시간표</button>
                                                    </div>
                                                  </div>


                                                  <!-- 시간표 modal -->
                                                  <div class="modal fade timetable-modal" tabindex="-1" aria-labelledby="mySmallModalLabel" style="display: none;" aria-hidden="true">
			                                        <div class="modal-dialog modal-dialog-centered modal-lg">
			                                            <div class="modal-content">
			                                                <div class="modal-body" style="font-weight: bold;">

			                                                   <%--  <c:forEach items="${timeList }" var="time">
			                                                    	${time }<hr>
			                                                    </c:forEach> --%>
			                                                    <div class="table-responsive">

						                                            <table id="timeTable" class="table table-bordered mb-0" style="text-align: center;">
						                                                <thead>
						                                                    <tr>
						                                                        <th><i class="bx bx-time-five font-size-16"></i></th>
						                                                        <th style="width: 100px;">월</th>
						                                                        <th style="width: 100px;">화</th>
						                                                        <th style="width: 100px;">수</th>
						                                                        <th style="width: 100px;">목</th>
						                                                        <th style="width: 100px;">금</th>
						                                                        <th style="width: 100px;">토</th>
						                                                        <th style="width: 100px;">일</th>
						                                                    </tr>
						                                                </thead>
						                                                <tbody>
<%-- 																			<c:forEach items="09:00, 10:00, 11:00, 12:00, 13:00, 14:00, 15:00, 16:00, 17:00, 18:00, 19:00, 20:00, 21:00, 22:00" var="t">
 --%>
						                                                      <tr>
						                                                        <th scope="row">09:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '09:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }
  						                                                                <input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '09:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }
  						                                                                <input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '09:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }
  						                                                                <input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '09:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }
  						                                                                <input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '09:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }
  						                                                                <input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '09:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '09:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">10:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '10:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '10:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '10:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '10:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '10:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '10:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '10:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">11:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '11:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '11:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '11:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '11:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '11:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '11:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '11:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">12:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '12:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '12:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '12:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '12:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '12:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '12:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '12:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">13:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '13:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '13:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '13:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '13:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '13:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '13:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '13:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">14:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '14:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '14:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '14:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '14:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '14:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '14:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '14:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">15:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '15:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '15:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '15:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '15:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '15:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '15:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '15:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">16:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '16:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '16:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '16:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '16:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '16:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '16:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '16:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">17:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '17:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '17:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '17:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '17:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '17:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '17:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '17:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">18:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '18:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '18:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '18:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '18:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '18:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '18:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '18:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">19:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '19:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '19:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '19:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '19:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '19:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '19:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '19:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">20:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '21:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '20:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '20:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '20:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '20:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '20:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '20:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>
						                                                      <tr>
						                                                        <th scope="row">21:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '21:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '21:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '21:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '21:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '21:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '21:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '21:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>


						                                                      <tr>
						                                                        <th scope="row">22:00</th>
						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '22:00' }">
  						                                                              <c:if test="${time.classday eq '1'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '22:00' }">
  						                                                              <c:if test="${time.classday eq '2'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '22:00' }">
  						                                                              <c:if test="${time.classday eq '3'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '22:00' }">
  						                                                              <c:if test="${time.classday eq '4'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '22:00' }">
  						                                                              <c:if test="${time.classday eq '5'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '22:00' }">
  						                                                              <c:if test="${time.classday eq '6'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/><br>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>

						                                                        <td>
						                                                          <c:forEach items="${timeList }" var="time">
  						                                                            <c:if test="${time.startTime eq '22:00' }">
  						                                                              <c:if test="${time.classday eq '0'}">
  						                                                                ${time.className }<input type="hidden" value="${time.classCode }"/>
  						                                                              </c:if>
  						                                                            </c:if>
						                                                          </c:forEach>
						                                                        </td>
						                                                      </tr>




						                                                </tbody>
						                                            </table><!-- end table -->
						                                        </div>

			                                                </div>
			                                            </div><!-- /.modal-content -->
			                                        </div><!-- /.modal-dialog -->
			                                    </div>




													  <div class="table-responsive">
			                                            <table class="table table-hover mb-0">
			                                                <tbody>
			                                                  <c:if test="${empty classList}">
			                                                    <th colspan="2">
			                                                      	오늘 수업은 없습니다
			                                                    </th>
			                                                  </c:if>
			                                                  <c:forEach items="${classList }" var="time">
			                                                    <tr>
			                                                        <th scope="row" style="width: 10%; text-align: center; vertical-align: middle;">
			                                                          ${time.STARTTIME }
			                                                        </th>
		                                                            <c:set var="nowTime"><fmt:formatDate value="${now }" pattern="HH:mm"/></c:set>
			                                                        <td style="vertical-align: middle;">
			                                                         <p style="margin: 0px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 250px; height: 20px;">
			                                                           <c:if test="${time.STARTTIME < nowTime}">
			                                                          	 <span style="color: grey;">${time.CLASSNAME }</span>
			                                                           </c:if>
			                                                           <c:if test="${time.STARTTIME >= nowTime}">
			                                                        	 <b>${time.CLASSNAME }</b>
			                                                           </c:if>
			                                                          </p>
			                                                        </td>
			                                                    </tr>
			                                                  </c:forEach>
			                                                </tbody><!-- end tbody -->
			                                            </table><!-- end table -->
			                                        </div>
		                                            </div>

		                                            <div class="tab-pane" id="today2" role="tabpanel">
		                                              <c:if test="${empty assignList }">
		                                                <div class="row mt-3">
				                                          <div class="col-12" style="padding: 5px">&nbsp;&nbsp;오늘 과제는 없습니다</div>
				                                        </div>
		                                              </c:if>

		                                              <c:set var="flag" value="0" />
													  <c:forEach items="${assignList }" var="assign">
													    <div onclick="javascript:location.href='<%=request.getContextPath()%>/assign/detail.go?from=list&assignCode=${assign.assignCode }'"
													    	class="row <c:if test="${flag eq 0 }"><c:set var="flag" value="1"/>mt-3</c:if>">
				                                          <div class="col-10">&nbsp;&nbsp;${assign.title }</div>
				                                          <div class="col-2"><i class="mdi mdi-chevron-right align-middle"></i></div>
				                                        </div>
				                                        <hr>
													  </c:forEach>



		                                            </div>


		                                            <div class="tab-pane" id="today3" role="tabpanel">
		                                              <c:if test="${empty examList }">
		                                                <div class="row mt-3">
				                                          <div class="col-12" style="padding: 5px">&nbsp;&nbsp;오늘 시험은 없습니다</div>
				                                        </div>
		                                              </c:if>

		                                              <c:set var="flag" value="0" />
		                                              <c:forEach items="${examList }" var="exam">
														<div class="row <c:if test="${flag eq 0 }"><c:set var="flag" value="1"/>mt-3</c:if>"
															onclick="goTest('${exam.examCode}');">
				                                            <div class="col-10">&nbsp;&nbsp;${exam.examName }</div>
				                                            <div class="col-2"><i class="mdi mdi-chevron-right align-middle"></i></div>
					                                      </div>
				                                      <hr>
		                                              </c:forEach>

		                                            </div>

		                                        </div>























                                                </div>
                                                <!-- end card body -->
                                            </div>
                                            <!-- end card -->







                                  <div class="card">
                                    <div class="card-body">



                                        <div class="row align-items-start">
                                            <div class="col-sm">
                                                <div>
                                                    <i class="mdi mdi-pencil me-1"></i> 학습계획표
                                                </div>
                                            </div>

                                        </div>

                                        <div class="table-responsive mt-4 mt-sm-0">
                                            <table class="table align-middle table-nowrap table-check">
                                              <tbody>
                                                <c:forEach items="${planList }" var="plan">
	                                              <tr>
                                                    <td style="width: 50px;">
                                                      <c:if test="${plan.subjectCode eq 1 }">
					   									 <span class="badge bg-danger rounded-pill" >국어</span>
													  </c:if>
													  <c:if test="${plan.subjectCode eq 2 }">
					   									 <span class="badge bg-warning rounded-pill" >수학</span>
													  </c:if>
													  <c:if test="${plan.subjectCode eq 3 }">
					   									 <span class="badge bg-success rounded-pill" >사회</span>
													  </c:if>
													  <c:if test="${plan.subjectCode eq 4 }">
					   									 <span class="badge bg-primary rounded-pill" >과학</span>
													  </c:if>
													  <c:if test="${plan.subjectCode eq 5 }">
					   									 <span class="badge bg-purple rounded-pill" >영어</span>
													  </c:if>
                                                    </td>
                                                    <td style="width: 80%;">${plan.studyPlan }</td>
                                                    <td>
                                                       <div class="form-check font-size-16">
                                                         <input onclick="planChk(${plan.planCode })"
                                                         	${plan.studyResult eq 0 ? "" : "checked" } type="checkbox" class="form-check-input">
                                                       </div>
                                                    </td>
                                                  </tr><!-- end tr -->
												</c:forEach>
                                              </tbody><!-- end tbody -->
                                            </table><!-- end table -->
                                        </div>


                                    </div>
                                    <!-- end card body -->
                                </div>


                              </div>










                                        <div class="col-5">

		                                  <div class="card">

		                                    <div class="card-body">

		                                        <!-- Nav tabs -->
		                                        <ul class="nav nav-tabs nav-tabs-custom" role="tablist">
		                                            <li class="nav-item" onclick="s_score()">
		                                                <a class="nav-link active" data-bs-toggle="tab" href="#home1" role="tab" aria-selected="false">
		                                                    <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
		                                                    <span class="d-none d-sm-block">학교성적</span>
		                                                </a>
		                                            </li>
		                                            <li class="nav-item" onclick="a_score()">
		                                                <a class="nav-link" data-bs-toggle="tab" href="#profile1" role="tab" aria-selected="false">
		                                                    <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
		                                                    <span class="d-none d-sm-block">학원성적</span>
		                                                </a>
		                                            </li>
		                                        </ul>

		                                        <!-- Tab panes -->
		                                        <div class="tab-content text-muted">
		                                            <div class="tab-pane active" id="home1" role="tabpanel">
		                                                <div id="sch_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
		                                            </div>
		                                            <div class="tab-pane" id="profile1" role="tabpanel">
		                                                <div id="acd_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
		                                            </div>

		                                        </div>
		                                    </div><!-- end card body -->
		                                </div>
                                            <!-- end card -->


								  <!-- 자료실 -->
                                  <div class="card">
                                    <div class="card-header justify-content-between d-flex align-items-center">
                                        <h4 class="card-title"><i class="mdi mdi-archive align-middle"></i>&nbsp;&nbsp;자료실 즐겨찾기</h4>

                                    </div><!-- end card header -->
                                    <div class="card-body">

                                      <c:if test="${empty likeData }">
                                      	<p style="text-align: center; vertical-align: middle; margin: 0px;">즐겨찾기 한 항목이 없습니다</p>
                                      </c:if>

                                      <c:if test="${!empty likeData }">
                                        <c:forEach items="${likeData }" var="like">
	                                      <div style="cursor: pointer;" class="row">
	                                        <div class="col-2">
	                                          <div  data-lCode="${like.pds.lCode }" class="star-rating disabled" style="width: 22px; height: 22px; background-size: 22px;" onclick="registLike(this)">
	                                            <div data-fno="${like.fav.fno }" class="star-value" style="background-size: 22px; width: 100%;"></div>
	                                          </div>
	                                        </div>
	                                        <div class="col-9" onclick="javascript:OpenWindow('<%=request.getContextPath()%>/pds/detail.do?from=list&lCode=${like.pds.lCode }','상세보기',600,700);">${like.pds.title }
	                                          <i style="float: right;" class="mdi mdi-chevron-right align-middle"></i>
	                                        </div>
	                                      </div>
	                                      <hr>
                                        </c:forEach>
                                      </c:if>
                                    </div><!-- end card body -->
                                </div>



                                  <div class="card">
                                    <div class="card-header justify-content-between d-flex align-items-center">
                                        <h4 class="card-title"><i class="mdi mdi-information-outline"></i>&nbsp;&nbsp;공지사항</h4>
                                    </div><!-- end card header -->
                                    <div class="card-body">
                                      <c:if test="${!empty noticeList }">
                                        <c:forEach items="${noticeList }" var="notice">
										  <div class="row" style="cursor: pointer;" onclick="OpenWindow('<%=request.getContextPath()%>/notice/detail.go?from=list&lcode=${notice.lcode }&cnt=3','상세보기',800,700);">
                                            <div class="col-8 notice_title" style="width: 165px;">${notice.title }</div>
                                            <div class="col-4">
                                              <span style="font-size: 0.5em; color: gray; vertical-align: middle;">
                                                <fmt:formatDate value="${notice.regDate }" pattern="yyyy/MM/dd"/>
                                              </span>
                                            </div>
                                          </div>
                                          <hr>
                                        </c:forEach>
                                      </c:if>
                                    </div><!-- end card body -->
                                </div>




                                        </div>
                                    </div><!-- end row -->
                                </div>
                            </div><!-- end col -->
                        </div><!-- end row -->

                    </div>

