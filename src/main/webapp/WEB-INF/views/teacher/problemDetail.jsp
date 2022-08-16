<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="problem" value="${dataMap.problem}" />
<c:set var="jimoon" value="${dataMap.jimoon}" />
<c:set var="idyo" value="${dataMap.idid}" />
<c:set var="examList" value="${dataMap.exam}" />
<c:set var="odapA" value="${dataMap.odapA}" />
<c:set var="odapB" value="${dataMap.odapB}" />
<c:set var="odapC" value="${dataMap.odapC}" />
<c:set var="fidback" value="${dataMap.fidback}" />
<script>

$(function(){
	
 	if($('#jimoon').val()==""){
 		
 		if($('#type').val()=="주관식"){
	   $('#jxproj').css("display","");
		
		}
 		else{
			$('#jxprog').css("display","");
		
		}
 	}
	else{
		if($('#type').val()=="주관식"){
			$('#joproj').css("display","");
			
		}else{
			$('#joprog').css("display","");
			
		}
	}
	//alert($('#jimoon').val());
	//alert($('#type').val());
})
if($('#picture').val().trim()==""){
	var code="view"+$('#code').val();
	
	$('.'+code).css('display',"none");
}
</script>
<script>
$(function(){
	
	var c=$('#code').val();
   
	ProblemPictureThumb('<%=request.getContextPath()%>',c);
	
})
</script>
<script>
function modify(){
	
  <c:if test="${problem.maker!=idyo}">
 	   alert("수정 할 수없는 문제입니다.");
	</c:if>
 	  <c:if test="${problem.maker==idyo}">
	  location.href="problemModify.go?prC=${problem.problemCode}";
	</c:if>
}

</script>

<script>

function repotgo(){
	var comment=$('#repotComment').val();
	
	 $.ajax({
			url : '<%=request.getContextPath()%>/rteacher/problemRepot.go',
			type : 'get',
			data : {'prC':${problem.problemCode},'comment':comment},
		    success: function(res){
		    	
		    	
		    	
		    	
		    	
					    		
				    		
			},
			error : function(xhr){
				$('.cnl').css("display","");
			},
			dataType : 'json'
		});
	
	 
	$('.repotgo').attr("disabled",true);

	
	$('#exampleModal').modal('hide');
}

</script>

<script>
$(function(){
	<c:if test="${problem.repot==idyo}">
	
	$('.cnl').css("display","");
  </c:if>


 <c:if test="${problem.repot!='0'}">
 $('.repotgo').attr("disabled",true);

</c:if>

<c:if test="${problem.repot=='0'}">
$('.repotgo').attr("disabled",false);
</c:if>
<c:if test="${empty problem.repot}">
$('.repotgo').attr("disabled",false);
</c:if>
})

</script>

<script>
function cancelgo(){
	
	$.ajax({
		url : '<%=request.getContextPath()%>/rteacher/problemRepotcancel.go',
		type : 'get',
		data : {'prC':${problem.problemCode}},
	    success: function(res){
	    	
	    
				    		
			    		
		},
		error : function(xhr){
			
		},
		dataType : 'json'
	});
	$('.repotgo').attr("disabled",false);
	$('.cnl').css("display","none");
	
}


</script>

<script>
function backgo(){
	location.href="<%=request.getContextPath()%>/teacher/problemmanage.go";
}

</script>







