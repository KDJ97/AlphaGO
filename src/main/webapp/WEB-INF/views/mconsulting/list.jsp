<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="counseltList" value="${dataMap.counseltList }" />
<c:set var="conseltstatus" value="${da.conseltstatus }" />
<c:set var="cri" value="${pageMaker.cri }" />

<head>

<script src="<%=request.getContextPath()%>/resources/js/main.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/ko.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/example.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>






</head>
<style>
table th, td {
	text-align: center;
}
</style>



<body>

	<!-- Content Header (Page header) -->


	<!-- Main content -->

	<div class="card">
	<div class="row mb-2">
					<div class="card-header">
						<h5 style="font-weight: bold;margin:0;padding:0;"><i class="uil-notes"></i>&nbsp;&nbsp;&nbsp;상담 관리</h5>
						
					</div>

					

				</div>
		<div class="col-sm-12">
			<div class="col-sm-6" style="float: left;">
				<div class="container-fluid">
				
			</div>
				<div class="card-header with-border">


					<span class="badge bg-primary" style="font-size: 1.0em;">상담
						신청 리스트</span>

					<div id="keyword" class="card-tools"
						style="width: 280px; margin-:10px; float: right;">
						<div class="input-group">

							<select class="form-control col-md-3" name="perPageNum"
								id="perPageNum" onchange="list_go(1);" style='display: none;'>
								<option value="10" ${cri.perPageNum==10 ? 'selected':'' }>개수</option>
								<option value="20" ${cri.perPageNum==20 ? 'selected':'' }>20개씩</option>
								<option value="30" ${cri.perPageNum==30 ? 'selected':'' }>30개씩</option>
								<option value="50" ${cri.perPageNum==50 ? 'selected':'' }>50개씩</option>

							</select> <select class="form-select col-md-3" name="searchType"
								id="searchType">
								<option value="tcw" ${cri.searchType eq 'tcw' ? 'selected':'' }>전
									체</option>
								<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>원생이름</option>
								<option value="w" ${cri.searchType eq 'w' ? 'selected':'' }>구분</option>


							</select> <input class="form-control" type="text" style="width:105px;"
								name="keyword" placeholder="검색어를 입력" value="${cri.keyword }" /> <span
								class="input-group-append">
								<button class="btn btn-primary" style="float: right;"
									type="button" id="searchBtn" data-card-widget="search"
									onclick="list_go(1);">
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>
						</div>
					</div>
				</div>
				<div class="card-body" style="padding: 5px;">
					<table class="table table-bordered text-center  table-hover ">
						<thead>
							<tr style="background-color: #038edc; color: white;">

								<th style="width: 12%; font-size: 0.1em;">이름</th>
								<th style="width: 30%; font-size: 0.3em;">상담 날짜</th>
								<th style="width: 10%; font-size: 0.3em;">구분</th>
								<th style="width: 13%; font-size: 0.1em;">신청자</th>
								<th style="width: 15%; font-size: 0.1em;">원생자료</th>
								<th style="width: 25%; font-size: 0.3em;">수락/연기</th>

							</tr>
						</thead>
						<c:if test="${!empty counseltList}">

							<c:forEach items="${counseltList}" var="cou">
								<tr class="table-white" style="font-size: 0.8em;" onclick="">
									<td style="display: none;"><input type="hidden"
										name="pcStart" value="${cou.pcStart}"></td>
									<td style="display: none;"><input type="hidden"
										name="pcEnd" value="${cou.pcEnd}"></td>
									<td style="display: none;"><input type="hidden"
										name="title" value="${cou.title}"></td>
										<td style="display: none;"><input type="hidden"
										name="pcs" value="${cou.pcCode}"></td>

									<td style="font-size: 0.5em;">${cou.name}</td>
									<td style="font-size: 0.5em;"><fmt:formatDate
											pattern="yyyy/MM/dd " value="${cou.meetDate}" />:<fmt:formatDate
											pattern="hh:mm" value="${cou.pcStart}" />~<fmt:formatDate
											pattern="hh:mm" value="${cou.pcEnd}" /></td>
									<td style="font-size: 0.5em;">${cou.purpose}</td>
									<td style="font-size: 0.5em;">부모님</td>
									<td><button type="button"
											style="margin-right: 5px; padding: 0px;"
											class="btn btn-warning"
											onclick="OpenWindow('detail.go?pcCode=${cou.pcCode}','원생 분석',1000,1000);">보기</button>
									</td>
									<td><button type="button"
											style="margin-right: 5px; padding: 0px;"
											class="btn btn-primary"
											onclick="insert_go('${cou.pcCode}')">수락</button>

										<button type="button" class="btn btn-danger"
											data-bs-toggle="modal" style="padding: 0px;"
											data-bs-target="#staticBackdrop" >연기</button></td>
									<td style="display: none;"><input type="hidden" name="id"
										value="${cou.counSelor}"></td>
								</tr>
							
							</c:forEach>

						</c:if>

						
						
							<c:if test="${empty counseltList }">
						
							
							<td colspan='6'>상담 신청 리스트가 없습니다.</td>
							
							
							
							</c:if>




					</table>
				</div>
				<div class="card-footer">
					<nav aria-label="pds list Navigation">
						<ul class="pagination justify-content-center m-0">
							<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
						</ul>
					</nav>
				</div>
			</div>




			<!-- Main content -->

			<div class="col-sm-6" style="float: right; padding: 20px;">

				<div id="hd-calendar"></div>

			</div>

		</div>

	</div>




	<%-- 	<%-- 	<c:if test="${from eq 'regist' }"> --%>

	<!-- 	<!-- 		<script> -->

	<!-- 	// alert("등록되었습니다."); // window.close(); // -->
	<!-- 	window.opener.location.reload(); -->
	<!-- 	<!-- 		</script> -->

	<%-- 	<%-- 	</c:if> --%>







	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header bg-primary">
					<h5 class="modal-title" id="staticBackdropLabel">
						<span style="color: white;"><i class="uil-comment-alt-message">메시지</i></span>
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">


					<!-- end card header -->
					<div class="card-body">



						<form>
							<div class="col-sm-6">
								<span class="badge bg-primary" style="font-size: 1.2em;">
									받는사람 </span>
							</div>
								<div class="col-sm-4">
	<input type="text" placeholder="010-9647-0026" class="form-control" id="horizontal-firstname-input">
											</div>
