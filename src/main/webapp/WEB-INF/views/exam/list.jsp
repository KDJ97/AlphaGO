<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="classingList" value="${dataMap.classingList }" />
<c:set var="examList" value="${dataMap.examList }" />
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
	function mainListClick(examCode){
		
		Swal.fire({
			  title: '정말로 시험에 응시하시겠습니까?',
			  text: "응시 후에는 취소가 불가능합니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '확인',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
				  Swal.fire({
					  icon: 'success',
					  title: '시험을 응시합니다'
					}).then((result) => {
						if (result.isConfirmed){
						  window.open('<%=request.getContextPath()%>/exam/detail.go?from=list&examCode='+examCode,'시험지','width=1000,height=1100,left=500,top=100,location=no,status=no,scrollbars=yes');
						}
					})
			  }else{
				  Swal.fire({
					  icon: 'error',
					  title: '시험응시에 취소하셨습니다',
					  showConfirmButton: false,
					  timer: 1500
					})
			  }
			})
// 		if (!confirm("정말로 시험에 응시하시겠습니까? 응시 후에는 취소가 불가능합니다.")) {
// 			alert("응시 취소하셨습니다.");   
// 	    } else {
// 	    	alert("시험을 응시합니다.");   
<%-- 	    	window.open('<%=request.getContextPath()%>/exam/detail.go?from=list&examCode='+examCode,'시험지','width=1000,height=990,left=500,top=100,location=no,status=no,scrollbars=yes'); --%>
// 	    }
	}
	
	function listClick(code){
		
		Swal.fire({
			  title: '정말로 시험에 응시하시겠습니까?',
			  text: "응시 후에는 취소가 불가능합니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '확인',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
				  Swal.fire({
					  icon: 'success',
					  title: '시험을 응시합니다'
					}).then((result) => {
						if (result.isConfirmed){
							window.open('<%=request.getContextPath()%>/exam/detail.go?from=list&examCode='+code,'시험지','width=1000,height=1100,left=500,top=100,location=no,status=no,scrollbars=yes');
						}
					})
			  }else{
				  Swal.fire({
					  icon: 'error',
					  title: '시험응시에 취소하셨습니다',
					  showConfirmButton: false,
					  timer: 1500
					})
			  }
			})
// 		if (!confirm("정말로 시험에 응시하시겠습니까? 응시 후에는 취소가 불가능합니다.")) {
// 			alert("응시 취소하셨습니다.");   
// 	    } else {
// 	    	alert("시험을 응시합니다.");   
<%-- 	    	window.open('<%=request.getContextPath()%>/exam/detail.go?from=list&examCode='+code,'시험지','width=1000,height=990,left=500,top=100,location=no,status=no,scrollbars=yes'); --%>
// 	    }
	}
	
	function resultClick(ecode){  
	    window.open('<%=request.getContextPath()%>/exam/result.go?from=list&examCode='+ecode,'채점','width=1000,height=980,left=500,top=100,location=no,status=no,scrollbars=yes');
	
	}
	
	
	$("#examType").on("change", function(){
		exam_go(v_cl);
	});
	
	
	
	var v_cl;
	function exam_go(cl) {	
		v_cl = cl;
		
		var today = new Date();

		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);

		var dateString = year + '/' + month  + '/' + day;
		name = cl.value;
	
		$.ajax({
		    type : "POST",          
		    url : "<%=request.getContextPath()%>/exam/examlist.go",
			data : {
				"name" : name							
			}, // Json 형식의 데이터이다.
			success : function(res) {	
				$('#examType').show();
				
				var v_select = $('#examType').val();
				
				if(v_select == "전체"){
					str = "";
					for (var i = 0; i < res.length; i++) {
						var start = res[i].startDate;
						var end = res[i].endDate;
						var tit = res[i].examName;
						var code = res[i].examCode;
						var status = res[i].achievement;
						
						
						str += "<div class='card' style='margin-bottom: 5px;'>";
						str += "<div class='card-body' style='padding:10px'>";
						if(status != null) { // 응시완료
							str += "<span class='badge rounded-pill bg-success' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>응시완료</span>";								
							str += "<button type='button' class='btn' style='font-weight: bold;' onclick=\"resultClick("+code+")\"><i class='uil-edit' style='margin-right: 10px; font-size: 1.3em;'></i>"
							+ tit + "</button>";
						} else {
							if(end < dateString){ // 미응시
								str += "<span class='badge rounded-pill bg-secondary' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>미응시</span>";								
								str += "<button type='button' class='btn' style='font-weight: bold;'><i class='uil-edit' style='margin-right: 10px; font-size: 1.3em;'></i>"
								+ tit + "</button>";
							}else if(end >= dateString){
								str += "<span class='badge rounded-pill bg-danger' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>진행중</span>";								
								str += "<button type='button' class='btn' style='font-weight: bold;' onclick=\"listClick("+code+")\"><i class='uil-edit' style='margin-right: 10px; font-size: 1.3em;'></i>"
								+ tit + "</button>";
							}
						} 	
						str += "<span id='week' style='color: purple; margin-bottom: 0px;float:right;margin-top:10px'>시험 기한   ["
								+ start
								+ " ~ "
								+ end
								+ "]</span>";	
						str += "</div>";
						str += "</div>";
					}
					$('#weekCard').html(str);
				}else{
					var res_list = [];
					if(v_select == "응시완료"){
						for(var i=0; i<res.length; i++){
							if(res[i].achievement != null){
								res_list.push(res[i]);
							}
						}
						printData(res_list, $('#weekCard'), $('#exam-finish-template'));
					}else if(v_select == "미응시"){
						for(var i=0; i<res.length; i++){
							if(res[i].achievement == null && res[i].endDate < dateString){
								res_list.push(res[i]);
							}
						}
						printData(res_list, $('#weekCard'), $('#exam-before-template'));
					}else if(v_select == "진행중"){
						for(var i=0; i<res.length; i++){
							if(res[i].achievement == null && res[i].endDate >= dateString){
								res_list.push(res[i]);
							}
						}
						printData(res_list, $('#weekCard'), $('#exam-ing-template'));
					}
					
				}
			},
			error : function(error) { 
				alert("에러 : " + error.status);
			}
		});
	}
	