<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>
</head>
<body>

	<input type="hidden" id="jimoon" value="${jimoon}">
	<input type="hidden" id="type" value="${problem.lproblem }">
	<input type="hidden" id="picture" value="${problem.picture}">
	<input type="hidden" id="code" value="${problem.problemCode}">

	<div class="card" style="height:700px; display: none;" id="jxprog">
		<div class="row">

			<div class="col-sm-6" style="margin-top: 20px;">
				<c:if test="${empty jimoon}">
					<c:if test="${problem.lproblem=='객관식'}">
						<div class="card-body" style="padding: 15px;">
							<div class="d-flex">
						
							

								<div style="margin-bottom:10px;width:100%">
								
								
								<c:if test="${idyo==problem.maker}">
								
								
								
									<button type="button" class="btn btn-warning"
										style="height: 30px; line-height: 5px; margin-right: 5px;float:right;"
										onclick="modify();">수정</button>
										</c:if>
								</div>
								<button type="button" class="btn btn-success"
										style="height: 30px;width:100px; line-height: 5px; margin-right: 5px;float:right;"
										onclick="backgo();">뒤로가기</button>


							</div>
							<div class="view${problem.problemCode}" id="pictureView2"
								style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">
							</div>

							<div class="bg-light"
								style="padding: 15px; border-radius: 10px; height: 200px; overflow: auto; margin-bottom: 10px;"
								id="preViewContent">
								<div id=maincontent></div>

								<p style="margin-left: 10px; margin-bottom: 0px;">

									${problem.problemContent} <br> ①${problem.none}<label
										id='1'></label><br>②${problem.ntwo}<label id='2'></label><br>③${problem.ntree}<label
										id='3'></label><br>④${problem.nfour}<label id='4'></label><br>⑤${problem.nfive}<label
										id='5'></label>

								</p>
							</div>

							<p style="font-weight: bold; margin-top: 15px;">해설 및 답</p>
							<div class="bg-light"
								style="padding: 15px; border-radius: 10px; height: 200px; overflow: auto;">
								<p>
									정답<span
										style="font-weight: bold; color: red; margin-left: 15px;"
										id="dap"> <c:if test="${problem.problemAnswer=='1'}">
									①${problem.none}
									</c:if> <c:if test="${problem.problemAnswer=='2'}">
									②${problem.ntwo}
									</c:if> <c:if test="${problem.problemAnswer=='3'}">
									③${problem.ntree}
									</c:if> <c:if test="${problem.problemAnswer=='4'}">
									④${problem.nfour}
									</c:if> <c:if test="${problem.problemAnswer=='5'}">
									⑤${problem.nfive}
									</c:if>
									</span>
								</p>
								<div id="sol">${problem.problemSolution}</div>
							</div>

						</div>
					</c:if>
				</c:if>
			</div>
			
			<div class="col-sm-6" style="margin-top: 30px; pading-right: 10px;">

				<div class="card" style="width: 95%; height: 650px;">
					<div class="card-body" style="width: 90%;">
						<h5 style="font-weight: bold; margin-bottom: 15px;width:420px;">
						<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제된 강의
						<div id="cancel" style="display:none;"class="cnl">
						<button type="button" class="btn btn-success repotcancel "
							style="margin-right: 5px;margin-bottom:10px; height: 30px; line-height: 5px;float:right;"
							onclick="cancelgo();">취소하기</button>
						</div>
						<div >
						<c:if test="${problem.maker!=idyo}">
						<button type="button" class="btn btn-danger repotgo"
							style="margin-right: 5px;margin-bottom:10px; height: 30px; line-height: 5px;float:right;"
							data-bs-toggle="modal" data-bs-target="#exampleModal"id="rpb">신고하기</button>
							</c:if>
						</div>
						
						</h5>
					<div style="height:250px;width:420px;overflow:auto;">
						<table class="table text-center table-hover"
							style="height: auto; text-align: center;">
							<thead>
								<tr style="width:340px;">
									<th data-column-id="name"
										style="font-weight: bold; background: #8BDDA8; width: 120px;"><div
											class="gridjs-th-content">강의 명</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;"><div
											class="gridjs-th-content">강의등급</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;"><div
											class="gridjs-th-content">오답률</div></th>

								</tr>
							</thead>
							<tbody>
						
						
									 <c:forEach items="${examList}" var="exam">
										
											<tr>
												<td data-column-id="name" >${exam.className}</td>
												<td data-column-id="name" >${exam.classRank}</td>
												
												<td data-column-id="email" style="text-align: center;padding:8px;">${exam.problemOdap }%</td>
												
											
