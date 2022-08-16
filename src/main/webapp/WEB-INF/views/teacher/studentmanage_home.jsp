<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${pageMaker.cri }" />
<c:set var="clist" value="${classList}" />


<head>
<style>
table th, td {
	text-align: center;
}
</style>



<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>

<script type="text/javascript">
$(function(){
	
})


</script>



<script>
$('#processSelect').on('change',function(){
	 processname=$('#processSelect option:selected').val();

	pstudentlistgo();
})

</script>
<script>
var page2=1;
var searchtype="";
var keyword="";
var processname="";	
</script>
<script>
$(function(){
	
	 processname=$('#processSelect option:selected').val();
	
	 pstudentlistgo();
	
	
	$('#search').on('click',function(){
		
		searchtype=$('#searchType option:selected').val().trim();
		
		keyword=$('#keyword2').val().trim();
		//alert(searchtype);
		//alert(keyword);
	  	  page2=1;
	  	pstudentlistgo();
	})
	
	  //page번호 클릭하는 이벤트
   $('#pagegogo').on('click','.pnum',function(){
	//   alert("클릭");
	// alert($(this).text());
	   page2=$(this).text();
	  // alert(page);
	   pstudentlistgo();
	   
   })
   
	 $('#pagegogo').on('click','.prev',function(){
	   page=parseInt($('.pager a').first().text())-1;
	  if(page2<=1){
		  page2=1;
		  pstudentlistgo();
	  }else{
		   
		  pstudentlistgo();
	  }
	   
	  
	  
   })
   
     $('#pagegogo').on('click','.next',function(){
	   page2=parseInt($('.pager a').last().text())+1;
	  // alert(page2);
	 //  alert(searchtype);
	//	alert(keyword);
	   if(page2>endPage){
		      page2-=1; 
		   pstudentlistgo();
		  }
	   else{
		   pstudentlistgo();
	   }
	
	  
   })
	
	
})

$(function(){
	$('#studentlist').on('click','tr',function(){
		var id=$(this).attr('id');
		var contextPath="<%=request.getContextPath()%>";
		$('#stuGradeGo').html('<i class="uil-book-reader"></i>&nbsp;학생 정보 상세보기 <button class="btn btn-info" style="float: right;" onclick=OpenWindow("'+contextPath+'/sscore/detail.go?id='+id+'","성적",900,800)>성적보기</button>')
		 $.ajax({
				url : '<%=request.getContextPath()%>/rteacher/piddetail',
				type : 'get',
				data : {'id' : id},
			    success : function(res){
			    var dt=timegogo(res.student.regDate);
				   $('#stuid').html(res.student.id);
				   $('#stuname').html(res.student.name);
				   $('#stuphon').html(res.student.phone);
				   $('#sturegi').html(dt);
				   $('#stuparentname').html(res.student.parentName);
				   $('#stuschool').html(res.student.schoolName);
				   $('#stuparentphone').html(res.student.parentPhone);
				   $('#un1').html(res.student.fuUni);	
				   $('#un2').html(res.student.suUni);	
				   $('#un3').html(res.student.tuUni);	
				   $('#stugrade').html(res.student.grade);
				   MemberPictureThumb2('<%=request.getContextPath()%>');
				},
				error : function(xhr){
					alert("상태 : " + xhr.status + " 체크");
				},
				dataType : 'json'
			})
	})
	
})

</script>
<script>
function MemberPictureThumb2(contextPath){
	 for(var target of document.querySelectorAll('.manPicture')){
		 var id2 = $('#stuid').text();
        // alert(id2);
		// console.log(id2);
		 target.style.backgroundImage="url('"+contextPath+"/master/getPicture.go?id="+id+"')";
		 target.style.backgroundPosition="center";
		 target.style.backgroundRepeat="no-repeat";
		 target.style.backgroundSize="cover";
	}
}
</script>
</head>

