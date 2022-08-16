<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<c:set var="lowschool" value="${dat.lowschool}" />
<c:set var="posschool" value="${data.posschool}" />
<c:set var="overschool" value="${dataMa.overschool}" />
<c:set var="counseltList" value="${dataMap.counseltList }" />
<head>

<script src="<%=request.getContextPath()%>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/sm_chart.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/jspdf.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/html2canvas.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/printThis/1.15.0/printThis.js"></script>

<script type="text/javascript">

//원생 막대차트

var d1 = $('.d1').text();
var d2 = $('.d2').text();
var d3 = $('.d3').text();
var d4 = $('.d4').text();
var d5 = $('.d5').text();
var aver4=(Number(d1)+Number(d2)+Number(d3)+Number(d4)+Number(d5))/5;
var e1 = $('.e1').text();
var e2 = $('.e2').text();
var e3 = $('.e3').text();
var e4 = $('.e4').text();
var e5 = $('.e5').text();
var aver5=(Number(e1)+Number(e2)+Number(e3)+Number(e4)+Number(e5))/5;
var f1 = $('.f1').text();
var f2 = $('.f2').text();
var f3 = $('.f3').text();
var f4 = $('.f4').text();
var f5 = $('.f5').text();
var aver6=(Number(f1)+Number(f2)+Number(f3)+Number(f4)+Number(f5))/5;


var mygrade1=$('.mygrade').text();
//var sfd=Math.round(mygrade1*100/100).toFixed(2);
var mygrade2 = parseFloat(mygrade1).toFixed(1);

var fu1=$('.d').text();
var su2=$('.e').text();
var cu3=$('.f').text();


var options = {
		   series: [
	            { name: '희망대학 평균', data: [aver4,aver5,aver6] },
	            { name: '원생 평균', data: [mygrade2,mygrade2,mygrade2] }
	        ]
			,
        chart: {
        type: 'bar',
        height: 235,
        toolbar:{
        	show:false
        }
      },
      plotOptions: {
        bar: {
          horizontal:true,
          dataLabels: {
            position: 'top',
          },
        }
      },
      dataLabels: {
        enabled: true,
        offsetX: -6,
        style: {
          fontSize: '12px',
          colors: ['#fff']
        }
      },
      stroke: {
        show: true,
        width: 1,
        colors: ['#fff']
      },
 /*     tooltip: {
        shared: true,
        intersect: false
      },*/
      xaxis: {
    	  categories: [fu1,su2,cu3],
      },
      };

      var chart = new ApexCharts(document.querySelector("#chart_bar"), options);
      chart.render();

     
</script>
<script>
//학부모 막대차트


//원생성적 등급


var gr = $('.abc').text();
var gr1 = $('.ab').text();
var gr2 = $('.aa').text();
var gr3 = $('.bb').text();
var gr4 = $('.cc').text();

var aver=(Number(gr)+Number(gr1)+Number(gr2)+Number(gr3)+Number(gr4))/5;


var b1 = $('.b1').text();
var b2 = $('.b2').text();
var b3 = $('.b3').text();
var b4 = $('.b4').text();
var b5 = $('.b5').text();

var aver2=(Number(b1)+Number(b2)+Number(b3)+Number(b4)+Number(b5))/5;


var c1 = $('.c1').text();
var c2 = $('.c2').text();
var c3 = $('.c3').text();
var c4 = $('.c4').text();
var c5 = $('.c5').text();

var aver3=(Number(c1)+Number(c2)+Number(c3)+Number(c4)+Number(c5))/5;


var mygrade=$('.mygrade').text();
var mygrade2 = parseFloat(mygrade).toFixed(1);
var fu=$('.a').text();
var su=$('.b').text();
var cu=$('.c').text();

var options = {
		  series: [
            { name: '희망대학 평균', data: [aver,aver2,aver3] },
            { name: '원생 평균', data: [mygrade2, mygrade2,mygrade2] }
        ]
		,
      chart: {
          type: 'bar',
          height: 235,
          toolbar:{
          	show:false
          }
        },
      plotOptions: {
        bar: {
          horizontal: true,
          dataLabels: {
            position: 'top',
          },
        }
      },
      dataLabels: {
        enabled: true,
        offsetX: -6,
        style: {
          fontSize: '12px',
          colors: ['#fff']
        },
        legend:{
      	  show:false
        }
      },
      stroke: {
        show: true,
        width: 1,
        colors: ['#fff']
      },
     
      tooltip: {
        shared:false,
        intersect: false
      },
      xaxis: {
        categories: [fu,su,cu],
      },
      };

      var chart = new ApexCharts(document.querySelector("#chart_bar2"), options);
      chart.render();


</script>

<script type="text/javascript">
	function print() {
		$("#pdf_wrap").printThis({
			debug : false,
			importCSS : true,
			printContainer : true,
			loadCSS : "common.css",
			pageTitle : "",
			removeInline : false
		});
	}
