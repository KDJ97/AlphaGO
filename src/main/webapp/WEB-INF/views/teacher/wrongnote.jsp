<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>Insert title here</title>

<head>
<style type="text/css">
.modal-dialog{
	max-width: 800px;
}
</style>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="examList" value="${dataMap.examList }" />
<c:set var="classList" value="${dataMap.classList }" />
<c:set var="average" value="${dataMap.average }" />


<script>
var classCode="";
$(function(){
	$('#cnselct').on('change',function(){
		classCode=$(this).val();
		examSearch();
	})
})


</script>



<script>
$(function(){
	classCode=$('#cnselct').val();
	examSearch();
})

</script>
<script>
var examCode2="";
var stuName2="";
function wrongGo2(){
	 $.ajax({
			url : '<%=request.getContextPath()%>/rteacher/wrongExamProblem',
			type : 'get',
			data : {"examCode":examCode2},
		    success : function(res){
		   		str="";
		   		var cnt=0;
		   		
		   		$.each(res,function(i,v){
		   		 
				if(v.wrongCheck!="o"){
					str+='<tr>';
					str+='	<td data-column-id="name"style="font-size:0.6em;vertical-align:middle;">'+(i+1)+'</td>';
					str+='	<td data-column-id="name"style="font-size:0.6em;vertical-align:middle;">'+v.problemAnswer+'</td> ';
					str+='	<td data-column-id="company"style="font-size:0.6em;vertical-align:middle;">-</td>';
					str+='</tr>';
				}else{
					if(v.quCheck=='o'){
						if(v.awCheck=='o'){
				str+='	<tr class="bg-soft-danger">';
				str+='	<td data-column-id="name"style="font-size:0.6em;vertical-align:middle;" class="no'+(i+1)+'">'+(i+1)+'</td>';
				str+='	<td data-column-id="name"style="font-size:0.6em;vertical-align:middle;">'+v.problemAnswer+'</td>';
				str+='	<td data-column-id="company"style="font-size:1em;vertical-align:middle;"><button type="button"';
				str+='	class="btn btn-primary" style="font-size: 0.6em;"';
	
				str+=' id="an'+v.odapNo+'"onclick="answerModifyGo(this);"style="font-size:0.4em;">수정하기</button></td>';
				str+='</tr>';
							                                                                          		
						}else{
					if(v.problemPrintcode==0){
						str+='<tr class="bg-soft-danger x" >';
					}else{
						str+='<tr class="bg-soft-danger o" >';
					}
					
					str+='	<td data-column-id="name"style="font-size:0.6em;vertical-align:middle;" class="no'+(i+1)+'">'+(i+1)+'</td>';
					str+='	<td data-column-id="name"style="font-size:0.6em;vertical-align:middle;">'+v.problemAnswer+'</td>';
					str+='	<td data-column-id="company"style="font-size:0.6em;vertical-align:middle;"><button type="button"';
					str+='	class="btn btn-success" style="font-size: 0.8em;"';
		
					str+=' id="an'+v.odapNo+'"onclick="answerGo(this);">답변하기</button></td>';
					str+='</tr>';
                                                                                    	
						}
					}else{
						str+='<tr class="bg-soft-danger">';
						str+='	<td data-column-id="name"style="font-size:0.6em;vertical-align:middle;">'+(i+1)+'</td>';
						str+='	<td data-column-id="name"style="font-size:0.6em;vertical-align:middle;">'+v.problemAnswer+'</td>';
						str+='	<td data-column-id="company"style="font-size:0.6em;vertical-align:middle;">-';
					    str+='</td>';
						str+='</tr>';
					}
				}
				
		   			$('#stuname').html(stuName2);                                     
		   			$('#proNo').html(res.length);
		   			$('#wrongContent').html(str);
		   			
		   			
		   		})
		    	
		    	
			},
			error : function(xhr){
			
			},
			dataType : 'json'
		});
	
	
	
	
	
}

