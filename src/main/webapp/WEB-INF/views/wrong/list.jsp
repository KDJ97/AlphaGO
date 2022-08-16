<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="cri" value="${pageMaker.cri }" />
<c:set var="classingList" value="${dataMap1.classingList }" />
<c:set var="wrongList" value="${dataMap.wrongList }" />
<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="wrongDetail" value="${dataMap.wrongDetail }" />

<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style>
#jimoon {
	border : 0px;
	background-color:#f5f6f8;
	position: absolute;
    top: 109px;
    left: 311px;
    font-weight:bold;
}

#jimoon:hover {
	color:red;
	font-weight:bold;
}
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script>
$(function(){
	test();
	
	<c:if test="${empty wno or wno eq ''}">
		var wno = $('#wrongTbody').find('tr').eq(0).attr('data-wno'); // tbody안의 첫번째 tr을 찾아서 'data-wno'라는 속성의 값
		var pc = $('#wrongTbody').find('tr').eq(0).attr('data-pc'); 
		detail(wno, pc);
	</c:if>
	<c:if test="${!empty wno and wno ne '' }">
		var wno = '${wno }';
		for(var i=0; i< $('#wrongTbody').find('tr').length; i++){
			if($('#wrongTbody').find('tr').eq(i).attr('data-wno') == wno){
				var pc = $('#wrongTbody').find('tr').eq(i).attr('data-pc'); 
			}
		}
		detail(wno, pc);
	</c:if>
	
})

$("#cateType").on("change", function(){
	test();
});


function test(){
	name = $("option:selected", "#cateType").text();
	$.ajax({
	    type : "POST",          
	    url : "<%=request.getContextPath()%>/wrong/examList.go",
				data : {
					"name" : name							
				}, // Json 형식의 데이터이다.
				success : function(res) {		
					printData(res, $('#searchType'), $('#exam-select-template'));
					var leng = $('#searchType option').length;
					for(var i=0; i<leng; i++){
						if($('#searchType option').eq(i).val() == '${search}'){
							$('#searchType option').eq(i).attr('selected', 'selected');
						}
					}
				},
				
				error : function(error) { 
					alert("에러 : " + error.status);
				}
	});
}
</script>
<script>
function printingData(data,target,templateObject){
	var template=Handlebars.compile(templateObject.html());
	var html = template(data);	
	target.append(html);
}
</script>

