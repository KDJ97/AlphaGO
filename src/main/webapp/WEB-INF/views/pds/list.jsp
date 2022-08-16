<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="pdsList" value="${dataMap.pdsList }" />

<head>

<style>
table th,td{
	text-align:center;
}

</style>
<script src="<%=request.getContextPath() %>/resources/assets/libs/rater-js/index.js"></script>
<script type="text/javascript">
function registLike(star_div){
	if($(star_div).find('.star-value').css('width') == '0px'){
		//등록
		 $.ajax({
            url:'<%=request.getContextPath()%>/favorite/regist.go',
            data : {
            	'lCode' : $(star_div).attr('data-lCode')
            },
            success:function(data){
            	$(star_div).find('.star-value').attr('data-fno', data.fno);
            	$(star_div).find('.star-value').css('width', '100%');
            }
        })



	}else{

		//해제
		$.ajax({
            url:'<%=request.getContextPath()%>/favorite/remove.go',
            data : {
            	'fno' : $(star_div).find('.star-value').attr('data-fno')
            },
            success:function(data){
            	$(star_div).find('.star-value').removeAttr('data-fno');
			 	$(star_div).find('.star-value').css('width', '0%');
            }
        })
	}
}

var tr = document.getElementById('thead_tr');
var i_btn = document.getElementById('inputBtn');
var s_btn = document.getElementById('searchBtn');
if(${sessionScope.loginUser.authority eq 'ROLE_STUDENT' }){
	tr.className = 'bg-soft-purple';
	i_btn.className = 'btn btn-soft-purple';
	s_btn.className = 'btn btn-soft-purple';
}
if(${sessionScope.loginUser.authority eq 'ROLE_TEACHER' }){
	//alert('강사')
	tr.className = 'table-success'
	i_btn.className = 'btn btn-soft-success';
	s_btn.className = 'btn btn-soft-success';
}
if(${sessionScope.loginUser.authority eq 'ROLE_MASTER' }){
	//alert('원장')
	tr.className = 'table-primary'
	i_btn.className = 'btn btn-soft-primary';
	s_btn.className = 'btn btn-soft-primary';
}

</script>
</head>

<body>


	<div class="row">
	  <div class="col-12">
	      <div class="page-title-box d-flex align-items-center justify-content-between">
	          <h4 class="mb-0">자료실</h4>

	          <div class="page-title-right">
	              <ol class="breadcrumb m-0">
	                  <li class="breadcrumb-item"><a href="javascript: void(0);"><i class="fa fa-dashboard"></i>자료실</a></a></li>
	                  <li class="breadcrumb-item active">리스트</li>
	              </ol>
	          </div>

	      </div>
	  </div>
	</div>

    <!-- Main content -->
    <section class="content">
		<div class="card" >

		 <!-- Content Header (Page header) -->
    <section class="content-header">
    	<div class="container-fluid">
      	</div>
    </section>
			<div class="card-header with-border">

				<div id="keyword" class="card-tools" >

					<button id="inputBtn" type="button" class="btn btn-soft-primary"  style="float:left;"id="registBtn" onclick="OpenWindow('registForm.go','상세보기',800,900);">자료등록</button>
					<div class="input-group"  style="width:450px; float:right;">
					    <select class="form-select col-md-3" name="perPageNum" id="perPageNum">
					  		<option value="10" ${cri.perPageNum==10 ? 'selected':'' } >정렬개수</option>
					  		<option value="20" ${cri.perPageNum==20 ? 'selected':'' }>20개씩</option>
					  		<option value="30" ${cri.perPageNum==30 ? 'selected':'' }>30개씩</option>
					  		<option value="50" ${cri.perPageNum==50 ? 'selected':'' }>50개씩</option>
					    </select>

						<select class="form-select col-md-3" name="searchType" id="searchType">
							<option value="tcw" ${cri.searchType eq 'tcw' ? 'selected':'' }>전 체</option>
							<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>제 목</option>
							<option value="w" ${cri.searchType eq 'w' ? 'selected':'' }>작성자</option>
						</select>

						<input  class="form-control" type="text" style="width:130px;" name="keyword" placeholder="검색어를 입력하세요." value="${cri.keyword }"/>
						<span class="input-group-append">
						  <button id="searchBtn" class="btn btn-soft-primary" style="float:right;"type="button" id="searchBtn" data-card-widget="search" onclick="list_go(1);" >
							<i class="fa fa-fw fa-search"></i>
						  </button>
						</span>
					</div>
				</div>
			</div>
			<div class="card-body" style="padding:0px;">
				<table class="table text-center table-hover" >
				  <thead>
					<tr id="thead_tr">
						<th style="font-weight: bold; width:10%;">즐겨찾기</th>
						<th style="font-weight: bold; width:30%;">제 목</th>
						<th style="font-weight: bold; width:15%;">작성자</th>
						<th style="font-weight: bold;">첨부파일</th>
						<th style="font-weight: bold;">작성일</th>
						<th style="font-weight: bold; width:10%;">조회수</th>
					</tr>
				  </thead>
				    <c:if test="${empty pdsList }">
			    	  <tr>
			    	    <td colspan="6"> <b>게시글이 없습니다</b> </td>
			    	  </tr>
				    </c:if>
					<c:forEach items="${pdsList }" var="pds">
						<tr class="table-white" style="cursor: pointer;" >
		    				<th>
		    				  <div data-lCode="${pds.lCode }" onclick="registLike(this)" class="star-rating " style="width: 22px; height: 22px; background-size: 22px;">

	                            <c:set var="isLike" value="f" />
	                            <c:forEach items="${likeList}" var="like">
	                              <c:if test="${pds.lCode eq like.lCode}">
		                            <c:set var="isLike" value="t" />
		                            <c:set var="fno" value="${like.fno }"/>
	                              </c:if>
								</c:forEach>

								<c:if test="${isLike eq 'f' }">
	                              <div class="star-value" style="background-size: 22px; width: 0%;"></div>
								</c:if>

								<c:if test="${isLike eq 't' }">
	                              <div data-fno="${fno }" class="star-value" style="background-size: 22px; width: 100%;"></div>
								</c:if>

	                          </div>
		    				</th>
		                	<th onclick="javascript:OpenWindow('detail.do?from=list&lCode=${pds.lCode }','상세보기',600,700);">${pds.title } </th>
		                	<th>${pds.writer }</th>
		                	<th>
		                	  <c:if test="${!empty pds.attachList }">
  			                	<i class="uil-clipboard-notes font-size-20"></i>
							  </c:if>
							  <c:if test="${empty pds.attachList }">
								<span>-</span>
							  </c:if>
		                	</th>
		                	<th><fmt:formatDate value="${pds.regDate }" pattern="yyyy-MM-dd"/></th>
		                	<th>${pds.viewCnt }</th>
			        	</tr>
					</c:forEach>
				</table>
			</div>
			<div class="card-footer">
				<nav aria-label="pds list Navigation">
					<ul class="pagination justify-content-center m-0">
						<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
					</ul>
				</nav>
			</div>
		</div>
	</section>


<c:if test="${from eq 'regist' }" >
	<script>
		//alert("등록되었습니다.");
		window.close();
		window.opener.location.reload();
	</script>
</c:if>


</body>