</script>

<script>
//시험 눌렀을시 오답 확인하기
function worongGo(t){
	var examCode=$(t).attr("id").substring(2);
	var stuName=$('.stuname',t).html();
	
	examCode2=examCode;
	stuName2=stuName;
	 $.ajax({
			url : '<%=request.getContextPath()%>/rteacher/wrongExamProblem',
			type : 'get',
			data : {"examCode":examCode},
		    success : function(res){
		   		str="";
		   		var cnt=0;
		   		
		   		$.each(res,function(i,v){
		   		 
				if(v.wrongCheck!="o"){
					str+='<tr>';
					str+='	<td data-column-id="name"style="font-size:1em;vertical-align:middle;padding:5px;">'+(i+1)+'</td>';
					str+='	<td data-column-id="name"style="font-size:1em;vertical-align:middle;padding:5px;">'+v.problemAnswer+'</td> ';
					str+='	<td data-column-id="company"style="font-size:1em;vertical-align:middle;padding:5px;">-</td>';
					str+='</tr>';
				}else{
					if(v.quCheck=='o'){
						if(v.awCheck=='o'){
				str+='	<tr class="bg-soft-danger">';
				str+='	<td data-column-id="name"style="font-size:0.6em;vertical-align:middle;" class="no'+(i+1)+'">'+(i+1)+'</td>';
				str+='	<td data-column-id="name"style="font-size:1em;vertical-align:middle;">'+v.problemAnswer+'</td>';
				str+='	<td data-column-id="company"style="font-size:1em;vertical-align:middle;"><button type="button"';
				str+='	class="btn btn-primary" style="font-size: 0.6em;"';
	
				str+=' id="an'+v.odapNo+'"onclick="answerModifyGo(this);"style="font-size:0.4em;">수정하기</button><input type="hidden" value="'+v.maker+'>"</td</td>';
				str+='</tr>';
							                                                                          		
						}else{
					if(v.problemPrintcode==0){
						str+='<tr class="bg-soft-danger x" >';
					}else{
						str+='<tr class="bg-soft-danger o" >';
					}
					
					str+='	<td style="font-size:1em;vertical-align:middle;" class="no'+(i+1)+'">'+(i+1)+'</td>';
					str+='	<td data-column-id="name"style="font-size:1em;vertical-align:middle;">'+v.problemAnswer+'</td>';
					str+='	<td data-column-id="company"style="font-size:1em;vertical-align:middle;"><button type="button"';
					str+='	class="btn btn-success" style="font-size: 0.6em;"';
		
					str+=' id="an'+v.odapNo+'"onclick="answerGo(this);"style=font-size:0.4em;>답변하기</button><input type="hidden" value="'+v.maker+'>"</td>';
					str+='</tr>';
                                                                                       	
						}
					}else{
						str+='<tr class="bg-soft-danger">';
						str+='	<td data-column-id="name"style="font-size:1em;vertical-align:middle;">'+(i+1)+'</td>';
						str+='	<td data-column-id="name"style="font-size:1em;vertical-align:middle;">'+v.problemAnswer+'</td>';
						str+='	<td data-column-id="company"style="font-size:1em;vertical-align:middle;">-';
					    str+='</td>';
						str+='</tr>';
					}
				}
				
		   			$('#stuname').html(stuName);                                     
		   			$('#proNo').html(res.length);
		   			$('#wrongContent').html(str);
		   			
		   			
		   		})
		    	
		    	
			},
			error : function(xhr){
			
			},
			dataType : 'json'
		});
}

</script>

