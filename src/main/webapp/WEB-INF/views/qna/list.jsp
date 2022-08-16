<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<body>
  <div>
	 <!-- Main content -->

	 
	 
   	<section class="content">
			<div class="card">
				<section class="content-header" style="margin-top:20px;">
					<div class="container-fluid">
						<div class="row md-2">
							<div class="col-sm-6">
								<h1>질문게시판</h1>
							</div>
							<div class="col-sm-6">
								<ol class="breadcrumb float-sm-right" style="float: right;">
									<li class="breadcrumb-item"><a href="list.go"><i
											class="fa fa-dashboard"></i>질문게시판</a></li>
									<li class="breadcrumb-item active">질문상세</li>
								</ol>
							</div>
						</div>
					</div>
				</section>
				<div class="card-header with-border">
   				<div id="" class="card-tools col-md-4" style="float:left;">
   				
						<select class="form-select col-sm-6" aria-label="Default select example"
								style="float:left;width:100px;" name="" id="" onchange="">
							<option value="">과목</option>
							<option value="k">국어</option>
							<option value="m">수학</option>
							<option value="e">영어</option>
							<option value="so">사회</option>
							<option value="si">과학</option>
						</select>
<!-- 						<select class="form-control col-sm-6" style="float:left;width:100px;" name="" id="" onchange=""> -->
<!-- 							<option value="">과목</option> -->
<!-- 							<option value="k">국어</option> -->
<!-- 							<option value="m">수학</option> -->
<!-- 							<option value="e">영어</option> -->
<!-- 							<option value="so">사회</option> -->
<!-- 							<option value="si">과학</option> -->
<!-- 						</select> -->
						<select class="form-select col-sm-6"
							aria-label="Default select example"
							style="width: 100px;" name="" id="" onchange="">
							<option value="">강사</option>
							<option value="강사id">강사명</option>
							<option value="강사id">강사명</option>
							<option value="강사id">강사명</option>
						</select>
<!-- 						<select class="form-control col-sm-6" style="width:100px;" name="" id="" onchange=""> -->
<!-- 							<option value="">강사</option> -->
<!-- 							<option value="강사id">강사명</option> -->
<!-- 							<option value="강사id">강사명</option> -->
<!-- 							<option value="강사id">강사명</option> -->
<!-- 						</select> -->
					</div>
					
   				<div id="keyword" class="card-tools col-md-8" style="width:550px;float:right;">
					<div class="input-group">
   					 	<!-- search bar -->
   					 	<!-- sort num -->
						<select class="form-select" aria-label="Default select example"
								name="perPageNum" id="perPageNum" onchange="list_go(1);">
						  <option value="10">정렬개수</option>
						  <option value="2">2개씩</option>
						  <option value="3">3개씩</option>
						  <option value="5">5개씩</option>
						</select>
<!-- 					  	<select class="form-control col-md-3" name="perPageNum"  -->
<!-- 					  			id="perPageNum" onchange="list_go(1);">					  		  		 -->
<!-- 					  		<option value="10" >정렬개수</option> -->
<!-- 					  		<option value="2">2개씩</option> -->
<!-- 					  		<option value="3">3개씩</option> -->
<!-- 					  		<option value="5">5개씩</option> -->
<!-- 					  	</select> -->
					  	
					  	<!-- search bar -->
						<select class="form-select col-md-3" aria-label="Default select example"
							name="searchType" id="searchType" onchange="list_go(1);">
							<option value="">검색구분</option>
							<option value="i">아이디</option>
							<option value="n">이 름</option>
							<option value="p">제목</option>
							<option value="e">내용</option>
						</select>
<!-- 						 <select class="form-control col-md-3" name="searchType" id="searchType"> -->
<!-- 					 		<option value="">검색구분</option> -->
<!-- 							<option value="i">아이디</option> -->
<!-- 							<option value="n">이 름</option> -->
<!-- 							<option value="p">제목</option> -->
<!-- 							<option value="e">내용</option>				 									 -->
<!-- 						</select> -->
						<!-- keyword -->
   					 	<input  class="form-control" type="text" name="keyword" 
										placeholder="검색어를 입력하세요." value="${param.keyword}"/>
						<span class="input-group-append">
							<button class="btn btn-soft-primary" type="button" 
									id="searchBtn" data-card-widget="search" onclick="list_go(1);">
								<i class="fa fa-fw fa-search"></i>
							</button>
						</span>
					<!-- end : search bar -->		
   					 </div>
   				</div>   			
   			</div>
			<div class="card-body" style="text-align:center;">
	   			<div class="row" style="margin-bottom:10px;">
	   				<div class="col-sm-8"></div>
	   				<div class="col-sm-4">
						<button type="button" style="float:right; margin-right:10px;" class="btn btn-soft-primary" onclick="location.href='<%=request.getContextPath()%>/qna/registForm.go'">질문등록</button>
					</div>
	    		</div>
   			  <div class="row">
	             <div class="col-sm-12">	
		    		<table class="table table-hover">
		    		<thead class="table-light">
		    			<tr class="table-primary">
		    				<th>글번호</th>
		                	<th>제목</th>
		                	<th>작성자</th>
		                	<th>작성일</th><!-- yyyy-MM-dd  -->
		                	<th>첨부파일</th>
		               	</tr>
				    </thead>
		     				
     					 <tr onclick="javascript:location.href='<%=request.getContextPath()%>/qna/detail.go'" style="cursor:pointer;">
            		  	   	<td>1</td>
		              		<td>제목입니다.<span style="float:right;" class="badge badge-soft-primary">답변완료</span></td>
		              		<td>강동주</td>
            		  	   	<td>2022-06-30</td>
            		  	   	<td><i class="bx bxs-download"></i></td>
            		  	  </tr>	
     					 <tr onclick="javascript:location.href='<%=request.getContextPath()%>/qna/detail.go'" style="cursor:pointer;">
            		  	   	<td>2</td>
		              		<td>제목입니다.<span style="float:right;" class="badge badge-soft-danger">미답변</span></td>
		              		<td>김형돈</td>
            		  	   	<td>2022-06-30</td>
            		  	   	<td>-</td>
            		  	  </tr>	
     					
		            </table>
    		     </div> <!-- col-sm-12 -->
    	       </div> <!-- row -->
    		</div> <!-- card-body -->
    		<div class="card-footer">
    			<!-- pagination -->
 			<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
    		</div>
	     </div>
   	</section>
  </div>
  
  <c:if test="${from eq 'regist' }">
	<script>
		alert("정상 등록되었습니다.");
		window.close();
		window.opener.location.reload();
	</script>
</c:if>
</body>