<!-- 												<td><button class="btn btn-danger btn-rounded btn-sm" onclick="repot(this);">신고하기</button></td> -->
											</tr>
										</c:forEach>
											
								<c:if test="${empty examList}">
									<td rowspan="3" colspan="3" style="font-size:1.6em;">시험에 출제된적 없습니다.</td>
								</c:if>
								
								
							</tbody>
						</table>
						</div>
					
							<h5 style="font-weight: bold; margin-bottom: 15px;width:450px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>만든이: ${problem.maker}
							</div>
							<div class="col-sm-7">
							<i class="uil-book-open" style="margin-right: 10px;"></i>단원: ${problem.subunitName}
							
							</div>
							</div>
							</h5>
							<h5 style="font-weight: bold; margin-bottom: 15px;width:450px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>과목:${problem.subdetailName}
							</div>
							<div class="col-sm-7">
							<i class="uil-book-open" style="margin-right: 10px;"></i>난이도: ${problem.plevel}
							</div>
							</div>
							</h5>
								<h5 style="font-weight: bold; margin-bottom: 15px;width:450px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>영역:${problem.saname}
							</div>
							<div class="col-sm-7">
								<c:if test="${!empty examList}">
							<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제일: ${examList.get(0).startDate.substring(2,10).replace('-','/')}
								</c:if>
										<c:if test="${empty examList}">
							<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제일:--
								</c:if>
							</div>
							</div>
							</h5>
					<hr>
					<h6 style="text-align:left;color:gray"><i class="bx bx-health"></i>강의 수준별 오답률</h6>
					
						<div style="width:420px;margin-left:0px;">
						<table class="table text-center table-hover"
							style="height: auto; text-align: center;">
							<thead>
								<tr style="width:340px;">
									<th data-column-id="name"
										style="font-weight: bold; background: #8BDDA8; width: 70px;"><div
											class="gridjs-th-content">A수준</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;"><div
											class="gridjs-th-content">B수준</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;"><div
											class="gridjs-th-content">C수준</div></th>

								</tr>
							</thead>
							<tbody>
						
						
									
										
											<tr>
												<td data-column-id="name" >${odapA}%</td>
												<td data-column-id="name" >${odapB}%</td>
												
												<td data-column-id="email" style="text-align: center;padding:8px;">${odapC}%</td>
												
											
<!-- 												<td><button class="btn btn-danger btn-rounded btn-sm" onclick="repot(this);">신고하기</button></td> -->
											</tr>
												<tr>
												<td data-column-id="name" colspan="3">${fidback}</td>
												
												
											
											</tr>
									
											
								<c:if test="${empty examList}">
								<tr>
									<td rowspan="3" colspan="3" style="font-size:1.6em;">시험에 출제된적 없습니다.</td>
								</tr>
								</c:if>
								
								
							</tbody>
						</table>
						</div>			
						
						
						</div>	
							
					</div>

				</div>
