<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="korList" value="${subjectMap.korList }"/>
<c:set var="engList" value="${subjectMap.engList }"/>
<c:set var="mathList" value="${subjectMap.mathList }"/>
<c:set var="socialList" value="${subjectMap.socialList }"/>
<c:set var="scienceList" value="${subjectMap.scienceList }"/>

<c:set var="korSum" value="0"/>
<c:forEach items="${korList }" var="kor">
	<c:set var="korSum" value="${korSum + kor.ACADEMY_SCORE}"/>
</c:forEach>
<c:set var="engSum" value="0"/>
<c:forEach items="${engList }" var="eng">
	<c:set var="engSum" value="${engSum + eng.ACADEMY_SCORE}"/>
</c:forEach>
<c:set var="mathSum" value="0"/>
<c:forEach items="${mathList }" var="math">
	<c:set var="mathSum" value="${mathSum + math.ACADEMY_SCORE}"/>
</c:forEach>
<c:set var="socialSum" value="0"/>
<c:forEach items="${socialList }" var="social">
	<c:set var="korSum" value="${socialSum + social.ACADEMY_SCORE}"/>
</c:forEach>
<c:set var="scienceSum" value="0"/>
<c:forEach items="${scienceList }" var="science">
	<c:set var="scienceSum" value="${scienceSum + science.ACADEMY_SCORE}"/>
</c:forEach>
<c:set var="korAvg" value="${korSum/korList.size() }"/>
<c:set var="engAvg" value="${engSum/engList.size() }"/>
<c:set var="mathAvg" value="${mathSum/mathList.size() }"/>
<c:set var="socialAvg" value="${socialSum/socialList.size() }"/>
<c:set var="scienceAvg" value="${scienceSum/scienceList.size() }"/>


<head>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
  <script src="<%=request.getContextPath() %>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
  <script type="text/javascript">
