<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>

<script src="<%=request.getContextPath() %>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${pageMaker.cri }" />
<c:set var="clist" value="${classList}" />
<c:set var="subj" value="${subject}" />






<script type="text/javascript">
function selectAll(selectAll)  {
  const checkboxes
       = document.getElementsByName('test');

  checkboxes.forEach((checkbox) => {
    checkbox.checked = selectAll.checked;
  })
}

// 분석 chart
// 1) 선 그래프

var options = {
    series: [
        {
            name: 'Total Visit',
            data: [87, 57, 74, 99, 75, 38, 62, 47, 82, 56, 45, 54]
        }
    ],
    chart: {
        id: 'area-datetime',
        type: 'area',
        height: 230,
        width: 250,
        dropShadow: {
            enabled: true,
            color: '#000',
            top: 18,
            left: 7,
            blur: 4,
            opacity: 0.075
        },
        zoom: {
            autoScaleYaxis: true
        },
        toolbar: {
            show: false,
        }
    },

    dataLabels: {
        enabled: false
    },
    markers: {
        size: 3,
        strokeWidth: 3,

        hover: {
            size: 6,
        }
    },
    stroke: {
        show: true,
        curve: 'smooth',
        width: 3,
        dashArray: 0,
    },
    xaxis: {
        categories: ['01 Jan', '02 Jan', '03 Jan', '04 Jan', '05 Jan', '06 Jan', '07 Jan', '08 Jan', '09 Jan', '10 Jan', '11 Jan', '12 Jan'],
    },
    yaxis: {
        labels: {
            show: false,
        }
    },
    tooltip: {
        x: {
            format: 'dd MMM yyyy'
        }
    },
    grid: {
        show: true,
        xaxis: {
            lines: {
                show: true,
            }
        },
        yaxis: {
            lines: {
                show: false,
            }
        }
    },
    colors: ["#038edc"],
    fill: {
        opacity: 0.05,
        colors: ["#038edc"],
        type: 'solid',
    },
};

var chart = new ApexCharts(document.querySelector("#acd_score_chart"), options);
chart.render();


// 2) 방사형 그래프
var options = {
  series: [{
	  name: 'Series 1',
	  data: [80, 50, 30, 40, 100],
  }],
  chart: {
	  height: 250,
	  width: 250,
	  type: 'radar',
  },
  xaxis: {
	  categories: ['January', 'February', 'March', 'April', 'May']
  }
};

var chart = new ApexCharts(document.querySelector("#acd_score_area_chart"), options);
chart.render();
</script>

<script>
var page2=1;
var searchtype="";
var keyword="";
var processname="";	
var classCode="";
</script>



<script>
$('#processSelect').on('change',function(){
	 processname=$('#processSelect option:selected').text();
	 classCode=$('#processSelect option:selected').val();
	 pslistgo();
})

</script>


<script>
$(function(){
	 processname=$('#processSelect option:selected').text();
	 classCode=$('#processSelect option:selected').val();
	 pslistgo();
})

</script>

<script>