</div>







			</div>
		</div>







		<div class="card" style="height: 700px; display: none;" id="jxproj">
			<div class="row">
			
				<div class="col-sm-6"
					style="margin-top: 30px; height: 600px;">
					<c:if test="${empty jimoon}">
						<c:if test="${problem.lproblem=='주관식'}">
							<div class="card-body" style="padding: 15px;">
								<div class="d-flex">
									<div style="margin-bottom:10px;width:100%">
											<button type="button" class="btn btn-success"
										style="height: 30px;width:100px; line-height: 5px; margin-right: 5px;float:right;"
										onclick="backgo();">뒤로가기</button>
								<c:if test="${idyo==problem.maker}">
									<button type="button" class="btn btn-warning"
										style="height: 30px; line-height: 5px; margin-right: 5px;float:right;"
										onclick="modify();">수정</button>
										</c:if>
									
								</div>
									<div>
										
									</div>
								</div>




								<div class="view${problem.problemCode }" id="pictureView2"
									style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">
								</div>
								<div class="bg-light"
									style="padding: 15px; border-radius: 10px;" id="preViewContent">
									<div id=maincontent>${problem.problemContent}</div>
								</div>
								<div style="height: 150px;">
									<p style="font-weight: bold; margin-top: 15px;">답</p>
									<div class="bg-light"
										style="padding: 15px; border-radius: 10px;">
										<p style="color: red; margin-bottom: 0px;" id='dap2'>${problem.problemAnswer}</p>
									</div>
									<p style="font-weight: bold; margin-top: 15px;">해설</p>
									<div class="bg-light"
										style="padding: 15px; border-radius: 10px;" id="sol">${problem.problemSolution}</div>
								</div>
							</div>
						</c:if>
					</c:if>
				</div>
				<div class="col-sm-6" style="margin-top: 30px; pading-right: 10px;">

				<div class="card" style="width: 95%; height: 650px;">
					<div class="card-body" style="width: 90%;">
						<h5 style="font-weight: bold; margin-bottom: 15px;width:420px;">
						<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제된 강의
						<div id="cancel" style="display:none;"class="cnl">
						<button type="button" class="btn btn-success repotcancel"
							style="margin-right: 5px;margin-bottom:10px; height: 30px; line-height: 5px;float:right;"
							onclick="cancelgo();">취소하기</button>
						</div>
						<div >
						<c:if test="${problem.maker!=idyo}">
						<button type="button" class="btn btn-danger repotgo"
							style="margin-right: 5px;margin-bottom:10px; height: 30px; line-height: 5px;float:right;"
							data-bs-toggle="modal" data-bs-target="#exampleModal"id="rpb">신고하기</button>
							</c:if>
						</div>
						
						</h5>
					<div style="height:250px;width:420px;overflow:auto;">
						<table class="table text-center table-hover"
							style="height: auto; text-align: center;">
							<thead>
								<tr style="width:340px;">
									<th data-column-id="name"
										style="font-weight: bold; background: #8BDDA8; width: 120px;"><div
											class="gridjs-th-content">강의 명</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;"><div
											class="gridjs-th-content">강의등급</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;"><div
											class="gridjs-th-content">오답률</div></th>

								</tr>
							</thead>
							<tbody>
						
						
									 <c:forEach items="${examList}" var="exam">
										
											<tr>
												<td data-column-id="name" >${exam.className}</td>
												<td data-column-id="name" >${exam.classRank}</td>
												
												<td data-column-id="email" style="text-align: center;padding:8px;">${exam.problemOdap }%</td>
												
											
<!-- 												<td><button class="btn btn-danger btn-rounded btn-sm" onclick="repot(this);">신고하기</button></td> -->
											</tr>
										</c:forEach>
											
								<c:if test="${empty examList}">
									<td rowspan="3" colspan="3" style="font-size:1.6em;">시험에 출제된적 없습니다.</td>
								</c:if>
								
								
							</tbody>
						</table>
						</div>
							<h5 style="font-weight: bold; margin-bottom: 15px;width:450px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>만든이: ${problem.maker}
							</div>
							<div class="col-sm-7">
							<i class="uil-book-open" style="margin-right: 10px;"></i>단원: ${problem.subunitName}
							
							</div>
							</div>
							</h5>
							<h5 style="font-weight: bold; margin-bottom: 15px;width:450px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>과목:${problem.subdetailName}
							</div>
							<div class="col-sm-7">
							<i class="uil-book-open" style="margin-right: 10px;"></i>난이도: ${problem.plevel}
							</div>
							</div>
							</h5>
								<h5 style="font-weight: bold; margin-bottom: 15px;width:450px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>영역:${problem.saname}
							</div>
							<div class="col-sm-7">
								<c:if test="${!empty examList}">
							<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제일: ${examList.get(0).startDate.substring(2,10).replace('-','/')}
								</c:if>
										<c:if test="${empty examList}">
							<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제일:--
								</c:if>
							</div>
							</div>
							</h5>
					<hr>
										<h6 style="text-align:left;color:gray"><i class="bx bx-health"></i>강의 수준별 오답률</h6>

					
					
						<div style="width:420px;margin-left:0px;">
						<table class="table text-center table-hover"
							style="height: auto; text-align: center;">
							<thead>
								<tr style="width:340px;">
									<th data-column-id="name"
										style="font-weight: bold; background: #8BDDA8; width: 70px;"><div
											class="gridjs-th-content">A등급</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;"><div
											class="gridjs-th-content">B등급</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;"><div
											class="gridjs-th-content">C등급</div></th>

								</tr>
							</thead>
							<tbody>
						
						
									
										
											<tr>
												<td data-column-id="name" >${odapA}%</td>
												<td data-column-id="name" >${odapB}%</td>
												
												<td data-column-id="email" style="text-align: center;padding:8px;">${odapC}%</td>
												
											