<script type="text/x-handlebars-template" id="exam-select-template">
<option value="">시험 선택</option>
{{#each .}}
<option value="{{examName}}" >{{examName}}</option>
{{/each}}
</script>
<script>
function detail(num, num2) {
	wno = num;
	problemCode = num2;
	
	$.ajax({
	    type : "POST",          
	    url : "<%=request.getContextPath()%>/wrong/wrongDetail.go",
				data : {
					"wno" : wno,
					"problemCode" : problemCode
				}, // Json 형식의 데이터이다.
				success : function(res) {	
					exam = res.examName;
					cla = res.className;
					sub = res.subdetailName;
					str = "";
					str += '<div>';
					str += '<p class="flex-grow-1"><span style="font-size:1.2em;font-weight: bold;">' + exam + '</span> | ' + cla +'</p>';
					if(res.problemPrint != null) {
						str += '<span style="font-size:0.9em;margin-top: 10px;" class="badge rounded-pill bg-primary">지문</span>';
					}
					str += '<span style="font-size:0.9em;margin-top: 10px;" class="badge rounded-pill bg-secondary">'+ sub +'</span>';
					if(res.question == null) {
						str += '<button type="button" class="btn btn-warning" style="float:right;margin-bottom: 10px;height: 30px;line-height: 5px;" onclick="ques('+ res.wno + ',' +res.examCode +')">질문하기</button>';
					} else if(res.question != null){
						str += '<button type="button" class="btn btn-warning" style="float:right;margin-bottom: 10px;height: 30px;line-height: 5px;" onclick="ques('+ res.wno + ',' +res.examCode +')">답변보기</button>';
					}
					if(res.content != null) {
						str += '<button type="button" class="btn btn-purple" style="float:right;margin-right: 5px;height: 30px;line-height: 5px;margin-bottom: 10px;" onclick="registSol('+ res.wno +')">내해설수정</button>';		
					} else {
						str += '<button id="solBtn" type="button" class="btn btn-purple" style="float:right;margin-right: 5px;height: 30px;line-height: 5px;margin-bottom: 10px;" onclick="registSol('+ res.wno +')">내해설등록</button>';	
					}
					str += '</div>';
					str += '<div class="bg-light" style="padding: 15px;margin-top: 10px;border-radius: 10px;min-height:200px">';
					str += '<span style="font-weight:bold">[' + res.lproblem + ']</span><br>';
					if(res.problemPrint != null) {                   
						str += '<button type="button" id="jimoon" onclick="see('+ res.wno + ',' + res.problemCode +')">지문보기</button>';	
					}
					str +=  res.pronum + '. ' + res.problemContent + "<br><br>"
					str += '<p style="margin-left: 10px;margin-bottom: 0px;">';
					if(res.lproblem == "객관식") {
						str += '① ' + res.none + "<br>";
						str += '② ' + res.ntwo + "<br>";
						str += '③ ' + res.ntree + "<br>";
						str += '④ ' + res.nfour + "<br>";
						str += '⑤ ' + res.nfive;				
					}
					str += '</p>';
					str += '</div>';
					str += '<p style="font-weight: bold; margin-top: 15px;">해설 및 답</p>';
					str += '<div class="bg-light" style="padding: 15px; border-radius: 10px;min-height:120px">';
					if(res.lproblem == "객관식") {
						if(res.problemAnswer == 1) {
							str += '<p style="font-weight: bold;">정답<span style="color: red; margin-left: 15px;">① ' + res.none + '</span>';	
						} else if(res.problemAnswer == 2) {
							str += '<p style="font-weight: bold;">정답<span style="color: red; margin-left: 15px;">② ' + res.ntwo + '</span>';	
						} else if(res.problemAnswer == 3) {
							str += '<p style="font-weight: bold;">정답<span style="color: red; margin-left: 15px;">③ ' + res.ntree + '</span>';	
						} else if(res.problemAnswer == 4) {
							str += '<p style="font-weight: bold;">정답<span style="color: red; margin-left: 15px;">④ ' + res.nfour + '</span>';	
						} else {
							str += '<p style="font-weight: bold;">정답<span style="color: red; margin-left: 15px;">⑤ ' + res.nfive + '</span>';	
						}				
					} else {
						str += '<p style="font-weight: bold;">정답<span style="color: red;margin-left: 15px;margin-bottom: 0px;"> ' + res.problemAnswer + '</span>';	
					}
					str += '<p style="font-weight: bold;margin-bottom: 0px;">해설<span style="margin-left: 15px;"> ' + res.problemSolution + '</span>';
					str += '</div>';
					str += '<p style="font-weight: bold; margin-top: 15px;">내 해설</p>';
				
					str += '<form enctype="multipart/form-data" role="form" method="post" action="regist.go" name="registForm">';
					str += '<input type="hidden" name="wno" value='+ res.wno +'>';
					if(res.content != null) {
						str += '<textarea id="solsol" class="form-control bg-light text-dark" name="content" style="height: 160px; resize: none;padding-top: 10px;">'+ res.content +'</textarea>';
					} else {
						str += '<textarea id="solsol" class="form-control bg-light text-dark" placeholder="해설을 입력해주세요." name="content" style="height: 160px; resize: none;padding-top: 10px;"></textarea>';
					}
					str += '</form>';							
					
					str += '</div>';
					
				$("#hello").html(str);
				},
				
				error : function(error) { 
					alert("에러 : " + error.status);
				}
	});
}
</script>
<script>
function ques(wno, examCode){  
    window.open('<%=request.getContextPath()%>/wrong/questionForm.go?wno='+wno+'&examCode='+examCode,'질문','width=500,height=730,left=800,top=180,location=no,status=no,scrollbars=yes');
}

function see(wno, problemCode) {
	 window.open('<%=request.getContextPath()%>/wrong/jimoon.go?wno='+wno+'&problemCode='+problemCode,'지문','width=500,height=730,left=800,top=180,location=no,status=no,scrollbars=yes');
}

function registSol(num){  
	wno = num;
	content = $('textarea[name="content"]').val();
	
		  $.ajax({
			    type : "POST",          
			    url : "<%=request.getContextPath()%>/wrong/regist.go",
				data : {
					"wno" : wno,	
					"content" : content
				}, 
				async: false,
				success : function(res) {	
					if(content != null && content != '') {
						//alert('해설이 등록되었습니다.');
						$('#solsol').val(content);
						
						$('#solBtn').text('해설수정');
						$('#solBtn').attr('onclick', 'registSol('+ wno +')');			
					} else {
						//alert('내용을 입력해주세요.');
					}
				},
				
				error : function(error) { 
					alert("에러 : " + error.status);
				}
			});
			
	
	
	Swal.fire({
	      icon: 'success',
	      title: '해설이 등록되었습니다.'
	      
	    }).then((result) => {
			if (result.value) {
				var url="list.go";
				var jobForm=$('#jobForm');
				var page = $('li.active a').text();
				
				if($('select[name="cateType"]').val()){
					str = "<input type='hidden' name='cateType' value=''/>";
					jobForm.append(str);
					jobForm.find("[name='cateType']").val($('select[name="cateType"]').val());
				}
				if($('select[name="perPageNum"]').val()){
					str = "<input type='hidden' name='perPageNum' value=''/>";
					jobForm.append(str);
					jobForm.find("[name='perPageNum']").val($('select[name="perPageNum"]').val());
				}

				jobForm.find("[name='page']").val(page);
				
				jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
				
				jobForm.find("[name='keyword']").val($('div.input-group>input[name="keyword"]').val());

	
				jobForm.append($('<input/>', {type: 'hidden', name: 'wno', value: wno }));
				
				jobForm.attr({
					action:url,
					method:'get'
				}).submit();
			}
		})
	
}
</script>
</head>
<body>
	<div class="row gx-3 gy-2">
		<div class="col-7" style="float: left;">
			<div class="card">
				<div class="card-body" style="padding: 12px;min-height:766px;">
					<h5 style="font-weight: bold;margin-bottom: 16px;">
						<i class="uil-book-open" style="margin-right: 10px;"></i>오답노트
					</h5>
					<div id="keyword" class="card-tools"
						style="margin-bottom: 6px; width: 320px;">
						<div class="input-group">
								<select class="form-select col-md-3" name="cateType"
									id="cateType" style="width: 40px;">
									<option value="">수업 선택</option>
									<c:forEach items="${classingList }" var="classing">
										<option value="${classing.className }"
											${fn:trim(cate) eq fn:trim(classing.className) ? 'selected' : '' }>${classing.className }</option>
									</c:forEach>
								</select> 
								<select class="form-select col-md-3" name="searchType"
									id="searchType" style="width: 40px;">
									<option value="">시험 선택</option>
								</select> 
							<span class="input-group-append">
								<button class="btn btn-soft-secondary" style="float: right;"
									type="button" id="searchBtn" data-card-widget="search"
									onclick="list_go(1);">
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>
						</div>
					</div>
					<div>
						<div id="table-pagination">
							<div style="width: 100%; text-align: center;">
								<div style="height: auto;">
									<table class="table text-center table-hover"
										style="height: auto;">
										<thead>
											<tr>
												<th data-column-id="name" class="bg-purple"
													style="font-weight: bold;color:white"><div
														class="gridjs-th-content">수업명</div></th>
												<th data-column-id="name" class="bg-purple"
													style="font-weight: bold;color:white"><div
														class="gridjs-th-content">시험명</div></th>
												<th data-column-id="email" class="bg-purple"
													style="font-weight: bold;color:white"><div
														class="gridjs-th-content">번호</div></th>
												<th data-column-id="position" class="bg-purple"
													style="font-weight: bold;color:white"><div
														class="gridjs-th-content">유형</div></th>
												<th data-column-id="position" class="bg-purple"
													style="font-weight: bold;color:white"><div
														class="gridjs-th-content">복습</div></th>
											</tr>
										</thead>
										<tbody id="wrongTbody">
											<c:forEach items="${wrongList }" var="wrong">
												<tr data-wno="${wrong.wno}" data-pc="${wrong.problemCode }" style="cursor: pointer;" onclick="detail(${wrong.wno}, ${wrong.problemCode })">
													<td data-column-id="email" style="text-align: left;font-size:0.9em;">${wrong.className }</td>
													<td data-column-id="email" style="text-align: left;font-size:0.9em;">${wrong.examName }</td>
													<td data-column-id="company">${wrong.pronum }</td>
													<td data-column-id="position"><span
														class="badge rounded-pill bg-secondary"
														style="font-size: 0.7em; padding: 7px; weight: 100px;">${wrong.subdetailName }</span></td>
													<c:if test="${empty wrong.content }">
														<td data-column-id="company"><span
														class="badge rounded-pill bg-danger"
														style="font-size: 0.7em; padding: 7px; weight: 100px;">미완료</span></td>
													</c:if>	
													<c:if test="${!empty wrong.content }">
														<td data-column-id="company"><span
														class="badge rounded-pill bg-success"
														style="font-size: 0.7em; padding: 7px; weight: 100px;">완료</span></td>
													</c:if>	
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>

							</div>
						</div>

					</div>

					<!-- pagination -->
					<nav aria-label="pds list Navigation">
						<ul class="pagination justify-content-center m-0">
							<%@ include file="/WEB-INF/views/common/YJpagination.jsp"%>
						</ul>
					</nav>

				</div>
			</div>
		</div>
		<div class="col-5">
			<div class="card">
				<div class="card-body" id="hello" style="padding: 15px;min-height:766px;">
						<div>
							<p class="flex-grow-1"><span style="font-size:1.2em;font-weight: bold;">${wrongDetail.examName }</span> | ${wrongDetail.className }</p>
							<span style="font-size:0.9em;margin-top: 10px;" class="badge rounded-pill bg-secondary">${wrongDetail.subdetailName}</span>
							<c:if test="${empty wrongDetail.question }">
								<button type="button" class="btn btn-warning" style="float:right;margin-bottom: 10px;height: 30px;line-height: 5px;" onclick="ques(${wrongDetail.wno}, ${wrongDetail.examCode })">질문하기</button>
							</c:if>
							<c:if test="${!empty wrongDetail.answer }">
								<button type="button" class="btn btn-warning" style="float:right;margin-bottom: 10px;height: 30px;line-height: 5px;" onclick="ques(${wrongDetail.wno}, ${wrongDetail.examCode })">답변보기</button>
							</c:if>
							<c:if test="${!empty wrongDetail.content }">
								<button type="button" class="btn btn-purple" style="float:right;margin-right: 5px;height: 30px;line-height: 5px;margin-bottom: 10px;" onclick="registSol(${wrongDetail.wno})">내해설수정</button>	
							</c:if>
							<c:if test="${empty wrongDetail.content }">
								<button id="solBtn" type="button" class="btn btn-purple" style="float:right;margin-right: 5px;height: 30px;line-height: 5px;margin-bottom: 10px;" onclick="registSol(${wrongDetail.wno})">내해설등록</button>	
							</c:if>
						</div>
						<div class="bg-light" style="padding: 15px; border-radius: 10px;margin-top:10px;min-height:200px">
							<span style="font-weight:bold">[${wrongDetail.lproblem }]</span><br>${wrongDetail.pronum }. ${wrongDetail.problemContent}<br><br>
							<p style="margin-left: 10px;margin-bottom: 0px;">
								<c:if test="${wrongDetail.lproblem eq '객관식'}">
									① ${wrongDetail.none }<br>
									② ${wrongDetail.ntwo }<br>
									③ ${wrongDetail.ntree }<br>
									④ ${wrongDetail.nfour }<br>
									⑤ ${wrongDetail.nfive }				
								</c:if>
							</p>
						</div>	
						<p style="font-weight: bold; margin-top: 15px;">해설 및 답</p>
						<div class="bg-light" style="padding: 15px; border-radius: 10px;min-height:120px">
							<c:if test="${wrongDetail.lproblem eq '객관식'}">
								<c:if test="${wrongDetail.problemAnswer eq 1 }">
									<p style="font-weight: bold;">정답<span style="color: red; margin-left: 15px;">① ${wrongDetail.none }</span>	
								</c:if>				
								<c:if test="${wrongDetail.problemAnswer eq 2 }">
									<p style="font-weight: bold;">정답<span style="color: red; margin-left: 15px;">② ${wrongDetail.ntwo }</span>	
								</c:if>				
								<c:if test="${wrongDetail.problemAnswer eq 3 }">
									<p style="font-weight: bold;">정답<span style="color: red; margin-left: 15px;">③ ${wrongDetail.ntree }</span>	
								</c:if>				
								<c:if test="${wrongDetail.problemAnswer eq 4 }">
									<p style="font-weight: bold;">정답<span style="color: red; margin-left: 15px;">④ ${wrongDetail.nfour }</span>	
								</c:if>				
								<c:if test="${wrongDetail.problemAnswer eq 5 }">
									<p style="font-weight: bold;">정답<span style="color: red; margin-left: 15px;">⑤ ${wrongDetail.nfive }</span>	
								</c:if>				
							</c:if>
							<c:if test="${wrongDetail.lproblem eq '주관식' }">
								<p style="font-weight: bold;">정답<span style="color: red;margin-left: 15px;margin-bottom: 0px;">${wrongDetail.problemAnswer }</span>
							</c:if>
							<p style="font-weight: bold;margin-bottom: 0px;">해설<span style="margin-left: 15px;">${wrongDetail.problemSolution }</span>
						</div>
			            <p style="font-weight: bold; margin-top: 15px;">내 해설</p>
			           
		           		<form enctype="multipart/form-data" role="form" method="post" action="regist.go" name="registForm">
							<input type="hidden" name="wno" value="${wrongDetail.wno}">
							<c:if test="${!empty wrongDetail.content }">
								<textarea id="solsol" class="form-control bg-light text-dark" name="content" style="height: 160px; resize: none;padding-top: 10px;">${wrongDetail.content }</textarea>
							</c:if>
							<c:if test="${empty wrongDetail.content }">
								<textarea id="solsol" class="form-control bg-light text-dark" placeholder="해설을 입력해주세요." name="content" style="height: 160px; resize: none;padding-top: 10px;"></textarea>
							</c:if>
						</form>	
					
					</div>
				</div>
			</div>
		</div>
</body>