<script>
function answerGo(t){
	var jimoonFlag=$(t).parent().parent().attr("class").substr(-1);
	var examNo=$(t).parent().parent().children().first().attr("class").substr(2);
	var examCode=$(t).attr("id").substr(2);
	
	if(jimoonFlag=="o"){
		OpenWindow('answerProblem.go?examCode='+examCode+'&&proNo='+examNo+'','문제디테일',800,750);
	}else{
	
		OpenWindow('answerProblem.go?examCode='+examCode+'&&proNo='+examNo+'','문제디테일',800,580);

	}
	
	
}
</script>
<script>
function answerModifyGo(t){
	
	var jimoonFlag=$(t).parent().parent().attr("class").substr(-1);
	var examNo=$(t).parent().parent().children().first().attr("class").substr(2);
	var examCode=$(t).attr("id").substr(2);
	
	if(jimoonFlag=="o"){
		OpenWindow('modifyAnswer.go?examCode='+examCode+'&&proNo='+examNo+'','문제디테일',800,750);
	}else{
	
		OpenWindow('modifyAnswer.go?examCode='+examCode+'&&proNo='+examNo+'','문제디테일',800,580);

	}
}
</script>


<script>
function examSearch(){
	var examCode="";
	<c:if test="${empty cri.keyword }">
	examCode="x";
	</c:if>
	<c:if test="${! empty cri.keyword }">
	examCode=${cri.keyword };
	</c:if>
	 $.ajax({
			url : '<%=request.getContextPath()%>/rteacher/examSearchClassCode',
			type : 'get',
			data : {'classCode' : classCode,"examCode":examCode},
		    success : function(res){
		    	str=""
		      $.each(res.examList,function(i,v){
		    	  
		    	
		    	 	if(res.examCode=="x"){
			    		  str+="<option value='"+v.examCode+"'>"+v.examName+"</option>"

		    	 	}else{
		    	 		if(res.examCode==v.examCode){
				    		  str+="<option value='"+v.examCode+"'selected>"+v.examName+"</option>"

		    	 		}else{
				    		  str+="<option value='"+v.examCode+"'>"+v.examName+"</option>"

		    	 		}
		    	 	}

		    	  
		    	  		      })
		    	$('#examlist').html(str);
		    	
			},
			error : function(xhr){
			
			},
			dataType : 'json'
		})

}

</script>









<script type="text/javascript">
$(function(){
	$('#search').on('click',function(){
		if($('#cnselct').val()==null){
			return;
		}
		if($('#examlist').val()==null){
			return;
		}
		$('#flag').val("0");
		list_go2(1,'wrongnote.go');
		
		
	})
})

</script>
<script>
function list_go2(page,url){
	//alert(page);
	if(!url) url="wrongnote.go";
	
	var jobForm=$('#wrongForm');
	
	if($('#flag').val()=="1"){
		jobForm.find("[name='page']").val(page);
		
	}
	else{
		jobForm.find("[name='page']").val(page);	
		jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
		jobForm.find("[name='keyword']").val($('select[name="searchType2"]').val());
	}
	
	
	jobForm.attr({
		action:url,
		method:'get'
	}).submit();

}

</script>











