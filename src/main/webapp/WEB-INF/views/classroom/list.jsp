<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<script>
	function regist_go(){
		OpenWindow('registForm.go','수업실 등록',500,820);
	}
	function roomDetail(tr){
		var roomCode= $(tr).children('td:eq(0)').text();
		console.log(roomCode);
		
		OpenWindow('detail.go?roomCode='+roomCode,'수업실 등록',1400,900);
	}
	
</script>
</head>

<body>

	<c:set var="pageMaker" value="${dataMap.pageMaker }"></c:set>
	<c:set var="classroomList" value="${dataMap.classroomList }"></c:set>
	<c:set var="newUseList" value="${dataMap.newUseList }"></c:set>
	<c:set var="canUseRoomList" value="${dataMap.canUseRoomList }"></c:set>
	<c:set var="newUnUsedList" value="${dataMap.newUnUsedList }"></c:set>
	<c:set var="useFixList" value="${dataMap.useFixList }"></c:set>
	<c:set var="cri" value="${pageMaker.cri }"></c:set>

	<!-- row 시작 -->
	<div class="row">
		<div class="col-lg-12">
			<!-- card 시작 -->
			<div class="card" style="margin-bottom: 3px;">
				<!-- cardheader 시작 -->
				<div class="card-header col-md-12">
					<h5 style="font-weight: bold;margin:0;"><i class="uil-university"></i>&nbsp;&nbsp;&nbsp;강의실 관리</h5>
				</div>
				<!-- cardheader 끝 -->

				<!-- card-body 시작 -->
				<div class="card-body" style="margin-top:10px;padding-top: 0;">
					<!-- 검색 -->
					<div class="row"
						style="padding-left: 50px; padding-right: 70px; margin-bottom: 3px;">
						<div class="col-md-7">
							<button type="button" id="registBtn" class="btn btn-primary"
								style="float: left; width: 15%;" onclick="regist_go();">등록</button>
						</div>
						<div class="col-sm-6 input-group" style="display: contents">
							<select class="form-select" style="width: auto;"
								aria-label="Default select example" name="searchType"
								id="searchType">
								<option value="npc" ${cri.searchType eq 'npc' ? 'selected':'' }>전체</option>
								<option value="n" ${cri.searchType eq 'n' ? 'selected':'' }>호수</option>
								<option value="p" ${cri.searchType eq 'p' ? 'selected':'' }>목적</option>
								<option value="c" ${cri.searchType eq 'c' ? 'selected':'' }>수용인원</option>
							</select>
							<!-- keyword -->
							<input class="form-control" type="text" name="keyword"
								placeholder="검색어를 입력하세요." value="${param.keyword }"
								style="width: auto;"> <span class="input-group-append">
								<button class="btn btn-primary" type="button"
									id="searchBtn" data-card-widget="search" onclick="list_go(1);">
									<i class="fa fa-fw fa-search"></i>
								</button>
							</span>
						</div>
						<!-- 검색 기능 끝 -->
					</div>
					<div class="bd-example"
						style="padding-left: 50px; padding-right: 50px;">
						<table class="table table-hover" style="text-align: center;">
							<thead style="background-color: #038edc; color: white;">
								<tr>
									<th scope="col">호수</th>
									<th scope="col">사용 목적</th>
									<th scope="col">수용 인원</th>
									<th scope="col">사용 여부</th>
									<th scope="col">비품</th>
									<th scope="col">미리보기</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="classroom" items="${classroomList }">
									<input type="hidden" value="${classroom.roomCode}">
									<tr onclick="roomDetail(this);">
										<td style="display: none;" id="room_code">${classroom.roomCode }</td>
										<th id="rno" scope="row">${classroom.roomNo }호</th>
										<td id="usepose">${classroom.usePurpose }</td>
										<td id="cap">${classroom.capacity }명</td>
										<td id="usecase"><c:forEach var="canUse"
												items="${newUnUsedList}" varStatus="status">
												<c:if test="${classroom.roomCode eq canUse }">
													<span style="font-size: initial;"class="badge bg-primary">사용 가능</span>
												</c:if>
											</c:forEach> <c:forEach var="cantUse" items="${ newUseList}">
												<c:if test="${classroom.roomCode eq cantUse }">
													<span style="font-size: initial;" class="badge bg-danger">사용중</span>
												</c:if>
											</c:forEach></td>
										<td id="fixt" class="pb-3" data-bs-toggle="modal"
											data-bs-target="#icon_info_modal"onclick="event.cancelBubble=true;">
											<c:forEach var="fixt" items="${useFixList }">
												<c:if test="${fixt.roomCode == classroom.roomCode}">
													<span title="" class="drr-313 equi-icon-small active">
														<i class="${fixt.fxticon }"></i>
													</span>
												</c:if>
											</c:forEach> 
											<c:if test="${empty useFixList}">
												<span>-</span>
											</c:if></td>
										<td id="roomPicture" data-bs-toggle="modal"
											data-bs-target="#roomPictureModal"
											data-id="${classroom.roomCode}"
											data-no="${classroom.roomNo }호"
											onclick="onclick=event.cancelBubble=true;getRoomPicture(this);"><i class="uil-camera"></i>
										</td>
									</tr>
								</c:forEach>
							</tbody>

						</table>
						<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
					</div>
				</div>
				<!-- card-body 끝 -->
				<!-- 비품 Modal 시작 -->
				<div class="modal fade" id="icon_info_modal" tabindex="-1"
					aria-labelledby="icon_info_label" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="icon_info_label">비품 아이콘 설명</h5>
								<!-- 								<button type="button" class="close" data-dismiss="modal" -->
								<!-- 									aria-label="Close"> -->
								<!-- 									<span aria-hidden="true"></span> -->
								<!-- 								</button> -->
							</div>
							<div class="modal-body">
								<div class="row no-gutters">
									<div class="col-12">
										<label class="mx-3 mb-3"><i class="fas fa-chair"></i>
											의자</label> <label class="mx-3 mb-3"><i class="fas fa-inbox"></i>
											책상</label> <label class="mx-3 mb-3"><i class="fas fa-video"></i>
											프로젝터</label> <label class="mx-3 mb-3"><i
											class="fas fa-chalkboard"></i> 화이트보드</label> <label class="mx-3 mb-3"><i
											class="fas fa-chalkboard-teacher"></i> 스크린</label> <label
											class="mx-3 mb-3"><i class="fas fa-fire-extinguisher"></i>
											소화기</label>
									</div>
								</div>
							</div>
							<div class="modal-footer"></div>
						</div>
					</div>
				</div>
				<!-- 비품 Modal 끝 -->
			</div>
			<!-- card 끝 -->

			<!-- 강의실 사진 Modal -->
			<div class="modal fade " id="roomPictureModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="roomPictureModalLabel"></h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="mailbox-attachments clearfix col-md-12"
									style="text-align: center; height: 500px;">
									<div id="pictureView" class="roomPicture"
										style="border: 1px solid green; height: 480px; width: 100%; margin: 0 auto;"></div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>



			<div class="card">
				<!-- start card body -->
				<div class="card-body">
					<!-- 아이콘 wrapper 시작 -->
					<div class="col-sm-12"
						style="padding-left: 50px; padding-right: 50px;">
						<div
							style="border: 1px solid skyblue; padding: 10px; padding-left: 160px;">

							<div class="d-flex align-items-center col-sm-2"
								style="float: left;">
								<div class="flex-shrink-0" style="margin-right: 5px;">
									<div class="avatar-sm">
										<div
											class="avatar-title bg-primary text-primary rounded-circle font-size-18">
											<i class="uil-university" style="color:white;"></i>
										</div>
									</div>
								</div>

								<div class="flex-grow-1 overflow-hidden">
									<p class="mb-1 text-truncate text-muted" style="font-style: bold">강의실 수</p>
									<h5 class="font-size-16 mb-0" id="allRoomCnt"></h5>
								</div>
							</div>
							
							<div class="d-flex align-items-center col-sm-2"
								style="float: left;">
								<div class="flex-shrink-0 " style="margin-right: 5px;">
									<div class="avatar-sm">
										<div
											class="avatar-title bg-primary text-primary rounded-circle font-size-18">
											<i class="uil uil-users-alt" style="color:white;"></i>
										</div>
									</div>
								</div>

								<div class="flex-grow-1 overflow-hidden">
									<p class="mb-1 text-truncate text-muted">수용인원</p>
									<h5 class="font-size-16 mb-0" id="allCapacity"></h5>
								</div>
							</div>

							<div class="d-flex align-items-center col-sm-2"
								style="float: left;">
								<div class="flex-shrink-0 "style="margin-right: 5px;">
									<div class="avatar-sm">
										<div
											class="avatar-title bg-primary text-primary rounded-circle font-size-18">
											<i class="bx bx-user-x" style="color:white;" ></i>
										</div>
									</div>
								</div>

								<div class="flex-grow-1 overflow-hidden">
									<p class="mb-1 text-truncate text-muted">사용가능</p>
									<h5 class="font-size-16 mb-0" id="unusedRoomCnt"></h5>
								</div>
							</div>

							<div class="d-flex align-items-center col-sm-2"
								style="float: left;">
								<div class="flex-shrink-0 "style="margin-right: 5px;">
									<div class="avatar-sm">
										<div
											class="avatar-title bg-primary text-primary rounded-circle font-size-18">
											<i class="bx bx-user-check" style="color:white;"></i>
										</div>
									</div>
								</div>

								<div class="flex-grow-1 overflow-hidden">
									<p class="mb-1 text-truncate text-muted">사용중</p>
									<h5 class="font-size-16 mb-0" id="usedRoomCnt"></h5>
								</div>
							</div>

							<div class="d-flex align-items-center col-sm-2">
								<div class="flex-shrink-0 "style="margin-right: 5px;">
									<div class="avatar-sm">
										<div
											class="avatar-title bg-primary text-primary rounded-circle font-size-18">
											<i class="uil-signal-alt-3" style="color:white;"></i>
										</div>
									</div>
								</div>

								<div class="flex-grow-1 overflow-hidden">
									<p class="mb-1 text-truncate text-muted">층수</p>
									<h5 class="font-size-16 mb-0" id="floorCnt"></h5>
								</div>
							</div>
						</div>
					</div>
					<!-- 아이콘 wrapper 끝 -->

					<!-- 빈강의실 table 시작 -->
					<div class="bd-example"
						style="margin-top:0; padding-left: 50px; padding-right: 50px;">
						<div class="col-md-12" style="text-align: center; margin: 10px;">
							<span class="badge bg-danger" style="font-size: 1.0em;">
								사용중인 강의실 </span>
						</div>
						<div class="col-md-12" style="height:150px;overflow: auto;">
							<table class="table" style="text-align: center;">
								<thead style="background-color: #038edc; color: white;">
									<tr>
										<th scope="col">호수</th>
										<th scope="col">사용 목적</th>
										<th scope="col">수용 인원</th>
									</tr>
								</thead>
								<tbody id="useRoomListTarget">
								</tbody>
							</table>
						</div>
						<!-- 빈강의실 table 끝 -->
					</div>
				</div>
				<!-- end card body -->
			</div>
			<!-- card 끝 -->
		</div>
	</div>
	<!-- row 끝 -->
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script>
	window.onload = function(){//사용불가능한 강의실 리스트
		useRoomListAjax();
		wholeRoomData();
	}
