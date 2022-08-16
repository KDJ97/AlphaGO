<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="studentList" value="${dataMap.studentList }" />
<c:set var="hopeschool" value="${dat.hopeschool}" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />

<head>


<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style>
table th, td {
	text-align: center;
}
</style>
<!-- <script type="text/javascript">
$('.page-list-link').href="javascript:list_go('${pageNum}');";
</script> -->


<script>
// window.onload=function(){
<%-- 	 MemberPictureThumb('<%=request.getContextPath()%>'); --%>
// }
</script>

<script>



// function swal() {
    
//         Swal.fire({
//             title: '정말로 그렇게 하시겠습니까?',
//             text: "다시 되돌릴 수 없습니다. 신중하세요.",
//             icon: 'warning',
//             showCancelButton: true,
//             confirmButtonColor: '#3085d6',
//             cancelButtonColor: '#d33',
//             confirmButtonText: '승인',
//             cancelButtonText: '취소'
//         }).then((result) => {
//             if (result.isConfirmed) {
//                 Swal.fire(
//                     '승인이 완료되었습니다.',
//                     '화끈하시네요~!',
//                     'success'
//                 )
//             }
//         })
//     });

</script>

</head>

<body>

	<!-- Content Header (Page header) -->


	<!-- Main content -->

	<div class="card" >
		<div class="col-sm-12">

			<div class="col-sm-5" style="float: left;">
				<section class="content-header">
					<div class="container-fluid">
						<div class="row mb-2">
							<div class="card-header">
								<h5 style="margin:0;padding:0; font-weight:bold;"><i class="uil-user-check"></i>&nbsp;&nbsp;&nbsp;원생 조회</h5>
							</div>



						</div>
					</div>
				</section>
				<div class="card-header with-border">

					<button type="button" class="btn btn-primary" id="registBtn"
						onclick="OpenWindow('registStudent.go','원생등록',540,680);">원생등록</button>
					<div id="keyword" class="card-tools"
						style="width: 250px; float: right;">
						<div class="input-group">

							<select class="form-control col-md-3" name="perPageNum"
								id="perPageNum" onchange="list_go(1);" style='display:none;'>
								<option value="10" ${cri.perPageNum==10 ? 'selected':'' }>개수</option>
								<option value="20" ${cri.perPageNum==20 ? 'selected':'' }>20개씩</option>
								<option value="30" ${cri.perPageNum==30 ? 'selected':'' }>30개씩</option>
								<option value="50" ${cri.perPageNum==50 ? 'selected':'' }>50개씩</option>

							</select> <select class="form-select col-md-3" name="searchType"
								id="searchType">
								<option value="tcw" ${cri.searchType eq 'tcw' ? 'selected':'' }>전
									체</option>
								<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>이름</option>
								<option value="w" ${cri.searchType eq 'w' ? 'selected':'' }>학교</option>
								<option value="c" ${cri.searchType eq 'c' ? 'selected':'' }>전화번호</option>
								<option value="n" ${cri.searchType eq 'n' ? 'selected':'' }>학년</option>

							</select> <input class="form-control" type="text" style="width: 40px;"
								name="keyword" placeholder="검색어 입력" value="${cri.keyword }" /> <span
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
				<div class="card-body" style="padding:0px;">
					<table class="table   table-bordered text-center table-hover">
						<thead class="">
							<tr
								style="font-size: 0.95em; background-color: #038edc; color: white;">
								<th style="width: 5%;">이름</th>
								<th style="width: 5%;">학년</th>
								<th style="width: 10%;">학교</th>
								<th style="width: 7%;">전화번호</th>


							</tr>
						</thead>
						<c:if test="${!empty studentList }">
							<c:forEach items="${studentList }" var="stu">
							
								<tr style='font-size: 0.85em;' onclick="studetail_go(this)">
								    <td style="display:none;"><input type="hidden" name="id" value="${stu.id }" ></td>
									<td >${stu.name }</td>
									<td>${stu.grade }</td>
									<td>${stu.schoolName}</td>
									<td>${stu.phone.replace('-','-') }</td>
							
						
								</tr>
							</c:forEach>

						</c:if>


	
<%-- 							<c:forEach items="${hopeschool }" var="hop"> --%>
							 
<!-- 								<tr style='font-size: 0.85em;' > -->
								    
