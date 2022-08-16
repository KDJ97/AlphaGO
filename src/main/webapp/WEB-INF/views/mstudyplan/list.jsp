<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.setHover{
	  opacity: 0.9;
}
.setHover:hover {
  opacity: 1.0;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
</head>
<body>
<div class="card-header">
	<h5 style="font-weight: bold;margin:0;padding:0;"><i class="uil-pen"></i>&nbsp;&nbsp;&nbsp;수업 계획서 관리</h5>
</div>
<div class="card">
	<div class="row">
			<div class="col-sm-2" style="margin-top: 10px;padding-left: 20px;">
				<div onclick="selectClassList('3');" class="card bg-primary text-white-50 setHover" style="text-align: center;">
					<h5 class="card-header bg-primary text-white" style="padding:10px;">승인</h5>
					<div class="card-body">
						<p class="card-text" style="color: white;">수업 승인이<br>완료된 수업</p>
					</div>
				</div>
			</div>
			<div class="col-sm-2" style="margin-top: 10px;padding-left: 10px;">
				<div onclick="selectClassList('2');" class="card bg-danger text-white-50 setHover" style="text-align: center;">
					<h5 class="card-header bg-danger text-white" style="padding:10px;">반려</h5>
					<div class="card-body">
						<p class="card-text" style="color: white;">수업계획서가<br>반려된 수업</p>
					</div>
				</div>
			</div>
			<div class="col-sm-2" style="margin-top: 10px;padding-left: 10px;">
				<div onclick="selectClassList('1');" class="card bg-success text-white-50 setHover" style="text-align: center;">
					<h5 class="card-header bg-success text-white" style="padding:10px;">제출</h5>
					<div class="card-body">
						<p class="card-text" style="color: white;">수업계획서가<br>제출된 수업</p>
					</div>
				</div>
			</div>
			<div class="col-sm-2" style="margin-top: 10px;padding-left: 10px;">
				<div onclick="selectClassList('0');" class="card bg-secondary text-white-50 setHover" style="text-align: center;">
					<h5 class="card-header bg-secondary text-white" style="padding:10px;">미제출</h5>
					<div class="card-body">
						<p class="card-text" style="color: white;">수업계획서가<br>미제출된 수업</p>
					</div>
				</div>
			</div>
			<div class="col-sm-2" style="margin-top: 10px;padding-left: 10px;">
				<div onclick="selectHotClassList('H');" class="card bg-purple text-white-50 setHover" style="text-align: center;">
					<h5 class="card-header bg-purple text-white" style="padding:10px;">인기 수업</h5>
					<div class="card-body">
						<p class="card-text" style="color: white;">후기 평점<br>4.0<i class="uil-arrow-up"></i>이상</p>
					</div>
				</div>
			</div>
			<div class="col-sm-2" style="margin-top: 10px;padding-right: 20px;">
				<div onclick="selectHotClassList('W');" class="card bg-dark text-white-50 setHover" style="text-align: center;">
					<h5 class="card-header bg-dark text-white" style="padding:10px;">비인기 수업</h5>
					<div class="card-body">
						<p class="card-text" style="color: white;">후기 평점이<br>3.0<i class="uil-arrow-down"></i>미만</p>
					</div>
				</div>
		</div>
		
		<div class="col-md-12" style="height:800px;overflow:auto;">
			<div id="handleTarget" style="padding-left: 10px;padding-right: 10px;"></div>
		</div>
	</div>
</div>
	<c:if test="${from eq '3'}">
		<script>
			//alert("승인 되었습니다.");
			window.close();
			window.opener.location.reload();
		</script>
	</c:if>
	<c:if test="${from eq '2'}">
		<script>
			//alert("반려 되었습니다.");
			window.close();
			window.opener.location.reload();
		</script>
	</c:if>
<head>

<script>
	window.onload = function(){
		selectClassList('3');
	}
</script>

<script>
function detail_go(tr){
	var classCode = $(tr).find('td:eq(0)').text();
	console.log(classCode);
	OpenWindow('<%=request.getContextPath()%>/classlist/detail.go?classCode='+classCode,'수업 상세',1000,820);
}
</script>

<script>
//수업계획서 제출 상태에 따른 수업목록 불러오기
	function selectClassList(cpcheck){
		if(cpcheck!=null){
			$.ajax({
				url:'<%=request.getContextPath()%>/mStudyPlan/selectClassListByCpcheck.go',
				data:{"cpcheck":cpcheck},
				success:function(data){
					console.log(data);
					if(data.length>0){
						//수업계획서 제출상태에 따라 다른 템플릿을 보여준다.
						if(cpcheck=="1" || cpcheck=="3"){
							printData(data,$('#handleTarget'),$('#class-list-template'));
						}else if(cpcheck=="0" || cpcheck=="2"){
							printData(data,$('#handleTarget'),$('#noclass-list-template'));
						}
					}else if(data.length<1){
						printData(data,$('#handleTarget'),$('#none-template'));
					}
				},
				error:function(error){
					alert("error : " + error.status);
				},
				dataType:"json"
			});
		}
	}
</script>

<script>
//인기 or 비인기 수업
	function selectHotClassList(hot){
		if(hot!=null){
			$.ajax({
				url:'<%=request.getContextPath()%>/mStudyPlan/selectHotClassList.go',
				data:{"cate":hot},
				success:function(data){
					if(data.length>0){
						console.log(data);
						printData(data,$('#handleTarget'),$('#hotORworst-list-template'))
					}else if(data.length<1){
						printData(data,$('#handleTarget'),$('#none-template'));
					}
				},
				error:function(error){
					alert("error : " + error.status);
				},
				dataType:"json"
			});
		}
	}
</script>

<script>
	//수업계획서 상세 페이지를 openwindow하는 함수
	function classPlan(classCode){
		OpenWindow('<%=request.getContextPath()%>/mStudyPlan/detail.go?classCode='+classCode,'수업계획서',1000,1200);
	}
</script>

<script>
	//쪽지함 보내기 페이지를 openwindow하는 함수
	function removeClass(classCode){
		
// 		if(confirm("수업 계획을 취소하시겠습니까?")){
		
// 		}else{
// 			return false;
// 		}
		
		Swal.fire({
			  title: '수업 계획을 취소하시겠습니까?',
			  text: "취소 후에는  되돌리실 수 없습니다.",
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
					  title: '취소 하였습니다'
					}).then((result) => {
						if (result.isConfirmed){
							$.ajax({
								url:'<%=request.getContextPath()%>/mStudyPlan/removeClass.go',
								data:{"classCode":classCode},
								success:function(data){
									console.log(data);
									//alert("삭제되었습니다.");
									selectClassList('0');
								},
								error:function(error){
									//alert("error : " + error.status);
								}
							});
						}
					})
			  }else{
				  Swal.fire({
					  icon: 'error',
					  title: '취소되었습니다',
					  showConfirmButton: false,
					  timer: 1500
					})
			  }
			})
		
	}
