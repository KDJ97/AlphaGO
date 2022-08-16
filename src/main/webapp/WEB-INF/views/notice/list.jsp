<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="noticeList" value="${dataMap.noticeList }" />
<c:set var="fixList" value="${dataMap.fixList }" />
<c:set var="cri" value="${pageMaker.cri }" />


<head>
<!-- <script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script> -->
<script>
	$(function() {
		<c:if test="${auth == 'S'}">
		$('#registBtn').hide();
		$('#searchBtn').css({
			"background" : "#564ab1",
			"color" : "white"
		});
		$('.back').css({
			"background-color" : "rgba(86,74,177,.25)"
		});
		</c:if>
		<c:if test="${auth == 'T'}">
		$('#registBtn').css({
			"background" : "#51d28c",
			"color" : "white"
		});
		$('#searchBtn').css({
			"background" : "#51d28c",
			"color" : "white"
		});
		$('.back').css({
			"background-color" : "rgba(81,210,140,.25)"
		});
		</c:if>
		<c:if test="${auth == 'M'}">
		$('#registBtn').css({
			"background" : "#038edc",
			"color" : "white"
		});
		$('#searchBtn').css({
			"background" : "#038edc",
			"color" : "white"
		});
		$('.back').css({
			"background-color" : "rgba(3,142,220,.25)"
		});
		</c:if>

	});
</script>
<style>
table th, td {
	text-align: center;
}

.red {
	background-color: lavenderblush;
	font-weight: bold;
/* 	color:red; */
}
</style>

</head>

<body>

	<!-- Main content -->
	<section class="content">
		<div class="card" style="padding: 10px;">

			<h5 style="margin: 10px 0px 15px 10px; font-weight: bold">
				<i class="uil-bell" style="margin-right: 10px;"></i>공지사항
			</h5>

			<div class="d-flex">
				<div class="w-100"
					style="width: 95% !important; margin-bottom: 10px;">
					<div id="keyword" class="card-tools"
						style="width: 400px; margin-left: 10px;">
						<div class="input-group">
							<select class="form-select col-md-3" name="cateType"
								id="cateType" style="width: 40px;">
								<option value="전체" ${cri.cateType eq '전체' ? 'selected':'' }>분류</option>
								<option value="수업" ${cri.cateType eq '수업' ? 'selected':'' }>수업</option>
								<option value="학원" ${cri.cateType eq '학원' ? 'selected':'' }>학원</option>
								<option value="입시" ${cri.cateType eq '입시' ? 'selected':'' }>입시</option>
								<option value="기타" ${cri.cateType eq '기타' ? 'selected':'' }>기타</option>
							</select> <select class="form-select col-md-3" name="perPageNum"
								style="width: 65px;" id="perPageNum">
								<option value="10" ${cri.perPageNum==10 ? 'selected':'' }>정렬개수</option>
								<option value="20" ${cri.perPageNum==20 ? 'selected':'' }>20개씩</option>
								<option value="30" ${cri.perPageNum==30 ? 'selected':'' }>30개씩</option>
								<option value="50" ${cri.perPageNum==50 ? 'selected':'' }>50개씩</option>
							</select> <select class="form-control col-md-3" name="searchType"
								id="searchType">
								<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>제목</option>
								<option value="c" ${cri.searchType eq 'c' ? 'selected':'' }>내용</option>
								<option value="w" ${cri.searchType eq 'w' ? 'selected':'' }>작성자</option>

							</select> <input class="form-control" type="text" style="width: 80px;"
								name="keyword" placeholder="검색어 입력" value="${cri.keyword }" />
							<span class="input-group-append">
								<button class="btn" style="float: right;" type="button"
									id="searchBtn" data-card-widget="search" onclick="list_go(1);">
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>
						</div>
					</div>
				</div>
				<div class="flex-shrink-1">
					<button type="button" class="btn btn-soft-primary" id="registBtn"
						style="width: 65px; margin-right: 10px;"
						onclick="OpenWindow('registForm.go?cnt=${fn:length(fixList) }','상세보기',800,700);">등록</button>
				</div>
			</div>

			<div class="card-body" style="padding-top: 0px;">
				<table class="table text-center" id="noticeTable">
					<tr style="font-size: 0.95em;">
						<th class="back" style="width: 9%;">No.</th>
						<th class="back" style="width: 10%;">Cate</th>
						<th class="back" style="width: 35%;">제목</th>
						<th class="back" style="width: 10%;">작성자</th>
						<th class="back" style="width: 15%;">작성일</th>
						<th class="back">첨부파일</th>
						<th class="back" style="width: 8%;">조회수</th>
					</tr>
					<c:if test="${empty noticeList }">
						<tr>
							<td colspan="7"><b>게시글이 없습니다</b></td>
						</tr>
					</c:if>
					<c:if test="${!empty noticeList }">	
						<c:forEach items="${fixList }" var="fix">
							<c:if test="${fix.fixed eq 1 }">
								<tr style='font-size: 0.85em; cursor: pointer;position: sticky; top: 0;' class="red"
									onclick="OpenWindow('detail.go?from=list&lcode=${fix.lcode}&cnt=${fn:length(fixList) }','상세보기',800,700);">
									<td style="font-weight: bold;font-size:1.7em;color:red;padding: 5px;"><i class="uil-volume"></i></td>
									<td>[${fix.category }]</td>
									<td style="text-align: left;">${fix.title }</td>
									<td>${fix.writer}</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd"
											value="${fix.regDate}" /></td>
									<td><c:if test="${!empty fix.attachList }">
											<i class="nav-icon fas fa-file"></i>
										</c:if> <c:if test="${empty fix.attachList }">
											<span>-</span>
										</c:if></td>
									<td>${fix.viewcnt}</td>
								</tr>
							</c:if>
						</c:forEach>
						<c:forEach items="${noticeList }" var="notice">
							<c:if test="${notice.fixed eq 0 }">
								<tr style='font-size: 0.85em; cursor: pointer;'
									onclick="OpenWindow('detail.go?from=list&lcode=${notice.lcode}&cnt=${fn:length(fixList) }','상세보기',800,700);">
									<td>${notice.lcode }</td>
									<td>[${notice.category }]</td>
									<td style="text-align: left;">${notice.title }</td>
									<td>${notice.writer}</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd"
											value="${notice.regDate}" /></td>
									<td><c:if test="${!empty notice.attachList }">
											<i class="nav-icon fas fa-file"></i>
										</c:if> <c:if test="${empty notice.attachList }">
											<span>-</span>
										</c:if></td>
									<td>${notice.viewcnt}</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:if>
				</table>

			</div>
			<!-- end tab pane -->


			<div class="card-footer">
				<nav aria-label="pds list Navigation">
					<ul class="pagination justify-content-center m-0">
						<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
					</ul>
				</nav>
			</div>
		</div>
	</section>

	<c:if test="${from eq 'regist' }">
		<script>
			//alert("등록되었습니다.");
			window.close();
			window.opener.location.reload();
		</script>
	</c:if>

	<%-- 	<script>