//학원 성적

  //국어 line
  var options = {
		  series: [{
			  name: '${member.name}',
			  data: [
				  <c:forEach items="${korList }" var="kor">
				  	'${kor.ACADEMY_SCORE}',
				  </c:forEach>
			  ]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '국어 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: [
				  <c:forEach items="${korList }" var="kor">
				  	'${kor.EXAM_NAME}',
				  </c:forEach>
			  ],
			  labels: {
				  show : false
			  }

		  }
  };

  var chart = new ApexCharts(document.querySelector("#acd_kor_line_chart"), options);
  chart.render();

  //국어 영역

  var options = {
          series: [{
          name: '${member.name}',
          data: [
        	  <c:forEach items="${subAreaData.korAreaList }" var="kor">
			  	${subAreaData.korAreaScoreMap.get(kor.saname)},
			  </c:forEach>
          ],
        }],
          chart: {
		  height: 250,
		  width: 340,
          type: 'radar',
        },
        xaxis: {
          categories: [
        	  <c:forEach items="${subAreaData.korAreaList }" var="kor">
			  	'${kor.saname}',
			  </c:forEach>
          ]
        }
  };

  var chart = new ApexCharts(document.querySelector("#acd_kor_chart"), options);
  chart.render();




  //영어 line
  var options = {
		  series: [{
			  name: '${member.name}',
			  data: [
				  <c:forEach items="${engList }" var="eng">
				  	${eng.ACADEMY_SCORE},
				  </c:forEach>
			  ]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '영어 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: [
				  <c:forEach items="${engList }" var="eng">
				  	'${eng.EXAM_NAME}',
				  </c:forEach>

			  ],
			  labels: {
				  show : false
			  }
		  }
  };

  var chart = new ApexCharts(document.querySelector("#acd_eng_line_chart"), options);
  chart.render();

  //영어 영역

  var options = {
		  series: [{
			  name: 'Series 1',
			  data: [
				  <c:forEach items="${subAreaData.engAreaList }" var="area">
				  	'${subAreaData.engAreaScoreMap.get(area.sano)}',
				  </c:forEach>
			  ],
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'radar',
		  },
		  xaxis: {
			  categories: [
				  <c:forEach items="${subAreaData.engAreaList }" var="area">
				  	'${area.saname}',
				  </c:forEach>
			  ]
		  }
  };

  var chart = new ApexCharts(document.querySelector("#acd_eng_chart"), options);
  chart.render();


  //수학 line
  var options = {
		  series: [{
			  name: '${member.name}',
			  data: [
				  <c:forEach items="${mathList }" var="math">
				  	${math.ACADEMY_SCORE},
				  </c:forEach>
			  ]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '수학 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: [
				  <c:forEach items="${mathList }" var="math">
				  	'${math.EXAM_NAME}',
				  </c:forEach>
			  ],
			  labels: {
				  show : false
			  }
		  }
  };

  var chart = new ApexCharts(document.querySelector("#acd_math_line_chart"), options);
  chart.render();

  //수학 영역

  var options = {
		  series: [{
			  name: 'Series 1',
			  data: [
				  <c:forEach items="${subAreaData.mathAreaList }" var="area">
				  	'${subAreaData.mathAreaScoreMap.get(area.sano)}',
				  </c:forEach>
			  ],
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'radar',
		  },
		  xaxis: {
			  categories: [
				  <c:forEach items="${subAreaData.mathAreaList }" var="area">
				  	'${area.saname}',
				  </c:forEach>
			  ]
		  }
  };
  var chart = new ApexCharts(document.querySelector("#acd_math_chart"), options);
  chart.render();


  //사회 line
  var options = {
		  series: [{
			  name: '${member.name}',
			  data: [
				  <c:forEach items="${socialList }" var="social">
				  	${social.ACADEMY_SCORE},
				  </c:forEach>
			  ]
		  }],
		  chart: {
			  height: 250,
			  width: 680,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '사회 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: [
				  <c:forEach items="${socialList }" var="social">
				  	'${social.EXAM_NAME}',
				  </c:forEach>
			  ],
			  labels: {
				  show : false
			  }
		  }
  };

  var chart = new ApexCharts(document.querySelector("#acd_social_line_chart"), options);
  chart.render();



  //과학 line
  var options = {
		  series: [{
			  name: '${member.name}',
			  data: [
				  <c:forEach items="${scienceList }" var="science">
				  	'${science.ACADEMY_SCORE}',
				  </c:forEach>
			  ]
		  }],
		  chart: {
			  height: 250,
			  width: 680,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '과학 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: [
				  <c:forEach items="${scienceList }" var="science">
				  	'${science.EXAM_NAME}',
				  </c:forEach>
			  ],
			  labels: {
				  show : false
			  }
		  }
  };

  var chart = new ApexCharts(document.querySelector("#acd_science_line_chart"), options);
  chart.render();

  </script>

<script type="text/javascript">
$(function(){
	printScore();

});

$("#class_select").on("change", function(){
	printScore();
});



function printExamData(){
	var v_length = $('#scorePrintTable').find('tbody tr').length;

	for(var i=0; i < v_length; i++){
		var tr = $('#scorePrintTable').find('tbody tr').eq(i);
		var examCode = tr.attr('data-examCode');

		$.ajax({
			type: "GET",
			async: false,
			url:"getExamData.go",
			data : {
				'id' : '${member.id}',
				'examCode' : examCode
			},
			success : function(result){
				// 시험명
				tr.find('td').text(result.name);

				// 평균
				tr.find('th').eq(-1).text(result.avg);
			}
		});



	}

}


function printScore(){
	var classCode = $('#class_select').val();

	$.ajax({
		type: "GET",
		url:"getAcademyScoreList.go",
		data : {
			'id' : '${member.id}',
			'classCode' : classCode
		},
		success : function(result){
			if(result.length == 0){
				$('#scorePrintTable').find('tbody').empty();
				var td = "<td colspan=5 style='height:47px; vertical-align: middle; ' class='border-bottom'>데이터가 존재하지 않습니다</td>"
				$('#scorePrintTable').find('tbody').append(td)
			}else{
				printData(result, $('#scorePrintTable').find('tbody'), $('#print-score-template'));
			}

			printExamData();
		}
	});

}


