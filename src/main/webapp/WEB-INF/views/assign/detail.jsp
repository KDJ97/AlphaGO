<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>

<script>
<c:if test="${from eq 'remove'}" >
	alert("삭제되었습니다.");
</c:if>
</script>
<script>

	let today = new Date();
	 
	let year = today.getFullYear(); 
	let month = today.getMonth() + 1
	let date = today.getDate(); // 일
	
	startDate = year + "-" + month + "-" + date;
	
	end = $('#last').text();
	endDate = end.substring(0, 10);
	
	let date1 = new Date(endDate);
	let date2 = new Date(startDate);
	let timeInMilisec = date1.getTime() - date2.getTime();
	let days = Math.trunc(timeInMilisec / (1000 * 60 * 60 * 24));
	
	str = days + "일 남음";

	if(days <= 0) {
		$('#last').text("제출 마감");	
		$('#give').hide();
	} else {
		$('#last').text(str);
	}
</script>
</head>
<body>
	<div class="card">
		<div class="card-body">
			<div class="d-flex">
                <div class="w-100">
					<h5 style="font-weight: bold;"><i class="uil-file-blank"
					style="margin-right: 10px; font-size: 1.3em;"></i>${assign.title }</h5>                                 
                </div>
                <div class="flex-shrink-1">
                	<button type="button" class="btn btn-purple"
						style="width: 90px; margin-right: 5px;height: 33px;line-height: 6px;" onclick="location.href='./list.go'">목록가기</button>
                </div>
                </div>
			<hr>
			<p>${assign.content }</p>
			<c:if test="${!empty assign.uploadpath }">
				<div class="list-group-item py-3">
					<div class="d-flex align-items-start">
						<div class="flex-shrink-0 avatar-sm me-3">
							<span
								class="avatar-title bg-light text-primary rounded font-size-20">
								<i class="uil uil-scenery"></i>
							</span>
						</div>
						<div class="flex-grow-1 overflow-hidden">
							<h5 class="font-size-13 text-truncate">
								<a href="getFile.go?assignCode=${assign.assignCode}"
									class="text-dark">${assign.filename }</a>
							</h5>
						</div>
						<div class="flex-shrink-0 ms-2">
							<ul class="list-inline mb-0">
								<li class="list-inline-item"><a
									href="getFile.go?assignCode=${assign.assignCode}"
									class="text-muted font-size-20 px-2"> <i
										class="uil uil-download-alt"></i>
								</a></li>
							</ul>
						</div>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<div class="card">
		<div class="card-body">
			<div class="d-flex justify-content-between">
				<h5 style="margin-bottom: 15px; font-weight: bold;">
					<i class="uil-file-alt"
						style="margin-right: 10px; font-size: 1.3em;"></i>제출 상황
				</h5>
				<c:if test="${attach.status ne '제출 완료'}">
					<button type="button" class="btn btn-soft-purple"
						style="width: 90px; height: 35px; line-height: 6px;" id="give"
						onclick="location.href='regist.go?assignCode=${assign.assignCode}'">
						제출하기</button>
				</c:if>	
				<c:if test="${attach.status eq '제출 완료' }">
					<c:if test="${attach.confirm ne '확인 완료' }">
						<button type="button" class="btn btn-soft-purple"
							style="width: 90px; height: 35px; line-height: 6px;"
							id="give"
							onclick="location.href='modify.go?assignCode=${assign.assignCode}'">
							수정하기</button>
					</c:if>
				</c:if>	
			</div>
			<br>
			<div class="table-responsive" style="margin-bottom: 15px;">
				<table class="table mb-0" style="text-align: center;">
						<tr>
							<th class="bg-soft-purple"
								style="width: 250px; font-weight: bold;">제출 여부</th>
							<c:if test="${!empty attach.assignCode}">
								<th class="bg-light">${attach.status }</th>
							</c:if>	
							<c:if test="${empty attach.assignCode }">
								<th class="bg-light">제출 안함</th>
							</c:if>
						</tr>
						<tr>
							<th class="bg-soft-purple" style="font-weight: bold;" scope="row">확인
								여부</th>
							<c:if test="${!empty attach.assignCode}">
								<c:if test="${!empty attach.confirm }">
									<td class="bg-light">${attach.confirm}</td>
								</c:if>
								<c:if test="${empty attach.confirm }">
									<td class="bg-light">확인 미완료</td>
								</c:if>
							</c:if>
							<c:if test="${empty attach.assignCode}">
								<td class="bg-light">-</td>
							</c:if>	
						</tr>
						<tr>
							<th class="bg-soft-purple" style="font-weight: bold;" scope="row">종료
								일시</th>
							<td class="bg-light">${assign.endDate }</td>
						</tr>
						<tr>
							<th class="bg-soft-purple" style="font-weight: bold;" scope="row">마감까지
								남은 기한</th>
							<td class="bg-light" id="last">${assign.endDate }</td>
						</tr>
						<tr>
							<th class="bg-soft-purple" style="font-weight: bold;" scope="row">최종
								수정 일시</th>
							<c:if test="${!empty attach.updatedate }">
								<td class="bg-light">${attach.updatedate }</td>
							</c:if>
							<c:if test="${empty attach.updatedate }">
								<td class="bg-light">-</td>
							</c:if>
						</tr>
				</table>
				<!-- end table-->
			</div>
			<!-- end table responsive -->
		</div>
	</div>
	<script>
		function page_rollback(name){
			location.href='list.go?name=' + name;
		}
	</script>
</body>
