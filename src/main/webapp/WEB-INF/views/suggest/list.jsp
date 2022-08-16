<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="suggestList" value="${dataMap.suggestList }" /> 
<c:set var="cri" value="${pageMaker.cri }" />
<c:set var="so" value="${dataMap.selectedOrder}"/>
<head>
<script>
// new_pageGo('list2.go');
function list_go2(page,url){
	if(!url) url="list.go";
	
	var jobForm=$('#jobForm_suggest2');
	jobForm.find("[name='page']").val(page);
	jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
	jobForm.find("[name='keyword']").val($('input[name="keyword"]').val());
	jobForm.find("[name='selectedOrder']").val();
	
	jobForm.attr({
		action:url,
		method:'get'
	}).submit();
	
}
</script>
<script>
var tr = document.getElementById('thead_tr');
var i_btn = document.getElementById('registBtn');
var s_btn = document.getElementById('searchBtn');

if(${sessionScope.loginUser.authority eq 'ROLE_STUDENT' }){
	tr.className = 'bg-soft-purple';
	i_btn.className = 'btn btn-purple';
	s_btn.className = 'btn btn-purple';
}
if(${sessionScope.loginUser.authority eq 'ROLE_TEACHER' }){
	tr.className = 'table-success'
	i_btn.className = 'btn btn-success';
	s_btn.className = 'btn btn-success';
}
if(${sessionScope.loginUser.authority eq 'ROLE_MASTER' }){
	tr.className = 'table-primary'
	i_btn.className = 'btn btn-primary';
	s_btn.className = 'btn btn-primary';
}

</script>
<script>
function order_go(order){
// 	var orderSelect = document.getElementById("orderFor");
// 	var selectedOrder = orderSelect.options[orderSelect.selectedIndex].value;
// 	console.log(selectedOrder);
	console.log(order.value);
	
	var selectForm=$('#form_selectOrder');
	selectForm.find("[name='selectedOrder']").val(order.value);
	selectForm.attr({
		action:"list.go",
		method:'get'
	}).submit();
}
</script>
<c:if test="${from eq 'regist' }">
<script>
	//alert("건의글 등록이 성공했습니다.");
</script>
</c:if> 
<c:if test="${from eq 'remove' }">
<script>
	alert("건의글을 삭제했습니다.");
</script>
</c:if> 
</head>

<title>건의게시판</title>

<body>
	 <!-- Main content -->
