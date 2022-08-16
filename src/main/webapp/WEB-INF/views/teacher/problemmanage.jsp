<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="problemPxlist" value="${dataMap.ProblemPXList}" />
<c:set var="repotProblemList" value="${dataMap.repotProblemList}" />
<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>



<script>

function repot(t){
	
	

	var tdim=$(t).parent().parent();
	var chil=tdim.children();
	
	
	var prC=chil.eq(0).text();
// 	alert($(":first-child",tdim).eq(0).text());
 	
 	
 	
 	
	 $.ajax({
			url : '<%=request.getContextPath()%>/rteacher/problemRepot.go',
			type : 'get',
			data : {'prC':prC},
		    success: function(res){
		    	
		   // alert(res);
					    		
				    		
			},
			error : function(xhr){
				//alert("상태 : " + xhr.status + " 체크");
			},
			dataType : 'json'
		});
	

event.stopPropagation();
	 
	
}

</script>
<script>
$(function(){
	  $('#test2').hover(function(){   
		$('#test').css('display','');   
		 },function() 
		{    $(this).css('color','red');   
		 });
	
})

</script>
<script>
$(function(){
	$('.drdr').on('click',function(e){
		e.stopPropagation();
	})
		
	
})

</script>



<script>
$(function(){
	//alert($('select[name="selectgo"]').val());
	//셀렉트 박스 변경시 실행되는 이벤트
	$('#searchType').on('change',function(){
		//alert($(":selected",this).val());
		list_pmgo(1,"problemmanage.go");
		//location
	})
})
</script>

</head>
	
<body>
	<div class="row gx-3 gy-2">
		<div class="col-12" style="float: left;">
			<div class="card">
				<div class="card-body" style="padding: 15px;">
					<h5 style="font-weight: bold; margin-bottom: 15px;">
						<i class="uil-book-open" style="margin-right: 10px;"></i>문제 관리
					
					
  
  	<div class="btn-group">
</div>

											


  

						

					
						<button type="button" class="btn btn-success"
							style="margin-right: 5px; height: 30px; line-height: 5px;float:right;"
							data-bs-toggle="modal" data-bs-target="#question"onclick="location.href='problemjcreateG.go'">지문</button>
							<button type="button" class="btn btn-success"
							style="margin-right: 5px; height: 30px; line-height: 5px;float:right;"
							data-bs-toggle="modal" data-bs-target="#question" onclick="location.href='problemcreateG.go'">일반</button>
					</h5>
					<div>
			

				
						<div class="input-group col-sm-2"
							style="width: 120px; float: right; margin-bottom: 10px;">
					

							<select class="form-select col-md-3" name="selectgo"
								id="searchType" style="width:100px;">
								<option value="a" ${cri.selectgogo eq 'a' ? 'selected':'' }>
									전체</option>
								
								<option value="m" ${cri.selectgogo eq 'm' ? 'selected':'' }>나의 문제</option>


							</select>
						
						</div>
					</div>
					<div>
					
						<div id="table-pagination">
							<div style="width: 100%;">
								<div style="height: auto;">
									<table class="table text-center table-hover"
										style="height: auto; text-align: center;">
										<thead>
											<tr>
												<th data-column-id="name"
													style="font-weight: bold; background: #8BDDA8; width: 70px;padding:8px;"><div
														class="gridjs-th-content">코드</div></th>
														
														<th data-column-id="email"
													style="font-weight: bold; background: #8BDDA8;width:70px;padding:8px;" ><div
														class="gridjs-th-content">과목</div></th>	
														
														
												<th data-column-id="email"
													style="font-weight: bold; background: #8BDDA8;width:70px;padding:8px;" ><div
														class="gridjs-th-content">영역</div></th>
														<th data-column-id="email"
													style="font-weight: bold; background: #8BDDA8;width:70px;padding:8px;" ><div
														class="gridjs-th-content">유형</div></th>
													
														<th data-column-id="email"
													style="font-weight: bold; background: #8BDDA8;width:140px;padding:8px;" ><div
														class="gridjs-th-content">단원</div></th>
												<th data-column-id="company"
													style="font-weight: bold; background: #8BDDA8; width: 68px;padding:8px;"><div
														class="gridjs-th-content">난이도</div></th>
												<th data-column-id="company"
													style="font-weight: bold; background: #8BDDA8; width: 68px;padding:8px;"><div
														class="gridjs-th-content">오답률</div></th>
															<th data-column-id="company"
													style="font-weight: bold; background: #8BDDA8; width: 68px;padding:8px;"><div
														class="gridjs-th-content">신고</div></th>