function pslistgo(){
	
	
	
	$.ajax({
		url : '../rteacher/pslist',
		type : 'get',
		data : {'page' : page2,
	        'searchtype' : searchtype,
	        'keyword' : keyword,
	        'processname':processname},
	    success : function(res){
			str="";
		
		   
			    		$.each(res.processStudentList,function(i,v){                 
			    		str+="<tr id='"+v.id+"'onclick='stuSgo(this);'>";
			    		str+="<td>"+v.id+"</td>";
			    		str+="<td class='stuname'>"+v.name+"</td>";
			    		str+="<td>"+v.schoolName+"</td>";
			    		str+="<td>"+v.grade+"</td>";
			    		str+="</tr>"	
			    		})
			    		
			    		$('#studentlist').html(str);
			    		
			    	
			    		 startPage=res.pageMaker.startPage;
			    		 endPage=res.pageMaker.endPage;
			    	    var pg=res.pageMaker.cri.page;
			    	    var pre=res.pageMaker.prev;
			    	    var next=res.pageMaker.next;
			    	 
			    	    page="";
			    	 
			    	    
			    	    
			    page+='	<ul class="pagination justify-content-center m-0">';
			    page+='	<li class="page-item">';
			    page+='		<a class="page-link">';
			    page+='			<i class="fas fa-angle-double-left"></i>';
			    page+='		</a>';
			    page+='	<li class="page-item">';
			    page+='		<a class="page-link prev" href="#">';
			    page+='			<i class="fas fa-angle-left"></i>';
			    page+='		</a>						                                    ';
			    page+='	</li>                                                                                   ';
			    
			    for(let i=startPage;i<=endPage;i++){
			    	if(pg==i){
			    		  page+='		<li class="page-item active pager">';     
			    	}else{
			    		  page+='		<li class="page-item pager">'; 
			    	}
			    	                      
					    page+='			<a class="page-link pnum" href="#" >'+i+'</a>  ';
					    page+='		</li>';
			    }
			    
			    
			
			    page+='	                                                                                        ';
			    page+='	                                                                                        ';
			    page+='	<li class="page-item">                                                                  ';
			    page+='		<a class="page-link next">                                                       ';
			    page+='			<i class="fas fa-angle-right"></i>                                              ';
			    page+='		</a>						                                                        ';
			    page+='	</li>                                                                                   ';
			    page+='	<li class="page-item">                                                                  ';
			    page+='		<a class="page-link">                                                       ';
			    page+='			<i class="fas fa-angle-double-right"></i>                                       ';
			    page+='		</a>						                                                        ';
			    page+='	</li>                                                                                   ';
			    page+='</ul>	                                                                                    ';
			    		
			    		$('#pagegogo').html(page);
			    		$('#pname').html(processname);
			    		
		},
		error : function(xhr){
			//alert("상태 : " + xhr.status + " 체크");
		},
		dataType : 'json'
	});
	
	
	
	
	
	
	
	
	
	
	
	
}

</script>



<script>

