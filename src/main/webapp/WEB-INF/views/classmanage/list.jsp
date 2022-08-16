<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
</head>

<body>
	<c:set var="classList" value="${dataMap.classList }"></c:set>
	<c:set var="pageMaker" value="${dataMap.pageMaker }"></c:set>

	<!-- row 시작 -->
	<div class="row">
		<div class="col-lg-12">
			<!-- card 시작 -->
			<div class="card" style="padding-bottom: 10px;">
				<div class="card-header">수업관리</div>
				<div class="card-body" style="padding-bottom: 0;">
					<div class="col-md-12"
						style="text-align: center; padding-left: 50px; padding-right: 50px;">
						<h5 style="font-weight: bold;">수업 관리</h5>
					</div>
					<!-- 검색 -->
					<div class="row">
						<div class="col-sm-6"></div>
						<div class="col-sm-6">
							<div class="col-sm-6 input-group" id="keyword"
								style="float: right; margin-top: 30px; padding-right: 40px;">
								<!-- keyword -->
									<select class="form-select " style="float: left;width: 20%;"
										aria-label="Default select example" name="searchType"
										id="searchType">
										<option value="nst" ${cri.searchType eq 'nst' ? 'selected':'' }>전체</option>
										<option value="n" ${cri.searchType eq 'n' ? 'selected':'' }>수업명</option>
										<option value="s" ${cri.searchType eq 's' ? 'selected':'' }>과목</option>
									</select>
									<input class="form-control col-sm-6 " type="text" name="keyword"
										placeholder="검색어를 입력하세요." value="${param.keyword }"
										style="width: 40%; "> <span
										class="input-group-append">
										<button class="btn btn-soft-primary" type="button"
											id="searchBtn" style="float: right;"
											data-card-widget="search" onclick="list_go(1);">
											<i class="fa fa-fw fa-search"></i>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div>

				<div class="col-md-12"
					style="padding-left: 50px; padding-right: 50px;">
					<span class="badge badge-soft-primary" style="font-size: 1.0em;">
						개설된 수업 목록</span>
				</div>
				<!-- 수업테이블 시작 -->
				<div class="col-md-12"
					style="margin-top: 10px; padding-left: 50px; padding-right: 50px;">
					<table class="table table-hover" style="text-align: center;">
						<thead class="">
							<tr class="" style="background-color: #86a8d9; color: white;">
								<th scope="col">과목</th>
								<th scope="col">과목영역</th>
								<th scope="col">수업명</th>
								<th scope="col">금액</th>
								<th scope="col">대상</th>
								<th scope="col">수준</th>
							</tr>
						</thead>
						<tbody style="">
							<c:forEach var="classvo" items="${classList }">
								<tr onclick="classDetail(this);">
									<td style="display: none;">${classvo.classCode }</td>
									<td>${classvo.subjectName }</td>
									<td>${classvo.subdetailName }</td>
									<td>${classvo.className }</td>
									<td><fmt:formatNumber value="${classvo.classPrice }" /></td>
									<td><span>고</span>${classvo.classGrade}</td>
									<td>${classvo.classRank}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- pagination -->
						<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
				</div>
				<!-- 수업테이블 끝 -->
			</div>
			<div class="card">
				<!-- 수업 상세 시작 -->
				<div class="col-md-12"
					style="margin-top: 10px; padding-left: 50px; padding-right: 50px;">
					<div class="col-sm-6" style="float: left;">
						<span class="badge badge-soft-primary" style="font-size: 1.0em;">
							수업 상세</span>
					</div>
					<div class="col-sm-6"
						style="float: right; text-align: right; padding-left: 20px;">
						<button id="reset" onclick="reset();" type="button"
							class="btn btn-secondary">
							<i class="uil-sync"></i>
						</button>
						<button id="regist" type="button" class="btn btn-soft-primary">등록</button>
						<button id="modify" type="button" class="btn btn-soft-warning">수정</button>
						<button id="remove" type="button" class="btn btn-soft-danger">삭제</button>
					</div>
				</div>
				<!-- 수업상세 테이블 시작 -->
				<div class="col-md-12"
					style="padding-left: 50px; padding-right: 50px;">
					<form role="form" action="" method="post">
						<input type="hidden" id="class_code" name="classCode">
						<table class="table" style="text-align: center;">
							<tr>
								<td scope="col" style="background-color: #86a8d9; color: white;">수업명</td>
								<td colspan="5"><input type="text" id="dcname"
									name="className" style="width: 99%; text-align: center;"
									placeholder="수업명을 입력하세요."></td>
							</tr>
							<tr class="">
								<td style="background-color: #86a8d9; color: white;" scope="col">과목명</td>
								<td><select onchange="getSubDetail(this);"
									class="form-select" id="dcsub" style="text-align: center;">
										<option value="" id="deSub">과목</option>
										<option class="subj" value="1">국어</option>
										<option class="subj" value="2">수학</option>
										<option class="subj" value="3">영어</option>
										<option class="subj" value="4">사회</option>
										<option class="subj" value="5">과학</option>
								</select> <input type="hidden" name="subjectCode" id="sjcode" value="">
								</td>
								<td style="background-color: #86a8d9; color: white;" scope="col">과목영역</td>
								<td><select class="form-select"
									onchange="getSubDeVal(this);" id="subdetail"
									style="text-align: center;">
										<option value="">과목 영역</option>
								</select> <input type="hidden" name="subdetailCode" id="subdetail_code"
									value=""></td>
								<td scope="col" style="background-color: #86a8d9; color: white;">학년</td>
								<td><select onchange="getGrade(this);"
									class="form-select" id="dcperson" style="text-align: center;">
										<option value="" id="deGrade">학년</option>
										<option value="1">1학년</option>
										<option value="2">2학년</option>
										<option value="3">3학년</option>
								</select> <input type="hidden" name="classGrade" id="cGrade" value="">
								</td>
							</tr>
							<tr class="">
								<td scope="col" style="background-color: #86a8d9; color: white;">정원</td>
								<td><input type="text" name="stuCnt" id="stu_cnt"
									placeholder="정원을 입력하세요" style="width: 85%; text-align: center;">
									명</td>
								<td scope="col" style="background-color: #86a8d9; color: white;">금액</td>
								<td><div>
										<input type="text" name="classPrice" id="dcprice"
											style="width: 85%; text-align: center;"
											placeholder="산정 금액을 입력하세요."> 원
									</div></td>
								<td style="background-color: #86a8d9; color: white;" scope="col">수업수준</td>
								<td><input type="text" id="class_rank" name="classRank"
									value="" placeholder="A/B/C"
									style="width: 90%; text-align: center;"></td>
							</tr>
						</table>
					</form>
				</div>
				<!-- 수업상세 테이블 끝 -->
				<!-- 수업 상세 끝 -->
			</div>
			<!-- card 끝 -->
		</div>
	</div>