<body>

	<!-- Content Header (Page header) -->
	<section class="content-header" style="">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-6" style="padding-right: 0px;">
					<div class="card">
						<div class="card-header with-border" style="padding-left: 10px;">

							<div style="margin-bottom: 10px; width: 100%;">
								<h5>
									<i class="bx bx-square"></i>수업명
								</h5>
								<select class="form-select col-md-3" id="processSelect">
									<option value="전체">전체</option>
									<c:forEach items="${clist}" var="class2">
										<option value="${ class2}">${ class2}</option>
										<%-- 										<option value="${process}" ${process eq selecprocess ? 'selected':'' }>${process}</option> --%>
										<%-- 									        <option value="${class}"> --%>

									</c:forEach>
								</select>
							</div>

							<div id="keyword" class="card-tools" style="width: 100%;">
								<div class="input-group">
									<select class="form-select col-md-3" name="searchType" id="searchType" style="width:100px;">
										<option value="ns">전체</option>
										<option value="n">학생명</option>
										<option value="s">학교명</option>
									</select> 
									<input class="form-control" type="text" style="width: 170px;" name="keyword" placeholder="검색어를 입력하세요." id="keyword2" />
									<span class="input-group-append">
										<button class="btn btn-success" style="float: right;" type="button" id="search" data-card-widget="search">
											<i class="fa fa-fw fa-search"></i>
										</button>
									</span>
								</div>
							</div>
						</div>
						<div class="card-body">

							<div class="table-responsive" style="height: 600px;">
								<table class="table table-hover mb-0" id="studentlist">

								</table>
								<!-- end table -->
							</div>

						</div>

						<div class="card-footer">
							<nav aria-label="Navigation" id="pagegogo">
								<ul class="pagination justify-content-center m-0">
									<li class="page-item"><a class="page-link"
										href="javascript:list_go(1);"> <i
											class="fas fa-angle-double-left"></i>
									</a>
									<li class="page-item"><a class="page-link" href=""> <i
											class="fas fa-angle-left"></i>
									</a></li>

									<c:forEach var="pageNum" begin="${pageMaker.startPage }"
										end="${pageMaker.endPage }">
										<li class="page-item ${cri.page == pageNum?'active':''}">
											<a class="page-link" href="javascript:list_go('${pageNum}');">${pageNum }</a>
										</li>

									</c:forEach>


									<li class="page-item"><a class="page-link" href=""> <i
											class="fas fa-angle-right"></i>
									</a></li>
									<li class="page-item"><a class="page-link" href=""> <i
											class="fas fa-angle-double-right"></i>
									</a></li>
								</ul>
							</nav>
						</div>
						<!-- 학생리스트 끝 -->
					</div>

				</div>

				<div class="col-sm-6">

					<div class="card">
						<div class="card-header">
							<h5 class="card-title" id="stuGradeGo">
								<i class="uil-book-reader"></i>&nbsp;학생 정보 상세보기
							</h5>
						</div>

						<div class="card-body d-flex justify-content-center">
							<div class="table-responsive" style="width: 578px;">
								<table class="table table-bordered  mb-0">
									<tbody>
										<tr>
											<td rowspan="4" style="width: 131px;">
												<%--                                             <img src="<%=request.getContextPath() %>/resources/assets/images/users/avatar-10.jpg" alt="" class="avatar-xl"> --%>
												<div id="pictureView" class="manPicture" data-id="ddddd"
													style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;"></div>
											</td>
											<td
												style="width: 149px; background: #8BDDA8; font-weight: bold; font-size: 0.6em; vertical-align: middle; padding: 2px;">아이디</td>
											<td id="stuid"
												style="font-size: 0.6em; vertical-align: middle;"></td>
										</tr>
										<tr>
											<td scope="row"
												style="background: #8BDDA8; font-weight: bold; font-size: 0.6em; vertical-align: middle; padding: 2px;">이름</td>
											<td id="stuname"
												style="font-size: 0.6em; vertical-align: middle;"></td>
										</tr>
										<tr>
											<td scope="row"
												style="background: #8BDDA8; font-weight: bold; font-size: 0.6em; vertical-align: middle; padding: 2px;">전화번호</td>
											<td id="stuphon"
												style="font-size: 0.6em; vertical-align: middle;"></td>
										</tr>
										<tr>
											<td scope="row"
												style="background: #8BDDA8; font-weight: bold; font-size: 0.6em; vertical-align: middle; padding: 2px;">등록일</td>
											<td id="sturegi"
												style="font-size: 0.6em; font-size: 0.6em; padding: 2px;"></td>
										</tr>
									</tbody>
									<!-- end tbody -->
								</table>
								<!-- end table -->
								<table class="table table-bordered mb-0">
									<tbody>
										<tr>
											<td scope="row"
												style="width: 80px; background: #8BDDA8; font-weight: bold; font-size: 0.6em; padding: 4px; vertical-align: middle;">학교</td>
											<td id="stuschool" style="font-size: 0.6em; width: 120px;"></td>
											<td scope="row"
												style="width: 80px; background: #8BDDA8; font-weight: bold; font-size: 0.6em; padding: 4px; vertical-align: middle;">학년</td>
											<td id="stugrade" style="font-size: 0.6em; width: 120px;"></td>
										</tr>
										<tr>
											<td scope="row"
												style="width: 100px; background: #8BDDA8; font-weight: bold; font-size: 0.6em; padding: 4px; vertical-align: middle;">부모님
												이름</td>
											<td id="stuparentname" style="font-size: 0.6em;"></td>
											<td scope="row"
												style="width: 100px; background: #8BDDA8; font-weight: bold; font-size: 0.6em; padding: 4px; vertical-align: middle;">부모님
												전화번호</td>
											<td id="stuparentphone"
												style="font-size: 0.6em; vertical-align: middle;"></td>
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
												style="background: #8BDDA8; font-weight: bold;">희망대학</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="un1"></td>
											<td id="un2"></td>
											<td id="un3"></td>
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
	</section>





</body>