<%-- 							<c:if test="${!empty counseltList}"> --%>
<%-- 								<c:forEach items="${counseltList}" var="cou"> --%>


<!-- 									<div class="row mb-3"> -->




<!-- 										<div class="col-sm-4"> -->
<%-- 											<input type="text" placeholder="${cou.phone}" --%>
<!-- 												class="form-control" id="horizontal-firstname-input"> -->

<%-- 											<input type="hidden" name="pcCode12" value="${cou.pcCode}"> --%>
<%-- 											<input type="hidden" name="client123" value="${cou.client}"> --%>
<%-- 											<input type="hidden" name="meetDate12312" value="${cou.meetDate}"> --%>
<%-- 											<input type="hidden" name="pcStar123t" value="${cou.pcStart}"> --%>
<%-- 											<input type="hidden" name="pcEnd1233" value="${cou.pcEnd}"> --%>
<%-- 											<input type="hidden" name="title123" value="${cou.title}"> --%>
<!-- 										</div> -->
<!-- 									</div> -->



<%-- 								</c:forEach> --%>


<%-- 							</c:if> --%>

							<!-- end row -->


<!-- 							<div class="col sm-6"> -->
<!-- 								<span class="badge badge-soft-primary" style="font-size: 1.2em;"> -->
<!-- 									제목 </span> -->
<!-- 							</div> -->
							

							<div class="col sm-6">
								<span class="badge bg-danger"
									style="width: 100%; font-size: 1.2em;">연기 사유</span>

							</div>
							<!-- end row -->
							<textarea class="form-control " placeholder="내용을 입력하세요"
								id="smscontent" style="height: 100px"></textarea>
							<!-- end row -->
							<button type="button" class="btn btn-primary"
								style="float: right;" onclick="cancel_go()">Send</button>
							<div class="row justify-content-end">
								<div class="col-sm-9">
									<div class="form-check mb-4"></div>

								</div>
								<!-- end col -->
							</div>
							<!-- end row -->
						</form>
						<!-- end form -->
					</div>
				</div>
			</div>

		</div>




	</div>


	<div class="modal fade"  id="datailCalendar" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #038edc;">
					<h5 class="modal-title" id="staticBackdropLabel"
						style="color: white;">상담 일정 상세</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
				<c:forEach items="${conseltstatus}" var="cous">
						<div class="col-sm-12" style="margin: 3px;">
							<div class="col-sm-4" style="float: left;">원생이름:</div>
							<div class="col-sm-8" style="float: right;">
								<input class="form-control" type="text" name="" id=""
									 placeholder="${cous.name}"/>
									
									
									
							</div>
						</div>
						
						</c:forEach>
						<c:forEach items="${conseltstatus}" var="cous">
						<div class="col-sm-12" style="margin: 3px;">
							<div class="col-sm-4" style="float: left;">상담일 :</div>
							<div class="col-sm-8" style="float: right;">
								<input class="form-control" type="text" name="meetDate" id=""
									value="<fmt:formatDate  pattern="yyyy/MM/dd" value="${cous.meetDate}"/>" /> 
									
									
										<input class="form-control" type="hidden" name="pcCode" id="pcCode"
									value="${cous.pcCode }" > 
									
							</div>
						</div>
						</c:forEach>
						<c:forEach items="${conseltstatus}" var="cous">
						<div class="col-sm-12" style="margin: 3px;">
							<div class="col-sm-4" style="float: left;">시작시간 :</div>
							<div class="col-sm-8" style="float: right;">
							<input class="form-control" type="text" name="pcStart1" id=""
									value="<fmt:formatDate  pattern="HH:ss" value="${cous.pcStart}"/>" /> 
									
							</div>
						</div>
						</c:forEach>
						<c:forEach items="${conseltstatus}" var="cous">
						<div class="col-sm-12" style="margin: 3px;">
							<div class="col-sm-4" style="float: left;">종료시간 :</div>
							<div class="col-sm-8" style="float: right;">
							
									<input class="form-control" type="text" name="pcEnd1" id=""
									value="<fmt:formatDate  pattern="HH:ss" value="${cous.pcEnd}"/>" /> 
							</div>
						</div>
					</c:forEach>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-warning" onclick="modify_go()">수정</button>
					<button type="button" class="btn btn-danger" onclick="delcal_go()">삭제</button>
				</div>
			</div>
		</div>
	</div>




	<script>
		//   function registCalender_go(abc){

		// 	  var pcCode=$('input[name=pcCode]').val();
		// 	  var meetDate=$('input[name=meetDate]').val();
		// 	  var client=$('input[name=client]').val();
		// 	  var pcStart=$('input[name=pcStart]').val();
		// 	  var pcEnd=$('input[name=pcEnd]').val();
		// 	  var title=$('input[name=title]').val();

		// 	  var param={"pcCode":pcCode,"meetDate":meetDate,"client":client,"pcStart":pcStart,"pcEnd":pcEnd,"title":title}

		//   	$.ajax({
		// 			url:"/calendar/insert.go",
		// 			method: "post",
		// 			contentType:'application/json',
		// 			data:JSON.stringify(param),
		// 			success: function(data){
		// 				alert("등록됨");
		// 			},
		// 			error: function(error){
		// 				alert("load error : " + error.status);
		// 			},
		// 			dataType: "json"
		//   	})

		//   }
	</script>


	<script>
		// var defaultEvents = loadingEvents();

		// //모든 일정 불러오기.
		// function loadingEvents(counsel){
		// 	var return_value = null;

		// 	 var counselor=counsel
		// 	console.log(counselor);
		// 	$.ajax({
		// 		url:"calendar/list.go",
		// 		method: "post",
		// 		contentType:'application/json',
		// 		data:{
		// 			"counselor":counselor
		// 		},
		// 		success: function(success){
		// 			console.log("load list: " + success);
		// 			return_value = success;
		// 		},
		// 		error: function(error){
		// 			alert("load error : " + error.status);
		// 		},
		// 		dataType: "json"
		// 	})
		// 	return return_value;
		// }
	</script>

	<script>
		function insert_go(pc) {

			var pcCode = pc
			console.log(pcCode);

			var pcStart = $('input[name=pcStart]').val();
			console.log(pcStart);
			var pcEnd = $('input[name=pcEnd]').val();
			console.log(pcEnd);
			var title = $('input[name=title]').val();
			console.log(title);

			
			const date=new Date(pcStart);
			console.log(date);
			var param = {
				"pcCode" : pcCode
			}

			Swal.fire({
			      icon: 'success',
			      title: '승인 되었습니다.'
			      
			    }).then((result) => {
				  if (result.value) {
						$.ajax({
							url : "registcalender.go",
							type : "POST",
							contentType : 'application/json',
							data : JSON.stringify(param),
							success : function(data) {
								//alert("승인되었습니다.");

								window.location.reload();

							},
							error : function(error) {
								//alert("error : " + error.status);
							},
							dataType : 'json'

						});
						
				  }
				})
			
		
		}
		
		
		 
	</script> 
	
	
	<script>
		function cancel_go() {

		
			var content=$('#smscontent').val();
			var pcCode = $('input[name=pcs]').val();
			
			var content={
					"content":content,
					"pcCode":pcCode
					
			};
			
			
			Swal.fire({
			      icon: 'success',
			      title: '연기 문자가 발송되었습니다.'
			      
			    }).then((result) => {
				  if (result.value) {
						$.ajax({
							url : "sendsms.go",
							
							type : "POST",
							contentType : 'application/json',
							data : JSON.stringify(content),
							success : function(data) {
								//alert('연기 문자가 발송되었습니다.');
								window.location.reload();

							},
							error : function(error) {
								//alert('연기 문자가 발송되었습니다.');
								window.location.reload();
							},
							dataType : 'json'

						});
						
				  }
				})
		
		}
		
		
		 
	</script> 
	
	
	<script>
	 function delcal_go(){
		 
		 var pcCode = $('input[name=pcCode]').val();
	
	
		
//			var id=$('td eq:0',stuid).val();
//			console.log(id);
		//var id = $('input[name="id"]').val(); 
		
		/*   var id= $(stuid).find('id');
		console.log(id); */
	
		
		$.ajax({
			url : "remove.go",
			type : "POST",
			data : {
				"pcCode" :pcCode
			},
			success : function(data) {
				
				alert("삭제되었습니다.")
				window.location.reload();
				
			},
			error : function(error) {
				//alert("error : " + error.status);
			},
		});
	}
	
	
	</script>