<!-- 												<td><button class="btn btn-danger btn-rounded btn-sm" onclick="repot(this);">신고하기</button></td> -->
											</tr>
												<tr>
												<td data-column-id="name" colspan="3">${fidback}</td>
												
												
											
											</tr>
									
											
								<c:if test="${empty examList}">
								<tr>
									<td rowspan="3" colspan="3" style="font-size:1.6em;">시험에 출제된적 없습니다.</td>
								</tr>
								</c:if>
								
								
							</tbody>
						</table>
						</div>			
						
						
						</div>	
							
					</div>

				</div>
</div>
			</div>

		</div>



		<div class="card" style="height: 700px; display: none;" id='joprog'>


			<c:if test="${!empty jimoon}">
				<c:if test="${problem.lproblem=='객관식'}">


					<div class="row" style="height: 720px;">

						<div class="card col-sm-4" id="지문"
							style="height: 720px; overflow: auto;">${jimoon}</div>
						<div class="card col-sm-4" style="height: 720px;">
							<div class="card" style="height: 700px;" id="jxprog">
								<div class="card-body"
									style="padding: 15px;">
									<div class="d-flex">
									

									<div style="margin-bottom:10px;width:100%">
									<c:if test="${idyo==problem.maker}">
									<button type="button" class="btn btn-warning"
										style="height: 30px; line-height: 5px; margin-right: 5px;float:right;"
										onclick="modify();">수정</button>
										</c:if>
											<button type="button" class="btn btn-success"
										style="height: 30px;width:100px; line-height: 5px; margin-right: 5px;float:right;"
										onclick="backgo();">뒤로가기</button>
								</div>
										


									</div>
									<div class="view${problem.problemCode }" id="pictureView2"
										style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">
									</div>

									<div class="bg-light"
										style="padding: 15px; border-radius: 10px; height: 170px; overflow: auto; margin-bottom: 10px;"
										id="preViewContent">
										<div id=maincontent>${problem.problemContent}</div>

										<p style="margin-left: 10px; margin-bottom: 0px;">
											①${problem.none}<label id='1'></label><br>②${problem.ntwo}<label
												id='2'></label><br>③${problem.ntree}<label id='3'></label><br>④${problem.nfour}<label
												id='4'></label><br>⑤${problem.nfive}<label id='5'></label>
										</p>
									</div>

									<p style="font-weight: bold; margin-top: 15px;">해설 및 답</p>
									<div class="bg-light"
										style="padding: 15px; border-radius: 10px; height: 180px; overflow: auto;">
										<p>
											정답<span
												style="font-weight: bold; color: red; margin-left: 15px;"
												id="dap"> <c:if test="${problem.problemAnswer=='1'}">
									①${problem.none}
									</c:if> <c:if test="${problem.problemAnswer=='2'}">
									②${problem.ntwo}
									</c:if> <c:if test="${problem.problemAnswer=='3'}">
									③${problem.ntree}
									</c:if> <c:if test="${problem.problemAnswer=='4'}">
									④${problem.nfour}
									</c:if> <c:if test="${problem.problemAnswer=='5'}">
									⑤${problem.nfive}
									</c:if>
											</span>
										</p>
										<div id="sol">${problem.problemSolution}</div>
									</div>




								</div>





							</div>
							
						</div>
