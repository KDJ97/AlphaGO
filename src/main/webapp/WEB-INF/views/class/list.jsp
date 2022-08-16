<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="cri" value="${dataMap.pageMaker.cri }" />
<c:set var="classList" value="${dataMap.classList }" />

<head>
<script src="<%=request.getContextPath() %>/resources/assets/libs/rater-js/index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript">
$(function(){
	overClassBtnSetting();
	classingBtnSettion();
	settingProgress();
})
<c:if test="${from eq 'regist' }">
Swal.fire({
  icon: 'success',
  title: '수업이 신청 되었습니다.'
})
</c:if>

<c:if test="${from eq 'registError' }">
Swal.fire({
  icon: 'error',
  title: '시스템 오류로 수업신청이 처리되지 않았습니다.'
})
</c:if>

function classingBtnSettion(){
	var btnList = $('#recommend').find('button');
	console.log(btnList);
	//정원초과 체크
	for(var i=0; i < btnList.length; i++){
		var btn = $(btnList).eq(i);
		var code = $(btn).attr('data-code');
		//정원초과 체크
		$.ajax({
			type: "get", //요청 메소드 방식
			url:"checkOverStudent.go",
			async : false,
			data : {
				"code" : code
			},success : function(result){
				if(result == 1){
					//정원초과
					$(btn).text('정원초과');
					$(btn).attr('disabled', 'disabled');
					$(btn).addClass('btn-secondary');
					$(btn).removeClass('btn-purple');

				}
			}
		});
	}

	//이미 신청된 수업 체크
	for(var i=0; i < btnList.length; i++){
		var btn = $(btnList).eq(i);
		var code = $(btn).attr('data-code');
		$.ajax({
			type: "get", //요청 메소드 방식
			url:"checkClassing.go",
			async : false,
			data : {
				"classCode" : code,
				"id" : '${loginUser.id}'
			},success : function(result){
				if(result == 1){
					$(btn).text('신청완료');
					$(btn).attr('disabled', 'disabled');
					//$(btn).addClass('btn-secondary');
					//$(btn).removeClass('btn-purple');

				}
			}
		});
	}
}

function applyClassBtn(btn){
	var code = $(btn).attr('data-code');
	var id = '${loginUser.id}';
	//수업신청
	var newForm = $('<form></form>');
	newForm.attr("name","newForm");
	newForm.attr("method","post");
	newForm.attr("action","registClassing.go");

	// create element & set attribute (input)
	newForm.append($('<input/>', {type: 'hidden', name: 'classCode', value:code }));
	newForm.append($('<input/>', {type: 'hidden', name: 'id', value: id }));

	// append form (to body)
	newForm.appendTo('body');

	// submit form
	newForm.submit();
}

function overClassBtnSetting(){
	var btnList = $('#classListTbody').find('.applyBtn');
	for(var i=0; i < btnList.length; i++){
		var btn = $(btnList).eq(i);
		var code = $(btn).attr('data-code');
		//정원초과 체크
		$.ajax({
			type: "get", //요청 메소드 방식
			url:"checkOverStudent.go",
			async : false,
			data : {
				"code" : code
			},success : function(result){
				if(result == 1){
					//정원초과
					$(btn).text('정원초과');
					$(btn).attr('disabled', 'disabled');
					$(btn).addClass('btn-secondary');
					$(btn).removeClass('btn-purple');

				}
			}
		});
	}
}

function openPdf(code){
	 OpenWindow('openPdf.go?classCode=' + code, '수업계획서', 1000, 1200);
}

</script>
<!-- 수업진도 체크 -->
<script type="text/javascript">
function settingProgress(){
	var progress = $('div[role=progressbar]');
	for(var i = 0 ; i < progress.length; i++){
		var target = $(progress).eq(i).parent('div');
		var cpno = $(target).attr('data-cpno');
		$.ajax({
			url:"<%=request.getContextPath()%>/teacher/homeProgress",
			method:"GET",
			async : false,
			data:{"cpno":cpno },
			success:function(res){
				$(target).children('div').css('width', res.progressRate +'%');
			}
		})
	}
}



