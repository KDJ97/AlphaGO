<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="assignList" value="${dataMap.assignList }" />


<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="<%=request.getContextPath()%>/resources/assets/libs/dropzone/min/dropzone.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
<script>
window.onload=function(){
	summernote_go($('#content'),'<%=request.getContextPath()%>');
}
</script>
<script>
function removeFile_go(className){
	//alert("X btn");
	var a = $('a.'+className);
	var assignCode = a.attr("target-code");
	//console.log("assignCode : " + assignCode);
	var inputFile = $('#fileBtn')
	
	if(!confirm(a.attr("file-name")+"을 정말 삭제하시겠습니까?")){
		return;
	}
	
	a.remove();
	$('#xIcon').remove();
	$('#sp').remove();

	$.ajax({
		url:"<%=request.getContextPath()%>/assignManage/deleteFile",
		method:"POST",
		data:{"assignCode" : assignCode},
		success:function(){
			alert("파일삭제!");
			inputFile.css('display','inline');
		},
		error:function(){
			alert("파일 삭제 실패..관리자에게 문의하세요");
		}
	})
}

function removeAssign_go(t){
	var assignCode = $(t).attr('target-code');
	//console.log("assignCode : " + assignCode);
	
	if(!confirm("정말 삭제하시겠습니까?")){
		return;
	}
	$.ajax({
		url:"<%=request.getContextPath()%>/assignManage/deleteAssign",
		method:"POST",
		data:{"assignCode" : assignCode},
		success:function(){
			alert("과제가 삭제되었습니다.");
			window.location.reload();
		},
		error:function(){
			alert("삭제 실패..관리자에게 문의하세요");
		}
	})
}

function modifyAssign_go(){
	
	Swal.fire({
	      icon: 'success',
	      title: '수정되었습니다.'
	      
	    }).then((result) => {
  	
  	  
	$("form[role='form']").submit();

 		})
	//alert("수정되었습니다");
	//$("form[role='form']").submit();
}

</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script type="text/x-handlebars-template"  id="assignDetail-template">
<hr>
<div class="col-md-3" style="float:left;">
	<h4>과제정보</h4>
</div>
<div class="col-md-9" style="float:right;" >
	<button style="height:20px; line-height:0px; float:right;" class="btn btn-secondary" onclick="removeAssign_go(this);" target-code="{{assignCode}}">삭제</button>
	<button style="height:20px; line-height:0px; float:right; margin-right:3px;" class="btn btn-primary" onclick="modifyAssign_go(this)">수정</button>
</div>
<br>
<hr>
<form enctype="multipart/form-data" role="form" method="post" action="modify.go" name="modifyForm">
<div  class="col-md-12">
	<input type="hidden" value="{{assignCode}}" name="assignCode">
	<table class="table table-bordered">
		<tr style="text-align: center;">
			<td style="font-weight:bold; background-color: #8BDDA8;">과제명</td>
			<td><input name="title" style="width:100%;" type="text" value="{{title}}"></td>
			<td style="font-weight:bold; background-color: #8BDDA8;">마감일</td>
			<td><input name="endDate" type="datetime-local" value="{{endDate}}"></td>
		</tr>
		<tr>
			<td colspan="4" rowspan="4">
			<textarea name="content" id="content" style="float:left;" rows="5" cols="130">{{content}}</textarea>
			</td>
		</tr>
	</table>