<div class="card col-sm-4">
<div class="card" style="width: 95%; height: 650px;">
					<div class="card-body" style="width: 90%;">
						<h6 style="font-weight: bold; margin-bottom: 15px;width:270px;">
						<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제된 강의
						<div id="cancel" style="display:none;"class="cnl">
						<button type="button" class="btn btn-success repotcancel"
							style="margin-right: 5px;margin-bottom:10px; height: 30px; line-height: 5px;float:right;"
							onclick="cancelgo();">취소하기</button>
						</div>
						<div >
						<c:if test="${problem.maker!=idyo}">
						<button type="button" class="btn btn-danger repotgo"
							style="margin-right: 5px;margin-bottom:10px; height: 30px; line-height: 5px;float:right;"
							data-bs-toggle="modal" data-bs-target="#exampleModal"id="rpb">신고하기</button>
							</c:if>
						</div>
						
						</h6>
					<div style="height:250px;width:260px;overflow:auto;">
						<table class="table text-center table-hover"
							style="height: auto; text-align: center;">
							<thead>
								<tr style="width:200px;">
									<th data-column-id="name"
										style="font-weight: bold; background: #8BDDA8; width: 40px;font-size:0.4em;"><div
											class="gridjs-th-content">강의 명</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 20px;font-size:0.4em;"><div
											class="gridjs-th-content">강의등급</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 20px;font-size:0.4em;"><div
											class="gridjs-th-content">오답률</div></th>

								</tr>
							</thead>
							<tbody>
						
						
									 <c:forEach items="${examList}" var="exam">
										
											<tr>
												<td data-column-id="name" style="font-size:0.4em;">${exam.className}</td>
												<td data-column-id="name"style="font-size:0.4em;" >${exam.classRank}</td>
												
												<td data-column-id="email" style="text-align: center;padding:8px;font-size:0.4em;">${exam.problemOdap }%</td>
												
											
<!-- 												<td><button class="btn btn-danger btn-rounded btn-sm" onclick="repot(this);">신고하기</button></td> -->
											</tr>
										</c:forEach>
											
								<c:if test="${empty examList}">
									<td rowspan="3" colspan="3" style="font-size:1.6em;">시험에 출제된적 없습니다.</td>
								</c:if>
								
								
							</tbody>
						</table>
						</div>
							<h6 style="font-weight: bold; margin-bottom: 15px;width:280px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>만든이: ${problem.maker}
							</div>
							<div class="col-sm-7">
							<i class="uil-book-open" style="margin-right: 10px;"></i>단원: ${problem.subunitName}
							
							</div>
							</div>
							</h6>
							<h6 style="font-weight: bold; margin-bottom: 15px;width:280px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>과목:${problem.subdetailName}
							</div>
							<div class="col-sm-7">
							<i class="uil-book-open" style="margin-right: 10px;"></i>난이도: ${problem.plevel}
							</div>
							</div>
							</h6>
								<h6 style="font-weight: bold; margin-bottom: 15px;width:280px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>영역:${problem.saname}
							</div>
							<div class="col-sm-7">
								<c:if test="${!empty examList}">
							<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제일:${(examList.get(0).startDate.substring(2,10)).replace("-", "")}
								</c:if>
										<c:if test="${empty examList}">
							<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제일:--
								</c:if>
							</div>
							</div>
							</h6>
					<hr>
										<h6 style="text-align:left;color:gray"><i class="bx bx-health"></i>강의 수준별 오답률</h6>
					
					
					
						<div style="width:280px;margin-left:0px;">
						<table class="table text-center table-hover"
							style="height: auto; text-align: center;">
							<thead>
								<tr style="width:280px;">
									<th data-column-id="name"
										style="font-weight: bold; background: #8BDDA8; width: 70px;font-size:0.4em;"><div
											class="gridjs-th-content">A등급</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;font-size:0.4em;"><div
											class="gridjs-th-content">B등급</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;font-size:0.4em;	"><div
											class="gridjs-th-content">C등급</div></th>

								</tr>
							</thead>
							<tbody>
						
						
									
										
											<tr>
												<td data-column-id="name" >${odapA}%</td>
												<td data-column-id="name" >${odapB}%</td>
												
												<td data-column-id="email" style="text-align: center;padding:8px;">${odapC}%</td>
												
											