</script>
<script>
//강의실 전체 정보 가져오기(강의실 개수, 수용인원, 사용가능수, 사용중 수, 층수)
function wholeRoomData(){
	$.ajax({
		url:'<%=request.getContextPath() %>/classroom/wholeRoomData.go',
		success:function(data){
			console.log(data);
			if(data!=null){
				$('#floorCnt').text(data.floorCnt);
				$('#allRoomCnt').text(data.allRoomCnt);
				$('#allCapacity').text(data.allCapacity);
				$('#unusedRoomCnt').text(data.unusedRoomCnt);
				$('#usedRoomCnt').text(data.usedRoomCnt);
			}
		},
		error:function(error){
			alert("error : " + error.status);
		},
		dataType:'json'
	});
}
</script>
<script>
function useRoomListAjax(){
	$.ajax({
		url:'<%=request.getContextPath() %>/classroom/useRoomList.go',
		success:function(data){
			console.log(data);
			if(data.length>0){
				printData(data,$('#useRoomListTarget'),$('#useroom-list-template'));
			}else if(data.length<1){
				printData(data,$('#useRoomListTarget'),$('#useroom-none-template'));
			}
		},
		error:function(error){
			alert("error : " + error.status);
		},
		dataType:'json'
	});
}
</script>
<!-- 사용중인 강의실 템플릿 -->
<script type="text/x-handlebars-template"  id="useroom-list-template" >
{{#each .}}
	<tr onclick="roomDetail(this);">
		<td style="display: none;" id="room_code">{{roomCode}}</td>
		<th scope="row">{{roomNo}}</th>
		<td>{{usePurpose}}</td>
		<td>{{capacity}}</td>
	</tr>
{{/each}}
</script>
<script type="text/x-handlebars-template"  id="useroom-none-template" >
	<tr>
		<td colspan="3"><h6 style="margin:5px;">오늘 사용중인 강의실이 없습니다</h6></td>
	</tr>
</script>

<script>
	function getRoomPicture(td){
		var roomCode = $(td).attr('data-id');
		var roomNo = $(td).attr('data-no');
		$('#roomPictureModalLabel').text(roomNo);
		RoomPictureThumb('<%=request.getContextPath()%>', roomCode);
	}

	//사용자 사진 출력
	function RoomPictureThumb(contextPath, roomCode){
		console.log(contextPath);// -> /ddit
		console.log(document.querySelectorAll('#pictureView'));
		 for(var target of document.querySelectorAll('#pictureView')){
	          console.log(roomCode);
	          //에러 ---아이디 없음.
			 target.style.backgroundImage="url('"+contextPath+"/classroom/getPicture.go?roomCode="+roomCode+"')";
			 target.style.backgroundPosition="center";
			 target.style.backgroundRepeat="no-repeat";
			 target.style.backgroundSize="cover";
		}
	}
	</script>

</head>
<c:if test="${from eq 'regist' }">
	<script>
		//alert("등록되었습니다.");
		window.close();
		window.opener.location.reload();
	</script>
</c:if>
<c:if test="${from eq '1' }">
	<script>
		alert("삭제를 성공했습니다.");
		window.location.reload();
	</script>
</c:if>
<c:if test="${from eq '0' }">
	<script>
		alert("진행중인 수업이 있어 삭제할 수 없습니다.");
		window.location.reload();
	</script>
</c:if>
</body>


















