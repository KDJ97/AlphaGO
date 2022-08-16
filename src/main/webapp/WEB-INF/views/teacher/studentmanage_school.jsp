<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<script src="<%=request.getContextPath() %>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
<script type="text/javascript">
// 분석 chart
// 비교그래프
var arr=[];

var nm="수민"

var arr2=["시"];
var arr3=["말"];
arr[0]=arr2[0];
arr[1]=arr3[0];




  
</script>

<script>	
function kor2go(){
	
 var options = {
    series: [{
    data:arr
  }],
    chart: {
    height: 200,
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
  dataLabels: {
    enabled: false
  },
  legend: {
    show: false
  },
  xaxis: {
    categories: arr,
    labels: {
      style: {
        fontSize: '12px'
      }
    }
  }
  };

  var chart = new ApexCharts(document.querySelector("#sch_score_bar_chart"), options);
  chart.render();
}
 </script>



<script>
 function prac(){
	 

//성적 추이

var options = {
    series: [{
      name: "",
      data: [50,60,70]
  }],
    chart: {
    height: 200,
    width: 340,
    type: 'line',
    zoom: {
      enabled: false
    },
    
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
    categories: korArr1,
  }
  };

  var chart = new ApexCharts(document.querySelector("#sch_score_line_chart"), options);
  chart.render();
 } 
 </script> 











<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="studentTotalList" value="${dataMap.studentTotalList}" />
<c:set var="tname" value="${dataMap.name}" />
<c:set var="tsubject" value="${dataMap.subject}" />






<script>
var stuname="";
var korArr1=[];
var korArr2=[];
var korArr3=[];
var korArr4=[];




</script>


<script>
function korGo(){
	
	
	 var options = {
			    series: [{
				    data:korArr2
			    }],
			    chart: {
			    height: 200,
			    width: 260,
			    type: 'bar',
			    toolbar:{
		        	show:false
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
			    categories: 
			    korArr1

			    ,
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


	
}

</script>



<script>

function korGo2(){
	var datatt=[];
	for(let i=0;i<korArr4.length;i++){
	   datatt.push(korArr4[i]);
	}
	console.log('korGo2');
	console.log(korArr4);
	
var options = {
	    series: [{
	    name: stuname,
	      data: 
	    	  korArr3
	      
	  }],
	    chart: {
	    height: 200,
	    width: 260,
	    type: 'line',
	    zoom: {
	      enabled: false
	    },
	    toolbar:{
        	show:false
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
	
	    categories:datatt,
	    labels: {
    	  show: false,
       },
  	 }
   };

	  var chart = new ApexCharts(document.querySelector("#kor_line_chart"), options);
	  chart.render();

}


</script>






<script>

$(function(){
	



	$('.go').on('click',function(){
		var id2=$(this).attr('id');
		
	     stuname=$('.namego',this).html();
	     $('#stuname').html(stuname);
	 	 $.ajax({
			url : '<%=request.getContextPath()%>/rteacher/schoolgrade',
			type : 'get',
			data : {'id' : id2},
		    success : function(res){
		       str="";
		      
		    	   
		       if($('#subj').val()=="국어"){
		    	   
		      if(res.subjectMap.korList==null||res.subjectMap.korList.length<1){
		    	  $('#kor_chart').empty();
		          $('#kor_line_chart').empty();
		          $('#stScore').html("-");
		          $('#GradeG').html("-");
		          $('#AverageG').html("-");
		    	  str+='<tr><td colspan="7">조회된 성적이 존재하지 않습니다.</td></tr>';
		    	  korGo();
			       korGo2();
		      }else{
		    	  
		      
		    	
		    		
				$.each(res.subjectMap.korList,function(i,v){
					
			str+='	<tr>';
			str+='	<td>'+v.mygrade+'</td>';
			str+='	<td>'+v.schoolTerm+'</td>';
			str+='	<td>'+v.testName+'</td>';
			str+='	<td>'+v.myscore+'</td>';
			str+='	<td>'+v.achievement+'</td>';
			str+='	<td>'+v.rank+'</td>';
			str+='	<td>'+v.rank+'/'+v.stucnt+'</td>';
			str+='</tr>';
			 
			korArr3.push(v.myscore);
			var apra=[];
			apra.push(v.schoolYear+"년도"+v.testName);
			korArr4.push(v.schoolYear+"년도"+v.testName);
								
				})
					var arrr=[];
				korArr1.push('내점수');
		    	
				 var prar1=[];
				 korArr1.push(res.uniMap.fuUni.universityName);
			    
			   
				 var prar2=[];
				 korArr1.push(res.uniMap.suUni.universityName);
				   
			
			 	korArr1.push(res.uniMap.tuUni.universityName);
			 	
			 	console.log(korArr1);
			 	korArr2.push(((res.subjectMap.korAvg)+"").substr(0,4));
			 	korArr2.push(res.uniMap.fuUni.universityKorScore);
			 	 korArr2.push(res.uniMap.suUni.universityKorScore);
				korArr2.push(res.uniMap.tuUni.universityKorScore);	     
				var pidback="";
				if(res.uniMap.fuUni.universityKorScore<res.subjectMap.korAvg||
						res.uniMap.suUni.universityKorScore<res.subjectMap.korAvg
						||res.uniMap.tuUni.universityKorScore<res.subjectMap.korAvg){
					pidback="희망 대학중 낮춰 쓴 대학은 국어점수가 부족하지는 않으나, 나머지 대학들은 국어점수가 부족하니 성적향상을위해 더 신경써 주세요.";
				if(res.uniMap.fuUni.universityKorScore<res.subjectMap.korAvg&&
						res.uniMap.suUni.universityKorScore<res.subjectMap.korAvg
						&&res.uniMap.tuUni.universityKorScore>res.subjectMap.korAvg){
					pidback="상향 희망하는 대학보다는 국어점수가 부족합니다. 조금 더 향상시켜 상향 희망대학교 까지 점수가 모자람이 없이 지도해 주세요.";
				}	
				if(res.uniMap.suUni.universityKorScore<res.subjectMap.korAvg
						&&res.uniMap.tuUni.universityKorScore<res.subjectMap.korAvg
						&&res.uniMap.fuUni.universityKorScore>res.subjectMap.korAvg){
					pidback="상향 희망하는 대학보다는 국어점수가 부족합니다. 조금 더 향상시켜 상향 희망대학교 까지 점수가 모자람이 없이 지도해 주세요.";

					}		
				if(res.uniMap.fuUni.universityKorScore<res.subjectMap.korAvg&&
						res.uniMap.tuUni.universityKorScore<res.subjectMap.korAvg
						&&res.uniMap.suUni.universityKorScore>res.subjectMap.korAvg){
					pidback="상향 희망하는 대학보다는 국어점수가 부족합니다. 조금 더 향상시켜 상향 희망대학교 까지 점수가 모자람이 없이 지도해 주세요.";

				}	
				if(res.uniMap.fuUni.universityKorScore<res.subjectMap.korAvg&&
						res.uniMap.suUni.universityKorScore<res.subjectMap.korAvg
						&&res.uniMap.tuUni.universityKorScore<res.subjectMap.korAvg){
					pidback="아주 잘 진행되고 있습니다.앞으로도 이 점수를 유지할 수 있도록 흔들리지 않도록 도와주세요.";

				}		
					
				}else{
					pidback="원하는 대학과의 국어점수의 차이가 큽니다. 낙담하지 않도록 주의해 주시고 더 노력 시켜 희망대학 을 향해 갈수 있도록 해 보세요.";
				}
				
				$('#pidbackgo').html(pidback);
				  $('#stScore').html("100");
				  $('#GradeG').html(((res.subjectMap.korGradeAvg)+"").substr(0,4));
				  $('#AverageG').html(((res.subjectMap.korAvg)+"").substr(0,4));
				  
				  $('#kor_chart').empty();
			       $('#kor_line_chart').empty();
			       
				 	//alert(korArr4);
			      
				 	console.log(korArr4);
			       korGo();
			       korGo2();
			       korArr1.splice(0, korArr1.length);
			       korArr2.splice(0, korArr2.length);
			       korArr3.splice(0, korArr3.length);
			       korArr4.splice(0, korArr4.length);
				  
           //     alert(korArr1);   
		       }
		      
		       }
	if ($('#subj').val() == "수학") {

											}

	if ($('#subj').val() == "영어") {

											}

	if ($('#subj').val() == "과학") {

									}
	if ($('#subj').val() == "사회") {

						}

	$('#schoolScoreContent').html(str);

											//  $('#stScore').html(res.subjectMap.korStandardAvg))

										},
										error : function(xhr) {
											alert("상태 : " + xhr.status + " 체크");
										},
										dataType : 'json'
									})

						})

	})
	function keygo(e) {

		if (e.keyCode == 13) {
			list_sgo(1, "studentmanage_school.go");
		}

	}
</script>

<script>


</script>

<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>
</head>
<body>
	<div class="row" >
		<div class="col-sm-5" style="padding-right:0px;height:842px;">
			<div class="card">
				<div class="card-header">
					<div class="justify-content-between d-flex align-items-center" >
			           <h4 class="card-title">학교성적</h4>
			           <a href="<%=request.getContextPath() %>/teacher/studentmanage_acardemy.go" class="btn btn-sm btn-soft-secondary">학원성적 보기&nbsp;&nbsp;<i class="mdi mdi-arrow-right align-middle"></i></a>
			        </div>
				</div>
				<div class="card-body">
					<div class="row mb-2">
					  <div class="col-4"style="padding-right:0px;">
						<select class="form-select" name="searchType" id="searchType">
							<option value="nsg" ${cri.searchType eq '' ? 'selected':'' }>전체</option>
							<option value="n" ${cri.searchType eq 'n' ? 'selected':'' }>이름</option>
							<option value="s" ${cri.searchType eq 's' ? 'selected':'' }>학교</option>
							<option value="g" ${cri.searchType eq 'g' ? 'selected':'' }>학년</option>

						</select>
					  </div>
					  <div class="col-8"style="padding-left:0px;">
						<input class="form-control" type="text" name="keyword" id="keyword"placeholder="검색어를 입력하세요." value="${cri.keyword }" onkeypress="keygo(event);" />
					  </div>
					</div>
					<div style="height:600px;">
					<table class="table table-hover text-center">
					  <thead>
						<tr style="background: #8BDDA8;">
							<th style="font-weight: bold;width:90px;vertical-align:middle;">아이디</th>
							<th style="font-weight: bold;width:90px;vertical-align:middle;">이름</th>
							<th style="font-weight: bold;width:140px;vertical-align:middle;">학교</th>
							<th style="font-weight: bold;width:70px;vertical-align:middle;">학년</th>
						</tr>
					  </thead>
					  <tbody style="cursor: pointer;">
					  	 <c:forEach items="${studentTotalList}" var="student">
						<tr id="${student.id}" class="go">
						  <td style="vertical-align:middle;">${student.id}</td>
						  <td class="namego"style="vertical-align:middle;">${student.name}</td>
						  <td style="vertical-align:middle;">${student.schoolName}</td>
						  <td style="vertical-align:middle;">${student.grade}</td>
						</tr>
						</c:forEach> 
<!-- 						<tr> -->
							
<!-- 						  <td>rsz5</td> -->
<!-- 						  <td>이수민</td> -->
<!-- 						  <td>대덕고등학교</td> -->
<!-- 						  <td>1</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 						  <td>rsz5</td> -->
<!-- 						  <td>이수민</td> -->
<!-- 						  <td>대덕고등학교</td> -->
<!-- 						  <td>1</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 						  <td>rsz5</td> -->
<!-- 						  <td>이수민</td> -->
<!-- 						  <td>대덕고등학교</td> -->
<!-- 						  <td>1</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 						  <td>rsz5</td> -->
<!-- 						  <td>이수민</td> -->
<!-- 						  <td>대덕고등학교</td> -->
<!-- 						  <td>1</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 						  <td>rsz5</td> -->
<!-- 						  <td>이수민</td> -->
<!-- 						  <td>대덕고등학교</td> -->
<!-- 						  <td>1</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 						  <td>rsz5</td> -->
<!-- 						  <td>이수민</td> -->
<!-- 						  <td>대덕고등학교</td> -->
<!-- 						  <td>1</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 						  <td>rsz5</td> -->
<!-- 						  <td>이수민</td> -->
<!-- 						  <td>대덕고등학교</td> -->
<!-- 						  <td>1</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 						  <td>rsz5</td> -->
<!-- 						  <td>이수민</td> -->
<!-- 						  <td>대덕고등학교</td> -->
<!-- 						  <td>1</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 						  <td>rsz5</td> -->
<!-- 						  <td>이수민</td> -->
<!-- 						  <td>대덕고등학교</td> -->
<!-- 						  <td>1</td> -->
<!-- 						</tr> -->
					  </tbody>


					</table>

</div>
				</div>
				<div class="card-footer">
								<nav aria-label="Navigation">
	<ul id="nav-ul" class="pagination justify-content-center m-0">
		<li class="page-item">
			<a class="page-link" href="javascript:list_go(1);">
				<i class="fas fa-angle-double-left"></i>
			</a>
		<li class="page-item">
			<a class="page-link" href="">
				<i class="fas fa-angle-left"></i>
			</a>						
		</li>
		
		<c:forEach var="pageNum" begin="${pageMaker.startPage }" 
								 end="${pageMaker.endPage }" >
			<li class="page-li page-item ${cri.page == pageNum?'active':''}">
				<a class="nav-list page-list-link page-link" href="javascript:list_sgo('${pageNum}','studentmanage_school.go');" >${pageNum }</a>
				
			</li>
			
		</c:forEach>
		
		<%-- <c:forEach var="pageNum" begin="${pageMaker.startPage }" 
								 end="${pageMaker.endPage }" >
			<li class="page-item ${cri.page == pageNum?'active':''}">
				<a class="page-list-link page-link" href="javascript:studentlist_go('${pageNum}');" >${pageNum }</a>
				
			</li>
			
		</c:forEach> --%>
		
		
		<li class="page-item">
			<a class="page-link" href="">
				<i class="fas fa-angle-right"></i>
			</a>						
		</li>
		<li class="page-item">
			<a class="page-link" href="">
				<i class="fas fa-angle-double-right"></i>
			</a>						
		</li>
	</ul>
</nav>  
				</div>
			</div>
		</div>

		<div class="col-sm-7" style="height:840px;" >
			<div class="card"style="height:820px;">
			  <div class="card-header">
			  	<div class="hstack gap-3">
                  <div class="p-1 px-2" style="vertical-align: middle;">
                    <span style="font-weight: bold; font-size: 1.2em;">
                      <i class="uil uil-user me-2"></i><span id="stuname">---</span>
                    </span>
                    <span class="badge bg-warning font-size-16">${tsubject }</span>
                  </div>
                  <div class="ms-auto">
                  </div>
               </div>
			  </div>

			  <div class="card-body" style="padding: 10px;">
				<div style="overflow: auto;padding:0px;height:380px;">
			    <table class="table table-hover text-center">
				  <thead>
					<tr style="background:#8BDDA8;">
						<th style="font-weight: bold;">학년</th>
						<th style="font-weight: bold;">학기</th>
						<th style="font-weight: bold;">중간/기말</th>
						<th style="font-weight: bold;">점수</th>
						<th style="font-weight: bold;">성취도</th>
						<th style="font-weight: bold;">석차등급</th>
						<th style="font-weight: bold;">석차/수강자수</th>
					</tr>
				  </thead>
				  <tbody id="schoolScoreContent">

<!-- 					<tr> -->
<!-- 						<td>1</td> -->
<!-- 						<td>1</td> -->
<!-- 						<td>중간</td> -->
<!-- 						<td>55</td> -->
<!-- 						<td>A</td> -->
<!-- 						<td>6</td> -->
<!-- 						<td>260/320</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<td>1</td> -->
<!-- 						<td>1</td> -->
<!-- 						<td>중간</td> -->
<!-- 						<td>55</td> -->
<!-- 						<td>A</td> -->
<!-- 						<td>6</td> -->
<!-- 						<td>260/320</td> -->
<!-- 					</tr> -->
					<tr >
						<td colspan="7" rowspan="3"style="font-size:1.6em;font-weight:700;color:gray;" id="pidback">학생을 선택해주세요..</td>
						</tr>
					
				  </tbody>
				</table>
</div>
				
<hr>
			

				 <div class="card" style="hight:500px;">
					<div class="card-body" style="height:310px; text-align: center;">
					  <div class="row">
					    <div class="col-4">
					            원점수 <br> <span style="font-weight: bold;" id="stScore">-</span>
					    </div>
					    <div class="col-4">
					           등급 <br> <span style="font-weight: bold;"id="GradeG">-</span>
					    </div>
					    <div class="col-4">
					           평균 <br> <span style="font-weight: bold;"id="AverageG">-</span>
					    </div>
					  </div>
					  <hr>
					  <div class="row">
					    <div class="col-sm-6">
					    
						  <div id="kor_chart" class="apex-charts"></div>
					    </div>
					    <div class="col-sm-6" >
					      <div id="kor_line_chart" class="apex-charts"></div>
					    </div>
					  </div><!-- row 끝 -->
					</div><!-- card-body 끝 -->
				</div><!-- card 끝 -->

			</div><!-- card-body 끝 -->


		</div><!-- card 끝 -->
	</div><!-- col 끝 -->
  </div><!-- row 끝 -->
<form id="jobForm_suggest">	
	<input type='hidden' name="page" value="" />
	<input type='hidden' name="searchType" value="" />
	<input type='hidden' name="keyword" value="" />
	
</form>
<div id="hi"></div>


<input type="hidden" id="subj" value="${tsubject }">
</body>