<!-- 												<td><button class="btn btn-danger btn-rounded btn-sm" onclick="repot(this);">신고하기</button></td> -->
											</tr>
												<tr>
												<td data-column-id="name" colspan="3">${fidback}</td>
												
												
											
											</tr>
									
											
								<c:if test="${empty examList}">
								<tr>
									<td rowspan="3" colspan="3" style="font-size:1.6em;">시험에 출제된적 없습니다.</td>
								</tr>
								</c:if>
								
								
							</tbody>
						</table>
						</div>			
						
						
						</div>	
							
					</div>


</div>



					</div>
				</c:if>
			</c:if>
		</div>







		<div class="card" style="height: 700px; display: none;" id="joproj">


			<c:if test="${!empty jimoon}">
				<c:if test="${problem.lproblem=='주관식'}">

					<div class="row" style="height: 720px;">

						<div class="card col-sm-4" id="지문"
							style="height: 720px; overflow: auto;">${jimoon}</div>
						
						<div class="card col-sm-4">
					<div class="card-body" style="padding: 15px;">
								<div class="d-flex">
									<div style="margin-bottom:10px;width:100%">
									<c:if test="${idyo==problem.maker}">
									<button type="button" class="btn btn-warning"
										style="height: 30px; line-height: 5px; margin-right: 5px;float:right;"
										onclick="modify();">수정</button>
										</c:if>
											<button type="button" class="btn btn-success"
										style="height: 30px;width:100px; line-height: 5px; margin-right: 5px;float:right;"
										onclick="backgo();">뒤로가기</button>
								</div>
									<div>
										
									</div>
								</div>




								<div class="view${problem.problemCode }" id="pictureView2"
									style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">
								</div>
								<div class="bg-light"
									style="padding: 15px; border-radius: 10px;" id="preViewContent">
									<div id=maincontent>${problem.problemContent}</div>
								</div>
								<div style="height: 150px;">
									<p style="font-weight: bold; margin-top: 15px;">답</p>
									<div class="bg-light"
										style="padding: 15px; border-radius: 10px;">
										<p style="color: red; margin-bottom: 0px;" id='dap2'>${problem.problemAnswer}</p>
									</div>
									<p style="font-weight: bold; margin-top: 15px;">해설</p>
									<div class="bg-light"
										style="padding: 15px; border-radius: 10px;" id="sol">${problem.problemSolution}</div>
								</div>
							</div>
							
						</div>
						<div class="card col-sm-4" style="height: 650px;">
							<div class="card" style="width: 95%; height: 650px;">
					<div class="card-body" style="width: 90%;">
						<h6 style="font-weight: bold; margin-bottom: 15px;width:270px;">
						<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제된 강의
						<div id="cancel" style="display:none;"class="cnl">
						<button type="button" class="btn btn-success repotcancel"
							style="margin-right: 5px;margin-bottom:10px; height: 30px; line-height: 5px;float:right;"
							onclick="cancelgo();">취소하기</button>
						</div>
						<div >
						
						<c:if test="${problem.maker!=idyo}">
						<button type="button" class="btn btn-danger repotgo"
							style="margin-right: 5px;margin-bottom:10px; height: 30px; line-height: 5px;float:right;"
							data-bs-toggle="modal" data-bs-target="#exampleModal"id="rpb">신고하기</button>
							</c:if>
						</div>
						
						</h6>
					<div style="height:250px;width:260px;overflow:auto;">
						<table class="table text-center table-hover"
							style="height: auto; text-align: center;">
							<thead>
								<tr style="width:200px;">
									<th data-column-id="name"
										style="font-weight: bold; background: #8BDDA8; width: 40px;font-size:0.4em;"><div
											class="gridjs-th-content">강의 명</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 20px;font-size:0.4em;"><div
											class="gridjs-th-content">강의등급</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 20px;font-size:0.4em;"><div
											class="gridjs-th-content">오답률</div></th>

								</tr>
							</thead>
							<tbody>
						
						
									 <c:forEach items="${examList}" var="exam">
										
											<tr>
												<td data-column-id="name" style="font-size:0.4em;">${exam.className}</td>
												<td data-column-id="name"style="font-size:0.4em;" >${exam.classRank}</td>
												
												<td data-column-id="email" style="text-align: center;padding:8px;font-size:0.4em;">${exam.problemOdap }%</td>
												
											