function korGo3(){
	var datatt=[];
	for(let i=0;i<examName.length;i++){
	   datatt.push(examName[i]);
	}
	
	
	
var options = {
	    series: [{
	    name: stuname,
	      data: 
	    	  korScore
	      
	  }],
	    chart: {
	    height: 300,
	    width: 250,
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
var korScore=[];
var examName=[];
var korSubareaScore=[];
var korSubarea=[];
</script>

<script>
var stuname="-";
function stuSgo(t){
	var idim=$(t).attr("id");
	stuname=$(".stuname",t).html();
	$('#stustuna').html(stuname);
	$.ajax({
		url : '<%=request.getContextPath()%>/rteacher/acdemyScoreGet',
		type : 'get',
		data : {'id' :idim,"classCode":classCode},
	    success : function(res){
			var str="";
			if(res.subject=="국어"){
			str+='<thead>';
			str+='	<tr style="background:#8BDDA8;">';
		
			str+='		<th style="font-weight: bold;width:80px;padding:2px;">일자</th>' ;
			str+='		<th style="font-weight: bold;width:120px;padding:2px;">시험명</th>';
			str+='		<th style="font-weight: bold;width:80px;padding:2px;">화작</th>';
			str+='		<th style="font-weight: bold;padding:2px;">문법</th>';
			str+='		<th style="font-weight: bold;padding:2px;">독서</th>';
			str+='		<th style="font-weight: bold;padding:2px;">문학</th>';
			str+='		<th style="font-weight: bold;padding:2px;">점수</th>' ;
			str+='		<th style="font-weight: bold;padding:2px;">성취도</th>';
			str+='	</tr>';
			str+=' </thead>';
			str+='<tbody>';
			var tkor1=0;
			var kor1=0;
			var tkor2=0;
			var kor2=0;
			var tkor3=0;
			var kor3=0;
			var tkor4=0;
			var kor4=0;
			
			
			if(res.eamList==null||res.eamList.length<1){
				// $('#acd_kor_line_chart').empty();
				 $('#acd_kor_chart').empty();
				 $('#kor_line_chart').empty();
				 
				 
				str+='<tr><td colspan="8" style="font-size:1.2em;font-weight:200;">조회된 값이 없습니다.</td></tr>';
				korSubareaScore.push(0,0,0,0);
				korSubarea.push("화작");
				korSubarea.push("문법");
				korSubarea.push("독서");
				korSubarea.push("문학");
				//korGo1();
				 korGo3();
				 korGo2();
				 korSubareaScore.splice(0,korSubareaScore.length);
				 korSubarea.splice(0,korSubarea.length);
			}else{
				
			
			
				 $.each(res.eamList,function(i,v){
					 
				str+=' <tr>';
				str+='	<td>'+(v.regdate.substr(2,9).replace("-","/")).substr(0,5)+"/"+(v.regdate.substr(2,9).replace("-","/")).substr(6,7)+'</td>';
				str+='	<td>'+v.examName+'</td>';
				str+='	<td>'+v.ko1+'/'+v.tko1+'</td>';
				str+='	<td>'+v.ko2+'/'+v.tko2+'</td>';
				str+='	<td>'+v.ko3+'/'+v.tko3+'</td>';
				str+='	<td>'+v.ko4+'/'+v.tko4+'</td>';
				str+='	<td>'+v.academyScore+'</td>';
				str+='	<td>'+v.achievement+'</td>';
				str+='</tr>';
				tkor1=tkor1+v.tko1;
				kor1=kor1+v.ko1;
				tkor2=tkor2+v.tko2;
				kor2=kor2+v.ko2;
				tkor3=tkor3+v.tko3;
				kor3=kor3+v.ko3;
				tkor4=tkor4+v.tko4;
				kor4=kor4+v.ko4;
				korScore.push(v.academyScore);	                                                        
				examName.push(v.examName);	 
				 })
//				 alert(korScore);
				 korSubareaScore.push((kor1/tkor1)*100);
				 korSubareaScore.push((kor2/tkor2)*100);
				 korSubareaScore.push((kor3/tkor3)*100);
				 korSubareaScore.push((kor4/tkor4)*100);
				 korSubarea.push("화작");
				 korSubarea.push("문법");
				 korSubarea.push("독서");
				 korSubarea.push("문학");
				 str+='</tbody>'; 
				// $('#acd_kor_line_chart').empty();
				 $('#acd_kor_chart').empty();
				 $('#kor_line_chart').empty();
				 //korGo1();
				 korGo3();
				 korGo2();
				 korScore.splice(0,korScore.length);
				 examName.splice(0,examName.length);
				 korSubareaScore.splice(0,korSubareaScore.length);
				 korSubarea.splice(0,korSubarea.length);
			}	 
			} 
		
			
			$('#scoreContent').html(str);	
			    		
		},
		error : function(xhr){
			//alert("상태 : " + xhr.status + " 체크");
		},
		dataType : 'json'
	});
	
	
	
	
	
	
	
	
	
}

</script>

<script>
function korGo1(){
	
	var datatt=[];
	for(let i=0;i<examName.length;i++){
	   datatt.push(examName[i]);
	}
	
	
	
	 //국어 line
	  var options = {
			  series: [{
				  name: stuname,
				  data: 
					korScore
				  
			  }],
			  chart: {
				  height: 300,
				  width: 330,
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
				  categories:datatt 
					
				  ,
			  }
	  };

	  var chart = new ApexCharts(document.querySelector("#acd_kor_line_chart"), options);
	  chart.render();
}

</script>
<script>
function korGo2(){
	 //국어 영역
	var datatt=[];
	for(let i=0;i<korSubarea.length;i++){
	   datatt.push(korSubarea[i]);
	}
	

	  var options = {
	          series: [{
	          name: stuname,
	          data: korSubareaScore
	          ,
	        }],
	          chart: {
			  height: 300,
			  width: 330,
	          type: 'radar',
	          toolbar:{
	          	show:false
	          }
	        },
	        xaxis: {
	          categories: datatt
	        
	        }
	  };

	  var chart = new ApexCharts(document.querySelector("#acd_kor_chart"), options);
	  chart.render();

	
	
	
}
</script>




<script>
function bunsuckgo(){
	

}

</script>

<script>
function keygo(e) {

	if (e.keyCode == 13) {
		
	}

}

</script>

</head>
<body>
	<div class="row" >
		<div class="col-sm-5" style="padding-right:0px;height:842px;">
			<div class="card">
				<div class="card-header">
					<div class="justify-content-between d-flex align-items-center" >
			           <h4 class="card-title">학원성적</h4>
			           <a href="<%=request.getContextPath() %>/teacher/studentmanage_school.go" class="btn btn-sm btn-soft-secondary">학교성적 보기&nbsp;&nbsp;<i class="mdi mdi-arrow-right align-middle"></i></a>
			        </div>

					<hr style="margin:4px;">
					
                       <label for="class_title" class="col-sm-3 col-form-label font-size-16"><i class="bx bx-book-bookmark"></i>&nbsp;수업명</label>
                      
												<select class="form-select col-md-3" 
										id="processSelect" >
							           <c:forEach items="${clist}" var="class2">
							           <option value="${ class2.classCode}">${ class2.className}</option>
<%-- 										<option value="${process}" ${process eq selecprocess ? 'selected':'' }>${process}</option> --%>
<%-- 									        <option value="${class}"> --%>
									
									</c:forEach> 
									
									</select> 
                       
                  

					<div class="row" style="margin-top:5px;">
					  <div class="col-4" style="padding-right:0px;">
						<select class="form-select col-md-3" name="searchType"
										id="searchType">
										<option value="ns">전체</option>
										<option value="n" >학생명</option>
										<option value="s">학교명</option>
									</select> 
					  </div>
					  <div class="col-8" style="padding-left:0px;">
						<input class="form-control" type="text" name="keyword" id="keyword"placeholder="검색어를 입력하세요." value="${cri.keyword }" onkeypress="keygo(event);" />
					  </div>
					</div>
				</div>
				<div class="card-body" style="height:540px;">
					<table class="table table-hover text-center">
					  <thead>
						<tr style="background: #8BDDA8;">
							<th style="font-weight: bold;width:90px;vertical-align:middle;">아이디</th>
							<th style="font-weight: bold;width:90px;vertical-align:middle;">이름</th>
							<th style="font-weight: bold;width:140px;vertical-align:middle;">학교</th>
							<th style="font-weight: bold;width:70px;vertical-align:middle;">학년</th>
						</tr>
					  </thead>
					  <tbody style="cursor: pointer;" id="studentlist">
						
					  </tbody>


					</table>


				</div>
				<div class="card-footer">
					<nav aria-label="pds list Navigation">
						<ul class="pagination justify-content-center m-0" id="pagegogo">
							
						</ul>
					</nav>
				</div>
			</div>
		</div>

		<div class="col-sm-7"style="height:835px;" >
			<div class="card" style="height:805px;">
			  <div class="card-header">
			  	<div class="hstack gap-3">
                  <div class="p-1 px-2" style="vertical-align: middle;">
                    <span style="font-weight: bold; font-size: 1.2em;">
                      <i class="uil uil-user me-2"></i><span id="stustuna">---</span>
                    </span>
                  </div>
                  <div class="ms-auto">
                  </div>
                  <div>
                  </div>
               </div>
			  </div>

			  <div class="card-body" style="padding: 10px;">
			    <span class="badge bg-secondary font-size-16 mb-2" id="pname"></span>
			<div style="height:310px;overflow: auto;">
		
			    <table class="table table-hover text-center" id="scoreContent">
				  <thead>
				  <c:if test="${subj=='국어' }">
					<tr style="background:#8BDDA8;">
						
						<th style="font-weight: bold;width:80px;padding:6px;">일자</th>
						<th style="font-weight: bold;width:120px;padding:6px;">시험명</th>
						<th style="font-weight: bold;width:60px;padding:6px;">화작</th>
						<th style="font-weight: bold;padding:6px;">문법</th>
						<th style="font-weight: bold;padding:6px;">독서</th>
						<th style="font-weight: bold;padding:6px;">문학</th>
						<th style="font-weight: bold;padding:6px;">점수</th>
						<th style="font-weight: bold;padding:6px;">성취도</th>
					</tr>
					</c:if>
				  </thead>
				  <tbody>
					<tr>
					<td colspan="8">학생을 선택해 주세요</td>
					</tr>
					
				  </tbody>
				</table>
	</div>
				 <hr>

				 

				 <div class="card">
					<div class="card-body">
					  <div class="row" style="height:295px;">
					    <div class="col-sm-5">
					     <div id="chart-area"></div>
						  <div id="kor_line_chart" class="apex-charts"></div>
					    </div>
					    <div class="col-sm-7" >
					      <div id="acd_kor_chart" class="apex-charts"></div>
					    </div>
					  </div><!-- row 끝 -->
					</div><!-- card-body 끝 -->
				</div><!-- card 끝 -->

			</div><!-- card-body 끝 -->


		</div><!-- card 끝 -->
	</div><!-- col 끝 -->
  </div><!-- row 끝 -->


</body>
