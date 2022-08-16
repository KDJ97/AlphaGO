<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="pdsList" value="${dataMap.pdsList }" />
<c:set var="cri" value="${pageMaker.cri }" />

<head>
  <link href="<%=request.getContextPath() %>/resources/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
  <script src="<%=request.getContextPath() %>/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<style>
table th, td {
	text-align: center;
	vertical-align: middle;
}
table thead th{
	background-color: #564ab1;
	color: white;
}
th>button{
	width: 70px;
}

</style>
<script type="text/javascript">
function cancel(type, code, btn){
	//비동기 삭제
	$.ajax({
		url:"cancelCounselor.go",
		type: "post",
		data : {
			'type' : type,
			'code' : code
		},
		success : function(){
			Swal.fire({
   			  title: '상담이 정상적으로 취소 되었습니다',
			  icon: 'success'
			})
			$(btn).parents('tr').remove();
		}
	});
}

function setAjaxData(type, code){
	$.ajax({
		url:"getCounselorData.go",
		async : false,
		type: "get",
		data : {
			'type' : type,
			'code' : code
		},
		success : function(result){
		//상세페이지 데이터 출력
		console.log(result);
		$('#modalDate').text(result.date);
		$('#modalStart').text(result.start);
		$('#modalEnd').text(result.end);
		$('#modalName').text(result.name);
		$('#modalPurpose').text(result.purpose);
		$('#modalContent').text(result.content);
		$('#modalResult').text(result.result);

		var badge = "";
		if(result.status == 1) badge = "<span class='badge bg-secondary font-size-16'>상담완료</span>";
		if(result.status == 2) badge = "<span class='badge bg-warning font-size-16'>반려</span>";
		if(result.status == 3) badge = "<span class='badge bg-success font-size-16'>상담예정</span>";

		$('#modalStatus').html(badge);



		//모달 오픈
		$('#detailModal').modal('show');
		}
	});

}
</script>
</head>

<body>

	<!-- Content Header (Page header) -->





	<div class="card"  >


	    <div class="card-header justify-content-between d-flex align-items-center">
	         <h4 class="card-title" style="font-weight: bold;">
	         	<i class="uil-calender" style="font-weight: bold;"></i>&nbsp;상담신청내역
	         </h4>
	         <div>
	           <button type="button" onclick="javascript:location.href = '<%=request.getContextPath() %>/consulting/insert.go'" class="btn btn-sm btn-secondary">
	         	상담신청하러 가기&nbsp;&nbsp;<i class="mdi mdi-arrow-right align-middle"></i>
	           </button>
	         </div>

	     </div>

		<div class="card-body" style="padding:0px;">

			<table class="table table-bordered text-center table-hover">
				<thead>
					<tr class="bg-purple">
						<th></th>
						<th>번호</th>
						<th>상담일</th>
						<th>상담자</th>
						<th>강사목적</th>
						<th style="width: 95px;">상태</th>
					</tr>
				</thead>
				<c:forEach items="${applyList }" var="apply" varStatus="num">
				  <tr class="table-white">
					<td width="50px;">
					  <button class="btn btn-sm btn-danger" type="button" onclick="cancel('${apply.type }','${apply.code }', this)"><i class="uil uil-trash-alt font-size-16"></i></button>
					</td>
					<th>${num.count }</th>
					<th>${apply.time }</th>
					<th>${apply.name }</th>
					<th>${apply.purpose }</th>
					<th><button class="btn btn-primary" type="button" style="padding:3px;">신청중</button></th>
				  </tr>
				</c:forEach>

			</table>
		</div>
	</div>






	<div class="card">
	   <div class="card-header justify-content-between d-flex align-items-center">
         <h4 class="card-title" style="font-weight: bold;">
         	<i class="uil-calender"></i>&nbsp;상담내역
         </h4>
       </div>

		<div class="card-body" style="padding:0px;">
			<table class="table   table-bordered text-center table-hover">
				<thead>
					<tr style="font-size: 0.95em; padding: 30px;"
						class="bg-purple">
						<th>번호</th>
						<th>상담일</th>
						<th>상담자</th>
						<th>강사목적</th>
						<th style="width: 95px;">상태</th>
					</tr>
				</thead>
				<c:forEach items="${appliedList }" var="apply" varStatus="num">
				  <tr class="table-white" onclick="setAjaxData('${apply.type }','${apply.code }')">
					<th>${num.count }</th>
					<th>${apply.time }</th>
					<th>${apply.name }</th>
					<th>${apply.purpose }</th>
					<th>
					  <c:if test="${apply.status eq '1' }">
  						<button class="btn btn-secondary"   style="padding:3px;"type="button">상담완료</button>
					  </c:if>
					  <c:if test="${apply.status eq '2' }">
  						<button class="btn btn-warning"   style="padding:3px;"type="button">반려</button>
					  </c:if>
					  <c:if test="${apply.status eq '3' }">
  						<button class="btn btn-success" style="padding:3px;" type="button">상담예정</button>
					  </c:if>
					</th>
				  </tr>
				</c:forEach>
			</table>
		</div>

	</div>


	<!-- Button trigger modal -->

	<div class="modal fade" id="detailModal" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel" style="font-weight: bold;">
						<i class="uil-calender"></i>&nbsp;상담신청내역
					</h5>
					<button type="button" class="btn btn-sm btn-secondary" data-bs-dismiss="modal">닫기</button>
				</div>
				<div class="modal-body">
				  <div class="row">
				    <div class="col-2">상담일자</div>
				    <div class="col-10" id="modalDate">2022-06-27</div>
				  </div>
				  <hr>
				  <div class="row">
				    <div class="col-6">
					  <div class="row">
					    <div class="col-4">시작시간</div>
					    <div class="col-8 border-end" id="modalStart">11:00</div>
					  </div>
				    </div>
				    <div class="col-6">
					  <div class="row">
					    <div class="col-4">종료시간</div>
					    <div class="col-8" id="modalEnd">12:00</div>
					  </div>
				    </div>
				  </div>
				  <hr>
				  <div class="row">
				    <div class="col-2">상담자</div>
				    <div class="col-10" id="modalName">예현의</div>
				  </div>
				  <hr>
				  <div class="row">
				    <div class="col-2">목적</div>
				    <div class="col-10" id="modalPurpose">상담</div>
				  </div>
			  	  <hr>
				  <div class="row">
				    <div class="col-2">상태</div>
				    <div class="col-10" id="modalStatus">
				      <span class="badge bg-secondary font-size-16">상담완료</span>
				     </div>
				  </div>
				  <hr>
				  <div class="row">
				    <div class="col-2">내용</div>
				    <div class="col-10" id="modalContent">학원을 다닌지 1년이 넘었는데 성적이 안오릅니다.<br>학원을 다닌지 1년이 넘었는데 성적이 안오릅니다.</div>
				  </div>
				  <hr>
				  <div class="row">
				    <div class="col-2">결과</div>
				    <div class="col-10" id="modalResult">아이가 수업시간에 집중을 못하네요.집중부탁이요.</div>
				  </div>

				</div>
			</div>
		</div>
	</div>

</body>