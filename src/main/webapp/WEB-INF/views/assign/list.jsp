<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="classingList" value="${dataMap.classingList }" />
<c:set var="assignList" value="${dataMap.assignList }" />
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script>
$("#assignType").on("change", function(){
	assign_go(v_cl);
});

var v_cl;
function assign_go(cl) {	
	v_cl = cl;
	
	var today = new Date();

	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);

	var dateString = year + '/' + month  + '/' + day;
	
	name = cl.value;

	$.ajax({
	    type : "POST",          
	    url : "<%=request.getContextPath()%>/assign/assignlist.go",
		data : {
			"name" : name							
		}, // Json 형식의 데이터이다.
		success : function(res) {
			str = "";
// 			if(res == null) {
// 				str += '<div class="card" style="margin-bottom: 5px;">';
// 				str += '<div class="card-body" style="padding:10px;height: 793px;text-align: center;line-height: 50px;">해당 수업의 과제가 없습니다.</div>';
// 				str += '</div>';
// 			}
			$('#assignType').show();
			
			var v_select = $('#assignType').val();

			if(v_select == "전체"){
				for (var i = 0; i < res.length; i++) {
					var start = res[i].startDate;
					var end = res[i].endDate;
					var tit = res[i].title;
					var code = res[i].assignCode;
					var status = res[i].status;
					
					str += "<div class='card' style='margin-bottom: 5px;'>";
					str += "<div class='card-body' style='padding:10px'>";
					if(status == "제출 완료") {
						str += "<span class='badge rounded-pill bg-success' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>"+ status +"</span>";								
					} else {
						if(end < dateString){
							str += "<span class='badge rounded-pill bg-secondary' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>미제출</span>";								
						}else if(end >= dateString){
							str += "<span class='badge rounded-pill bg-danger' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>진행중</span>";								
						}
					} 
					str += "<button type='button' class='btn' style='font-weight: bold;' onclick=\"location.href=\'detail.go?from=list&assignCode="+code+"\'\"><i class='uil-edit' style='margin-right: 10px; font-size: 1.3em;'></i>"
							+ tit + "</button>";
					str += "<span id='week' style='color: purple; margin-bottom: 0px;float:right;margin-top: 10px;margin-right: 10px;'>과제 기한   ["
							+ start
							+ " ~ "
							+ end
							+ "]</span>";
					
					str += "</div>";
					str += "</div>";
				}
				$('#weekCard').html(str);
			} else {
				var res_list = [];
				if(v_select == "제출 완료"){
					for(var i=0; i<res.length; i++){
						if(res[i].status == "제출 완료"){
							res_list.push(res[i]);
						}
					}
					printData(res_list, $('#weekCard'), $('#assign-finish-template'));
				}else if(v_select == "미제출"){
					for(var i=0; i<res.length; i++){
						if(res[i].status == null && res[i].endDate.substring(0, 10) < dateString){
							res_list.push(res[i]);
						}
					}
					printData(res_list, $('#weekCard'), $('#assign-before-template'));
				}else if(v_select == "진행중"){
					for(var i=0; i<res.length; i++){
						if(res[i].status == null && res[i].endDate.substring(0, 10) >= dateString){
							res_list.push(res[i]);
						}
					}
					printData(res_list, $('#weekCard'), $('#assign-ing-template'));
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

<!-- 제출완료  --> 
<script type="text/x-handlebars-template" id="assign-finish-template">
{{#each .}}
<div class='card' style='margin-bottom: 5px;'>
  <div class='card-body' style='padding:10px'>
	<span class='badge rounded-pill bg-success' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>{{status}}</span>							
	<button type='button' class='btn' style='font-weight: bold;' onclick="location.href='detail.go?from=list&assignCode={{assignCode}}'"><i class='uil-edit' style='margin-right: 10px; font-size: 1.3em;'></i>{{title}}</button>
    <span id='week' style='color: purple; margin-bottom: 0px;float:right;margin-top:10px'>시험 기한   [{{startDate}} ~ {{endDate}}]</span>
  </div>
</div>
{{/each}}
</script>

<!-- 미제출 -->
<script type="text/x-handlebars-template" id="assign-before-template">
{{#each .}}
<div class='card' style='margin-bottom: 5px;'>
  <div class='card-body' style='padding:10px'>
	<span class='badge rounded-pill bg-secondary' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>미제출</span>							
	<button type='button' class='btn' style='font-weight: bold;'><i class='uil-edit' style='margin-right: 10px; font-size: 1.3em;'></i>{{title}}</button>						
    <span id='week' style='color: purple; margin-bottom: 0px;float:right;margin-top:10px'>시험 기한   [{{startDate}} ~ {{endDate}}]</span>
  </div>
</div>
{{/each}}
</script>

<!-- 진행중 -->
<script type="text/x-handlebars-template" id="assign-ing-template">
{{#each .}}
<div class='card' style='margin-bottom: 5px;'>
  <div class='card-body' style='padding:10px'>
	<span class='badge rounded-pill bg-danger' style='font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;'>진행중</span>								
	<button type='button' class='btn' style='font-weight: bold;' onclick='location.href="detail.go?from=list&assignCode={{assignCode}}"'><i class='uil-edit' style='margin-right: 10px; font-size: 1.3em;'></i>{{title}}</button>													
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
								style="width: 100%;" onclick="assign_go(this)"
								value="${classing.className}">${classing.className}</button>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<div class="col-8">
			<div class="card bg-purple" style="margin-bottom: 5px;color:white">
				<div class="card-body" style="font-weight: bold; text-align: center;padding:10px">수업별 과제 목록</div>
			</div>
			<select class="form-select col-md-3" name="assignType" id="assignType" style="display:none;width: 112px;height:44px;position: absolute;top: -1px;">
				<option value="전체">제출 상태</option>
				<option value="미제출">미제출</option>
				<option value="제출 완료">제출 완료</option>
				<option value="진행중">진행중</option>
			</select>
			<div id="weekCard" style="overflow:auto;height:800px;">
				<c:if test="${empty assignList }">
					<div class="card" style="margin-bottom: 5px;">
						<div class="card-body" style="padding:10px;height: 793px;text-align: center;line-height: 50px;">
							진행 중인 과제가 없습니다.
						</div>
														
					</div>	
				</c:if>
				<c:forEach items="${assignList }" var="assign" varStatus="status">
					<div class="card" style="margin-bottom: 5px;">
						<div class="card-body" style="padding:10px;">
							<span style="color: purple; margin-bottom: 0px;">과제 기한 [${assign.startDate } ~ ${assign.endDate }]</span>
							<span class="badge badge-outline-purple" style="font-size:0.9em;margin-left:5px;">${assign.className }</span>
							<br>
							<button type="button" class="btn" style="font-weight: bold;" onclick="location.href='detail.go?assignCode=${assign.assignCode}'">
								<i class="uil-edit" style="margin-right: 10px; font-size: 1.3em;"></i>${assign.title }
							</button>
							<span class="badge rounded-pill bg-danger"
								style="font-size: 0.7em; padding: 10px; margin-left: 10px; margin-top: 10px;height: 27px;line-height: 5px;">진행중</span>
							
						</div>
														
					</div>		
				</c:forEach>	
			</div>
		</div>

	</div>
</body>