function clickExam(code){
	window.open('<%=request.getContextPath()%>/exam/result.go?from=list&examCode='+code,'채점','width=1000,height=980,left=500,top=100,location=no,status=no,scrollbars=yes');

}
</script>

<script type="text/x-handlebars-template" id="print-score-template">
{{#each .}}
	<tr data-examCode="{{examCode}}" onclick="clickExam('{{examCode}}')">
      <td>-</td>
      <th>{{perfectScore}}</th>
      <th>{{academyScore}}</th>
      <th>{{achievement}}</th>
      <th>-</th>
   </tr>
{{/each}}
</script>


</head>

<style type="text/css">
.nav-pills .nav-link.active, .nav-pills .show>.nav-link{
    <c:if test="${loginUser.authority eq 'ROLE_STUDENT' }">
	    background-color: #564ab1;
    </c:if>
    <c:if test="${loginUser.authority eq 'ROLE_TEACHER' }">
	    background-color: #51d28c;
    </c:if>
    <c:if test="${loginUser.authority eq 'ROLE_MASTER' }">
	    background-color: #038edc;
    </c:if>
}

thead{
    color: white;
    font-weight: bold;

    border-color: transparent;
    <c:if test="${loginUser.authority eq 'ROLE_STUDENT' }">
	    background-color: #564ab1;
    </c:if>
    <c:if test="${loginUser.authority eq 'ROLE_TEACHER' }">
	    background-color: #51d28c;
    </c:if>
    <c:if test="${loginUser.authority eq 'ROLE_MASTER' }">
	    background-color: #038edc;
    </c:if>
}
</style>


   <div class="card">
     <div class="card-header justify-content-between d-flex align-items-center">
         <h4 class="card-title">
         	<c:if test="${from ne 'student'}">
         	  <b>${member.name }</b> 님의
         	</c:if>
         	학원성적
         </h4>
         <button
         	<c:if test="${from ne 'student'}">
         		onclick="javascript:location.href='<%=request.getContextPath() %>/sscore/detail.go?id=${member.id}'"
       		</c:if>
       		<c:if test="${from eq 'student'}">
       			onclick="parent.goPage('<%=request.getContextPath() %>/sscore/detail.go?id=${member.id}','S010300')"
       		</c:if>
         	class="btn btn-sm btn-secondary">
         	학교성적 보기&nbsp;&nbsp;<i class="mdi mdi-arrow-right align-middle"></i>
         </button>
     </div><!-- end card header -->
     <div class="card-body">



     <div class="row">
       <div class="d-flex justify-content-between mb-3">
          <select id="class_select" class="form-select" style="width : 300px;">
            <c:forEach items="${classList }" var="c">
              <option value="${c.classCode }">${c.className }</option>
            </c:forEach>
            <c:if test="${empty classList }">
              <option disabled selected value="-1">수강한 수업이 없습니다</option>
            </c:if>
          </select>
       </div>
     </div>

     <div class="table-responsive">
        <table id="scorePrintTable" class="table table-hover mb-0" style="text-align: center;">
            <thead>
                <tr>
                    <th>시험명</th>
                    <th>만점</th>
                    <th>원점수</th>
                    <th>성취도</th>
                    <th>평균</th>
                </tr>
            </thead>
            <tbody></tbody><!-- end tbody -->
        </table><!-- end table -->
      </div>

      <br><br>

      <div class="row">
        <div class="col-md-3">
            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical" style="text-align: center;">
            <a class="nav-link mb-2 active" id="kor-tab" data-bs-toggle="pill" href="#kor" role="tab" aria-controls="kor" aria-selected="true">국어</a>
            <a class="nav-link mb-2" id="eng-tab" data-bs-toggle="pill" href="#eng" role="tab" aria-controls="eng" aria-selected="false">영어</a>
            <a class="nav-link mb-2" id="math-tab" data-bs-toggle="pill" href="#math" role="tab" aria-controls="math" aria-selected="false">수학</a>
            <a class="nav-link mb-2" id="social-tab" data-bs-toggle="pill" href="#social" role="tab" aria-controls="social" aria-selected="false">사회</a>
            <a class="nav-link mb-2" id="science-tab" data-bs-toggle="pill" href="#science" role="tab" aria-controls="science" aria-selected="false">과학</a>
            </div>
        </div>
        <div class="col-md-9">
            <div class="tab-content text-muted mt-4 mt-md-0" id="v-pills-tabContent" style="text-align: center;">
                <div class="tab-pane fade show active" id="kor" role="tabpanel" aria-labelledby="kor-tab">
                  <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">성취도</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                    <div class="col-4">
                      <c:if test="${korSum ne 0}">${korAvg }</c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${korAvg >= 90 and korSum ne 0}">A</c:if>
                      <c:if test="${korAvg >= 80 and korAvg < 90}">B</c:if>
                      <c:if test="${korAvg < 80 }">C</c:if>
                      <c:if test="${korSum eq 0 }"> - </c:if>
                    </div>
                    <div class="col-4">${subjectAvgMap.korAvg }</div>
                  </div>

                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="acd_kor_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="acd_kor_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>

                </div>
                <div class="tab-pane fade" id="eng" role="tabpanel" aria-labelledby="eng-tab">
                   <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">성취도</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                    <div class="col-4">
                      <c:if test="${engSum ne 0}">${engAvg }</c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${engAvg >= 90 and engSum ne 0}">A</c:if>
                      <c:if test="${engAvg >= 80 and engAvg < 90}">B</c:if>
                      <c:if test="${engAvg < 80 }">C</c:if>
                      <c:if test="${engSum eq 0 }"> - </c:if>
                    </div>
                    <div class="col-4">${subjectAvgMap.engAvg }</div>
                  </div>

                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="acd_eng_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="acd_eng_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
                <div class="tab-pane fade" id="math" role="tabpanel" aria-labelledby="math-tab">
                   <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">성취도</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                    <div class="col-4">
                      <c:if test="${mathSum ne 0}">${mathAvg }</c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${mathAvg >= 90 and mathSum ne 0}">A</c:if>
                      <c:if test="${mathAvg >= 80 and mathAvg < 90}">B</c:if>
                      <c:if test="${mathAvg < 80 }">C</c:if>
                      <c:if test="${mathSum eq 0 }"> - </c:if>
                    </div>
                    <div class="col-4">${subjectAvgMap.mathAvg }</div>
                  </div>

                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="acd_math_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="acd_math_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
                <div class="tab-pane fade" id="social" role="tabpanel" aria-labelledby="social-tab">
                    <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">성취도</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                    <div class="col-4">
                      <c:if test="${socialSum ne 0}">${socialAvg }</c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${socialAvg >= 90 and socialSum ne 0}">A</c:if>
                      <c:if test="${socialAvg >= 80 and socialAvg < 90}">B</c:if>
                      <c:if test="${socialAvg < 80 }">C</c:if>
                      <c:if test="${socialSum eq 0 }"> - </c:if>
                    </div>
                    <div class="col-4">${subjectAvgMap.socialAvg }</div>
                  </div>

                  <div class="row mt-3">
                    <div class="col-12">
                      <div id="acd_social_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
                <div class="tab-pane fade" id="science" role="tabpanel" aria-labelledby="science-tab">
                    <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">성취도</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                    <div class="col-4">
                      <c:if test="${scienceSum ne 0}">${scienceAvg }</c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${scienceAvg >= 90 and scienceSum ne 0}">A</c:if>
                      <c:if test="${scienceAvg >= 80 and scienceAvg < 90}">B</c:if>
                      <c:if test="${scienceAvg < 80  }">C</c:if>
                      <c:if test="${scienceSum eq 0 }"> - </c:if>
                    </div>
                    <div class="col-4">${subjectAvgMap.scienceAvg }</div>
                  </div>

                  <div class="row mt-3">
                    <div class="col-12">
                      <div id="acd_science_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
            </div>
        </div><!-- end col -->
    </div>



     </div><!-- end crad body -->
</div>