<!-- 															<th data-column-id="company" -->
<!-- 													style="font-weight: bold; background: #8BDDA8; width: 68px;"><div -->
<!-- 														class="gridjs-th-content"></div></th> -->
											</tr>
										</thead>
										<tbody>
										
										
											 <c:forEach items="${repotProblemList}" var="problem">
										
											<tr onclick="location.href='problemDetail.go?prC=${problem.problemCode}'" style="font-weight:120;background:#FF6666;color:#0066CC;">
													<td data-column-id="name"style="padding:8px;font-weight:120;"  >${problem.problemCode}</td>
												<td data-column-id="name" style="padding:8px;font-weight:120;">${problem.subdetailName}</td>
												<td data-column-id="position"style="padding:8px;font-weight:120;"><span
													class="badge rounded-pill bg-success"
													style="font-size: 0.8em; padding: 8px; weight: 100px;font-weight:120;">${problem.saname}</span></td>
												<td data-column-id="email" style="text-align:center;padding:8px;font-weight:120;">${problem.lproblem}</td>
												<td data-column-id="email" style="text-align:center;padding:8px;font-weight:120;">${problem.subunitName}</td>
												<td data-column-id="company" style="${problem.plevel=='상'?'color:red;':problem.plevel=='중'?'color:blue;':'color:black;'};padding:8px;font-weight:120;">${problem.plevel}</td>
												<td data-column-id="company"style="padding:8px;font-weight:120;">
													<c:if test="${problem.odap==0}">-</c:if>
													<c:if test="${problem.odap!=0}">${problem.odap}</c:if>
												</td>
										<td data-column-id="company" style="padding:8px;">
   <i class="uil-info-circle dropdown-toggle drdr"data-bs-toggle="dropdown" aria-expanded="false" ></i>
 <ul class="dropdown-menu">
  ${problem.repotcomment}
  </ul>
 
										</td>
											
											
											</tr>
										</c:forEach>
										 <c:forEach items="${problemPxlist}" var="problem">
										
											<tr onclick="location.href='problemDetail.go?prC=${problem.problemCode}'">
												<td data-column-id="name"style="padding:8px;" >${problem.problemCode}</td>
												<td data-column-id="name" style="padding:8px;">${problem.subdetailName}</td>
												<td data-column-id="position"style="padding:8px;"><span
													class="badge rounded-pill bg-success"
													style="font-size: 0.8em; padding: 8px; weight: 100px;">${problem.saname}</span></td>
												<td data-column-id="email" style="text-align: center;padding:8px;">${problem.lproblem}</td>
												<td data-column-id="email" style="text-align: center;padding:8px;">${problem.subunitName}</td>
												<td data-column-id="company" style="${problem.plevel=='상'?'color:red;':problem.plevel=='중'?'color:blue;':'color:black;'};padding:8px;">${problem.plevel}</td>
												<td data-column-id="company"style="padding:8px;">
													<c:if test="${problem.odap==0}">-</c:if>
													<c:if test="${problem.odap!=0}">${problem.odap}</c:if>
												</td>
											
												<c:if test="${!empty problem.repot && problem.repot!='0'}">
												<td data-column-id="email" style="text-align: center;padding:8px;"><i class="uil-info-circle"></i></td>
												
										
												</c:if>
															<c:if test="${empty problem.repot }">
									<td data-column-id="email" style="text-align: center;padding:8px;">-</td>
												
											
												</c:if>
												<c:if test="${problem.repot == '0'}">
									<td data-column-id="email" style="text-align: center;padding:8px;">-</td>
												
											
												</c:if>
								
												