function printingData(data,target,templateObject){
	var template=Handlebars.compile(templateObject.html());
	var html = template(data);	
	target.append(html);
}
</script>

<!-- 응시완료  --> 
<script type="text/x-handlebars-template" id="exam-finish-template">
{{#each .}}
<div class='card' style='margin-bottom: 5px;'>
  <div class='card-body' style='padding:10px'>
	<span class='badge rounded-pill bg-success' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>응시완료</span>							
	<button type='button' class='btn' style='font-weight: bold;' onclick="resultClick({{examCode}})"><i class='uil-edit' style='margin-right: 10px; font-size: 1.3em;'></i>{{examName}}</button>
    <span id='week' style='color: purple; margin-bottom: 0px;float:right;margin-top:10px'>시험 기한   [{{startDate}} ~ {{endDate}}]</span>
  </div>
</div>
{{/each}}
</script>

<!-- 미응시 -->
<script type="text/x-handlebars-template" id="exam-before-template">
{{#each .}}
<div class='card' style='margin-bottom: 5px;'>
  <div class='card-body' style='padding:10px'>
	<span class='badge rounded-pill bg-secondary' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>미응시</span>							
	<button type='button' class='btn' style='font-weight: bold;'><i class='uil-edit' style='margin-right: 10px; font-size: 1.3em;'></i>{{examName}}</button>						
    <span id='week' style='color: purple; margin-bottom: 0px;float:right;margin-top:10px'>시험 기한   [{{startDate}} ~ {{endDate}}]</span>
  </div>
</div>
{{/each}}
</script>

<!-- 진행중 -->
<script type="text/x-handlebars-template" id="exam-ing-template">
{{#each .}}
<div class='card' style='margin-bottom: 5px;'>
  <div class='card-body' style='padding:10px'>
	<span class='badge rounded-pill bg-danger' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>진행중</span>								
	<button type='button' class='btn' style='font-weight: bold;' onclick=listClick({{examCode}})><i class='uil-edit' style='margin-right: 10px; font-size: 1.3em;'></i>{{examName}}</button>													
    <span id='week' style='color: purple; margin-bottom: 0px;float:right;margin-top:10px'>시험 기한   [{{startDate}} ~ {{endDate}}]</span>
  </div>
</div>
{{/each}}
</script>

</head>

<body>
	<div class="row gx-3 gy-2">
		<div class="col-4" style="float: left;">
			<div class="card">
				<div class="card-body">
					<h5 style="margin-bottom: 15px; font-weight: bold;">
						<i class="uil-book-open" style="margin-right: 10px;"></i>수업 리스트
					</h5>
					<div style="overflow:auto;height: 770px;">
						<c:forEach items="${classingList }" var="classing">
						 
							<button type="button" class="btn btn-outline-secondary mb-2"
								style="width: 100%;" onclick="exam_go(this)"
								value="${classing.className}">${classing.className}</button>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<div class="col-8">
			<div class="card bg-purple" style="margin-bottom: 5px;color:white">
				<div class="card-body" style="font-weight: bold; text-align: center;padding:10px">수업별 시험 목록</div>
			</div>
			<select class="form-select col-md-3" name="examType" id="examType" style="display:none;width: 112px;height:44px;position: absolute;top: -1px;">
				<option value="전체">응시 상태</option>
				<option value="미응시">미응시</option>
				<option value="응시완료">응시완료</option>
				<option value="진행중">진행중</option>
			</select>
			<div id="weekCard" style="overflow:auto;height:800px;">
				<c:forEach items="${examList }" var="exam" varStatus="status">
					<div class="card" style="margin-bottom: 5px;">
						<div class="card-body" style="padding:10px;">
							<span style="color: purple; margin-bottom: 0px;">시험 기한 [${exam.startDate } ~ ${exam.endDate }]</span>
							<span class="badge badge-outline-purple" style="font-size:0.9em;margin-left:5px;">${exam.className }</span>
							<br>
							<button type="button" class="btn" style="font-weight: bold;" onclick="mainListClick(${exam.examCode})">
								<i class="uil-edit" style="margin-right: 10px; font-size: 1.3em;"></i>${exam.examName }
							</button>
							<span class="badge rounded-pill bg-danger"
								style="font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;">진행중</span>							
						</div>													
					</div>		
				</c:forEach>	
			</div>
		</div>
		<!-- end card body -->
	</div>
	
</body>