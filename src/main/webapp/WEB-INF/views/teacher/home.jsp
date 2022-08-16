<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<head>
<style type="text/css">

</style>
<script src="<%=request.getContextPath() %>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
<script type="text/javascript">
	var options = {
			  series: [${dayMap.day1}, ${dayMap.day2}, ${dayMap.day3}, ${dayMap.day4}, ${dayMap.day5}],
			  chart: {
			    height: 300,
			    type: 'pie',
			  },
			  labels: ['출근', '결근', '지각', '외출', '조퇴'],
			  legend: {
			    position: 'bottom'
			  },
			  dataLabels: {
			    dropShadow: {
			      enabled: false,
			    }
			  },
			  colors: ["#038edc", "#f34e4e", "#f7cc53", "#564ab1", "#74788d"]
			};

			var chart = new ApexCharts(document.querySelector("#chart02"), options);
			chart.render();
</script>
<script src="<%=request.getContextPath() %>/resources/js/t_calender.js"></script>

<script>  
//시간표 
var classColoring = [];
var classNameList = [];

function rowSpaning(num){
/* 	var num = 0; */
	var cnt = 0;
	var spanTr = "";
	var el = $('#timeTable td:eq(' + num + ')');
	var removing = "";


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
				spanTr.attr('rowspan', cnt);
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
	var classNames = [];
	var classColor = [];

	var colorBgClass = ['table-danger','table-warning','table-info','table-success','table-light'];
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
//오늘 요일 구하기
$(function(){
	today = new Date()  
	var week = new Array('Sun', 'Mon', 'Tues', 'Wednes', 'Thurs', 'Fri', 'Satur');
	
	var day = week[today.getDay()]
	//console.log(day);
	
	$('#'+day).attr('style','border:2px solid black;width: 200px; padding: 0px;');
	if(day=='Mon') day='월';
	if(day=='Tues') day='화';
	if(day=='Wednes') day='수';
	if(day=='Thurs') day='목';
	if(day=='Fri') day='금';
	if(day=='Satur') day='토';
	if(day=='Sun') day='일';
	$('#DayForToday').append("("+day+")");
})
</script>

<script>
//수업진도 선택
$('#classSelect').change(function(){
	//alert($(this).val());
	var cpno = $(this).val();
	var str0 = '';
	if(cpno=='none'){
		str0+='<div style="width:92%; height:15px; margin:0px auto;  margin-left:14px;" class="progress">';
		str0+='	<div class="progress-bar bg-success" role="progressbar" style="width:0%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">0%</div>';
		str0+='</div>';
		$('#progressDetailBtn').attr('disabled','disabled');
		$('#progressRateDiv').html(str0);
		return;
	}else{
		$('#progressDetailBtn').removeAttr("disabled");
	}
	
	$.ajax({
		url:"<%=request.getContextPath()%>/teacher/homeProgress",
		method:"GET",
		data:{"cpno":cpno },
		success:function(res){
			
			var per = res.perWeek;
			var proRate = res.progressRate;
			var totalWeek = res.weekCount;
			
			//str,str2는 모달 
			str='';
			str+='<span class="badge rounded-pill bg-warning"';
			str+='<	style="font-size: 0.8em; padding: 8px; height: 25px; width: 60px;">'+ res.wpList[0].subjectName +'</span>';
			str+='<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';
			$('#progressSubjectName').html(str);
			
			str2='';
			str2+='<p style="font-weight: bold; font-size: 1.2em;">'+ res.wpList[0].className + '</p>';
			str2+='<div class="row" style="height:600px;">';
			str2+='	<div class="col-3 mb-3" style="margin-left: 23px; margin-right: -44px;">';
			str2+='		<div style="width:20%; height:100%; margin:0px auto;  margin-left:14px;" class="progress">';
			str2+='		 	 <div class="progress-bar bg-purple" role="progressbar" style="height:'+ res.progressRate +'%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">'+ res.progressRate +'%</div>';
			str2+='		</div>';
			str2+='	</div>';
			
			str2+='	<div class="col-9 mb-3">';
			for(var i=0; i<totalWeek; i++){
				if(per*(i+1) < proRate){      //현재 진도율보다 이전 계획들
					str2+='   <div style="height:'+ res.perWeek +'%;">';
					str2+='		<div class="bg-soft-purple"';
					str2+='			style="border-radius: 5px; width: 100%; height:85%; padding:5px; text-align:left; vertical-align:middle; overflow:auto;">['+ res.wpList[i].week +'주차] ';
					str2+='			'+ res.wpList[i].content +'</div>';
					str2+='   </div>'
				}else if(proRate < per*i){     //현재 진도율 이후 계획들
					str2+='   <div style="height:'+ res.perWeek +'%;">';
					str2+='		<div class="bg-soft-secondary"';
					str2+='			style="border-radius: 5px; width: 100%; height:85%; padding:5px; text-align:left; vertical-align:middle; overflow:auto;">['+ res.wpList[i].week +'주차] ';
					str2+='			'+ res.wpList[i].content +'</div>';
					str2+='   </div>'
				}else{                          //현재 진행중인 계획
					str2+='   <div style="height:'+ res.perWeek +'%;">';
					str2+='		<div id="talkbuble" class="bg-purple"';
					str2+='			style="border-radius: 5px; width: 100%; height:85%; padding:5px; text-align:left; vertical-align:middle; overflow:auto; color:white;">['+ res.wpList[i].week +'주차] ';
					str2+='			'+ res.wpList[i].content +'</div>';
					str2+='   </div>'
				}
			}
			
			str2+='	</div>';
			str2+='</div>';
			$('#progressContent').html(str2);
			
			//str3는 홈화면 진도율 
			str3='';
			str3+='<div style="width:92%; height:15px; margin:0px auto;  margin-left:14px;" class="progress">';
			str3+='  <div class="progress-bar bg-success" role="progressbar" style="width:'+ res.progressRate +'%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">'+ res.progressRate +'%</div>';
			str3+='</div>';
			$('#progressRateDiv').html(str3);
		},
		error:function(){
			alert("진도율을 불러올수 없습니다. 관리자에게 문의하세요.");
		}
	})
})
</script>
<script>
$('.QR-modal').on('hidden.bs.modal', function () {
	//reload
	location.reload();
})
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script type="text/x-handlebars-template"  id="recentNotice-template" >
<div class="col-md-12">
	<span style="margin:3px;" class="badge bg-success">공지사항</span>
	<button style="float:right; border-color: lightgray; border:none; margin-right:7px;">
	<i class="uil-plus" onclick="location.href='../notice/list.go'"></i>
	</button>
	<button style="background-color:white; float:right; border:none;">
	<i id="updateNoticeBtn" class="uil-redo"></i>
	</button>
</div>
<table class="table table-hover" style="text-align: center; height:10px;">
		<thead class="">
			  <tr style="background-color:#8BDDA8;" class="table">
			    <th style="width:75%;padding: 5px; font-weight:bold;">제목</th>
			    <th style="width:25%; padding: 5px; font-weight:bold;">작성일</th>
			  </tr>
		</thead>
		{{#each noticeList}}
	    	<tr onclick="OpenWindow('<%=request.getContextPath()%>/notice/detail.go?from=list&lcode={{lcode}}&cnt=3','상세보기',800,700)" style="cursor:pointer;">
	            <td style="padding: 5px; padding-left:20px; text-align: left; ">{{title}}</td>
		        <td style="padding: 5px;">{{prettifyDate regDate}}</td>
	        </tr>
		{{/each}}	
</table>
</script>
<script type="text/x-handlebars-template"  id="recentHomework-template" >
<div class="col-md-12">
	<span style="margin:3px;" class="badge bg-success">과제제출현황</span>
	<button style="float:right; border-color: lightgray; border:none; margin-right:7px;">
	<i class="uil-plus" onclick="location.href='../assignManage/list.go'"></i>
	</button>
	<button style="background-color:white; float:right; border:none;">
	<i id="updateHomeworkBtn" class="uil-redo"></i>
	</button>
</div>
<div style="overflow: auto; height:250px;">
	<table class="table table-hover" style="text-align: center;">
  		<thead class="">
  			<tr style="background-color:#8BDDA8;" class="table">
  				<th style="width:15%; padding: 5px; font-weight:bold;">학생</th>
  				<th style="width:40%; padding: 5px; font-weight:bold;">과제명</th>
              	<th style="width:22%; padding: 5px; font-weight:bold;">만기일</th>
              	<th style="width:20%; padding: 5px; font-weight:bold;">제출현황</th>
             </tr>
   	 	</thead>
		{{#each studentList}}	
			{{#if status}}
			
			{{else}}	
			<tr onclick="" style="cursor:pointer; background-color:#FF9CBB;">
    		  	<td style="padding: 5px;" onclick="OpenWindow('../assignManage/detail.go?id={{id}}','상세보기',600,650);">{{name}}</td>
           		<td style="padding: 5px;" onclick="OpenWindow('../assignManage/dm.go?id={{id}}','상세보기',800,600);">{{title}}</td>
           		<td style="padding: 5px;" onclick="OpenWindow('../assignManage/dm.go?id={{id}}','상세보기',800,600);">{{prettifyDate endDate}}</td>
           		<td style="padding: 5px;" onclick="OpenWindow('../assignManage/dm.go?id={{id}}','상세보기',800,600);">
           		<button style="height:20px; line-height:0px; background-color:red; font-size: 0.8em;" class="btn btn-primary">미제출</button>
           		</td>
    		</tr>
			{{/if}}	
		{{/each}}	
		{{#each studentList}}	
			{{#if status}}
			<tr onclick="" style="cursor:pointer; ">
    		  	<td style="padding: 5px;" onclick="OpenWindow('../assignManage/detail.go?id={{id}}','상세보기',600,650);">{{name}}</td>
           		<td style="padding: 5px;" onclick="OpenWindow('../assignManage/check.go?assignCode={{assignCode}}&id={{id}}&name={{name}}','상세보기',800,600);">{{title}}</td>
           		<td style="padding: 5px;" onclick="OpenWindow('../assignManage/check.go?assignCode={{assignCode}}&id={{id}}&name={{name}}','상세보기',800,600);">{{prettifyDate endDate}}</td>
           		<td style="padding: 5px;" onclick="OpenWindow('../assignManage/check.go?assignCode={{assignCode}}&id={{id}}&name={{name}}','상세보기',800,600);">
				<button style="height:20px; line-height:0px;" class="btn btn-primary">제출</button>	
           		</td>
	    	</tr>
			{{/if}}	
		{{/each}}	
    </table>	
</div>
</script>

<script>
Handlebars.registerHelper({
	"prettifyDate":function(timeValue){ //Handlbars에 날짜출력함수 등록
		var dateObj=new Date(timeValue);
		var year=dateObj.getFullYear();
		var month=dateObj.getMonth()+1;
		var date=dateObj.getDate();
		return year+"-"+month+"-"+date;
	}
});

</script>
<script>
//최근 공지사항  뽑아오기 
$(function(){
	$.ajax({
		url : "<%=request.getContextPath()%>/teacher/homeNotice",
		method:"GET",
		success:function(res){
			printData(res,$('#recentNotice'),$('#recentNotice-template'));			
		},
		error:function(){
			alert("공지사항을 불러올수 없습니다. 관리자에게 문의하세요.");
		}
	})
	
})

	$('#recentNotice').on('click','#updateNoticeBtn',function(){
		$.ajax({
			url : "<%=request.getContextPath()%>/teacher/homeNotice",
			method:"GET",
			success:function(res){
				printData(res,$('#recentNotice'),$('#recentNotice-template'));			
			},
			error:function(){
				alert("공지사항을 불러올수 없습니다. 관리자에게 문의하세요.");
			}
		})
	})

</script>
<script>
//만기일이 가장 다가온 과제제출현황 리스트 출력
$(function(){
	$.ajax({
		url : "<%=request.getContextPath()%>/teacher/homeHomework",
		method:"GET",
		success:function(res){
			printData(res,$('#recentHomework'),$('#recentHomework-template'));			
		},
		error:function(){
			alert("과제제출현황을 불러올수 없습니다. 관리자에게 문의하세요.");
		}
	})
})
	
	$('#recentHomework').on('click','#updateHomeworkBtn',function(){
		$.ajax({
			url : "<%=request.getContextPath()%>/teacher/homeHomework",
			method:"GET",
			success:function(res){
				printData(res,$('#recentHomework'),$('#recentHomework-template'));			
			},
			error:function(){
				alert("과제제출현황을 불러올수 없습니다. 관리자에게 문의하세요.");
			}
		})
	})

</script>

</head>
<style type="text/css">

.fc-toolbar-title {
  text-align: center;
}
.fc-scrollgrid {
	margin: 0px auto;
}
.fc-toolbar-chunk:nth-child(3){
display: none;
}
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
</style>

<body>
	<!-- 첫줄 row 시작 -->
		<div class="row">
			<div class=""></div>
			<!-- 왼쪽 wrapper 시작 -->
			<div class="col-md-6" style="padding-left: 0px; padding-right: 3px;">
				<!-- 시간표 카드 시작 -->
				<div class="card task-box col-lg-12" style="margin-bottom:5px;">
					<div class="col-md-12">
					<span style="margin:3px; margin-left:11px;" class="badge bg-success">수업시간표</span>
					</div>
<!-- 					<div id="counsert-calendar01"></div> -->
					<div id="timeTable" class="table-responsive">
                       <table class="table table-bordered mb-0" style="text-align: center;padding: 0px;font-size: 0.8em;">
                           <thead>
                               <tr style="background-color: #8BDDA8;">
                                   <th style="width: 200px; padding: 0px;"><i class="bx bx-time-five font-size-16"></i></th>
                                   <th id="Mon" style="width: 200px; padding: 0px;">월</th>
                                   <th id="Tues" style="width: 200px; padding: 0px;">화</th>
                                   <th id="Wednes" style="width: 200px; padding: 0px;">수</th>
                                   <th id="Thurs" style="width: 200px; padding: 0px;">목</th>
                                   <th id="Fri" style="width: 200px; padding: 0px;">금</th>
                                   <th id="Satur" style="width: 200px; padding: 0px;">토</th>
                                   <th id="Sun" style="width: 200px; padding: 0px;">일</th>
                               </tr>
                           </thead>
                           <tbody>
                               <tr>
                                  <th style="padding:0px;" scope="row">09:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '09:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '09:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '09:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '09:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '09:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '09:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '09:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">10:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '10:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '10:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '10:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '10:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '10:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '10:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '10:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">11:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '11:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '11:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '11:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '11:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '11:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '11:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '11:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">12:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '12:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '12:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '12:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '12:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '12:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '12:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '12:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">13:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '13:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '13:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '13:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '13:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '13:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '13:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '13:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">14:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '14:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '14:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '14:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '14:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '14:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '14:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '14:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">15:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '15:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '15:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '15:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '15:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '15:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '15:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '15:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">16:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '16:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '16:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '16:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '16:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '16:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '16:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '16:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">17:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '17:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '17:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '17:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '17:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '17:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '17:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '17:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">18:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '18:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '18:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '18:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '18:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '18:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '18:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '18:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">19:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '19:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '19:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '19:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '19:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '19:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '19:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '19:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">20:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '21:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '20:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '20:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '20:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '20:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '20:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '20:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                                <tr>
                                  <th style="padding:0px;" scope="row">21:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '21:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '21:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '21:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '21:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '21:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '21:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '21:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>


                                <tr>
                                  <th style="padding:0px;" scope="row">22:00</th>
                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '22:00' }">
                                          <c:if test="${time.classday eq '1'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '22:00' }">
                                          <c:if test="${time.classday eq '2'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '22:00' }">
                                          <c:if test="${time.classday eq '3'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '22:00' }">
                                          <c:if test="${time.classday eq '4'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '22:00' }">
                                          <c:if test="${time.classday eq '5'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '22:00' }">
                                          <c:if test="${time.classday eq '6'}">
                                            ${time.className }<br>
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>

                                  <td style="padding:0px;">
                                    <c:forEach items="${timeList }" var="time">
                                        <c:if test="${time.startTime eq '22:00' }">
                                          <c:if test="${time.classday eq '0'}">
                                            ${time.className }
                                          </c:if>
                                        </c:if>
                                    </c:forEach>
                                  </td>
                                </tr>
                               
                           </tbody>
                       </table><!-- end table -->
                   </div>	
				</div>
			<!-- 원생수 카드 끝 -->
			
			
			
			
			<!-- 출결조회 시작 -->
			
				<div class="card task-box col-lg-12" style="margin-bottom:5px;">
					<div>
						<div class="col-md-6" style="float:left;">
						<span style="margin:3px; margin-left:13px;" class="badge bg-success">출결조회</span>
						</div>
						<div class="col-md-6" style="float:left;">
						<span style="margin:3px;" class="badge bg-success">오늘의 일정</span>
						</div>
					</div>
					<div>
						<div class="col-md-6" style="float:left;">
						  <div class="card-body" style="position: relative; padding:0px;">
                                <div id="chart02" onclick="OpenWindow('list.go','상세보기',800,700);" style="cursor:pointer;">
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
                                           <div class="p-2 ps-3 text-primary"><b>출근</b></div>
                                            </c:if>

                                            <c:if test="${attend.attendanceStatus eq 2}">
                                           <div class="p-2 ps-3 text-danger"><b>결근</b></div>
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
                                        <button type="button" <c:if test="${empty classList}">disabled</c:if>
                                        	class="btn btn-purple" data-bs-toggle="modal" data-bs-target=".QR-modal"><i class="mdi mdi-qrcode-scan me-1"></i> QR 출석체크</button>
                                    </div>
	                            </div>                           
   			 			  </div>  
						</div>
						<!-- 오늘의 일정 시작 -->
						<%@ page import="java.util.Date" %>
						<%@ page import="java.text.SimpleDateFormat" %>
						<%
							Date nowTime = new Date();
							SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일");
						%>
						<div class="col-md-6" style="float:left; overflow: auto;">
							<div class="bg-light mb-2" style="border-radius: 5px; padding: 15px; width:95%; height: 330px;">
								<p id="DayForToday" style="font-size: 0.75em; color:blue; text-align: right;"><%= sf.format(nowTime) %><p>
								<c:choose>
								    <c:when test="${empty assignList and empty couseltList and empty examList }">  
										<div style="text-align: center; padding-top:100px; font-weight: bold; height: 250px;" >오늘의 일정이 없습니다</div>							    
								    </c:when>
								    <c:otherwise>
								      <c:forEach items="${assignList }" var="assign">
									  	<button type="button" class="btn btn-danger mb-1" style="width: 100%; padding:0px; text-align:left; padding-left:10px; vertical-align:middle; font-size:0.9em;">[과제] ${assign.title } ${fn:substring(assign.endDate,11,16)} 마감 </button>
								      </c:forEach>
								      <c:forEach items="${counseltList }" var="counselt">
								      	<button type="button" class="btn btn-primary mb-1" style="width: 100%; padding:0px; text-align:left; padding-left:10px; vertical-align:middle; font-size:0.9em;">[상담] ${fn:substring(counselt.conStart,11,16) } (${counselt.name })</button>
								      </c:forEach>
								      <c:forEach items="${examList }" var="exam">
								      	<button type="button" class="btn btn-success mb-1" style="width: 100%; padding:0px; text-align:left; padding-left:10px; vertical-align:middle; font-size:0.9em;">[시험] ${fn:substring(exam.startDate,11,16) } (${exam.examName })</button>
								      </c:forEach>
								     </c:otherwise> 
							    </c:choose>
							</div>
	                	</div> 
	                	<!-- 오늘의 일정 끝 --> 
                	</div>                
				</div>
				
			<!-- 출결조회 끝 -->
			
			
			
			
			
			
			</div>
			<!-- 왼쪽 wrapper 끝  -->
			
			<!-- 오른쪽 wrapper 시작 -->
			<div class="col-md-6" style="padding-left: 0px; padding-right: 0px;">
				
				<!-- 수업진도현황 시작 -->
				<div class="card task-box col-lg-12" style="margin-bottom:5px;">
					<div>
					<div style="float:left;" class="col-lg-12">
					<span style="margin:3px; margin-left:12px;" class="badge bg-success">수업진도현황</span>
					
					</div>
<!-- 					<div style="float:left;" class="col-lg-4">ㅇㅇ</div> -->
					</div>
					<div style="margin-bottom: 10px;">
					<div style="float: left;" class="col-md-9">
						<select id="classSelect" style="float:left; margin-left: 3px; margin-left:13px;" class="form-select">
							<option value="none">수업을 선택하세요</option>
							<c:forEach items="${classList }" var="classes">
							<option value="${classes.cpno }">${classes.className }</option>
							</c:forEach>
						</select>
					</div>
					<div style="float: right; margin-right:20px;" class="col-md-2">
						<button id="progressDetailBtn" class="btn btn-primary" style="font-size: 0.9em;" data-bs-toggle="modal" data-bs-target="#step" disabled>상세보기</button>
					</div>			
					</div>
					<label style="width: 47%; font-size: 0.8em; font-weight: bold; margin-left:6px; margin-left:15px;margin-bottom:0px;">진도율</label>
					<div id="progressRateDiv">
						<div style="width:92%; height:15px; margin:0px auto;  margin-left:14px;" class="progress">
							<div class="progress-bar bg-success" role="progressbar" style="width:0%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">0%</div>
						</div>
					</div>
					<br>
				</div>
				<!-- 수업진도현황 끝 -->
				
				
				<!-- 과제 제출 현황 리스트 -->
				<div id="recentHomework" class="card task-box col-lg-12" style="margin-bottom:5px;">
									
				</div>
				<!-- 과제 제출 현황 리스트   끝 -->
				
				<!-- 최근 공지 리스트 -->
				<div id="recentNotice" class="card task-box col-lg-12" style="margin-bottom:5px;">
										
				</div>
				<!-- 최근 공지 리스트  끝-->
				
				
			</div>
		</div>
		<!-- row 끝 -->

 <!--QR코드 MODAL -->
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

<!-- modal -->
<div class="modal fade bs-example-modal-center" tabindex="-1"
		role="dialog" id="step" aria-labelledby="mySmallModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div id="progressSubjectName" class="modal-header">
				
				</div>
				<div id="progressContent" class="modal-body" style="text-align: center; padding: 15px; overflow: auto;">
					
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
	

</body>