<!-- 												<td><button class="btn btn-danger btn-rounded btn-sm" onclick="repot(this);">신고하기</button></td> -->
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>

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
			<a class="page-link" href="javascript:list_pmgo('${cri.page-1}','problemmanage.go');">
				<i class="fas fa-angle-left"></i>
			</a>						
		</li>
		
		<c:forEach var="pageNum" begin="${pageMaker.startPage }" 
								 end="${pageMaker.endPage }" >
			<li class="page-li page-item ${cri.page == pageNum?'active':''}">
				<a class="nav-list page-list-link page-link" href="javascript:list_pmgo('${pageNum}','problemmanage.go');" >${pageNum }</a>
				
			</li>
			
		</c:forEach>
				
		<li class="page-item">
			<a class="page-link" href="javascript:list_pmgo('${cri.page+1}','problemmanage.go');">
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
<!-- 		<div class="col-5"> -->
<!-- 			<div class="card" style="height: 803px;"> -->
<!-- 				<div class="card-body" style="padding: 15px;"> -->
<!-- 					<div class="d-flex"> -->
<!-- 						<p style="font-weight: bold;" class="flex-grow-1">문제 미리보기</p> -->
<!-- 						<button type="button" class="btn btn-soft-warning" -->
<!-- 							style="margin-bottom: 10px; margin-right: 5px; height: 30px; line-height: 5px;" -->
<!-- 							data-bs-toggle="modal" data-bs-target="#question">수정</button> -->
<!-- 						<button type="button" class="btn btn-soft-danger" -->
<!-- 							style="margin-bottom: 10px; height: 30px; line-height: 5px;">삭제</button> -->
<!-- 					</div> -->

<!-- 					<div class="bg-light" style="padding: 15px; border-radius: 10px;"> -->
<!-- 						<div style="margin-bottom: 5px; font-size: 1.1em;"> -->
<!-- 							<span class="badge rounded-pill bg-secondary" -->
<!-- 								style="margin-right: 5px;">코드 123</span><span -->
<!-- 								class="badge rounded-pill bg-danger">오답률 68%</span><br> -->
<!-- 						</div> -->
<!-- 						애국가(愛國歌)는 ‘나라를 사랑하는 노래’라는 뜻이에요. 우리나라는 애국가에 특별한 이름을 붙이지 않고 국가(國歌)로 -->
<!-- 						사용하고 있어요. 오늘날 불리고 있는 애국가 노랫말은 우리나라가 외세의 침략으로 위기에 처해있던 시기(1907년 -->
<!-- 						전후)에 나라 사랑하는 마음과 우리 민족의 자주의식을 북돋우기 위해 만들어진 것으로 보여져요.오늘날 불리고 있는 애국가 -->
<!-- 						노랫말은 우리나라가 외세의 침략으로 위기에 처해있던 시기(1907년 전후)에 나라 사랑하는 마음과 우리 민족의 -->
<!-- 						자주의식을 북돋우기 위해 만들어진 것으로 보여져요.<br> <br> -->
<!-- 						<p style="margin-left: 10px;margin-bottom: 0px;"> -->
<!-- 							① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④ -->
<!-- 							간주(看做)하면<br> ⑤ 결성(結成)되지 -->
<!-- 						</p> -->
<!-- 					</div> -->

<!-- 					<p style="font-weight: bold; margin-top: 15px;">해설 및 답</p> -->
<!-- 					<div class="bg-light" style="padding: 15px; border-radius: 10px;"> -->
<!-- 						<p> -->
<!-- 							정답<span style="font-weight: bold; color: red; margin-left: 15px;">① -->
<!-- 								소지(所持)하여야</span> -->
<!-- 						</p> -->
<!-- 						애국가(愛國歌)는 ‘나라를 사랑하는 노래’라는 뜻이에요. 우리나라는 애국가에 특별한 이름을 붙이지 않고 국가(國歌)로 -->
<!-- 						사용하고 있어요. 오늘날 불리고 있는 애국가 노랫말은 우리나라가 외세의 침략으로 위기에 처해있던 시기(1907년 -->
<!-- 						전후)에 나라 사랑하는 마음과 우리 민족의 자주의식을 북돋우기 위해 만들어진 것으로 보여져요. -->
<!-- 					</div> -->

<!-- 				</div> -->

<!-- 			</div> -->

<!-- 		</div> -->
	</div>

<form id="jobFormProblem">	
	<input type='hidden' name="page" value="" />
	<input type='hidden' name="searchType" value="" />
	<input type='hidden' name="jimoon" value="" />
	<input type='hidden' name="keyword" value="" />
	
		<input type='hidden' name="selectgogo" value="" />
	
</form>
</body>
