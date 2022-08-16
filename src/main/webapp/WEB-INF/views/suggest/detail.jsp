<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<head>
<script>
function remove_go(){
	var formObj = $("form[role='form']");
	var answer = confirm("정말 삭제하시겠습니까?");
	if(answer){		
		formObj.attr("action", "remove.go");
		formObj.attr("method", "get");
		formObj.submit();
	}
}
function modify_go(){
	var formObj = $("form[role='form']");
	formObj.attr({
		'action':'modifyForm.go',
		'method':'post'
	});
	formObj.submit();
}
</script>
<script>
$(document).ready(function() {
	$('#likecnt').bind('click', function() {
		doSomething();  
	});
});

function like_go(){
// 	var data23 = {"lcode":$("#lcode2").val(),"id":$("#answerer").val()};
// 	console.log(data23);
	$.ajax({
		url:"<%=request.getContextPath()%>/suggest/like.go",
		method:"GET",
		data:{
			  "lcode":$("#lcode2").val()
			  ,"id":$("#answerer").val()
			  },
		dataType:"json",
		success:function(success){
			console.log(success);
			alert("좋아요 +1");
			$('#likecnt').html(success.cnt);			
			$('#td_likecnt').html(success.cnt);			
		},
		error:function(error){
			alert("이미 좋아요를 누른 글입니다");
		}
	});
}
</script>
<c:if test="${from eq 'modify' }">
<script>
	//alert("게시글이 수정되었습니다.");
</script>
</c:if> 
<script>
var tr = document.getElementById('titleTr');
var tr2 = document.getElementById('likeTr');
var tr3 = document.getElementById('regTr');
var tr4 = document.getElementById('viewcntTr');
var bt = document.getElementById('likeBtn');

if(${sessionScope.loginUser.authority eq 'ROLE_STUDENT' }){
	tr.className = 'bg-soft-purple';
	tr2.className = 'bg-soft-purple';
	tr3.className = 'bg-soft-purple';
	tr4.className = 'bg-soft-purple';
}
if(${sessionScope.loginUser.authority eq 'ROLE_TEACHER' }){
	tr.className = 'table-success'
	tr2.className = 'table-success'
	tr3.className = 'table-success'
	tr4.className = 'table-success'
}
if(${sessionScope.loginUser.authority eq 'ROLE_MASTER' }){
	tr.className = 'table-primary'
	tr2.className = 'table-primary'
	tr3.className = 'table-primary'
	tr4.className = 'table-primary'
}

</script>

</head>

<title>건의게시판</title>

<body>
	 
	 <!-- Main content -->
    <section class="content">		
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
			        	상세보기
			        </li>		        
	    	  </ol>
	  			</div>
	  		</div>
	  	</div>
	</section>
	  		<div id="keyword" class="card-tools" style="">
	  			<table style="width:96%; margin-left:20px;  border-top: solid black 1px;"  class="table table-bordered text-center">
				<tr>
					<th id="titleTr" scope="row">제목</th>
					<c:choose>
						<c:when test="${suggest.updateDate ne null}">
						<td colspan="5" id="suggestTitle" style="text-align: left;max-width: 100px; overflow:hidden;white-space: nowrap; text-overflow: ellipsis;">
						${suggest.title } (수정됨)
						</td>
						</c:when>
						<c:otherwise>
						<td colspan="5" id="suggestTitle" style="text-align: left;max-width: 100px; overflow:hidden;white-space: nowrap; text-overflow: ellipsis;">
						${suggest.title } 
						</td>
						</c:otherwise>
					</c:choose>	
				</tr>
				<tr style="border-bottom: solid black 1px;">
					<th id="likeTr" scope="row"><i class="uil-thumbs-up" ></i></th>
					<td id="td_likecnt">${suggest.likecnt }</td>
					<th id="regTr" scope="row">작성일</th>
					<c:choose>
						<c:when test="${suggest.updateDate ne null}">
							<td><fmt:formatDate value="${suggest.updateDate }" pattern="yyyy-MM-dd"/></td>
						</c:when>
						<c:otherwise>
							<td><fmt:formatDate value="${suggest.regDate }" pattern="yyyy-MM-dd"/></td>
						</c:otherwise>
					</c:choose>
					<th id="viewcntTr" scope="row">조회수</th>
					<td>${suggest.viewcnt }</td>
				</tr>
				<tr class="bgnone">
					<td style="border-bottom: solid black 1px; height: 300px; text-align: left;" colspan="6" class="tview_desc">
					${suggest.content }						
					</td>
				</tr>
				</table>
			</div>
			<div style="text-align: center;">
			<button id="likeBtn" onclick="like_go();" class="btn btn-primary" style="height: 80px; width: 80px; border-radius: 50%; background-color:#eff0f2; border-color: white; ">
				<i style="font-size: 35px; text-align: center; color:black;" class="uil-thumbs-up"></i>
				<br>
				<h4 id="likecnt">${suggest.likecnt }</h4>
			</button>	
			</div>
		<!-- 답글(댓글) -->		
		<div class="card-body" style="padding-top:0px;">
			<div id=answercnt style="margin-bottom:10px;">
			<i class="uil-comment-message"></i>댓글 <span id="answercount">${suggest.answercnt }</span>
			</div>
			<div id="suggestAns">
			
			</div>
			<div class='text-center'>
				<ul id="pagination" class="pagination justify-content-center m-0" >
					
				</ul>
			</div>
			<div style="margin-top:10px;">
			<input id="answerer" name="answerer"  type="hidden" value="${loginUser.id }" >
			<textarea id="answer" name="answer" placeholder="내용을 입력하세요" style="width:88%;height:100px;flaot:left;"  rows="" cols=""></textarea>			
			<button onclick="answerRegist_go();" class="btn btn-primary" style="width:10%;height:100px; float:right;">댓글입력</button>
			<hr>
			<button style="float:right;" class="btn btn-primary col-sm-1" onclick="location.href='list.go'">목록</button>
			<c:if test="${suggest.writer eq loginUser.id}">
				<button onclick="modify_go();" style="float:right; margin-right: 10px; background-color:green;" class="btn btn-primary col-sm-1">수정</button>
				<button onclick="remove_go();" style="float:right; margin-right: 10px; background-color:black;" class="btn btn-primary col-sm-1">삭제</button>
			</c:if>
			<c:if test="${sessionScope.loginUser.authority eq 'ROLE_MASTER' }">
				<button onclick="remove_go();" style="float:right; margin-right: 10px; background-color:black;" class="btn btn-primary col-sm-1">삭제</button>
			</c:if>
			</div>
		</div>
    </section>

<form role="form">
	<input type="hidden" name="lcode" id="lcode2" value="${suggest.lcode }" />
</form>
<%@ include file="./answer_js.jsp" %>    
</body>
    
    
    
    
    
    
    