<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>

 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<c:set var="problem" value="${dataMap.problem }" />
<c:set var="jimoon" value="${dataMap.jimoon }" />
<c:set var="pno" value="${dataMap.pno }" />
<c:set var="examCode" value="${dataMap.examCode }" />
<c:set var="que" value="${dataMap.que}" />
<c:set var="id2" value="${dataMap.idim}" />
<c:set var="answerId" value="${dataMap.answerId}" />
<script>
$(function(){
	
	ProblemPictureThumb('<%=request.getContextPath()%>',${problem.problemCode});
})

</script>

<script>
$(function(){
	$(".anbn").on('click',function(){
		var answer=$('.answer').val();
	
	
		Swal.fire({
		      icon: 'success',
		      title: '답변이 등록되었습니다.'
		      
		    }).then((result) => {
	  	
		    	var id2=$('#idim').val();
				var anid=$('#anid').val();
				 location.href="answerInput.go?examCode="+${examCode}+"&&answer="+answer+"&&id="+id2+"&&answerId="+anid;
				
		    	 

	 		})
		
		
		
		
	})
})

</script>






</head>
<body>
<input type="hidden" id="idim" value="${id2}">
<input type="hidden" id="anid" value="${answerId}">



<c:if test="${empty jimoon}">
<div class="row" style="height:600px;">
	<div class="col-sm-6"style="padding-right:2px;">
	
<!-- 	주관식 -->
	<c:if test="${problem.lproblem=='주관식' }">
	
	
	<div style="margin-left:10px;margin-top:10px;border:1px solid black;height:500px;">
	<div style="font-weight: bold;">[문제]</div>
							<div>${pno}.${problem.problemContent}</div>
							<c:if test="${!empty problem.picture }">
							<div class="view${problem.problemCode}" id="pictureView2"
							style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">
										</div>
							</c:if>
							
						
							<div style="font-weight: bold;">[답]</div>
							<div style="margin-bottom: 15px;">
								<span style="font-weight: bold; color: red;">
							      ${problem.problemAnswer}
									
									</span>
							</div>
							<div style="font-weight: bold;">[해설]</div>
							<div style="margin-bottom: 10px;">${problem.problemSolution }</div>
	
	
	
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	</c:if>
<!-- 	객관식 -->
	<c:if test="${problem.lproblem=='객관식' }">
	<div style="margin-left:10px;margin-top:10px;border:1px solid black;height:500px;">
	<div style="font-weight: bold;">[문제]</div>
							<div>${pno}.${problem.problemContent}</div>
							<c:if test="${!empty problem.picture }">
							<div class="view${problem.problemCode}" id="pictureView2"
							style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">
										</div>
							</c:if>
							
							<p style="margin-left: 10px;">
								①${problem.none }<br>② ${problem.ntwo }<br>③
								${problem.ntree }<br> ④ ${problem.nfour }<br> <span
									style="font-weight: bold">⑤ ${problem.nfive }</span><br>
							</p>
							<div style="font-weight: bold;">[답]</div>
							<div style="margin-bottom: 15px;">
								<span style="font-weight: bold; color: red;">
								<c:if test="${problem.problemAnswer=='1'}">
								①${problem.none} 
									</c:if>
										<c:if test="${problem.problemAnswer=='2'}">
								② ${problem.ntwo }
									</c:if>
										<c:if test="${problem.problemAnswer=='3'}">
								③${problem.ntree }
									</c:if>
										<c:if test="${problem.problemAnswer=='4'}">
								 ④ ${problem.nfour } 
									</c:if>
										<c:if test="${problem.problemAnswer=='5'}">
								⑤ ${problem.nfive } 
									</c:if>
									
									</span>
							</div>
							<div style="font-weight: bold;">[해설]</div>
							<div style="margin-bottom: 10px;">${problem.problemSolution }</div>
	
	
	
	</div>
	
	
	
	
	</c:if>
	</div>
	<div class="col-sm-6" style="padding-left:0px;padding-right:50px;">
	<div style="margin-left:0px;marign-right:10px;margin-top:10px;border:1px solid black;height:500px;">
	
	<div style="font-weight: bold;">[질문]</div>
							<div style="margin-bottom: 15px;height:220px;">
								<span>${que}</span>
							</div>
							<hr>
							
							<div class="form-floating" style="height:230px;">
								<textarea class="form-control bg-light text-dark answer"
									placeholder="Leave a comment here" id="floatingTextarea2"
									style="height: 220px" name="answer"></textarea>
								<label for="floatingTextarea2" class="text-dark ">답변</label>
							</div>
	
	
	<div  style="text-align: right;width:150px;float:right;">
					<button type="button" class="btn btn-success anbn" >등록하기</button>
				</div>
	</div>
	
	</div>