</head>
<body>

	<div class="row">
		<div class="col-7">
			<div class="card">
				<div class="card-body" style="padding: 15px;">
					<h5 style="font-weight: bold; margin: 10px 0px 15px 10px;">
						<i class="uil-clipboard-alt" style="margin-right: 10px;"></i>오답 관리
					
					</h5>
					<div>
						<div class="d-flex">
								<select class="form-select col-md-3" name="searchType"
								id="cnselct" style="width:170px;margin-bottom:10px;">
								<c:forEach items="${classList}" var="cll">
								
								
								<option value="${cll.classCode}" ${cll.classCode==cri.searchType?"selected":"" }>
									${cll.className}</option>
								</c:forEach>
								


							</select>
								<select class="form-select col-md-3" name="searchType2"
								id="examlist" style="width:170px;margin-bottom:10px;">
								
								


							</select>
							<button class="btn btn-success" style="float: right;height:40px;"
											type="button" id="search" data-card-widget="search"
											>
											<i class="fa fa-fw fa-search"></i>
										</button>
							
							
							
							<div class="ms-auto">
								<p style="font-weight: bold; color: red;">평균점수 : ${average}점</p>
							</div>
						</div>

					</div>
					<div>


						<div style="width: 100%;">
							<div style="height: 560px;overflow: auto;">
								<table class="table text-center table-hover"
									style="height: auto; text-align: center;">
									<thead>
										<tr>
											<th data-column-id="name"
												style="font-weight: bold; background: #8BDDA8;width:180px;"><div
													class="gridjs-th-content">강의명</div></th>
											<th data-column-id="name"
												style="font-weight: bold; background: #8BDDA8;width:180px;"><div
													class="gridjs-th-content">시험명</div></th>
											<th data-column-id="email"
												style="font-weight: bold; background: #8BDDA8;width:100px;"><div
													class="gridjs-th-content">이름</div></th>
											<th data-column-id="position"
												style="font-weight: bold; background: #8BDDA8;width:100px;"><div
													class="gridjs-th-content">점수</div></th>
											<th data-column-id="position"
												style="font-weight: bold; background: #8BDDA8;width:120px;"><div
													class="gridjs-th-content">성취도</div></th>

										</tr>
									</thead>
									<tbody>
									 <c:forEach items="${examList}" var="exam">
										<tr id="ex${exam.examCode}" onclick="worongGo(this);">
											<td data-column-id="name">${exam.className}</td>
											<td data-column-id="name">${exam.examName }</td>
											<td data-column-id="position" class="stuname">${exam.name }</td>
											<td data-column-id="email">${exam.acardemyScore}</td>
											<c:if test="${average<=exam.acardemyScore }">
											<td data-column-id="email" style="color: blue">적정</td>
											</c:if>
											<c:if test="${average>exam.acardemyScore }">
											<td data-column-id="email" style="color: red">미흡</td>
											</c:if>
										</tr>
									

										</c:forEach>
									</tbody>
								</table>
							</div>

						</div>


					</div>

							<nav aria-label="Navigation">
	<ul id="nav-ul" class="pagination justify-content-center m-0">
		<li class="page-item">
			<a class="page-link" href="javascript:list_pmgo(1,'problemmanage.do');">
				<i class="fas fa-angle-double-left"></i>
			</a>
		<li class="page-item">
			<a class="page-link" href="#">
				<i class="fas fa-angle-left"></i>
			</a>						
		</li>
		
		<c:forEach var="pageNum" begin="${pageMaker.startPage }" 
								 end="${pageMaker.endPage }" >
			<li class="page-li page-item ${cri.page == pageNum?'active':''}">
				<a class="nav-list page-list-link page-link" href="javascript:list_go2('${pageNum}','wrongnote.go');" >${pageNum }</a>
				
			</li>
			
		</c:forEach>
				
		<li class="page-item">
			<a class="page-link" href="#">
				<i class="fas fa-angle-right"></i>
			</a>						
		</li>
		<li class="page-item">
			<a class="page-link" href="#">
				<i class="fas fa-angle-double-right"></i>
			</a>						
		</li>
	</ul>