<!-- 	<section class="content-header"> -->
<!-- 	  	<div class="container-fluid"> -->
<!-- 	  		<div class="row md-2"> -->
<!-- 	  		</div> -->
<!-- 	  	</div> -->
<!-- 	</section> -->
	 
	 <!-- Main content -->
    <section class="content">		
		<div class="card">
			<section class="content-header">
	  	<div class="container-fluid">
	  		<div class="row md-2">
	  			<div class="col-sm-6">
	  				<h5 style="margin-bottom: 15px; font-weight: bold; margin-top:20px; margin-left:10px;">
						<i class="uil-clipboard-notes" style="margin-right: 10px;"></i>건의게시판
					</h5>  				
	  			</div>
	  			<div  class="col-sm-6">
	  				<ol style="float:right; margin:20px;" class="breadcrumb float-sm-right">
			        <li class="breadcrumb-item">
			        	<a href="list.go">
				        	<i class="fa fa-dashboard"></i>건의게시판
				        </a>
			        </li>
			        <li class="breadcrumb-item active">
			        	목록
			        </li>		        
	    	  </ol>
	  			</div>
	  		</div>
	  	</div>
	</section>
	<hr style="margin-top:0px;">
	  		<div id="keyword" class="card-tools" style="">
					<div class="col-md-3" style="float:left;">
						<button style="margin-left:20px;" type="button" class="btn btn-primary col-sm-0.6" id="registBtn" onclick="location.href='registForm.go'">등록</button>
					</div>
					<div class="col-md-9" style="float:right;" >
					
					<span style="float:right;" class="input-group-append">
						<button id="searchBtn" style="margin-right:20px;"style="margin-left:20px;" class="btn btn-primary" type="button" onclick="list_go2(1);" data-card-widget="search">
							<i class="fa fa-fw fa-search"></i>
						</button>
					</span>
					<input  class="form-control col-sm-6" style="width:150px; float:right;" type="text" name="keyword" placeholder="검색어 입력" value="${cri.keyword }"/>
					<select class="form-select" style="width:100px; float:right;" name="searchType" id="searchType">
							<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>제 목</option>
							<option value="tc" ${cri.searchType eq 'tc' ? 'selected':'' }>제목+내용</option>
					</select>
					<select onchange="order_go(this);" class="form-select" name="orderFor" id="orderFor" style="width:150px; float:right;">
							<option value="reg" ${so eq 'reg' ? 'selected':'' } >등록순</option>
							<option value="like" ${so eq 'like' ? 'selected':'' } >인기순</option>
					</select>	
					</div>
			</div>
			<div class="card-body">
				<table class="table table text-center" >					
					<tr id="thead_tr" style="font-size:0.95em;">
						<th style="width:10%;">번 호</th>
						<th style="width:50%;">제 목</th>
						<th style="width:15%;">작성일</th>
						<th style="width:10%;">조회수</th>
						<th style="width:10%;">
						<i class="uil-thumbs-up" style="font-size: 1.0em; padding:0px;"></i>
						</th>
					</tr>				
					<c:if test="${empty suggestList }">
						<tr>
							<td colspan="5"><strong>해당 내용이 없습니다.</strong></td>
						</tr>
					</c:if>				
					<c:forEach items="${suggestList }" var="suggest">
						<tr style='font-size:0.85em;cursor:pointer;' onclick="location.href='detail.go?from=list&lcode=${suggest.lcode}'">
							<td>${suggest.lcode }</td>
							<c:choose>
								<c:when test="${suggest.updateDate ne null}">
								<td id="suggestTitle" style="text-align: left;max-width: 100px; overflow:hidden;white-space: nowrap; text-overflow: ellipsis;">
								${suggest.title } (수정됨)
								</td>
								</c:when>
								<c:otherwise>
								<td id="suggestTitle" style="text-align: left;max-width: 100px; overflow:hidden;white-space: nowrap; text-overflow: ellipsis;">
								${suggest.title } 
								</td>
								</c:otherwise>
							</c:choose>			
							<c:choose>
								<c:when test="${suggest.updateDate ne null}">
									<td><fmt:formatDate value="${suggest.updateDate }" pattern="yyyy-MM-dd"/></td>
								</c:when>
								<c:otherwise>
									<td><fmt:formatDate value="${suggest.regDate }" pattern="yyyy-MM-dd"/></td>
								</c:otherwise>
							</c:choose>
							<td>${suggest.viewcnt }</td>		
							<td>${suggest.likecnt }</td>		
						</tr>
					</c:forEach>
				</table>				
			</div>
			<div class="card-footer">
				<nav aria-label="Navigation">
					<ul id="nav-ul" class="pagination justify-content-center m-0">
						<li class="page-item">
							<a class="page-link" href="javascript:list_go2(1);">
								<i class="fas fa-angle-double-left"></i>
							</a>
						<li class="page-item">
							<a class="page-link" href="javascript:list_go2('${pageMaker.startPage}');">
								<i class="fas fa-angle-left"></i>
							</a>						
						</li>
						<c:forEach var="pageNum" begin="${pageMaker.startPage }" 
												 end="${pageMaker.endPage }" >
							<li class="page-li page-item ${cri.page == pageNum?'active':''}">
								<a class="nav-list page-list-link page-link" href="javascript:list_go2('${pageNum}');" >${pageNum }</a>
								
							</li>
							
						</c:forEach>
						<li class="page-item">
							<a class="page-link" href="javascript:list_go2('${pageMaker.endPage}');">
								<i class="fas fa-angle-right"></i>
							</a>						
						</li>
						<li class="page-item">
							<a class="page-link" href="javascript:list_go2('${pageMaker.realEndPage}');">
								<i class="fas fa-angle-double-right"></i>
							</a>						
						</li>
					</ul>
				</nav>
			</div>
		
		</div>
		
    </section>
<form id="jobForm_suggest2">	
	<input type='hidden' name="page" value="" />
	<input type='hidden' name="searchType" value="" />
	<input type='hidden' name="keyword" value="" />
	<input type="hidden" name="selectedOrder" value="${so }"/>
</form>    
    
<form id="form_selectOrder">
	<input type="hidden" name="selectedOrder" value=""/>
<!-- 	<input type='hidden' name="page" value="" /> -->
<!-- 	<input type='hidden' name="searchType" value="" /> -->
<!-- 	<input type='hidden' name="keyword" value="" /> -->
</form>
   
    
</body>
    
    
    
    
    
    
    