<%-- 									<td >${hop.universityName}</td> --%>
									
								
<!-- 								</tr> -->
<%-- 							</c:forEach> --%>

					</table>
				</div>
				<div class="card-footer">
					<nav aria-label="studentlist Navigation">
						<ul class="pagination justify-content-center m-0">
							<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
						</ul>
					</nav>
				</div>
			</div>




			<!-- Main content -->

			<div class="col-sm-7" style="float: right; padding: 5px;">

				<div class="card">
					<div class="card-header">
						<h5 class="card-title" style="font-weight:bold; margin:0;padding:0;">
							<i class="uil-book-reader"></i>&nbsp;&nbsp;&nbsp;학생 정보 상세보기
						<button type="button" style="float: right; margin-left: 5px;"
							class="btn btn-danger" id="confirmStart"    
							onclick="deletestu_go(this)">삭제</button>

						<button type="button" style="float: right;"
							id="scoreOpenBtn"
							class="btn btn-warning" >성적보기</button>
						</h5>
						


					</div>
					<div class="card-body d-flex justify-content-center">
						<div class="table-responsive" style="width: 578px;">
							<table class="table table-bordered  mb-0">
								<tbody>
									
									<tr>
										<td rowspan="3" style="width: 150px;">
											 <div id="pictureView" class="manPicture" data-id="${stu.id }" style="border: 1px solid black; height: 150px; width: 100px; margin: 0 auto;"></div>
											
										</td>
										<td
											style="width: 100px; background: #038edc; color: white; font-weight: bold;">아이디</td>
										<td class="stuid" ></td>
									</tr>
									<tr>
										<td scope="row"
											style="background: #038edc; color: white; font-weight: bold;">이름</td>
										<td class="stuname"></td>
									</tr>
									<tr>
										<td scope="row"
											style="background: #038edc; color: white; font-weight: bold;">전화번호</td>
										<td class="stuphone"></td>
									</tr>
									<tr>
										<td></td>
										<td scope="row"
											style="background: #038edc; color: white; font-weight: bold;">등록일</td>
										<td class="regdate"></td>
									</tr>
									
								</tbody>
								<!-- end tbody -->
							</table>
							
							<!-- end table -->
							<table class="table table-bordered mb-0">
								<tbody>
									<tr>
										<td scope="row"
											style="width:80px; background: #038edc; color: white; font-weight: bold;">학교</td>
										<td class="school"></td>
										<td scope="row"
											style="width: 131px; background: #038edc; color: white; font-weight: bold;">학년</td>
										<td class="grade"></td>
									</tr>
									<tr>
										<td scope="row"
											style="width: 131px; background: #038edc; color: white; font-weight: bold;">부모님
											이름</td>
										<td class="parent_name"></td>
										<td scope="row"
											style="width: 131px; background: #038edc; color: white; font-weight: bold;">부모님
											전화번호</td>
										<td class="parent_phone"></td>
									</tr>
								</tbody>
								<!-- end tbody -->
							</table>
							<!-- end table -->

							<hr>

							<table class="table table-bordered mb-0">
								<thead>
									<tr>
										<th scope="row" colspan="3"
											style="background: #038edc; color: white; font-weight: bold;">희망대학</th>
									</tr>
								</thead>
								<tbody>
									<tr>
									<td class="Fuuniversity_name"></td>
										<td class="Suuniversity_name"></td>
										<td class="Tuuniversity_name"></td>
									</tr>
								</tbody>
								<!-- end tbody -->
							</table>
							<!-- end table -->

							<hr>
							<!-- 코멘트  -->
							
						</div>
					</div>


				</div>


			</div>

		</div>
	</div>

	<c:if test="${from eq 'regist' }">
		<script>
			alert("등록되었습니다.");
			window.close();
			window.opener.location.reload();
		</script>
	</c:if>
	

 

	<script>
		 function studetail_go(stuid) {
			
			 console.log(stuid);
			 var id = stuid.children[0].children[0].value;
			
			
			 
			var stuid = $('.stuid');
			stuid.empty();
			
			
			var stuname = $('.stuname');
			stuname.empty();
			var stuphone = $('.stuphone');
			stuphone.empty();
			var regdate = $('.regdate');
			regdate.empty();
			var school = $('.school');
			school.empty();
			var grade = $('.grade');
			grade.empty();
			var parentname = $('.parent_name');
			parentname.empty();
			var parentphone = $('.parent_phone');
			
			
			parentphone.empty();
			
			 var Fuuniversityname=$('.Fuuniversity_name');
			
			 Fuuniversityname.empty();
			 var Suuniversityname=$('.Suuniversity_name');
				
			 Suuniversityname.empty();
			 var Tuuniversityname=$('.Tuuniversity_name');
				
			 Tuuniversityname.empty();
			
// 			var id=$('td eq:0',stuid).val();
// 			console.log(id);
			//var id = $('input[name="id"]').val(); 
			
			/*   var id= $(stuid).find('id');
			console.log(id); */
					
		
			
			$.ajax({
				url : "studetail.go",
				type : "POST",
				data : {
					"id" : id
				},
				success : function(data) {
					 
					
					//1지망 대학
					var new_fuUni;
					if(data.fuUni==null){
						new_fuUni="-";
						
					}else{
						new_fuUni=data.fuUni;
					}
					Fuuniversityname.text(new_fuUni);
					
					//2지망 대학
					var new_suUni;
					if(data.suUni==null){
						new_suUni="-";
					}else{
						new_suUni=data.suUni;
					}
					Suuniversityname.text(new_suUni);
					
					//3지망 대학
					var new_tuUni;
					if(data.tuUni==null){
						new_tuUni="-";
					}else{
						new_tuUni=data.tuUni;
					}
					Tuuniversityname.text(new_tuUni);
					
					//전화번호
					var new_phone;
					if(data.phone==null){
						new_phone="-";
					}else{
						new_phone=data.phone;
					}
					stuphone.text(new_phone);
					
					//학교이름
					var new_schoolName;
					if(data.schoolName==null){
						new_schoolName="-";
					}else{
						new_schoolName=data.schoolName;
					}
					school.text(new_schoolName);
					
					//학년
					var new_grade;
					if(data.grade==null){
						new_grade="-";
					}else{
						new_grade=data.grade;
					}
					grade.text(new_grade);
					
					//부모님 이름
					var data_parentName;
					if(data.parentName==null){
						data_parentName="-";
					}else{
						data_parentName=data.parentName;
					}
					parentname.text(data_parentName);
					
					//부모님 전화번호
					var data_parentPhone;
					if(data.parentPhone==null){
						data_parentPhone="-";
					}else{
						data_parentPhone=data.parentPhone;
					}
					parentphone.text(data_parentPhone);
					
					
				
					//var regExp = /\d{2,3}-\d{3,4}-\d{4}/g;
					//console.log(data);
					var dt=timego(data.regDate);
					stuid.text(data.id);
					stuname.text(data.name);
					//stuphone.text(data.phone);
					regdate.text(dt);
							
					//school.text(data.schoolName);
					//grade.text(data.grade);
					//parentname.text(data.parentName);
					//parentphone.text(data.parentPhone);
					//Fuuniversityname.text(new_fuUni);
					//Fuuniversityname.text(data_fuUni);
					//Suuniversityname.text(data.suUni);
					//Tuuniversityname.text(data.tuUni);
					
					StudentPictureThumb("<%=request.getContextPath()%>");
					
					
					//성적보기 버튼 url변경
					$('#scoreOpenBtn').attr('onclick', "OpenWindow('/ddit/sscore/detail.go?id="+ data.id +"','성적보기',1000,900)");
					
					
				},
				error : function() {
					//alert("학생을 선택해 주세요");
				},
				dataType : "json"
			});
		}
	</script>
	
	<script>
	
 	$('#scoreOpenBtn').on("click", function() {
 		 var id = stuid.children[0].children[0].value;
 		if(id==""){
     	alert('클릭이벤트 발생');
 		return;			
 		}
     });
	
	</script>
	
	
	
	<script>
	function StudentPictureThumb(contextPath){
		
		
		console.log(contextPath);// -> /ddit
		console.log(document.querySelectorAll('.manPicture'));
		 for(var target of document.querySelectorAll('.manPicture')){
			 var id = $('.stuid').text();
			
	          console.log(id);
			 target.style.backgroundImage="url('"+contextPath+"/mstudent/getPicture.go?id="+id+"')";
			 target.style.backgroundPosition="center";
			 target.style.backgroundRepeat="no-repeat";
			 target.style.backgroundSize="cover";
		}
	}
	
	</script>
	
	<script>
	 function deletestu_go(destuid) {
		 var id = $('.stuid').text();
		 console.log(id);
		
		
				Swal.fire({
				  title: '원생을 삭제하시겠습니까?',
				  text: "삭제하시면 다시 복구시킬 수 없습니다.",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: '삭제',
				  cancelButtonText: '취소'
				}).then((result) => {
				  if (result.isConfirmed) {
					  
					   Swal.fire({
						  icon: 'success',
						  title: '삭제 되었습니다'
						}).then((result) => {
							if (result.isConfirmed){
								  $.ajax({
										url : "remove.go",
										type : "POST",
										data : {
											"id" : id
										},
										success : function(data) {
											
											//alert("삭제되었습니다.")
											window.location.reload();
											
										},
										error : function(error) {
											//alert("error : " + error.status);
										},
									});
							}
						})
				  }else{
					  Swal.fire({
						  icon: 'error',
						  title: '취소하셨습니다',
						  showConfirmButton: false,
						  timer: 1500
						})
				  }
				})
					  
					  
					  
					  
					  
					  
					
			
			 
			 
	 }
			
// 			var id=$('td eq:0',stuid).val();
// 			console.log(id);
			//var id = $('input[name="id"]').val(); 
			
			/*   var id= $(stuid).find('id');
			console.log(id); */
		
			
			
		
	 </script>
	 
	 
<script>
	function timego(timeValue){ //Handlbars에 날짜출력함수 등록
     var dateObj=new Date(timeValue);
     var year=dateObj.getFullYear();
     var month=dateObj.getMonth()+1;
     if(month<10){
    	 month="0"+month;
     }
   
     var date=dateObj.getDate();
     if(date<10){
    	 date="0"+date;
     }
     return year+"/"+month+"/"+date;


}
</script>

	
	
<!-- 	<script>
	function remove_go(id){
 		location.href="remove.go?id="+id;
 	}
	
	
	</script>
	<script>
	<c:if test="${from eq 'remove'}">
	   alert("삭제되었습니다.");
	   window.close();
	   window.opener.location.reload();
	 </c:if>
	
	
	</script>
 -->

</body>