<script>

// 	 var addEvent = new bootstrap.Modal(document.getElementById('datailCalendar');
	       
	 
// 	var pcCode= $('input[name=pcCode]').val();
// 	console.log(pcCode)
    

// 	var param = {
// 		"pcCode" : pcCode
// 	}

// 	$.ajax({
// 		url : "condetail.go",
// 		type : "POST",
// 		contentType : 'application/json',
// 		data : JSON.stringify(param),
// 		success : function(data) {
// 			alert("디테일되었습니다.");

// 			window.location.reload();

// 		},
// 		error : function(error) {
// 			alert("error : " + error.status);
// 		},
// 		dataType : 'json'

// 	});


</script>

	

<script>
	 function modify_go() {
			 
		
		 var currentDate = new Date(meetdate);
		 currentDate = JSON.stringify(meetdate);

		 // Now currentDate is in a different format... oh gosh what do we do...

	
		 
		 
		 var pccode = $('input[name=pcCode]').val();
		 console.log(pccode);
		 
		 
		 
		 var meetdate = $('input[name=meetDate]').val();
		 console.log(meetdate);
		 
		 var meet=new Date(meetdate)
		 var pcstart= $('input[name=pcStart1]').val();
		 var meet=new Date(pcstart)
		 console.log(pcstart);
		 var pcend= $('input[name=pcEnd1]').val();
		 console.log(pcend);
		 
		
		
		 
		 var param = {"meetDate":meetdate,"pcStart":pcstart,"pcEnd":pcend,"pcCode":pccode}
		
// 			var id=$('td eq:0',stuid).val();
// 			console.log(id);
			//var id = $('input[name="id"]').val(); 
			
			/*   var id= $(stuid).find('id');
			console.log(id); */			
			$.ajax({
				url :"modfiycalender.go",
				type : "POST",
				contentType: 'application/json',
				data : JSON.stringify(param),
				success : function(data) {
					alert("수정되었습니다.");
					
					window.location.reload();
					 
					
				},
				error : function(error) {
					//alert("error : " + error.status);
				},
				dataType:'json'
				
			});
		}
	 </script>

	
</body>