</div>	
</c:if>

<c:if test="${!empty jimoon}">
<div class="row" style="height:1000px;padding:0px;">

<div class="col-sm-6" style="padding-right:0px;">

<div style="border:1px solid black;margin-left:10px;word-wrap: break-word;height:750px;margin-top:10px;margin-right:0px;">
${jimoon }





</div>

</div>


<div class="col-sm-6" style="padding-right:90px;padding-left:0px;">
<div style="border:1px solid black;margin-left:5px;word-wrap: break-word;height:750px;margin-top:10px;width:400px;">

<div style="height:330px;">

<c:if test="${problem.lproblem=='주관식' }">
	
	
	<div style="margin-left:0px;margin-top:0px;border:1px solid black;height:340px;overflow:auto;">
	<div style="font-weight: bold;">[문제]</div>
							<div>${pno}.${problem.problemContent}</div>
							<c:if test="${!empty problem.picture }">
							<div class="view${problem.problemCode}" id="pictureView2"
							style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">
										</div>
							</c:if>
							
						
							<div style="font-weight: bold;">[답]</div>
							<div style="margin-bottom: 15px;">
								<span style="font-weight: bold; color: red;">
							      ${problem.problemAnswer}
									
									</span>
							</div>
							<div style="font-weight: bold;">[해설]</div>
							<div style="margin-bottom: 10px;">${problem.problemSolution }</div>
	
	
	
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	</c:if>
<!-- 	객관식 -->
	<c:if test="${problem.lproblem=='객관식' }">
	<div style="margin-left:0px;margin-top:0px;border:1px solid black;height:340px;overflow:auto;">
	<div style="font-weight: bold;">[문제]</div>
							<div>${pno}.${problem.problemContent}</div>
							<c:if test="${!empty problem.picture }">
							<div class="view${problem.problemCode}" id="pictureView2"
							style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">
										</div>
							</c:if>
							
							<p style="margin-left: 10px;">
								①${problem.none }<br>② ${problem.ntwo }<br>③
								${problem.ntree }<br> ④ ${problem.nfour }<br> <span
									style="font-weight: bold">⑤ ${problem.nfive }</span><br>
							</p>
							<div style="font-weight: bold;">[답]</div>
							<div style="margin-bottom: 15px;">
								<span style="font-weight: bold; color: red;">
								<c:if test="${problem.problemAnswer=='1'}">
								①${problem.none} 
									</c:if>
										<c:if test="${problem.problemAnswer=='2'}">
								② ${problem.ntwo }
									</c:if>
										<c:if test="${problem.problemAnswer=='3'}">
								③${problem.ntree }
									</c:if>
										<c:if test="${problem.problemAnswer=='4'}">
								 ④ ${problem.nfour } 
									</c:if>
										<c:if test="${problem.problemAnswer=='5'}">
								⑤ ${problem.nfive } 
									</c:if>
									
									</span>
							</div>
							<div style="font-weight: bold;">[해설]</div>
							<div style="margin-bottom: 10px;">${problem.problemSolution }</div>
	
	
	
	</div>
	
	
	
	
	</c:if>


</div>


<div style="height:330px;">


<div style="font-weight: bold;margin-top:5px;">[질문]</div>
							<div style="margin-bottom: 15px;height:140px;overflow: auto;">
								<span>${que}</span>
							</div>
							<hr>
							
							<div class="form-floating" style="height:150px;overflow:auto;">
								<textarea class="form-control bg-light text-dark answer"
									placeholder="Leave a comment here" id="floatingTextarea2"
									style="height: 140px" name="answer"></textarea>
								<label for="floatingTextarea2" class="text-dark">답변</label>
							</div>
	
	
	<div  style="text-align: right;width:150px;float:right;">
					<button type="button" class="btn btn-success anbn">등록하기</button>
				</div>


</div>





</div>


</div>

</div>
</c:if>





</body>
</html>