<head>
<script>
	$('#regist').on("click", function() {
		var form = $('form[role="form"]');
		form.attr("action", "classregistGo.go");
		form.submit();
	})

	$('#remove').on("click", function() {
		var form = $('form[role="form"]');
		form.attr("action", "classremove.go");
		form.submit();
	})
</script>

<script>
	function getGrade(op) {
		// 		console.log(op.value);
		$('#cGrade').val(op.value);
	}

	function getSubDeVal(op) {
		$('#subdetail_code').val(op.value);
	}
</script>

<script>
	function getSubDetail(op) {

		var opVal = op.value;

		$('#sjcode').val(opVal);

		var str = "";
		console.log(opVal);
		$.ajax({
			url : "subDetail.go",
			method : "post",
			data : {
				opVal : opVal
			},
			success : function(data) {
				console.log(data);
				if (data) {
					for (var i = 0; i < data.length; i++) {
						str += "<option class='subDetailLi' value="+data[i].subdetailCode+">"
								+ data[i].subdetailName + "</option>";
					}
					subdetail.empty();
					subdetail.append(str);
				}
			},
			error : function(error) {
				alert("load error : " + error.status);
			},
			dataType : "json"
		});
	}
</script>

<script>
	function reset() {
		dcname.val("");
		dcprice.val("");
		stu_cnt.val("");
		class_rank.val("");

		for (var i = 0; i < dcpersonChild.length; i++) {
			//checked가 있는지 확인하고 있으면 삭제
			if (dcpersonChild[i].getAttribute("selected") == "true") {
				dcpersonChild[i].removeAttribute("selected");
			}
		}
		$('#deGrade').attr("selected", "true");

		//과목 option들 selected 속성 확인
		for (var i = 0; i < dcsubChild.length; i++) {
			//checked가 있는지 확인하고 있으면 삭제
			if (dcsubChild[i].getAttribute("selected") == "true") {
				dcsubChild[i].removeAttribute("selected");
			}
		}
		$('#deSub').attr("selected", "true");

		subdetail.empty();
	}
