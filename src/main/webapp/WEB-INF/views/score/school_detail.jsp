<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="korList" value="${subjectMap.korList }"></c:set>
<c:set var="mathList" value="${subjectMap.mathList }"></c:set>
<c:set var="socialList" value="${subjectMap.socialList }"></c:set>
<c:set var="scienceList" value="${subjectMap.scienceList }"></c:set>
<c:set var="engList" value="${subjectMap.engList }"></c:set>

<c:set var="fuUni" value="${uniMap.fuUni }"></c:set>
<c:set var="suUni" value="${uniMap.suUni }"></c:set>
<c:set var="tuUni" value="${uniMap.tuUni }"></c:set>




<head>
	<link href="<%=request.getContextPath() %>/resources/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
	<script src="<%=request.getContextPath() %>/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
	<script>

	// 학교성적 chart list
	// 국어
	 var options = {
	    series: [{
		    data: [
		    	<fmt:formatNumber value="${subjectMap.korAvg}" pattern=".0"/>, ${fuUni.universityKorScore}, ${suUni.universityKorScore}, ${tuUni.universityKorScore}
		    ]
	    }],
	    chart: {
	    height: 250,
	    width: 340,
	    type: 'bar',
	  },
	  title: {
	    text: '희망대학 목표점수 비교',
	    align: 'left'
	  },
	  plotOptions: {
	    bar: {
	      columnWidth: '45%',
	      distributed: true,
	    }
	  },
	  dataLabels: {
	    enabled: false
	  },
	  legend: {
	    show: false
	  },
	  xaxis: {
	    categories: [
	      ['내점수'],
	      ['${member.fuUni}'],
	      ['${member.suUni}'],
	      ['${member.tuUni}']

	    ],
	    labels: {
	      style: {
	        fontSize: '12px'
	      }
	    }
	  },
	  yaxis: {
	    	max: 100
	    }
	  };

	  var chart = new ApexCharts(document.querySelector("#kor_chart"), options);
	  chart.render();


	// 국어 성적 추이
	var options = {
	    series: [{
	    name: '${member.name}',
	      data: [
	    	  <c:forEach items="${korList }" var="kor">
				${kor.myscore},
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
			'${kor.schoolYear}년도 ${kor.testName}',
    	  	</c:forEach>
	    ],
	    labels: {
    	  show: false,
       },
  	 },
	  yaxis: {
	    	max: 100, min :0
	    }
   };

	  var chart = new ApexCharts(document.querySelector("#kor_line_chart"), options);
	  chart.render();


	// 영어
	  var options = {
	    series: [{
	    data: [<fmt:formatNumber value="${subjectMap.engAvg}" pattern=".0"/>, ${fuUni.universityEngScore}, ${suUni.universityEngScore}, ${tuUni.universityEngScore}]
	  }],
	    chart: {
	    height: 250,
	    width: 340,
	    type: 'bar'
	  },
	  title: {
	    text: '희망대학 목표점수 비교',
	    align: 'left'
	  },
	  plotOptions: {
	    bar: {
	      columnWidth: '45%',
	      distributed: true,
	    }
	  },
	  dataLabels: {
	    enabled: false
	  },
	  legend: {
	    show: false
	  },
	  xaxis: {
	    categories: [
	    	['내점수'],
		      ['${member.fuUni}'],
		      ['${member.suUni}'],
		      ['${member.tuUni}']
	    ],

	    labels: {
	      style: {
	        fontSize: '12px'
	      }
	    }
	  },
	  yaxis: {
	    	max: 100,min :0
	    }
	  };

	  var chart = new ApexCharts(document.querySelector("#eng_chart"), options);
	  chart.render();


	// 영어 성적 추이
	  var options = {
			  series: [{
				  name: '${member.name}',
				  data: [
					  <c:forEach items="${engList }" var="eng">
						${eng.myscore},
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
						'${eng.schoolYear}년도 ${eng.testName}',
			    	  	</c:forEach>
				  ],
				  labels: {
			    	  show: false,
			       },
			  },
			  yaxis: {
			    	max: 100,min :0
			    }
	  };

	  var chart = new ApexCharts(document.querySelector("#eng_line_chart"), options);
	  chart.render();

	// 수학
	  var options = {
			  series: [{
				  data: [<fmt:formatNumber value="${subjectMap.mathAvg}" pattern=".0"/>, ${fuUni.universityMathScore}, ${suUni.universityMathScore}, ${tuUni.universityMathScore}
				  ]}],
			  chart: {
				  height: 250,
				  width: 340,
				  type: 'bar',
				  events: {
					  click: function(chart, w, e) {
						  // console.log(chart, w, e)
					  }
				  }
			  },
			  title: {
			    text: '희망대학 목표점수 비교',
			    align: 'left'
			  },
			  plotOptions: {
				  bar: {
					  columnWidth: '45%',
					  distributed: true,
				  }
			  },
			  dataLabels: {
				  enabled: false
			  },
			  legend: {
				  show: false
			  },
			  xaxis: {
				  categories: [
					  ['내점수'],
				      ['${member.fuUni}'],
				      ['${member.suUni}'],
				      ['${member.tuUni}']
				  ],
				  labels: {
					  style: {
						  fontSize: '12px'
					  }
				  }
		  },
		  yaxis: {
		    	max: 100,min :0
		    }
	  };

	  var chart = new ApexCharts(document.querySelector("#math_chart"), options);
	  chart.render();


	// 수학 성적 추이
	  var options = {
			  series: [{
				  name: '${member.name}',
				  data: [
					  <c:forEach items="${mathList }" var="math">
						${math.myscore},
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
						'${math.schoolYear}년도 ${math.testName}',
			    	  	</c:forEach>
				  ],
				  labels: {
			    	  show: false,
			       },
			  },
			  yaxis: {
			    	max: 100,min :0
			    }
	  };

	  var chart = new ApexCharts(document.querySelector("#math_line_chart"), options);
	  chart.render();

	// 사회
	  var options = {
			  series: [{
				  data: [<fmt:formatNumber value="${subjectMap.socialAvg}" pattern=".0"/>, ${fuUni.universitySocialScore}, ${suUni.universitySocialScore}, ${tuUni.universitySocialScore}]
			  }],
			  chart: {
				  height: 250,
				  width: 340,
				  type: 'bar',
				  events: {
					  click: function(chart, w, e) {
						  // console.log(chart, w, e)
					  }
				  }
			  },
			  plotOptions: {
				  bar: {
					  columnWidth: '45%',
					  distributed: true,
				  }
			  },
			  title: {
			    text: '희망대학 목표점수 비교',
			    align: 'left'
			  },
			  dataLabels: {
				  enabled: false
			  },
			  legend: {
				  show: false
			  },
			  xaxis: {
				  categories: [
					  ['내점수'],
				      ['${member.fuUni}'],
				      ['${member.suUni}'],
				      ['${member.tuUni}']
				  ],
				  labels: {
					  style: {
						  fontSize: '12px'
					  }
				  }
			  },
			  yaxis: {
		    	max: 50,min :0
		      }
	  };

	  var chart = new ApexCharts(document.querySelector("#social_chart"), options);
	  chart.render();


	// 사회 성적 추이
	  var options = {
			  series: [{
				  name: '${member.name}',
				  data: [
					  <c:forEach items="${socialList }" var="social">
						${social.myscore},
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
						'${social.schoolYear}년도 ${social.testName}',
			    	  	</c:forEach>
				  ],
				  labels: {
			    	  show: false,
			       },
			  },
			  yaxis: {
			    	max: 50,min :0
			    }
	  };

	  var chart = new ApexCharts(document.querySelector("#social_line_chart"), options);
	  chart.render();

	// 과학
	  var options = {
			  series: [{
				  data: [<fmt:formatNumber value="${subjectMap.scienceAvg}" pattern=".0"/>, ${fuUni.universityScienceScore}, ${suUni.universityScienceScore}, ${tuUni.universityScienceScore}]
			  }],
			  chart: {
				  height: 250,
				  width: 340,
				  type: 'bar',
				  events: {
					  click: function(chart, w, e) {
						  // console.log(chart, w, e)
					  }
				  }
			  },
			  title: {
			    text: '희망대학 목표점수 비교',
			    align: 'left'
			  },
			  plotOptions: {
				  bar: {
					  columnWidth: '45%',
					  distributed: true,
				  }
			  },
			  dataLabels: {
				  enabled: false
			  },
			  legend: {
				  show: false
			  },
			  xaxis: {
				  categories: [
					  ['내점수'],
				      ['${member.fuUni}'],
				      ['${member.suUni}'],
				      ['${member.tuUni}']
				  ],
				  labels: {
					  style: {
						  fontSize: '12px'
					  }
				  }
			  },
			  yaxis: {
			    	max: 50,min :0
			    }
	  };

	  var chart = new ApexCharts(document.querySelector("#science_chart"), options);
	  chart.render();


	// 과학 성적 추이
	  var options = {
			  series: [{
				  name: '${member.name}',
				  data: [
					  <c:forEach items="${scienceList }" var="science">
						${science.myscore},
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
						'${science.schoolYear}년도 ${science.testName}',
			    	  	</c:forEach>
				  ],labels: {
			    	  show: false,
			       },
			  },
			  yaxis: {
			    	max: 50,min :0
			    }
	  };

	  var chart = new ApexCharts(document.querySelector("#science_line_chart"), options);
	  chart.render();
	</script>

<script type="text/javascript">
var card = $('body').find('.card');
$(function(){
	setScoreInfoTable();
	$(top.document).find('#the_iframe').css('height', parseInt(card.css('height').split('px')[0]) + 200 + 'px' );
})

$("#scoreInfoSelect").on("change", function(){
	setScoreInfoTable();
	$(top.document).find('#the_iframe').css('height', parseInt(card.css('height').split('px')[0]) + 200 + 'px');
});



function setScoreInfoTable(){
	var scoreInfo = $('#scoreInfoSelect').val();

	var schoolYear = scoreInfo.split("/")[0];
	var schoolTerm = scoreInfo.split("/")[1].split('학기')[0];
	var testName = scoreInfo.split("/")[1];
	var id = "${member.id}"

	//ajax로 데이터 불러와서 리스트 출력하기
	$.ajax({
		type: "GET",
		url:"getScoreList.go",
		data : {
			'schoolYear' : schoolYear,
			'testName' : testName,
			'id' : id
		},
		success : function(result){
			if(result.length == 0){
				$('#scoreInfoTable').find('tbody').empty();
				var td = "<td colspan=7 style='height:47px; vertical-align: middle; ' class='border-bottom'>데이터가 존재하지 않습니다</td>"
				$('#scoreInfoTable').find('tbody').append(td)
			}else{
				printData(result, $('#scoreInfoTable').find('tbody'), $('#print-scoreInfo-template'));
			}

		}
	});

}


$('#scoreInputModal').on('show.bs.modal', function (e) {
	var v_selected = $('#score-table-option').val();

	var schoolYear = v_selected.split("/")[0];
	var testName = v_selected.split("/")[1];

	getTableListAjax(schoolYear, testName, '${member.id}');
})

var isReload = false;
$('#scoreInputModal').on('hidden.bs.modal', function (e) {

	//데이터 변경시 reload
	if(isReload){
		location.reload();
	}

    $('#scoreTable').find('tbody').empty();

})

function modifyTr(btn){
	var tr = $(btn).parents('tr');

	var sscode = tr.attr('data-code');

	//데이터 수정
	var subjectCode = tr.find('select[name=subjectCode]').val();
	var perfectScore = tr.find('select[name=perfectScore]').val();
	var myscore = tr.find('input[name=myscore]').val();
	var achievement = tr.find('select[name=achievement]').val();
	var mygrade = tr.find('select[name=mygrade]').val();
	var rank = tr.find('input[name=rank]').val();
	var stucnt = tr.find('input[name=stucnt]').val();
	var standardScore = tr.find('input[name=standardScore]').val();


	var v_selected = $('#score-table-option').val();
	var schoolYear = v_selected.split("/")[0];
	var schoolTerm = v_selected.split("/")[1].split('학기')[0];
	var testName = v_selected.split("/")[1];

	//중복과목 체크
	var siblingTr = tr.siblings('tr').find('select[name=subjectCode]');
	for(var i=0; i<siblingTr.length; i++){
		var s_subCode = siblingTr.eq(i).val();
		if(subjectCode == s_subCode){
			//중복!
			Swal.fire({
			  icon: 'warning',
			  title: 'Oops...',
			  text: '이미 존재하는 과목 데이터는 입력할 수 없습니다!'
			})
			return;
		}
	}

	$.ajax({
		type: "GET",
		url:"modifyScoreData.go",
		data : {
			'sscode' : sscode,
			'subjectCode' : subjectCode,
			'perfectScore' : perfectScore,
			'myscore' : myscore,
			'achievement' : achievement,
			'mygrade' : mygrade,
			'rank' : rank,
			'stucnt' : stucnt,
			'standardScore' : standardScore,
			'id' : '${member.id}',
			'schoolYear' : schoolYear,
			'schoolTerm' : schoolTerm,
			'testName' : testName
		},
		success : function(){
			//정상 수정되었습니다
			Swal.fire({
			  icon: 'success',
			  title: 'success',
			  text: '데이터가 정상적으로 수정되었습니다'
			})
			isReload = true;
		}
	});
}


function removeTr(btn){
	var tr = $(btn).parents('tr');
	var sscode = tr.attr('data-code');
	if(!sscode){
		$(btn).parents('tr').remove();
		return;
	}

	//Tr데이터 삭제
	$.ajax({
		type: "GET",
		url:"removeScoreData.go",
		data : {
			'sscode' : sscode
		},
		success : function(result){
			Swal.fire({
			  icon: 'success',
			  title: 'success',
			  text: '데이터가 정상적으로 삭제되었습니다'
			})
			$(btn).parents('tr').remove();
			isReload = true;
		}
	});


}

function saveTr(btn){
	var tr = $(btn).parents('tr');
	//중복과목 체크

	//과목
	var subjectCode = tr.find('select[name=subjectCode]').val();
	var perfectScore = tr.find('select[name=perfectScore]').val();
	var myscore = tr.find('input[name=myscore]').val();
	var achievement = tr.find('select[name=achievement]').val();
	var mygrade = tr.find('select[name=mygrade]').val();
	var rank = tr.find('input[name=rank]').val();
	var stucnt = tr.find('input[name=stucnt]').val();
	var standardScore = tr.find('input[name=standardScore]').val();


	var v_selected = $('#score-table-option').val();
	var schoolYear = v_selected.split("/")[0];
	var schoolTerm = v_selected.split("/")[1].split('학기')[0];
	var testName = v_selected.split("/")[1];

	if(myscore == "" || rank =="" || stucnt == "" || standardScore == ""){
		//alert('모든 양식을 입력해주세요');
		Swal.fire({
		  icon: 'warning',
		  title: 'Oops...',
		  text: '모든 양식을 입력해주세요!'
		})
		return;
	}

	//중복과목 체크
	var siblingTr = tr.siblings('tr').find('select[name=subjectCode]');
	for(var i=0; i<siblingTr.length; i++){
		var s_subCode = siblingTr.eq(i).val();
		if(subjectCode == s_subCode){
			//중복!
			Swal.fire({
			  icon: 'warning',
			  title: 'Oops...',
			  text: '이미 존재하는 과목 데이터는 입력할 수 없습니다!'
			})
			return;
		}
	}

	//Tr데이터 저장 후
	$.ajax({
		type: "GET",
		url:"insertScoreData.go",
		data : {
			'subjectCode' : subjectCode,
			'perfectScore' : perfectScore,
			'myscore' : myscore,
			'achievement' : achievement,
			'mygrade' : mygrade,
			'rank' : rank,
			'stucnt' : stucnt,
			'standardScore' : standardScore,
			'id' : '${member.id}',
			'schoolYear' : schoolYear,
			'schoolTerm' : schoolTerm,
			'testName' : testName
		},
		success : function(code){
			Swal.fire({
			  icon: 'success',
			  title: 'success',
			  text: '데이터가 정상적으로 입력되었습니다'
			})
			tr.attr('data-code', code);

			var modifyBtn = '<button onclick="modifyTr(this)" class="btn btn-sm btn-info"><i class="uil uil-pen font-size-16"></i></button>';
			$(btn).before(modifyBtn);
			$(btn).remove();

			isReload = true;
		}
	});




}

function addFormBtn(){
	var template=Handlebars.compile($('#add-scoreForm-template').html());
	var html = template();
	$('#scoreTable').find('tbody').append(html);
}


$("#score-table-option").on("change", function(){
    var v_selected = $(this).val();
    //년도, 시험이름
    var schoolYear = v_selected.split("/")[0];
    var testName = v_selected.split("/")[1];
	var id = '${member.id }';

	getTableListAjax(schoolYear, testName, id)

});

function getTableListAjax(schoolYear, testName, id){
	 //ajax로 데이터 불러와서 리스트 출력하기
	$.ajax({
		type: "GET",
		url:"getScoreList.go",
		data : {
			'schoolYear' : schoolYear,
			'testName' : testName,
			'id' : id
		},
		success : function(result){
			printData(result, $('#scoreTable').find('tbody'), $('#print-scoreForm-template'));
		}
	});

}

Handlebars.registerHelper('ifCond', function(v1, v2, options) {
  if(v1 == v2) {
    return options.fn(this);
  }
  return options.inverse(this);
});


</script>

<script type="text/x-handlebars-template" id="print-scoreInfo-template">
{{#each .}}
	<tr data-code="{{sscode}}">
	  <td>
		{{#ifCond subjectCode 1}} 국어 {{/ifCond}}
		{{#ifCond subjectCode 2}} 수학 {{/ifCond}}
		{{#ifCond subjectCode 3}} 사회 {{/ifCond}}
		{{#ifCond subjectCode 4}} 과학 {{/ifCond}}
		{{#ifCond subjectCode 5}} 영어 {{/ifCond}}
	  </td>
	  <td>{{perfectScore}}</td>
	  <td>{{myscore}}</td>
	  <td>{{achievement}}</td>
	  <td>{{mygrade}}</td>
	  <td>{{rank}}&nbsp;/&nbsp;{{stucnt}}</td>
	  <td>{{standardScore}}</td>
	</tr>
{{/each}}
</script>

<script type="text/x-handlebars-template" id="print-scoreForm-template">
{{#each .}}
	<tr data-code="{{sscode}}">
		<td>
		  <select name="subjectCode" class="form-select" style="width:70px">
		     <option {{#ifCond subjectCode 1}} selected {{/ifCond}} value="1">국어</option>
		     <option {{#ifCond subjectCode 5}} selected {{/ifCond}} value="5">영어</option>
		     <option {{#ifCond subjectCode 2}} selected {{/ifCond}} value="2">수학</option>
		     <option {{#ifCond subjectCode 3}} selected {{/ifCond}} value="3">사회</option>
		     <option {{#ifCond subjectCode 4}} selected {{/ifCond}} value="4">과학</option>
		   </select>
		</td>
		<td>
		  <select name="perfectScore" class="form-select" style="width: 70px">
		    <option {{#ifCond perfectScore 100}}selected{{/ifCond}}>100</option>
		    <option {{#ifCond perfectScore 50}}selected{{/ifCond}}>50</option>
		  </select>
		</td>
		<td>
		  <input name="myscore" class="form-control" type="text" style="width: 50px;" value="{{myscore}}">
		</td>
		<td>
		  <select name="achievement" class="form-select" style="width: 60px;">
		    <option {{#ifCond achievement 'A'}} selected {{/ifCond}}>A</option>
		    <option {{#ifCond achievement 'B'}} selected {{/ifCond}}>B</option>
		    <option {{#ifCond achievement 'C'}} selected {{/ifCond}}>C</option>
		    <option {{#ifCond achievement 'D'}} selected {{/ifCond}}>D</option>
		    <option {{#ifCond achievement 'F'}} selected {{/ifCond}}>F</option>
		  </select>
		</td>
		<td>
		  <select name="mygrade" class="form-select" style="width: 60px;">
		    <option {{#ifCond mygrade 1}} selected {{/ifCond}}>1</option>
		    <option {{#ifCond mygrade 2}} selected {{/ifCond}}>2</option>
		    <option {{#ifCond mygrade 3}} selected {{/ifCond}}>3</option>
		    <option {{#ifCond mygrade 4}} selected {{/ifCond}}>4</option>
		    <option {{#ifCond mygrade 5}} selected {{/ifCond}}>5</option>
		    <option {{#ifCond mygrade 6}} selected {{/ifCond}}>6</option>
		    <option {{#ifCond mygrade 7}} selected {{/ifCond}}>7</option>
		    <option {{#ifCond mygrade 8}} selected {{/ifCond}}>8</option>
		    <option {{#ifCond mygrade 9}} selected {{/ifCond}}>9</option>
		  </select>
		</td>
		<td>
		  <div class="row">
		    <div class="col-5">
		      <input name="rank" type="text" class="form-control" style="width: 50px;" value="{{rank}}">
		    </div>
		    <div class="col-2" style="padding-top: 5px;">/</div>
		    <div class="col-5">
		      <input name="stucnt" type="text" class="form-control" style="width: 50px;" value="{{stucnt}}">
		    </div>
		  </div>
		</td>
		<td >
		  <input name="standardScore" class="form-control" type="text" style="width: 50px;" value="{{standardScore}}">
		</td>
		<td style="width: 50px;">
		  <div class="d-flex flex-wrap gap-2">
		      <button onclick="modifyTr(this)" class="btn btn-sm btn-info"><i class="uil uil-pen font-size-16"></i></button>
			  <button onclick="removeTr(this)" class="btn btn-sm btn-danger"><i class="uil uil-trash-alt font-size-16"></i></button>
          </div>
		</td>
	</tr>
{{/each}}
</script>
<script type="text/x-handlebars-template" id="add-scoreForm-template">
	<tr>
		<td>
		  <select name="subjectCode" class="form-select" style="width:70px">
		     <option value="1">국어</option>
		     <option value="5">영어</option>
		     <option value="2">수학</option>
		     <option value="3">사회</option>
		     <option value="4">과학</option>
		   </select>
		</td>
		<td>
		  <select name="perfectScore" class="form-select" style="width: 70px">
		    <option>100</option>
		    <option>50</option>
		  </select>
		</td>
		<td>
		  <input name="myscore" class="form-control" type="text" style="width: 50px;">
		</td>
		<td>
		  <select name="achievement" class="form-select" style="width: 60px;">
		    <option>A</option>
		    <option>B</option>
		    <option>C</option>
		    <option>D</option>
		    <option>F</option>
		  </select>
		</td>
		<td>
		  <select name="mygrade" class="form-select" style="width: 60px;">
		    <option>1</option>
		    <option>2</option>
		    <option>3</option>
		    <option>4</option>
		    <option>5</option>
		    <option>6</option>
		    <option>7</option>
		    <option>8</option>
		    <option>9</option>
		  </select>
		</td>
		<td>
		  <div class="row">
		    <div class="col-5">
		      <input name="rank" type="text" class="form-control" style="width: 50px;">
		    </div>
		    <div class="col-2" style="padding-top: 5px;">/</div>
		    <div class="col-5">
		      <input name="stucnt" type="text" class="form-control" style="width: 50px;">
		    </div>
		  </div>
		</td>
		<td >
		  <input name="standardScore" class="form-control" type="text" style="width: 50px;">
		</td>
		<td style="width: 50px;">
   		  <div class="d-flex flex-wrap gap-2">
			  <button onclick="saveTr(this)" class="btn btn-sm btn-primary saveTrBtn"><i class="uil uil-check font-size-16"></i></button>
			  <button onclick="removeTr(this)" class="btn btn-sm btn-danger"><i class="uil uil-trash-alt font-size-16"></i></button>
          </div>
		</td>
	</tr>
</script>

<!-- 모의지원  -->
<script type="text/javascript">
var analysis_uni = 'fuUni';
function analysisBtn(target){
	analysis_uni = target;
	settingAnalysis();
}

$("#switch").on('click', function() {
	settingAnalysis();
});

function settingAnalysis(){

	if ($("#switch").is(":checked")) {
	     //alert('점수');
	     $('#prediction_kor').text('<fmt:formatNumber value="${subjectMap.korAvg}" pattern="0.0"/>점');
	     $('#prediction_eng').text('<fmt:formatNumber value="${subjectMap.engAvg}" pattern="0.0"/>점');
	     $('#prediction_math').text('<fmt:formatNumber value="${subjectMap.mathAvg}" pattern="0.0"/>점');
	     $('#prediction_social').text('<fmt:formatNumber value="${subjectMap.socialAvg}" pattern="0.0"/>점');
	     $('#prediction_science').text('<fmt:formatNumber value="${subjectMap.scienceAvg}" pattern="0.0"/>점');

	     if(analysis_uni == "fuUni"){
		  $('#uni_name').text('${fuUni.universityName} 합격자');
	      $('#uni_kor').text('<fmt:formatNumber value="${fuUni.universityKorScore}" pattern="0.0"/>점')
	      $('#uni_eng').text('<fmt:formatNumber value="${fuUni.universityEngScore}" pattern="0.0"/>점')
	      $('#uni_math').text('<fmt:formatNumber value="${fuUni.universityMathScore}" pattern="0.0"/>점')
	      $('#uni_social').text('<fmt:formatNumber value="${fuUni.universitySocialScore}" pattern="0.0"/>점')
	      $('#uni_science').text('<fmt:formatNumber value="${fuUni.universityScienceScore}" pattern="0.0"/>점')
	     }
	     if(analysis_uni == "suUni"){
		  $('#uni_name').text('${suUni.universityName} 합격자');
	      $('#uni_kor').text('<fmt:formatNumber value="${suUni.universityKorScore}" pattern="0.0"/>점')
	      $('#uni_eng').text('<fmt:formatNumber value="${suUni.universityEngScore}" pattern="0.0"/>점')
	      $('#uni_math').text('<fmt:formatNumber value="${suUni.universityMathScore}" pattern="0.0"/>점')
	      $('#uni_social').text('<fmt:formatNumber value="${suUni.universitySocialScore}" pattern="0.0"/>점')
	      $('#uni_science').text('<fmt:formatNumber value="${suUni.universityScienceScore}" pattern="0.0"/>점')
	     }
	     if(analysis_uni == "tuUni"){
		  $('#uni_name').text('${tuUni.universityName} 합격자');
	      $('#uni_kor').text('<fmt:formatNumber value="${tuUni.universityKorScore}" pattern="0.0"/>점')
	      $('#uni_eng').text('<fmt:formatNumber value="${tuUni.universityEngScore}" pattern="0.0"/>점')
	      $('#uni_math').text('<fmt:formatNumber value="${tuUni.universityMathScore}" pattern="0.0"/>점')
	      $('#uni_social').text('<fmt:formatNumber value="${tuUni.universitySocialScore}" pattern="0.0"/>점')
	      $('#uni_science').text('<fmt:formatNumber value="${tuUni.universityScienceScore}" pattern="0.0"/>점')
	     }

	   } else {
	     //alert('등급');
	     $('#prediction_kor').text('<fmt:formatNumber value="${subjectMap.korGradeAvg}" pattern="0.0"/>등급');
	     $('#prediction_eng').text('<fmt:formatNumber value="${subjectMap.engGradeAvg}" pattern="0.0"/>등급');
	     $('#prediction_math').text('<fmt:formatNumber value="${subjectMap.mathGradeAvg}" pattern="0.0"/>등급');
	     $('#prediction_social').text('<fmt:formatNumber value="${subjectMap.socialGradeAvg}" pattern="0.0"/>등급');
	     $('#prediction_science').text('<fmt:formatNumber value="${subjectMap.scienceGradeAvg}" pattern="0.0"/>등급');


	     if(analysis_uni == "fuUni"){
			  $('#uni_name').text('${fuUni.universityName} 합격자');
		      $('#uni_kor').text('${fuUni.universityKor}등급')
		      $('#uni_eng').text('${fuUni.universityEng}등급')
		      $('#uni_math').text('${fuUni.universityMath}등급')
		      $('#uni_social').text('${fuUni.universitySocial}등급')
		      $('#uni_science').text('${fuUni.universityScience}등급')
	     }
	     if(analysis_uni == "suUni"){
			  $('#uni_name').text('${suUni.universityName} 합격자');
		      $('#uni_kor').text('${suUni.universityKor}등급')
		      $('#uni_eng').text('${suUni.universityEng}등급')
		      $('#uni_math').text('${suUni.universityMath}등급')
		      $('#uni_social').text('${suUni.universitySocial}등급')
		      $('#uni_science').text('${suUni.universityScience}등급')
	     }
	     if(analysis_uni == "tuUni"){
			  $('#uni_name').text('${tuUni.universityName} 합격자');
		      $('#uni_kor').text('${tuUni.universityKor}등급')
		      $('#uni_eng').text('${tuUni.universityEng}등급')
		      $('#uni_math').text('${tuUni.universityMath}등급')
		      $('#uni_social').text('${tuUni.universitySocial}등급')
		      $('#uni_science').text('${tuUni.universityScience}등급')
	     }
	   }

	settingAnayList();
}



function settingAnayList(){
	w_cnt = 0;
	d_cnt = 0;
	   
	var p_kor = $('#anay_div').find('p').eq(0);
	var p_eng = $('#anay_div').find('p').eq(1);
	var p_math = $('#anay_div').find('p').eq(2);
	var p_social = $('#anay_div').find('p').eq(3);
	var p_science = $('#anay_div').find('p').eq(4);

	//점수일때
	if ($("#switch").is(":checked")) {
		var v_prediction = $('#prediction_kor').text().split('점')[0];
		var v_uni = $('#uni_kor').text().split('점')[0];
		settingStep(v_prediction, v_uni, p_kor);

		var v_prediction = $('#prediction_eng').text().split('점')[0];
		var v_uni = $('#uni_eng').text().split('점')[0];
		settingStep(v_prediction, v_uni, p_eng);

		var v_prediction = $('#prediction_math').text().split('점')[0];
		var v_uni = $('#uni_math').text().split('점')[0];
		settingStep(v_prediction, v_uni, p_math);

		var v_prediction = $('#prediction_social').text().split('점')[0];
		var v_uni = $('#uni_social').text().split('점')[0];
		settingStep(v_prediction, v_uni, p_social);

		var v_prediction = $('#prediction_science').text().split('점')[0];
		var v_uni = $('#uni_science').text().split('점')[0];
		settingStep(v_prediction, v_uni, p_science);

	}else{
		var v_prediction = $('#prediction_kor').text().split('등급')[0];
		var v_uni = $('#uni_kor').text().split('등급')[0];
		settingStep(v_prediction, v_uni, p_kor);

		var v_prediction = $('#prediction_eng').text().split('등급')[0];
		var v_uni = $('#uni_eng').text().split('등급')[0];
		settingStep(v_prediction, v_uni, p_eng);

		var v_prediction = $('#prediction_math').text().split('등급')[0];
		var v_uni = $('#uni_math').text().split('등급')[0];
		settingStep(v_prediction, v_uni, p_math);

		var v_prediction = $('#prediction_social').text().split('등급')[0];
		var v_uni = $('#uni_social').text().split('등급')[0];
		settingStep(v_prediction, v_uni, p_social);

		var v_prediction = $('#prediction_science').text().split('등급')[0];
		var v_uni = $('#uni_science').text().split('등급 ')[0];
		settingStep(v_prediction, v_uni, p_science);

	}

	//합격 퍼센트 셋팅
	//경고 갯수당 -20% 주의 갯수당 -10%
	var v_percent = 100-(w_cnt*10 + d_cnt*20);
	$('#anay_percent').text(v_percent + '%');

}

var w_cnt = 0;
var d_cnt = 0;
function settingStep(v_prediction, v_uni, target){

	v_prediction = parseFloat(v_prediction);
	v_uni = parseFloat(v_uni);


	var str_good = '<i class="fas fa-check font-size-13"></i>&nbsp;&nbsp;적정';
	var str_warning = '<i class="fas fa-angle-up font-size-16"></i>&nbsp;&nbsp;주의';
	var str_danger = '<i class="fas fa-angle-double-up font-size-16"></i>&nbsp;&nbsp;경고';

	//점수가 없을 경우
	if(v_prediction == 0){
		d_cnt++;

		target.html('');
		target.removeClass('text-primary');
		target.removeClass('text-warning');
		target.removeClass('text-danger');
		return;
	}

	if ($("#switch").is(":checked")) {

		if(v_prediction >= v_uni){
			target.html(str_good);
			target.addClass('text-primary');
			target.removeClass('text-warning');
			target.removeClass('text-danger');
		}else if(v_uni-v_prediction < 5){
			w_cnt++;
			target.html(str_warning);
			target.removeClass('text-primary');
			target.addClass('text-warning');
			target.removeClass('text-danger');
		}else{
			d_cnt++;
			target.html(str_danger);
			target.removeClass('text-primary');
			target.removeClass('text-warning');
			target.addClass('text-danger');
		}
	}else{
		if(v_prediction <= v_uni){

			console.log(v_prediction)
			console.log(v_uni)

			target.html(str_good);
			target.addClass('text-primary');
			target.removeClass('text-warning');
			target.removeClass('text-danger');
		}else if(v_prediction-v_uni < 0.5){
			w_cnt++;
			target.html(str_warning);
			target.removeClass('text-primary');
			target.addClass('text-warning');
			target.removeClass('text-danger');
		}else{
			d_cnt++;
			target.html(str_danger);
			target.removeClass('text-primary');
			target.removeClass('text-warning');
			target.addClass('text-danger');
		}

	}

}


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
         	학교성적
         </h4>
         <button type="button"
         		<c:if test="${from ne 'student'}">
	         		onclick="javascript:location.href='<%=request.getContextPath() %>/ascore/detail.go?id=${member.id}'"
         		</c:if>
         		<c:if test="${from eq 'student'}">
         			onclick="parent.goPage('<%=request.getContextPath() %>/ascore/detail.go?id=${member.id}','S010301')"
         		</c:if>
         		class="btn btn-sm btn-secondary">
         	학원성적 보기&nbsp;&nbsp;<i class="mdi mdi-arrow-right align-middle"></i>
         </button>
     </div><!-- end card header -->
     <div class="card-body">

       <c:if test="${from eq 'student'}">
      <div class="row">
        <div class="col-5">
           <h5 class="mb-0"><i class="mdi mdi-school me-1"></i> 희망 대학</h5>
           <p style="font-size: 10px; color: gray;">* 버튼 클릭시 모의지원 가능</p>

           <div class="mb-3 row">
              <label for="example-text-input" class="col-md-2 col-form-label">1지망</label>
              <div class="col-md-8">
                  <input class="form-control" type="text" value="${member.fuUni }" id="example-text-input" disabled>
              </div>
              <div class="col-md-1">
                <button type="button" onclick="analysisBtn('fuUni')" class="btn btn-purple rounded-circle" data-bs-toggle="modal" data-bs-target=".analysis-modal"><i class="uil-angle-right-b font-size-13"></i></button>
              </div>
           </div>
           <div class="mb-3 row">
              <label for="example-text-input" class="col-md-2 col-form-label">2지망</label>
              <div class="col-md-8">
                  <input class="form-control" type="text" value="${member.suUni }" id="example-text-input" disabled>
              </div>
              <div class="col-md-1">
                <button type="button" onclick="analysisBtn('suUni')" class="btn btn-purple rounded-circle" data-bs-toggle="modal" data-bs-target=".analysis-modal"><i class="uil-angle-right-b font-size-13"></i></button>
              </div>
           </div>
           <div class="mb-3 row">
              <label for="example-text-input" class="col-md-2 col-form-label">3지망</label>
              <div class="col-md-8">
                  <input class="form-control" type="text" value="${member.tuUni }" id="example-text-input" disabled>
              </div>
              <div class="col-md-1">
                <button type="button"onclick="analysisBtn('tuUni')" class="btn btn-purple rounded-circle" data-bs-toggle="modal" data-bs-target=".analysis-modal"><i class="uil-angle-right-b font-size-13"></i></button>
              </div>
           </div>

        </div>
        <div class="col-7">
           <h5 class="mb-0"><i class="uil uil-file-search-alt me-1"></i> 합격 예측</h5>
           <p style="font-size: 10px; color: gray;">* 학교이름 클릭시 모의 지원 가능</p>

        	<div class="table-responsive">
              <table class="table mb-0" style="text-align: center;">
                  <tbody>
                      <tr>
                          <th scope="row" style="width: 100px;">
                            <h5 style="margin: 0px;"><span class="badge bg-danger">상향<i class="uil uil-arrow-up-right"></i></span></h5>
                          </th>
                          <td>
                            <c:forEach items="${predictionUniMap.top }" var="uni">
	                          	<a href="#">${uni.universityName }</a>
                            </c:forEach>
                          </td>
                      </tr>
                      <tr>
                          <th scope="row">
                            <h5 style="margin: 0px;"><span class="badge bg-success">적정<i class="uil uil-arrow-right"></i></span></h5>
                          </th>
                          <td>
                          	<c:forEach items="${predictionUniMap.mid }" var="uni">
	                          	<a href="#">${uni.universityName }</a>
                            </c:forEach>
                          </td>
                      </tr>
                      <tr>
                          <th scope="row">
                            <h5 style="margin: 0px;"><span class="badge bg-secondary">하향<i class="uil uil-arrow-down-right"></i></span></h5>
                          </th>
                          <td>
                          	<c:forEach items="${predictionUniMap.bot }" var="uni">
	                          	<a href="#">${uni.universityName }</a>
                            </c:forEach>
                          </td>
                      </tr>
                  </tbody>
              </table><!-- end table -->
          </div>



        </div>
      </div>

       <!-- 모의지원 modal -->
       <div class="modal fade analysis-modal" tabindex="-1" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none;">
         <div class="modal-dialog modal-lg modal-dialog-centered">
             <div class="modal-content">
                 <div class="modal-header">
                     <h5 class="modal-title" id="myLargeModalLabel"><i class="bx bxs-pie-chart-alt-2"></i>&nbsp;&nbsp;모의지원</h5>
                     <div class="form-check form-switch form-switch-md mb-2">
                        <input type="checkbox" id="switch" switch="none" checked/>
                        <label for="switch" data-on-label="점수" data-off-label="등급" class="mb-0"></label>
                    </div>
                 </div>
                 <div class="modal-body" style="text-align: center;">


                   <div class="row" style="margin-bottom: 14px; padding: 0px 40px;" >
                     <div class="col-5">
                       	${member.name }
                     </div>
                     <div class="col-2"></div>
                     <div id="uni_name" class="col-5">
                                                서울대학교 합격자
                     </div>
                   </div>

                   <div class="row" style="height: 250px; padding: 0px 40px;">
                     <div class="col-5 rounded-3 shadow-sm ">
                       <div class="row mt-3">
                         <div class="col-6">
	                     	<span class="badge bg-danger font-size-16">국어</span>
                         </div>
                         <div class="col-6">
                         	<p id="prediction_kor" style="text-align: left; font-weight: bold;">
                         	  <fmt:formatNumber value="${subjectMap.korAvg}" pattern="0.0"/>점
                         	</p>
                         </div>
                       </div>
                       <div class="row mt-3">
                         <div class="col-6">
	                     	<span class="badge bg-warning font-size-16">영어</span>
                         </div>
                         <div class="col-6">
                         	<p id="prediction_eng" style="text-align: left; font-weight: bold;">
                         	  <fmt:formatNumber value="${subjectMap.engAvg}" pattern="0.0"/>점
                         	</p>
                         </div>
                       </div>
                       <div class="row mt-3">
                         <div class="col-6">
	                     	<span class="badge bg-success font-size-16">수학</span>
                         </div>
                         <div class="col-6">
                         	<p id="prediction_math" style="text-align: left; font-weight: bold;">
                         	  <fmt:formatNumber value="${subjectMap.mathAvg}" pattern="0.0"/>점
                         	</p>
                         </div>
                       </div>
                       <div class="row mt-3">
                         <div class="col-6">
	                     	<span class="badge bg-info font-size-16">사회</span>
                         </div>
                         <div class="col-6">
                         	<p id="prediction_social" style="text-align: left; font-weight: bold;">
                         	  <fmt:formatNumber value="${subjectMap.socialAvg}" pattern="0.0"/>점
                         	</p>
                         </div>
                       </div>
                       <div class="row mt-3">
                         <div class="col-6">
	                     	<span class="badge bg-purple font-size-16">과학</span>
                         </div>
                         <div class="col-6">
                         	<p id="prediction_science" style="text-align: left; font-weight: bold;">
                         	  <fmt:formatNumber value="${subjectMap.scienceAvg}" pattern="0.0"/>점
                         	</p>
                         </div>
                       </div>
                     </div>
                     <div id="anay_div" class="col-2" style="height: 250px; text-align: center;">

						<p style="height: 40px; margin-top: 13px;" class="text-primary"><i class="fas fa-check font-size-13"></i>&nbsp;&nbsp;적정</p>
						<p style="height: 40px;" class="text-warning"><i class="fas fa-angle-up font-size-16"></i>&nbsp;&nbsp;주의</p>
						<p style="height: 40px;" class="text-warning"><i class="fas fa-angle-up font-size-16"></i>&nbsp;&nbsp;주의</p>
						<p style="height: 40px;" class="text-danger"><i class="fas fa-angle-double-up font-size-16"></i>&nbsp;&nbsp;경고</p>
						<p style="height: 40px;" class="text-primary"><i class="fas fa-check font-size-13"></i>&nbsp;&nbsp;적정</p>

                     </div>
                     <div class="col-5 rounded-3 shadow-sm ">
                       <div class="row mt-3">
                         <div class="col-6">
	                     	<span class="badge bg-danger font-size-16">국어</span>
                         </div>
                         <div class="col-6">
                         	<p id="uni_kor" style="text-align: left; font-weight: bold;"></p>
                         </div>
                       </div>
                       <div class="row mt-3">
                         <div class="col-6">
	                     	<span class="badge bg-warning font-size-16">영어</span>
                         </div>
                         <div class="col-6">
                         	<p id="uni_eng" style="text-align: left; font-weight: bold;"></p>
                         </div>
                       </div>
                       <div class="row mt-3">
                         <div class="col-6">
	                     	<span class="badge bg-success font-size-16">수학</span>
                         </div>
                         <div class="col-6">
                         	<p id="uni_math" style="text-align: left; font-weight: bold;"></p>
                         </div>
                       </div>
                       <div class="row mt-3">
                         <div class="col-6">
	                     	<span class="badge bg-info font-size-16">사회</span>
                         </div>
                         <div class="col-6">
                         	<p id="uni_social" style="text-align: left; font-weight: bold;"></p>
                         </div>
                       </div>
                       <div class="row mt-3">
                         <div class="col-6">
	                     	<span class="badge bg-purple font-size-16">과학</span>
                         </div>
                         <div class="col-6">
                         	<p id="uni_science" style="text-align: left; font-weight: bold;"></p>
                         </div>
                       </div>
                     </div>
                   </div>
                   <div style="margin-top: 40px; text-align : center!">
                     <h4>이 대학교를 합격할 확률은 <span id="anay_percent" style="color: red; font-weight: bold; font-size: 1.2em;">64%</span>입니다.</h4>
                   </div>


                 </div>
             </div><!-- /.modal-content -->
         </div><!-- /.modal-dialog -->
     </div>

	</c:if>

     <div class="row">
       <div class="d-flex justify-content-between mb-3">
          <select id="scoreInfoSelect" class="form-select" style="width : 300px;">
              <option value="2021/1학기중간">2021학년도 1학기 중간고사</option>
              <option value="2021/1학기기말">2021학년도 1학기 기말고사</option>
              <option value="2021/2학기중간">2021학년도 2학기 중간고사</option>
              <option value="2021/2학기기말">2021학년도 2학기 기말고사</option>

              <option value="2022/1학기중간">2022학년도 1학기 중간고사</option>
              <option value="2022/1학기기말">2022학년도 1학기 기말고사</option>
              <option value="2022/2학기중간">2022학년도 2학기 중간고사</option>
              <option value="2022/2학기기말" selected>2022학년도 2학기 기말고사</option>
          </select>

	      <c:if test="${from eq 'student'}">
          <button type="button" class="btn btn-purple w-md" data-bs-toggle="modal" data-bs-target=".input-modal"><i class="uil uil-pen"></i>&nbsp;&nbsp;성적입력</button>
	      </c:if>

          <!-- 성적 입력 modal-->
          <div id="scoreInputModal" class="modal fade input-modal" tabindex="-1" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="display: none;">
	         <div class="modal-dialog modal-xl modal-dialog-centered">
	             <div class="modal-content">
	                 <div class="modal-header">
	                     <h5 class="modal-title" id="myLargeModalLabel"><i class="uil uil-pen"></i>&nbsp;&nbsp;성적입력하기</h5>
	                 </div>
	                 <div class="modal-body" style="text-align: center;">
						<select id="score-table-option" class="form-select">
                          <option value="2021/1학기중간">2021학년도 1학기 중간고사</option>
                          <option value="2021/1학기기말">2021학년도 1학기 기말고사</option>
                          <option value="2021/2학기중간">2021학년도 2학기 중간고사</option>
                          <option value="2021/2학기기말">2021학년도 2학기 기말고사</option>

                          <option value="2022/1학기중간">2022학년도 1학기 중간고사</option>
                          <option value="2022/1학기기말">2022학년도 1학기 기말고사</option>
                          <option value="2022/2학기중간">2022학년도 2학기 중간고사</option>
                          <option value="2022/2학기기말" selected>2022학년도 2학기 기말고사</option>
                        </select>
                        <br>
	                    <div class="table-responsive">
                         <table id="scoreTable" class="table mb-0">
                             <thead>
                                 <tr>
                                     <th>과목</th>
                                     <th>만점</th>
                                     <th>원점수</th>
                                     <th>성취도</th>
                                     <th>석차등급</th>
                                     <th>석차&nbsp;/&nbsp;인원</th>
                                     <th>평균</th>
                                     <th style="width: 100px"></th>
                                 </tr>
                             </thead>
                             <tbody></tbody><!-- end tbody -->
                         </table><!-- end table -->
                         <button onclick="addFormBtn()" class="btn btn-purple mt-3"><i class="uil uil-plus font-size-16"></i>&nbsp;&nbsp;추가하기</button>
                        </div>

	                 </div>
	             </div><!-- /.modal-content -->
	         </div><!-- /.modal-dialog -->
	     </div>


       </div>
     </div>

     <div class="table-responsive">
        <table id="scoreInfoTable" class="table table-hover mb-0" style="text-align: center;">
            <thead>
                <tr>
                    <th>과목</th>
                    <th>만점</th>
                    <th>원점수</th>
                    <th>성취도</th>
                    <th>석차등급</th>
                    <th>석차&nbsp;/&nbsp;인원</th>
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
                    <div class="col-4">등급</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                    <div class="col-4">
                      <c:if test="${!empty subjectMap.korAvg}">
                    	<fmt:formatNumber value="${subjectMap.korAvg}" pattern=".00"/>
                      </c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${!empty subjectMap.korGradeAvg}">
                    	<fmt:formatNumber value="${subjectMap.korGradeAvg}" pattern=".0"/>
                      </c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${!empty subjectMap.korStandardAvg}">
                    	<fmt:formatNumber value="${subjectMap.korStandardAvg}" pattern=".00"/>
                      </c:if>
                    </div>
                  </div>

                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="kor_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="kor_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>

                </div>
                <div class="tab-pane fade" id="eng" role="tabpanel" aria-labelledby="eng-tab">
                   <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">등급</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                  	<div class="col-4">
                      <c:if test="${!empty subjectMap.engAvg}">
                    	<fmt:formatNumber value="${subjectMap.engAvg}" pattern=".00"/>
                      </c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${!empty subjectMap.engGradeAvg}">
                    	<fmt:formatNumber value="${subjectMap.engGradeAvg}" pattern=".0"/>
                      </c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${!empty subjectMap.engStandardAvg}">
                    	<fmt:formatNumber value="${subjectMap.engStandardAvg}" pattern=".00"/>
                      </c:if>
                    </div>
                  </div>

                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="eng_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="eng_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
                <div class="tab-pane fade" id="math" role="tabpanel" aria-labelledby="math-tab">
                   <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">등급</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                  	<div class="col-4">
                      <c:if test="${!empty subjectMap.mathAvg}">
                    	<fmt:formatNumber value="${subjectMap.mathAvg}" pattern=".00"/>
                      </c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${!empty subjectMap.mathGradeAvg}">
                    	<fmt:formatNumber value="${subjectMap.mathGradeAvg}" pattern=".0"/>
                      </c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${!empty subjectMap.mathStandardAvg}">
                    	<fmt:formatNumber value="${subjectMap.mathStandardAvg}" pattern=".00"/>
                      </c:if>
                    </div>
                  </div>

                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="math_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="math_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
                <div class="tab-pane fade" id="social" role="tabpanel" aria-labelledby="social-tab">
                    <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">등급</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                  	<div class="col-4">
                      <c:if test="${!empty subjectMap.socialAvg}">
                    	<fmt:formatNumber value="${subjectMap.socialAvg}" pattern=".00"/>
                      </c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${!empty subjectMap.socialGradeAvg}">
                    	<fmt:formatNumber value="${subjectMap.socialGradeAvg}" pattern=".0"/>
                      </c:if>
                    </div>
                    <div class="col-4">
                      <c:if test="${!empty subjectMap.socialStandardAvg}">
                    	<fmt:formatNumber value="${subjectMap.socialStandardAvg}" pattern=".00"/>
                      </c:if>
                    </div>
                  </div>

                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="social_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="social_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
                <div class="tab-pane fade" id="science" role="tabpanel" aria-labelledby="science-tab">
                    <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">등급</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
	                  <div class="col-4">
	                      <c:if test="${!empty subjectMap.scienceAvg}">
	                    	<fmt:formatNumber value="${subjectMap.scienceAvg}" pattern=".00"/>
	                      </c:if>
	                    </div>
	                    <div class="col-4">
	                      <c:if test="${!empty subjectMap.scienceGradeAvg}">
	                    	<fmt:formatNumber value="${subjectMap.scienceGradeAvg}" pattern=".0"/>
	                      </c:if>
	                    </div>
	                    <div class="col-4">
	                      <c:if test="${!empty subjectMap.scienceStandardAvg}">
	                    	<fmt:formatNumber value="${subjectMap.scienceStandardAvg}" pattern=".00"/>
	                      </c:if>
	                    </div>
                  </div>

                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="science_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="science_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
            </div>
        </div><!-- end col -->
    </div>



     </div><!-- end crad body -->
 </div>



