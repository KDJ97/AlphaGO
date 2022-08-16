<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="classList" value="${dataMap.classListForReview }"/>
<c:set var="classAllReviewList" value="${dataMap.classAllReviewList }"/>

<head>
<script src="<%=request.getContextPath() %>/resources/js/index2.js"></script>
<script src="<%=request.getContextPath() %>/resources/js/index3.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>

<script type="text/javascript">
function review_go(target){
	var classCode= $(target).attr('data-role');
	//console.log("classCode : " + classCode);	
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/getReview",
		method:"GET",
		data:{"classCode" : classCode},
		success:function(res){
			printData(res,$('#reviewDiv'),$('#reviewList-template'));			
		},
		error:function(xhr){
			
		}
	})
	
}
</script>
<script type="text/x-handlebars-template"  id="reviewList-template" >
{{#if classReviewList}}
{{#each classReviewList}}
<div id="review{{reviewCode}}" onclick="modal_go(this);" class="bg-light mb-2" data-bs-toggle="modal" data-bs-target="#review_detail" style="border-radius: 5px; padding: 15px; cursor: pointer;">
	<p style="font-weight: bold; padding-bottom:5px; margin-bottom:0px;">{{title}}</p>
	<div class="d-flex justify-content-start">
		<div id="rater-step" dir="ltr" class="star-rating" style="width: 110px; height: 22px; background-size: 22px;">
			<div class="star-value" style="background-size: 22px; width: {{starScoreRate}}%;"></div>
		</div>
		<div style="font-weight: bold; margin-left: 5px;">{{starScore}}</div>
	</div>
	<div style="margin-top: 5px;">{{compareLength content}}</div>
</div>
{{/each}}
{{else}}
	<br>
	<h5 style="font-weight: bold; text-align:center;">해당 수업의 수업후기가 없습니다.</h5>
{{/if}}
</script>
<script type="text/x-handlebars-template" id="reviewDetail-template">
<div>
	<table class="table table-bordered text-center">
		<tr>
			<td style="background-color: #8BDDA8;">제목</td>
			<td style="text-align:left;">{{title}}</td>
		</tr>
		<tr>
			<td style="background-color: #8BDDA8;">평점</td>
			<td style="text-align:left;">
			<div id="rater-step" dir="ltr" class="star-rating" style="float:left; width: 110px; height: 22px;
			 background-size: 22px;">
				<div class="star-value" style="background-size: 22px; width: {{starScoreRate}}%;"></div>
			</div>
			<div style="font-weight: bold; margin-left:5px; float:left; ">{{starScore}}</div>
			</td>
		</tr>
	</table>
</div>
<div style="margin-top: 10px; border:1px solid #8BDDA8; overflow: auto; height:200px;">{{content}}</div>
</script>
<script>
Handlebars.registerHelper({
	"prettifyDate":function(timeValue){ //Handlbars에 날짜출력함수 등록
		var dateObj=new Date(timeValue);
		var year=dateObj.getFullYear();
		var month=dateObj.getMonth()+1;
		var date=dateObj.getDate();
		return year+"-"+month+"-"+date;
	},
	"trimString":function(passedString){     //substring 함수
		var theString = passedString.substring(0,57);
	    return new Handlebars.SafeString(theString)					  
	},
	"compareLength":function(str){
		var strLength = str.length;
		//console.log(strLength);
		var theString ='';
		if(strLength>=56){
			theString = str.substring(0,57);
			theString += '...';
		}else{
			theString = str;
		}
		return new Handlebars.SafeString(theString)
	}
	
});
</script>
<script>
function modal_go(target){
	var reviewID = $(target).attr('id')
	var reviewCode = reviewID.substring(6,reviewID.length);
	console.log("reviewID : " + reviewID);
	console.log("reviewCode : " + reviewCode);
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/getReviewDetail",
		method:"GET",
		data:{"reviewCode" : reviewCode},
		success:function(res){
			printData(res.classReviewVO,$('#reviewDetailDiv'),$('#reviewDetail-template'));			
		},
		error:function(xhr){
			alert("리뷰상세정보 조회 실패..");
		}
	})
	
}
</script>
</head>

<title>수업후기</title>

<body>
	 <!-- Main content -->
<!-- 	<section class="content-header"> -->
<!-- 	  	<div class="container-fluid"> -->
<!-- 	  		<div class="row md-2"> -->
<!-- 	  		</div> -->
<!-- 	  	</div> -->
<!-- 	</section> -->
	 
	 <!-- Main content -->
	<div class="card">
		<section class="content-header">
			<div class="container-fluid">
				<div class="row md-2">
					<div class="col-sm-6">
						<h5 style="margin-bottom: 15px; font-weight: bold; margin-top:20px; margin-left:10px;">
							<i class="uil-comment-lines" style="margin-right: 10px;"></i>수업후기
						</h5>
					</div>
					<div class="col-sm-6">
						<ol style="float: right; margin: 20px;"
							class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="list.go"> <i
									class="fa fa-dashboard"></i>수업관리
							</a></li>
							<li class="breadcrumb-item active">수업후기</li>
						</ol>
					</div>
				</div>
			</div>
		</section>
		<hr style="margin-top:0px;">
		
<!-- 		<div id="keyword" class="card-tools" style=""> -->
<!-- 		</div> -->
		
		<div class="card-body"  style="vertical-align: middle; padding-top:0px;">
			<div style="height:700px; overflow:auto; float:left; border:1px solid seashell;" class="col-md-6"> 
			<table class="table table-bordered text-center" >
				<tr style="font-size: 0.95em; font-wieght:bold; background-color: #8BDDA8;">
					<th style="width: 35%;">수업명</th>
					<th style="width: 9%;">종료일</th>
					<th style="width: 5%;">평점</th>
				</tr>
				<c:forEach items="${classList }" var="classes"> 
				<tr onclick="review_go(this);" style='font-size: 0.85em; cursor: pointer;' data-role="${classes.classCode }">
					<td>${classes.className }<input class="clCode" type="hidden" value="${classes.classCode }"/></td>
					<td>${fn:substring(classes.endDate,0,10) }</td>
					<td>${classes.avgPoint }</td>
				</tr>
				</c:forEach>
			</table>
			</div>
			<div class="col-md-1" style="text-align:center; float:left; height: 700px;">
				<div style="display: inline-block; margin-top: 250px;">
					<i style="font-size:3.0em; vertical-align: center;" class="uil-angle-double-right"></i>
				</div>
			</div>
			<div class="col-md-5" style="float: right; overflow:auto; height:700px; border:1px solid seashell; ">
				<table class="table table-bordered text-center" style="margin-bottom: 0px;">
					<tr style="font-size: 0.95em; font-wieght:bold; background-color: #8BDDA8;">
						<th style="width: 8%;">수업후기</th>
					</tr>
				</table>
				<div class="card">
					<div id="reviewDiv" class="card-body" style="padding:5px; height:100%;">
						<div class="d-flex justify-content-start">
						</div> 	
						<c:forEach items="${classAllReviewList }" var="reviews">
						<div id="review${reviews.reviewCode}" onclick="modal_go(this);" class="bg-light mb-2" data-bs-toggle="modal" data-bs-target="#review_detail" style="border-radius: 5px; padding: 15px; cursor: pointer;">
							<p style="font-weight: bold; padding-bottom:5px; margin-bottom:0px;">${reviews.className }</p>					
							<p style="font-weight: bold; padding-bottom:5px; margin-bottom:0px;">${reviews.title }</p>
							<div class="d-flex justify-content-start">
								<div id="rater-step" dir="ltr" class="star-rating" style="width: 110px; height: 22px; background-size: 22px;">
									<div class="star-value" style="background-size: 22px; width: ${reviews.starScoreRate}%;"></div>
								</div>
								<div style="font-weight: bold; margin-left: 5px;">${reviews.starScore}</div>
							</div>
							<c:choose>
						        <c:when test="${fn:length(reviews.content) gt 57}">
								<div style="margin-top: 5px;">${fn:substring(reviews.content, 0, 56)}...</div>
						        </c:when>
						        <c:otherwise>
								<div style="margin-top: 5px;">${reviews.content}</div>
						        </c:otherwise>
							</c:choose>
						</div>
						</c:forEach>
					</div>
				</div>
<!-- 				<div class="card" style="background-color: #8BDDA8;"> -->
<!-- 					<p>강의 정말 이해가 잘됩니다!!</p> -->
<!-- 					<div> -->
<!-- 						<div id="rater" style="float:left;"></div> -->
<!-- 						<div><span class="live-rating"></span></div> -->
<!-- 					</div> -->
<!-- 				</div> -->
			</div>
		</div>
		<div class="card-footer">
<%-- 			<%@ include file="/WEB-INF/views/common/pagination.jsp"%> --%>
		</div>

	</div>

<!-- Modal2 -->
<div class="modal fade" id="review_detail" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">수업후기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div id="reviewDetailDiv" class="modal-body">
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<c:if test="${from eq 'regist' }">
<script>
	alert("건의글 등록이 성공했습니다.");
	window.opener.location.reload();
	window.close();
</script>
</c:if>    
 
<!-- <script src="node-modules/rater-js/index.js"></script>     -->
</body>
    
    
    
    
    
    
    