</nav>   
				</div>
			</div>
		</div>
		<div class="col-5">
			<div class="card">
				<div class="card-body" style="padding: 15px;">
					<h5 style="margin: 10px 0px 15px 10px;">[<span style="font-weight:120;"id="stuname">---</span>] 원생 답안지</h5>
					<div class="d-flex justify-content-end mb-3">문항 수 :<span id="proNo">--</span>개</div>
					<div style="width: 100%; margin-bottom: 10px;">
						<div style="height:650px;;overflow:auto;">
						
							<table class="table text-center"style="height: 590px; text-align: center;">
								<thead>
									<tr>
										<th data-column-id="name"
											style="font-weight: bold; width: 82px; background: #8BDDA8;"><div
												class="gridjs-th-content">문항번호</div></th>
										<th data-column-id="name"
											style="font-weight: bold; width: 150px; background: #8BDDA8;"><div
												class="gridjs-th-content">답</div></th>
										<th data-column-id="email"
											style="font-weight: bold; width: 80px; background: #8BDDA8;"><div
												class="gridjs-th-content">질문답변</div></th>

									</tr>
								</thead>
								<tbody id="wrongContent">
								<tr>
										<td colspan="3">학생을 선택해 주세요</td>
										
									</tr>
								
									
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade bs-example-modal-center" tabindex="-1"
		role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">질문 답변하기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-6">
							<div style="font-weight: bold;">[문제]</div>
							<div>01. 위 발표자의 말하기에 대한 설명으로 적절하지 않은 것은?</div>
							<p style="margin-left: 10px;">
								① 그림을 그리면서 설명을 하여 청중의 이해<br>② 준언어적 표현을 조절하여 발표의 전달력<br>③
								자신의 경험에 비추어 청중의 관심<br> ④ 질문하고 답하는 방식을 사용하여 발표 내용<br> <span
									style="font-weight: bold">⑤ 청중이 얻을 수 있는 효용을 제시하며 실천을 권유</span><br>
							</p>
							<div style="font-weight: bold;">[답]</div>
							<div style="margin-bottom: 15px;">
								<span style="font-weight: bold; color: red;">④ 질문하고 답하는
									방식을 사용하여 발표 내용</span>
							</div>
							<div style="font-weight: bold;">[해설]</div>
							<div style="margin-bottom: 10px;">첫해 배치 에는 두 가지 문제가 있었는데요,
								우선 작물의 키를 고려하지 않았다는 점이에요. 해는 동쪽에서 떠서 한낮에 남쪽을 지나 서쪽으로 지고 해가 떠 있는
								반대 방향으로 그림자가 생기죠. 작물은 광합성이 많이 이루어지는 오전부터 한낮까지 그림자의 영향을 최소한으로 받아야
								잘 자랄 수 있어요. 이를 고려해 키가 작은 작물을 동쪽과 남쪽에 배치해야 해요. 해는 동쪽에서 떠서 한낮에 남쪽을
								지나 서쪽으로 지고 해가 떠 있는 반대 방향으로 그림자가 생기죠. 작물은 광합성이 많이 이루어지는 오전부터 한낮까지
								그림자의 영향을 최소한으로 받아야 잘 자랄 수 있어요. 이를 고려해 키가 작은 작물을 동쪽과 남쪽에 배치해야 해요.</div>
						</div>
						<div class="col-6">
							<div style="font-weight: bold;">[질문]</div>
							<div style="margin-bottom: 15px;">
								<span>해설을 봐도 해는 동쪽에서 떠서 한낮에 남쪽을 지나 서쪽으로 지고 해가 떠 있는 반대
									방향으로 그림자가 생기죠. 작물은 광합성이 많이 이루어지는 오전부터 한낮까지 그림자의 영향을 최소한으로 받아야 잘
									자랄 수 있어요. 이를 고려해 키가 작은 작물을 동쪽과 남쪽에 배치해야 해요 부분이 이해되지 않습니다. 왜 답이
									4번이죠?</span>
							</div>
							<hr>
							<div class="form-floating">
								<textarea class="form-control bg-light text-dark"
									placeholder="Leave a comment here" id="floatingTextarea2"
									style="height: 320px"></textarea>
								<label for="floatingTextarea2" class="text-dark">답변</label>
							</div>

						</div>
					</div>
				</div>
				<div class="card-footer" style="text-align: right;">
					<button type="button" class="btn btn-success">등록하기</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	
	<input type="hidden" id="flag" value="1">
	
	
	
<form id="wrongForm" action="wrongnote.go">
	<input type='hidden' name="page" value="" />
	<input type='hidden' name="searchType" value="" />
	<input type='hidden' name="cateType" value="" />
	<input type='hidden' name="keyword" value="" />
</form>	
	
	
	
	
	
	
	
	

</body>