<!-- 												<td><button class="btn btn-danger btn-rounded btn-sm" onclick="repot(this);">신고하기</button></td> -->
											</tr>
										</c:forEach>
											
								<c:if test="${empty examList}">
									<td rowspan="3" colspan="3" style="font-size:1.6em;">시험에 출제된적 없습니다.</td>
								</c:if>
								
								
							</tbody>
						</table>
						</div>
							<h6 style="font-weight: bold; margin-bottom: 15px;width:280px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>만든이: ${problem.maker}
							</div>
							<div class="col-sm-7">
							<i class="uil-book-open" style="margin-right: 10px;"></i>단원: ${problem.subunitName}
							
							</div>
							</div>
							</h6>
							<h6 style="font-weight: bold; margin-bottom: 15px;width:280px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>과목:${problem.subdetailName}
							</div>
							<div class="col-sm-7">
							<i class="uil-book-open" style="margin-right: 10px;"></i>난이도: ${problem.plevel}
							</div>
							</div>
							</h6>
								<h6 style="font-weight: bold; margin-bottom: 15px;width:280px;">
						<div class="row">
							<div class="col-sm-5">
							<i class="uil-book-open" style="margin-right: 10px;"></i>영역:${problem.saname}
							</div>
							<div class="col-sm-7">
								<c:if test="${!empty examList}">
							<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제일:${(examList.get(0).startDate.substring(2,10)).replace("-", "")}
								</c:if>
										<c:if test="${empty examList}">
							<i class="uil-book-open" style="margin-right: 10px;"></i>최근 출제일:--
								</c:if>
							</div>
							</div>
							</h6>
					<hr>
										<h6 style="text-align:left;color:gray"><i class="bx bx-health"></i>강의 수준별 오답률</h6>
					
					
					
						<div style="width:280px;margin-left:0px;">
						<table class="table text-center table-hover"
							style="height: auto; text-align: center;">
							<thead>
								<tr style="width:280px;">
									<th data-column-id="name"
										style="font-weight: bold; background: #8BDDA8; width: 70px;font-size:0.4em;"><div
											class="gridjs-th-content">A등급</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;font-size:0.4em;"><div
											class="gridjs-th-content">B등급</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8; width: 70px;font-size:0.4em;	"><div
											class="gridjs-th-content">C등급</div></th>

								</tr>
							</thead>
							<tbody>
						
						
									
										
											<tr>
												<td data-column-id="name" >${odapA}%</td>
												<td data-column-id="name" >${odapB}%</td>
												
												<td data-column-id="email" style="text-align: center;padding:8px;">${odapC}%</td>
												
											
<!-- 												<td><button class="btn btn-danger btn-rounded btn-sm" onclick="repot(this);">신고하기</button></td> -->
											</tr>
												<tr>
												<td data-column-id="name" colspan="3">${fidback}</td>
												
												
											
											</tr>
									
											
								<c:if test="${empty examList}">
								<tr>
									<td rowspan="3" colspan="3" style="font-size:1.6em;">시험에 출제된적 없습니다.</td>
								</tr>
								</c:if>
								
								
							</tbody>
						</table>
						</div>			
						
						
						</div>	
							
					</div>

							
						</div>
						
						
		
						
						</div>	
							
					</div>


</div>



					</div>
				</c:if>
			</c:if>
		</div>
		
		
		
		
		
	
		
		
		
		<div class="modal" tabindex="-1"id="exampleModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">신고내용을 적어주세요</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" >
        <input type="text" id="repotComment" style="width:440px;">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="repotgo();">완료</button>
      </div>
    </div>
  </div>
</div>
		
		
		
		
		
		
		
		
		
		
</body>
</html>