</script>
<script>
//가격에 콤마 붙이기
Handlebars.registerHelper('setPriceComma', (price) => {
	 return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
});
</script>

<script>
//소수점 두자리 처리
Handlebars.registerHelper('setDouble', (avgGrade) => {
	var num = parseFloat(avgGrade);
    return num.toFixed(2);
});
</script>

<script>
//카테고리에 따라 테이블 thead값 변경
Handlebars.registerHelper('setTableColor', (cpcheck) => {
	var returnValue;
	if(cpcheck!=null){
		if(cpcheck=="0"){
			returnValue = "#74788d";
		}else if(cpcheck=="1"){
			returnValue = "#51d28c";
		}else if(cpcheck=="2"){
			returnValue = "#f56666";
		}else if(cpcheck=="3"){
			returnValue = "#038edc";
		}else if(cpcheck=="5"){
			returnValue = "#564ab1";
		}else if(cpcheck=="6"){
			returnValue = "#3f474e";
		}
	}
	return returnValue;
})
</script>

<script type="text/x-handlebars-template"  id="class-list-template" >
<h6 style="margin:5px;">* 수업을 클릭해 현황을 확인하세요.</h6>
<table class="table table-hover" style="text-align:center;vertical-align: middle;">
	<thead>
		<tr style="border-top: 1px solid {{setTableColor [0].cpcheck}};border-bottom: 1px double {{setTableColor [0].cpcheck}};">
			<th style="width:7%;">과목명</th>
			<th style="width:9%;">영역</th>
			<th style="width:31%;">수업명</th>
			<th style="width:7%;">강사명</th>
			<th style="width:21%;">수업기간</th>
			<th style="width:6%;">수준</th>
			<th style="width:5%;">수업료</th>
			<th style="width:6%;">시수</th>
			<th style="width:8%;">계획서</th>
		</tr>
	</thead>
{{#each .}}
	<tr onclick="detail_go(this);">
		<td style="display: none;">{{classCode}}</td>
		<td style="">{{subjectName}}</td>
		<td style="">{{subdetailName}}</td>
		<td style="text-align: left;">{{className}}</td>
		<td style="">{{name}}</td>
		<td style="">{{startDate}}~ {{endDate}}</td>
		<td style="">{{classRank}}</td>
		<td style="">{{setPriceComma classPrice}}</td>
		<td style="">{{totalTime}}</td>
		<td style=""><button type="button"style="background-color:{{setTableColor cpcheck}};border:none;" class="btn btn-dark" onclick="event.cancelBubble=true;classPlan({{classCode}});">확인</button></td>
	</tr>
{{/each}}
</table>
</script>	
<script type="text/x-handlebars-template"  id="noclass-list-template" >
<h6 style="margin:5px;">* 수업 개설을 취소할 수 있습니다.</h6>
<table class="table table-hover" style="text-align:center;vertical-align: middle;">
	<thead>
		<tr style="border-top: 1px solid {{setTableColor [0].cpcheck}};border-bottom: 1px double {{setTableColor [0].cpcheck}};">
			<th style="width:7%;">과목명</th>
			<th style="width:9%;">영역</th>
			<th style="width:31%;">수업명</th>
			<th style="width:7%;">강사명</th>
			<th style="width:21%;">수업기간</th>
			<th style="width:6%;">수준</th>
			<th style="width:5%;">수업료</th>
			<th style="width:6%;">시수</th>
			<th style="width:8%;">취소</th>
		</tr>
	</thead>
{{#each .}}
	<tr>
		<td style="display: none;">{{classCode}}</td>
		<td style="">{{subjectName}}</td>
		<td style="">{{subdetailName}}</td>
		<td style="text-align: left;">{{className}}</td>
		<td style="">{{name}}</td>
		<td style="">{{startDate}}~ {{endDate}}</td>
		<td style="">{{classRank}}</td>
		<td style="">{{setPriceComma classPrice}}</td>
		<td style="">{{totalTime}}</td>
		<td style=""><button type="button"style="background-color:{{setTableColor cpcheck}};border:none;" class="btn btn-danger" onclick="event.cancelBubble=true;removeClass({{classCode}});">취소</button></td>
	</tr>
{{/each}}
</table>
</script>	

<script type="text/x-handlebars-template"  id="hotORworst-list-template" >
<h6 style="margin:5px;">* 수업을 클릭해 현황을 확인하세요.</h6>
<table class="table table-hover" style="text-align:center;vertical-align: middle;">
	<thead >
		<tr style="border-top: 1px solid {{setTableColor [0].cpcheck}};border-bottom: 1px double {{setTableColor [0].cpcheck}};">
			<th style="width:7%;">과목명</th>
			<th style="width:9%;">영역</th>
			<th style="width:31%;">수업명</th>
			<th style="width:7%;">강사명</th>
			<th style="width:21%;">수업기간</th>
			<th style="width:6%;">수준</th>
			<th style="width:5%;">수업료</th>
			<th style="width:6%;">시수</th>
			<th style="width:8%;">평점</th>
		</tr>
	</thead>
{{#each .}}
	<tr onclick="detail_go(this);">
		<td style="display: none;">{{classCode}}</td>
		<td style="">{{subjectName}}</td>
		<td style="">{{subdetailName}}</td>
		<td style="text-align: left;">{{className}}</td>
		<td style="">{{name}}</td>
		<td style="">{{startDate}}~ {{endDate}}</td>
		<td style="">{{classRank}}</td>
		<td style="">{{setPriceComma classPrice}}</td>
		<td style="">{{totalTime}}</td>
		<td style="">{{setDouble starScore}}</td>
	</tr>
{{/each}}
</table>
</script>	

<script type="text/x-handlebars-template"  id="none-template" >
<div class="col-md-12" style="text-align:center;margin-top:13px;">
	<h3>수업 목록이 없습니다.</h3>
</div>
</script>	

</head>
</body>