function clickProgress(cpno, target){
	//var cpno = $(this).val();
	var str0 = '';

	$.ajax({
		url:"<%=request.getContextPath()%>/teacher/homeProgress",
		method:"GET",
		data:{"cpno":cpno },
		success:function(res){

			var per = res.perWeek;
			var proRate = res.progressRate;
			var totalWeek = res.weekCount;

			//str,str2는 모달
			str='';
			str+='<span class="badge rounded-pill bg-warning"';
			str+='<	style="font-size: 0.8em; padding: 8px; height: 25px; width: 60px;">'+ res.wpList[0].subjectName +'</span>';
			str+='<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>';
			$('#progressSubjectName').html(str);

			str2='';
			str2+='<p style="font-weight: bold; font-size: 1.2em;">'+ res.wpList[0].className + '</p>';
			str2+='<div class="row" style="height:600px;">';
			str2+='	<div class="col-3 mb-3" style="margin-left: 23px; margin-right: -44px;">';
			str2+='		<div style="width:20%; height:100%; margin:0px auto;  margin-left:14px;" class="progress">';
			str2+='		 	 <div class="progress-bar bg-purple" role="progressbar" style="height:'+ res.progressRate +'%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">'+ res.progressRate +'%</div>';
			str2+='		</div>';
			str2+='	</div>';

			str2+='	<div class="col-9 mb-3">';
			for(var i=0; i<totalWeek; i++){
				if(per*(i+1) < proRate){      //현재 진도율보다 이전 계획들
					str2+='   <div style="height:'+ res.perWeek +'%;">';
					str2+='		<div class="bg-soft-purple"';
					str2+='			style="border-radius: 5px; width: 100%; height:85%; padding:5px; text-align:left; vertical-align:middle; overflow:auto;">['+ res.wpList[i].week +'주차] ';
					str2+='			'+ res.wpList[i].content +'</div>';
					str2+='   </div>'
				}else if(proRate < per*i){     //현재 진도율 이후 계획들
					str2+='   <div style="height:'+ res.perWeek +'%;">';
					str2+='		<div class="bg-soft-secondary"';
					str2+='			style="border-radius: 5px; width: 100%; height:85%; padding:5px; text-align:left; vertical-align:middle; overflow:auto;">['+ res.wpList[i].week +'주차] ';
					str2+='			'+ res.wpList[i].content +'</div>';
					str2+='   </div>'
				}else{                          //현재 진행중인 계획
					str2+='   <div style="height:'+ res.perWeek +'%;">';
					str2+='		<div id="talkbuble" class="bg-purple"';
					str2+='			style="border-radius: 5px; width: 100%; height:85%; padding:5px; text-align:left; vertical-align:middle; overflow:auto; color:white;">['+ res.wpList[i].week +'주차] ';
					str2+='			'+ res.wpList[i].content +'</div>';
					str2+='   </div>'
				}
			}

			str2+='	</div>';
			str2+='</div>';
			$('#progressContent').html(str2);

		},
		error:function(){
			alert("진도율을 불러올수 없습니다. 관리자에게 문의하세요.");
		}
	})
}
</script>
</head>
<body>
	<h5 style="font-weight: bold; margin-bottom: 10px;">
		<i class="uil-thumbs-up" style="margin-right: 10px;"></i>추천 수업
	</h5>
	<div id="recommend" class="row">
		<div class="col" style="float: left; text-align: center;">
			<div>
				<span class="badge rounded-pill bg-danger" style="font-size: 0.8em; padding: 10px; margin-bottom: 10px; width: 60px;">국어</span>
				<div class="bg-soft-secondary" style="border-radius: 10px; padding: 10px; min-height: 150px;">
				  <c:if test="${empty kor}">
					<span style="margin-top: 55px; display: block;">추천수업이 없습니다</span>
				  </c:if>
				  <c:if test="${!empty kor}">
					<span style="font-weight: bold;">${kor.classRank } 레벨</span><hr style="margin: 2px; color: black; height: 3px;">
					<span style="font-weight: bold;">${kor.className }</span><br>
					<span style="font-weight: bold;">${kor.name }</span><br>
					<button data-code="${kor.classCode }" onclick="applyClassBtn(this)" type="button" class="btn btn-purple mt-3">신청하기</button>
				  </c:if>
				</div>
			</div>
		</div>
		<div class="col" style="float: left; text-align: center;">
			<div>
				<span class="badge rounded-pill bg-warning" style="font-size: 0.8em; padding: 10px; margin-bottom: 10px; width: 60px;">영어</span>
				<div class="bg-soft-secondary" style="border-radius: 10px; padding: 10px; min-height: 150px;">
				  <c:if test="${empty eng}">
					<span style="margin-top: 55px; display: block;">추천수업이 없습니다</span>
				  </c:if>
				  <c:if test="${!empty eng}">
					<span style="font-weight: bold;">${eng.classRank } 레벨</span><hr style="margin: 2px; color: black; height: 3px;">
					<span style="font-weight: bold;">${eng.className }</span><br>
					<span style="font-weight: bold;">${eng.name }</span><br>
					<button data-code="${eng.classCode }" onclick="applyClassBtn(this)" type="button" class="btn btn-purple mt-3">신청하기</button>
				  </c:if>
				</div>
			</div>

		</div>
		<div class="col" style="float: left; text-align: center;">
			<div>
				<span class="badge rounded-pill bg-success" style="font-size: 0.8em; padding: 10px; margin-bottom: 10px; width: 60px;">수학</span>
				<div class="bg-soft-secondary" style="border-radius: 10px; padding: 10px; min-height: 150px;">
				  <c:if test="${empty math}">
					<span style="margin-top: 55px; display: block;">추천수업이 없습니다</span>
				  </c:if>
				  <c:if test="${!empty math}">
					<span style="font-weight: bold;">${math.classRank } 레벨</span><hr style="margin: 2px; color: black; height: 3px;">
					<span style="font-weight: bold;">${math.className }</span><br>
					<span style="font-weight: bold;">${math.name }</span><br>
					<button data-code="${math.classCode }" onclick="applyClassBtn(this)" type="button" class="btn btn-purple mt-3">신청하기</button>
				  </c:if>
				</div>
			</div>

		</div>
		<div class="col" style="float: left; text-align: center;">
			<div>
				<span class="badge rounded-pill bg-primary"
					style="font-size: 0.8em; padding: 10px; margin-bottom: 10px; width: 60px;">사회</span>
				<div class="bg-soft-secondary" style="border-radius: 10px; padding: 10px; min-height: 150px;">
				  <c:if test="${empty social}">
					<span style="margin-top: 55px; display: block;">추천수업이 없습니다</span>
				  </c:if>
				  <c:if test="${!empty social}">
					<span style="font-weight: bold;">${social.classRank } 레벨</span><hr style="margin: 2px; color: black; height: 3px;">
					<span style="font-weight: bold;">${social.className }</span><br>
					<span style="font-weight: bold;">${social.name }</span><br>
					<button data-code="${social.classCode }" onclick="applyClassBtn(this)" type="button" class="btn btn-purple mt-3">신청하기</button>
				  </c:if>
				</div>
			</div>
		</div>
		<div class="col" style="float: left; text-align: center;">
			<div>
				<span class="badge rounded-pill bg-purple"
					style="font-size: 0.8em; padding: 10px; margin-bottom: 10px; width: 60px;">과학</span>
				<div class="bg-soft-secondary" style="border-radius: 10px; padding: 10px; min-height: 150px;">
				  <c:if test="${empty science}">
					<span style="margin-top: 55px; display: block;">추천수업이 없습니다</span>
				  </c:if>
				  <c:if test="${!empty science}">
					<span style="font-weight: bold;">${science.classRank } 레벨</span><hr style="margin: 2px; color: black; height: 3px;">
					<span style="font-weight: bold;">${science.className }</span><br>
					<span style="font-weight: bold;">${science.name }</span><br>
					<button data-code="${science.classCode }" onclick="applyClassBtn(this)" type="button" class="btn btn-purple mt-3">신청하기</button>
				  </c:if>
				</div>
			</div>
		</div>
	</div>
	<h5 style="font-weight: bold; display: inline-block; margin-top: 25px;">
		<i class="uil-file-alt" style="margin-right: 10px;"></i>수업 목록
	</h5>
	<div class="row-4">
		<div class="card">
			<div class="card-body">
				<div class="d-flex justify-content-start mb-2">
					<input class="form-control" type="text" style="width: 150px;"
						name="keyword" placeholder="검색어 입력" value="${cri.keyword }" /> <span
						class="input-group-append">
						<button class="btn btn-purple" style="float: left;" type="button"
							id="searchBtn" data-card-widget="search" onclick="list_go2(1);">
							<i class="fa fa-fw fa-search"></i>
						</button>
					</span>
				</div>
				<table class="table" style="text-align: center;">
					<thead class="table-light">
						<tr>
							<th class="bg-purple text-white" style="font-weight: bold;"></th>
							<th class="bg-purple text-white" style="font-weight: bold;">수업명</th>
							<th class="bg-purple text-white" style="font-weight: bold;">선생님</th>
							<th class="bg-purple text-white" style="font-weight: bold;">과목</th>
							<th class="bg-purple text-white" style="font-weight: bold;">학년</th>
							<th class="bg-purple text-white" style="font-weight: bold;">레벨</th>
							<th class="bg-purple text-white" style="font-weight: bold;">별점</th>
							<th class="bg-purple text-white" style="font-weight: bold;">수업계획서</th>
						</tr>
					</thead>
					<tbody id="classListTbody">
					  <c:forEach items="${classList }" var="c">
						<tr>
							<td rowspan='2'>
							  <button data-code="${c.classCode }" onclick="applyClassBtn(this)"
							  	type="button" class="btn btn-purple applyBtn" style="height: 40px; width: 100px; vertical-align: -22px;">신청하기</button></td>
							<td>${c.className }</td>
							<td>${c.name }</td>
							<td>
							  <c:if test="${c.subjectCode eq 1}">
							    <span class="badge rounded-pill bg-danger" style="font-size: 0.8em; padding: 8px; height: 25px; width: 60px;">국어</span>
							  </c:if>
							  <c:if test="${c.subjectCode eq 5}">
							    <span class="badge rounded-pill bg-warning" style="font-size: 0.8em; padding: 8px; height: 25px; width: 60px;">영어</span>
							  </c:if>
							  <c:if test="${c.subjectCode eq 2}">
							    <span class="badge rounded-pill bg-success" style="font-size: 0.8em; padding: 8px; height: 25px; width: 60px;">수학</span>
							  </c:if>
							  <c:if test="${c.subjectCode eq 3}">
							    <span class="badge rounded-pill bg-primary" style="font-size: 0.8em; padding: 8px; height: 25px; width: 60px;">사회</span>
							  </c:if>
							  <c:if test="${c.subjectCode eq 4}">
							    <span class="badge rounded-pill bg-purple" style="font-size: 0.8em; padding: 8px; height: 25px; width: 60px;">과학</span>
							  </c:if>
							</td>
							<td>${c.classGrade }학년</td>
							<td>${c.classRank }</td>
							<td>
							  <div class="rater-step star-rating disabled"  style="width: 100px; height: 20px; background-size: 20px;">
								<div class="star-value" style="background-size: 20px; width: ${c.avgPoint * 20}%;"></div>
							  </div>
							</td>
							<td>
							  <button onclick="openPdf('${c.classCode }')"
							  	type="button" class="btn btn-secondary" style="height: 25px; width: 50px; padding: 0px 0px 10px 0px">보기</button>
							</td>
						</tr>
						<tr>
							<td colspan='7'>
								<div data-cpno='${c.cpno }' onclick="clickProgress('${c.cpno}', this)"
									class="progress progress-xl animated-progess custom-progress">
									<div
										class="progress-bar bg-primary" role="progressbar"
										data-bs-toggle="modal" data-bs-target="#step"
										style="width: 25%" aria-valuemin="0"
										aria-valuemax="100"></div>
								</div>
							</td>
						</tr>
					  </c:forEach>
					</tbody>
				</table>
					<!-- pagination -->
					<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
				<!-- end -->
			</div>
		</div>


	</div>





	<div class="modal fade bs-example-modal-center" tabindex="-1"
		role="dialog" id="step" aria-labelledby="mySmallModalLabel"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div id="progressSubjectName" class="modal-header">

				</div>
				<div id="progressContent" class="modal-body" style="text-align: center; padding: 15px; overflow: auto;">

				</div>

			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
</body>