</script>

<script>
	//데이터 넣어줄 태그들
	var dcname = $('#dcname');
	var dcperson = $('#dcperson');//select
	var dcprice = $('#dcprice');
	var dcsub = $('#dcsub');//select
	var subdetail = $('#subdetail');//select
	var stu_cnt = $('#stu_cnt');//정원
	var class_rank = $('#class_rank'); //수업수준

	//학년 SELECT BOX
	var dcpersonChild = dcperson.children('option');
	//과목 SELECT BOX
	var dcsubChild = dcsub.children('option');
	//상세과목 select box
	var dcsubDeChild = subdetail.children('option');

	//수업 상세 불러오기
	function classDetail(tr) {
		var classcode = $(tr).children('td:eq(0)').text();
		// 		console.log(classcode);
		$.ajax({
			url : "classDetail.go",
			method : "post",
			data : {
				classCode : classcode
			},
			success : function(data) {
				printDetail(data);
			},
			error : function(error) {
				alert("error : " + error.status);
			},
			dataType : "json"
		})
	}

	function printDetail(data) {
		var classvo = data.classvo;
		var subList = data.subDetailList;
		var inputCode = $("#class_code");
		inputCode.val(classvo.classCode);
		console.log(classvo.classCode);
		console.log(subList);
		//function화하기
		//학년 option들 selected 속성 확인
		for (var i = 0; i < dcpersonChild.length; i++) {
			//checked가 있는지 확인하고 있으면 삭제
			if (dcpersonChild[i].getAttribute("selected") == "true") {
				dcpersonChild[i].removeAttribute("selected");
			}

			if (dcpersonChild[i].value == classvo.classGrade) {
				dcpersonChild[i].setAttribute("selected", "true");
			}
		}
		//function화하기
		//과목 option들 selected 속성 확인
		for (var i = 0; i < dcsubChild.length; i++) {
			//checked가 있는지 확인하고 있으면 삭제
			if (dcsubChild[i].getAttribute("selected") == "true") {
				dcsubChild[i].removeAttribute("selected");
			}

			if (dcsubChild[i].value == classvo.subjectCode) {
				dcsubChild[i].setAttribute("selected", "true");
			}
		}

		//상세과목 option 지우기
		var str = "";
		subdetail.empty();
		for (var i = 0; i < subList.length; i++) {
			if (subList[i].subdetailCode == classvo.subdetailCode) {
				str += "<option selected='true' class='subDetailLi' value="+subList[i].subdetailCode+">"
						+ subList[i].subdetailName + "</option>";
			} else {
				str += "<option class='subDetailLi' value="+subList[i].subdetailCode+">"
						+ subList[i].subdetailName + "</option>";
			}
		}
		subdetail.html(str);

		//상세과목 option들 selected 속성 확인
		for (var i = 0; i < dcsubDeChild.length; i++) {
			//checked가 있는지 확인하고 있으면 삭제
			if (dcsubDeChild[i].getAttribute("selected") == "true") {
				dcsubDeChild[i].removeAttribute("selected");
			}

			if (dcsubDeChild[i].value == classvo.subdetailCode) {
				dcsubDeChild[i].setAttribute("selected", "true");
			}
		}

		class_rank.attr("value", classvo.classRank);
		stu_cnt.attr("value", classvo.stuCnt);
		dcname.attr("value", classvo.className);
		dcprice.attr("value", classvo.classPrice);
	}
</script>

<c:if test="${from eq 'regist' }">
	<script>
		alert("수업 등록을 성공했습니다.");
	</script>
</c:if>
<c:if test="${from eq 'removeSuccess' }">
	<script>
		alert("수업 삭제를 성공했습니다.");
	</script>
</c:if>
<c:if test="${from eq 'removeFail' }">
	<script>
		alert("진행중인 수업이 있어 삭제가 불가능합니다.");
	</script>
</c:if>

</head>
</body>