</div>
<div class="col-md-12">
	{{#if filename}}
	<input id="fileBtn" type="file" name="uploadFile" style="display:none;">
	<span id="sp">첨부파일 :</span> <a class="aa" file-name="{{filename}}" target-code="{{assignCode}}" href="getFile.go?assignCode={{assignCode}}"><i class="uil-file-download">{{filename}}</i></a>
	<i id="xIcon" onclick="removeFile_go('aa');return false;" style="cursor:pointer; font-size: 1.5em; margin-left:5px;" class="uil-times-circle"></i>
	{{else}}
	<input id="fileBtn" type="file" name="uploadFile" style="display:inline;">
	{{/if}}
</div>
</form>
</script>


<script>
$(function(){
	//원생들의 과제 제출현황 목록 출력
	$('#aTable').on('click','.assigns',function(){
		var classCode = $(this).children('td.tdClass').children('input.cc').val();
		var assignCode = $(this).children('td.tdClass').children('input.ac').val();
		console.log("cc:"+classCode);
		console.log("ac:"+assignCode);
		$.ajax({
			url: "<%=request.getContextPath()%>/assignManage/studentAndStatus",
			data:{"classCode" : classCode, "assignCode" : assignCode},
			method:"GET",
			success:function(data){
// 				printData(data,$('#stuAndStatus'),$('#studentAndStatus-template'));
				str='';
				str+='<table class="table table-bordered text-center" >';	
				str+='<tr style="font-size:0.95em; background-color: #8BDDA8;">';
				str+='	<th style="width: 40%;">원생명</th>';
				str+='	<th style="width: 60%;">제출상태</th>';
				str+='</tr>';
				$.each(data.studentList,function(i,v){
					str+='<tr style="font-size:0.75em;cursor:pointer;">';
					str+='	<td style="padding-top: 8px; padding-bottom: 8px;" onclick=OpenWindow("detail.go?id='+v.id+'","상세보기",600,650)>'+v.name+'</td>';
					if(v.status){
						str+='	<td style="padding-top: 8px; padding-bottom: 8px;" onclick=OpenWindow("check.go?assignCode='+assignCode+'&id='+v.id+'&name='+v.name+'","상세보기",1000,600)><button style="height:20px; line-height:0px;" class="btn btn-primary">'+v.status+'</button></td>';
					}else{
						str+='	<td style="padding-top: 8px; padding-bottom: 8px;" onclick=OpenWindow("dm.go?id='+v.id+'","상세보기",800,600)><button style="height:20px; line-height:0px; background-color:red;" class="btn btn-primary">미제출</button></td>';
					}
					str+='</tr>';
				})
				str+='</table>';
			$('#stuAndStatus').html(str);	
			},
			error:function(){
				alert("학생 데이터 전송 실패ㅜㅜ");
			}
		})
		
		//과제상세정보 출력
		$.ajax({
			url: "<%=request.getContextPath()%>/assignManage/assignDetail",
			data:{"assignCode" : assignCode,"classCode" : classCode},
			method:"GET",
			success:function(data){
				printData(data.assignVO,$('#assignDetail'),$('#assignDetail-template'));
				summernote_go($('#content'),'<%=request.getContextPath()%>');

			},
			error:function(){
				alert("과제 데이터 전송 실패..");
			}
		})
		
	})
})


</script>

</head>

<title>과제관리</title>

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
								<i class="fas fa-book-reader" style="margin-right: 10px;"></i>과제관리
							</h5> 				
			  			</div>
			  			<div  class="col-sm-6">
			  				<ol style="float:right; margin:20px;" class="breadcrumb float-sm-right">
					        <li class="breadcrumb-item">
					        	<a href="list.go">
						        	<i class="fa fa-dashboard"></i>수업관리
						        </a>
					        </li>
					        <li class="breadcrumb-item active">
					        	과제관리
					        </li>		        
			    	  </ol>
			  			</div>
			  		</div>
			  	</div>
			</section>
	<hr style="margin-top:0px;">
	  		<div id="keyword" class="card-tools" style="">
					<div class="col-md-3" style="float:left;">
						<button onclick="location.href='registForm.go'" style="margin-left:20px;" type="button" class="btn btn-primary col-sm-0.6" id="registBtn" >과제등록</button>
					</div>
					<div class="col-md-9" style="float:right;" >
					
					</div>
			</div>
			<div class="card-body">
				<div class="col-md-8" style="float:left; height:280px; overflow: auto; border:0.5px solid lightgray;">
				<table id="aTable" class="table table-bordered text-center"style="vertical-align: middle;" >					
					<tr style="font-size:0.85em; background-color: #8BDDA8;">
						<th style="width:25%;">수업명</th>
						<th style="width:25%;">과제명</th>
						<th style="width:15%;">요청일</th>
						<th style="width:15%;">마감일</th>
						<th style="width:10%;">제출율</th>
					</tr>				
					<c:if test="${empty assignList }">		
						<tr>
							<td colspan="5"><strong>해당 내용이 없습니다.</strong></td>
						</tr>
					</c:if>
					<c:forEach items="${assignList }" var="assign">	
						<tr class="assigns" style='font-size:0.85em;cursor:pointer;'>
							<td style="text-align: left; padding-top: 8px; padding-bottom: 8px; ">${assign.className }</td>
							<td style="text-align: left;max-width: 100px;  padding-top: 8px; padding-bottom: 8px; " >${assign.title }</td>			
							<td style="padding-top: 8px; padding-bottom: 8px; ">${fn:substring(assign.startDate,0,10) }</td>
							<td style="padding-top: 8px; padding-bottom: 8px; ">${fn:substring(assign.endDate,0,10) }</td>
							<td style="padding-top: 8px; padding-bottom: 8px; " class="tdClass">
							${assign.submitRate }%
							<input class="cc" type="hidden" value="${assign.classCode }">
							<input class="ac" type="hidden" value="${assign.assignCode }">
							</td>		
						</tr>
					</c:forEach>	
						
				</table>				
				</div>
				<div id="doubleRight" style="display: none; margin-top: 11%; margin-left: 2%;" >
					<i style="font-size:3.0em; vertical-align: center;" class="uil-angle-double-right"></i>
				</div>
				<div id="stuAndStatus" class="col-md-3" style="float:right; height:280px; overflow: auto; border:0.5px solid lightgray;">
				<table class="table table-bordered text-center" >					
					<tr style="font-size:0.95em; background-color: #8BDDA8;">
						<th style="width: 40%;">원생명</th>
						<th style="width: 60%;">제출상태</th>
					</tr>
				</table>
				</div>
			</div>
			<div id="assignDetail" class="card-body" style="padding-top:0px;">
				<hr>
				<div class="col-md-3" style="float:left;">
					<h4>과제정보</h4>
				</div>
				<div class="col-md-9" style="float:right;" >
					<button style="height:20px; line-height:0px; float:right;" class="btn btn-secondary">삭제</button>
					<button style="height:20px; line-height:0px; float:right; margin-right:3px;" class="btn btn-primary">수정</button>
				</div>
				<br>
				<hr>
				<div  class="col-md-12">
					<table class="table table-bordered">
						<tr style="text-align: center;">
							<td style="font-weight:bold; background-color: #8BDDA8;">과제명</td>
							<td><input style="width:100%;" type="text" value=""></td>
							<td style="font-weight:bold; background-color: #8BDDA8;">마감일</td>
							<td><input type="datetime-local" ></td>
						</tr>
						<tr>
							<td colspan="4" rowspan="4">
							<textarea id="content" style="float:left;" rows="5" cols="130"> </textarea>
							</td>
						</tr>
					</table>
				</div>
				<div class="col-md-12">
				
				<input type="file" name="uploadFile" style="display:inline;">
				</div>
				<div style="margin-top:3px;" class="col-md-12">
				</div>
			</div>
			<div class="card-footer">
			</div>
		</div>

</body>
    
    
    
    
    
    
    