function printData(replyArr,target,templateObject){
	var template=Handlebars.compile(templateObject.html());
	var html = template(replyArr);	
	$('#noticeTable').remove();
	target.after(html);
}

function ajax_go(page) {
	console.log(page.value);
	
	var name = "";
	
	if(page.value == 0) {
		name = "전체";
	} else if(page.value == 1) {
		name = "수업";
	} else if(page.value == 2) {
		name = "학원";
	} else if(page.value == 3) {
		name = "입시";
	} else {
		name = "기타";
	}
	
	var str = "";
	$.ajax({
	    type : "POST",            // HTTP method type(GET, POST) 형식이다.
	    url : "<%=request.getContextPath()%>/notice/cateList.go",      // 컨트롤러에서 대기중인 URL 주소이다.
	    data : {name : name},            // Json 형식의 데이터이다.
	    success : function(res){ // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
	        // 응답코드 > 0000
// 	        alert(res[0].title);
// 	        for(var i =0; i<res.length; i++){
// 	        	console.log(res[i].title);
// 	        }
			
	        printData(res.noticeList,$('#noticeTable'),$('#notice-list-template'));
	       /*  printPagination(res.pageMaker,$('ul#pagination'),$('#notice-pagination-template')); */
	    },
	    error : function(error){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
	        alert("에러 : " + error.status);
	    }
	});
	
}
</script>
	<script type="text/x-handlebars-template" id="notice-list-template">
{{#each .}}
	<tr style='font-size: 0.85em; cursor: pointer;' onclick="OpenWindow('detail.go?from=list&lcode=${notice.lcode}','상세보기',800,700);">

		{{#ifnotice1 fixed}}
   			 <td style="font-weight: bold; color: red;">📢</td>
		{{else}}
    		<td>{{lcode}}</td>
		{{/ifnotice1}}

		{{#ifnotice2 fixed}}
   			 <td class="red">{{category}}</td>
		{{else}}
    		<td>{{category}}<</td>
		{{/ifnotice2}}

		{{#ifnotice3 fixed}}
   			 <td style="text-align: left;" class="red">{{title}}</td>
		{{else}}
    		<td>{{title}}<</td>
		{{/ifnotice3}}

		<td>{{writer}}</td>
		<td><prettifyDate {{regDate}}></td>

		{{#ifnotice4 attachList}}
   			 <td><i class="nav-icon fas fa-file"></i></td>
		{{else}}
    		<td><span>-</span><</td>
		{{/ifnotice4}}
		<td>{{viewcnt}}</td>
	</tr>
{{/each}}
</script>

	<script>
Handlebars.registerHelper('ifnotice1', function(v1, options) {
	  if(v1 == 1) {
	    return options.fn(this);
	  }
	  return options.inverse(this);
	});
	
Handlebars.registerHelper('ifnotice2', function(v1, options) {
	  if(v1 == 1) {
	    return options.fn(this);
	  }
	  return options.inverse(this);
	});
	
Handlebars.registerHelper('ifnotice3', function(v1, options) {
	  if(v1 == 1) {
	    return options.fn(this);
	  }
	  return options.inverse(this);
	});
	
Handlebars.registerHelper('ifnotice4', function(v1, options) {
	  if(v1 = null) {
	    return options.fn(this);
	  }
	  return options.inverse(this);
	});
	
Handlebars.registerHelper({
	   "prettifyDate":function(timeValue){ //Handlbars에 날짜출력함수 등록
	      var dateObj=new Date(timeValue);
	      var year=dateObj.getFullYear();
	      var month=dateObj.getMonth()+1;
	      var date=dateObj.getDate();
	      return year+"-"+month+"-"+date;
	   },
	   "LookUpCheck":function(replyer){
	      var result="none";
	      if(replyer == "${loginUser.id}") result="visible";
	      return result;
	   }
	});
</script>

<script type="text/x-handlebars-template"
		id="notice-pagination-template">
<li class="paginate_button page-item">
   <a href="1" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
      <i class='fas fa-angle-double-left'></i>
   </a>
</li>
<li class="paginate_button page-item">
   <a href="{{#if prev}}{{prevPageNum}}{{/if}}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
      <i class='fas fa-angle-left'></i>
   </a>
</li>
{{#each pageNum}}
<li class="paginate_button page-item {{signActive this}} ">
   <a href="javascript:getPage('<%=request.getContextPath()%>/notice/list.do?lcode=${notice.lcode}&page={{this}}',{{this}});" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
      {{this}}
   </a>
</li>
{{/each}}

<li class="paginate_button page-item ">
   <a href="{{#if next}}{{nextPageNum}}{{/if}}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
      <i class='fas fa-angle-right'></i>
   </a>
</li>
<li class="paginate_button page-item">
   <a href="{{realEndPage}}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
      <i class='fas fa-angle-double-right'></i>
   </a>
</li>   
</script>
	<script>
var replyPage=1;

window.onload=function(){
	getPage("<%=request.getContextPath()%>
		/replies/${board.bno}/"
					+ replyPage);
		}
		function getPage(pageInfo, page) {
			if (page)
				replyPage = page;
			$.getJSON(pageInfo, function(data) {
				printData(data.replyList, $('#repliesDiv'),
						$('#reply-list-template'));
				printPagination(data.pageMaker, $('ul#pagination'),
						$('#reply-pagination-template'));
			});
		}

		function printData(replyArr, target, templateObject) {
			var template = Handlebars.compile(templateObject.html());
			var html = template(replyArr);
			$('.replyLi').remove();
			target.after(html);
		}

		/* pagination */
		function printPagination(pageMaker, target, templateObject) {
			var pageNumArray = new Array(pageMaker.endPage
					- pageMaker.startPage + 1);
			for (var i = 0; i < pageMaker.endPage - pageMaker.startPage + 1; i++) {
				pageNumArray[i] = pageMaker.startPage + i;
			}
			pageMaker.pageNum = pageNumArray;
			pageMaker.prevPageNum = pageMaker.startPage - 1;
			pageMaker.nextPageNum = pageMaker.endPage + 1;

			var template = Handlebars.compile(templateObject.html());
			var html = template(pageMaker);
			target.html("").html(html);
		}
	</script> --%>
</body>