</script>



<script>
// 	$(function() {
// 		$('#btn').on('click', function() {

// 			window.open('pdfprpr.go')

// 		})
// 	})
	
	/* $(function(){
	 $("#btn").on('click',function(){
	 html2canvas(document.body, {
	 onrendered: function(canvas) {
	
	 // 캔버스를 이미지로 변환
	 var imgData = canvas.toDataURL('image/png');
	
	 var imgWidth = 210; // 이미지 가로 길이(mm) A4 기준
	 var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
	 var imgHeight = canvas.height * imgWidth / canvas.width;
	 var heightLeft = imgHeight;
	
	 var doc = new jsPDF('p', 'mm');
	 var position = 0;
	
	 // 첫 페이지 출력
	 doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
	 heightLeft -= pageHeight;
	
	 // 한 페이지 이상일 경우 루프 돌면서 출력
	 while (heightLeft >= 20) {
	 position = heightLeft - imgHeight;
	 doc.addPage();
	 doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
	 heightLeft -= pageHeight;
	 }
	
	 // 파일 저장
	 doc.save('분석.pdf');
	 }
	 });
	 })
	 })
	
	 */
</script>

<style>
table {
	width: 100%;
	border: 1px solid #444444;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #444444;
	padding: 10px;
}
}
</style>
</head>
<body>

	<div id="pdf_wrap">
		<div class="row">
			<div class="card">
			
							<div class="col-md-12">	
							
							    <h2 style="font-weight:bold; float:left;"><i class="uil-book-reader"></i>김학생님의 성적분석 </h2>&nbsp;&nbsp;&nbsp;<button id="btn" class="btn btn-danger" onclick="OpenWindow('pdfprpr.go?pcCode=${pcCode}','원생인쇄',1000,1000);"
								style=" padding:3px;  float:right;">인쇄하기</button>	
							  
							
									
								
												
								</div>
								<hr style="margin:2px; color:skyblue;" size="5px;" >
					<div class="col-md-12">
				
						
   
					<div class="col-md-2" style="float: left;">
						<p style="text-align: center;">
							<span class="badge bg-primary" style="font-size: 1.2em;">희망대학</span>
						</p>
						<table class="table table-bordered text-center  table-hover ">
							<tr style="font-size: 0.95em; background-color: #038edc; color: white;">
								<th style="width: 5%;">학부모</th>
								<th style="width: 5%;">원생</th>
							</tr>


							<tr class="table-white">
								<th>${efg.universityName}</th>
								<th>${cou.universityName}</th>

							</tr>
							<tr class="table-white">
								<th>${ab.universityName}</th>
								<th>${abc.universityName}</th>
							</tr>

							<tr class="table-white">
								<th>${cd.universityName}</th>
								<th>${cde.universityName}</th>
							</tr>



						</table>


					</div>
					
					
						
						
							
					
					
					     
					<div class="col-md-5" style="float: right;">
					
					<p style="text-align: center; float: center;">
							<span class="badge bg-primary" style="font-size: 1.2em;">원생
								희망대학 내신 등급</span>
										
							
								
														
								
								
						</p>
					
						
			<div id="chart_bar"></div>
					</div>

					<div class="col-md-5" style="float: right;">
						<p style="text-align: center;">
							<span class="badge bg-primary" style="font-size: 1.2em;">학부모
								희망대학 내신 등급</span>
						</p>

						<div id="chart_bar2"></div>
					</div>

				</div>
				<div class="col-md-12">


					<div class="col-sm-5" style="float: left; margin-left: 30px;">
						<p style="text-align: center; float: center;">
							<span class="badge bg-primary" style="font-size: 1.2em;">학부모
								희망대학 과목별 내신 등급</span>
						</p>

						<div>
							<table class="table table-bordered text-center  table-hover ">
								<tr style="font-size: 0.95em; background-color:#038edc;color: white;">
									<th style="width: 10%;">대학/과목</th>
									<th style="width: 5%;">국어</th>
									<th style="width: 5%;">수학</th>
									<th style="width: 5%;">영어</th>
									<th style="width: 5%;">사회</th>
									<th style="width: 5%;">과학</th>
								</tr>


								<tr class="table-white">
									<th class="a">${efg.universityName}</th>
									<th class="abc">${a.universityKor }</th>
									<th class="ab">${a.universityMath }</th>
									<th class="aa">${a.universityEng }</th>
									<th class="bb">${a.universitySocial }</th>
									<th class="cc">${a.universityScience }</th>
								</tr>
								<tr class="table-white">
									<th class="b">${ab.universityName}</th>
									<th class="b1">${b.universityKor }</th>
									<th class="b2">${b.universityMath }</th>
									<th class="b3">${b.universityEng }</th>
									<th class="b4">${b.universitySocial }</th>
									<th class="b5">${b.universityScience }</th>
								</tr>

								<tr class="table-white">
									<th class="c">${cd.universityName}</th>
									<th class="c1">${c.universityKor }</th>
									<th class="c2">${c.universityMath }</th>
									<th class="c3">${c.universityEng }</th>
									<th class="c4">${c.universitySocial }</th>
									<th class="c5">${c.universityScience }</th>
								</tr>



							</table>

						</div>

					</div>

					<div class="col-sm-5" style="float: right; margin-right: 30px;">
						<p style="text-align: center; float: center;">
							<span class="badge bg-primary" style="font-size: 1.2em;">원생
								희망대학 과목별 내신 등급</span>
						</p>
						<div>
							<table class="table table-bordered text-center  table-hover ">
								<tr style="font-size: 0.95em; background-color:#038edc;color: white; " >
									<th style="width: 10%;">대학/과목</th>
									<th style="width: 5%;">국어</th>
									<th style="width: 5%;">수학</th>
									<th style="width: 5%;">영어</th>
									<th style="width: 5%;">사회</th>
									<th style="width: 5%;">과학</th>
								</tr>


								<tr class="table-white">
									<th class="d">${cou.universityName}</th>
									<th class="d1">${e.universityKor }</th>
									<th class="d2">${e.universityMath }</th>
									<th class="d3">${e.universityEng }</th>
									<th class="d4">${e.universitySocial }</th>
									<th class="d5">${e.universityScience }</th>
								</tr>
								<tr class="table-white">
									<th class="e">${abc.universityName}</th>
									<th class="e1">${f.universityKor }</th>
									<th class="e2">${f.universityMath }</th>
									<th class="e3">${f.universityEng }</th>
									<th class="e4">${f.universitySocial }</th>
									<th class="e5">${f.universityScience }</th>
								</tr>

								<tr class="table-white">
									<th class="f">${cde.universityName}</th>
									<th class="f1">${g.universityKor }</th>
									<th class="f2">${g.universityMath }</th>
									<th class="f3">${g.universityEng }</th>
									<th class="f4">${g.universitySocial }</th>
									<th class="f5">${g.universityScience }</th>
									<th class="mygrade" style="display: none;">${h.stuavg}</th>
								</tr>



							</table>

						</div>

					</div>
				</div>



				<div class="col-md-12" style="float: left;">
					<p style="text-align: center;">
						<span class="badge bg-success" style="font-size: 1.2em;">합격예측</span>
					</p>

					<div class="bg-danger"
						style="width: 1000px; height: 50px; backgroundcolor:">
						<span class=""
							style="font-size: 1.5em; font-weight: bold;  color: white; marign: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;상향&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<c:forEach items="${overschool}" var="over">

							<span
								style="font-weight: bold; font-size: 1.2em;  color: white;text-align: center;">${over.universityName}</span>
						</c:forEach>


					</div>
					<div class="bg-primary"
						style="width: 1000px; height: 50px; backgroundcolor:">
						<span class=""
							style="font-size: 1.5em; font-weight: bold; color: white; marign: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;적정&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>


						<c:forEach items="${posschool}" var="pos">

							<span
								style="font-weight: bold; font-size: 1.2em;  color: white;text-align: center;">${pos.universityName}</span>
						</c:forEach>
					</div>


					<div class="bg-warning"
						style="width: 1000px; height: 50px; backgroundcolor:">
						<span class=""
							style="font-size: 1.5em; font-weight: bold;  color: white; marign: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;하향&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<c:forEach items="${lowschool}" var="low">


							<span
								style="font-weight: bold; font-size: 1.2em; color: white;text-align: center;">${low.universityName}</span>


						</c:forEach>




					</div>
					<!-- 				<table class="table table-bordered text-center  table-hover "> -->



					<!-- 					<tr class="table-danger"> -->
					<!-- 						<th style="width: 15;"%>상향</th> -->
					<!-- 						<th>경희대,한양대,서울대</th> -->
					<!-- 					</tr> -->
					<!-- 					<tr class="table-primary"> -->
					<!-- 						<th style="width: 15%;">적정</th> -->
					<!-- 						<th>아주대,세종대,과기대</th> -->
					<!-- 					</tr> -->

					<!-- 					<tr class="table-warning"> -->

					<!-- 						<th style="width: 15%;">하향</th> -->


					<!-- 					</tr> -->




					<!-- 				</table> -->




				</div>

				<div class="col-md-12">
					<div class="col-md-4" style="float: left; padding: 10px;">


						<p style="text-align: center;">
							<span class="badge bg-danger" style="font-size: 1.2em; ">상향
								대학 과목별 내신 등급</span>
						</p>

						<table border="1" class="table myclass">
							<tr style="font-size: 0.5em;  color:white;"
								class="bg-danger ">
								<th style="width: 13%;">대학/과목</th>
								<th style="width: 5%;">국어</th>
								<th style="width: 5%;">수학</th>
								<th style="width: 5%;">영어</th>
								<th style="width: 5%;">사회</th>
								<th style="width: 5%;">과학</th>
							</tr>


							<tr class="table-white" style="font-size: 0.5em;">
								<th>${i.universityName }</th>
								<th>${j.universityKor }</th>
								<th>${j.universityMath }</th>
								<th>${j.universityEng }</th>
								<th>${j.universitySocial }</th>
								<th>${j.universityScience }</th>
							</tr>
							<tr class="table-white" style="font-size: 0.5em;">
								<th>${tt.universityName }</th>
								<th>${tt.universityKor }</th>
								<th>${tt.universityMath }</th>
								<th>${tt.universityEng }</th>
								<th>${tt.universitySocial }</th>
								<th>${tt.universityScience }</th>

							</tr>

							<tr class="table-white" style="font-size: 0.5em;">
								<th>${ta.universityName }</th>
								<th>${ta.universityKor }</th>
								<th>${ta.universityMath }</th>
								<th>${ta.universityEng }</th>
								<th>${ta.universitySocial }</th>
								<th>${ta.universityScience }</th>
							</tr>
						</table>

					</div>

					<div class="col-md-4" style="float: left; padding: 10px;">


						<p style="text-align: center;">
							<span class="badge bg-primary" style="font-size: 1.2em;">적정
								대학 과목별 내신 등급</span>
						</p>

						<table border="1" class="table myclass">
							<tr style="font-size: 0.5em; color:white;background: #038edc;"
								>
								<th style="width: 13%;">대학/과목</th>
								<th style="width: 5%;">국어</th>
								<th style="width: 5%;">수학</th>
								<th style="width: 5%;">영어</th>
								<th style="width: 5%;">사회</th>
								<th style="width: 5%;">과학</th>
							</tr>


							<tr class="table-white" style="font-size: 0.5em;">
								<th>${k.universityName }</th>
								<th>${o.universityKor }</th>
								<th>${o.universityMath }</th>
								<th>${o.universityEng }</th>
								<th>${o.universitySocial }</th>
								<th>${o.universityScience }</th>
							</tr>
							<tr class="table-white" style="font-size: 0.5em;">
								<th>${sf.universityName }</th>
								<th>${ss.universityKor }</th>
								<th>${ss.universityMath }</th>
								<th>${ss.universityEng }</th>
								<th>${ss.universitySocial }</th>
								<th>${ss.universityScience }</th>

							</tr>

							<tr class="table-white" style="font-size: 0.5em;">
								<th>${si.universityName }</th>
								<th>${si.universityKor }</th>
								<th>${si.universityMath }</th>
								<th>${si.universityEng }</th>
								<th>${si.universitySocial }</th>
								<th>${si.universityScience }</th>
							</tr>
						</table>

					</div>
					<div class="col-md-4" style="float: left; padding: 10px;">


						<p style="text-align: center;">
							<span class="badge bg-warning" style="font-size: 1.2em;">하향
								대학 과목별 내신 등급</span>
						</p>

						<table border="1" class="table myclass">
							<tr style="font-size: 0.5em; color:white;"
								class="bg-warning ">
								<th style="width: 13%;">대학/과목</th>
								<th style="width: 5%;">국어</th>
								<th style="width: 5%;">수학</th>
								<th style="width: 5%;">영어</th>
								<th style="width: 5%;">사회</th>
								<th style="width: 5%;">과학</th>
							</tr>


							<tr class="table-white" style="font-size: 0.5em;">
								<th>${m.universityName }</th>
								<th>${n.universityKor }</th>
								<th>${n.universityMath }</th>
								<th>${n.universityEng }</th>
								<th>${n.universitySocial }</th>
								<th>${n.universityScience }</th>
							</tr>
							<tr class="table-white" style="font-size: 0.5em;">
								<th>${ds.universityName }</th>
								<th>${ds.universityKor }</th>
								<th>${ds.universityMath }</th>
								<th>${ds.universityEng }</th>
								<th>${ds.universitySocial }</th>
								<th>${ds.universityScience }</th>

							</tr>

							<tr class="table-white" style="font-size: 0.5em;">
							<th>${dt.universityName }</th>
								<th>${dt.universityKor }</th>
								<th>${dt.universityMath }</th>
								<th>${dt.universityEng }</th>
								<th>${dt.universitySocial }</th>
								<th>${dt.universityScience }</th>
							</tr>
						</table>

					</div>
				</div>

				<div class="col-sm-12">

					<div class="col-sm-12">
						
					</div>


				</div>


			</div>
		
</div>
</div>
	
</body>