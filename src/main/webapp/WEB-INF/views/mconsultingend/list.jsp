<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:set var="pageMaker" value="${dataMap.pageMaker }" />
<c:set var="counseltEndList" value="${dataMap.counseltEndList }" />
<c:set var="cri" value="${pageMaker.cri }" />

<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<style>
table th, td {
	text-align: center;
}
</style>


<script>



</script>	
	
</head>

<body>

	<!-- Content Header (Page header) -->


	<!-- Main content -->

	<div class="card">

		<section class="content-header">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="card-header">
						<h5 style="font-weight: bold;margin:0;padding:0;"><i class="uil-notes"></i>&nbsp;&nbsp;&nbsp;상담 일지</h5>
						
					</div>

					

				</div>
			</div>
		</section>
		<div class="card-header with-border">
              	  <span class="badge bg-primary" style="font-size:1.2em;">상담 완료 내역</span>
			<div id="keyword" class="card-tools"
				style="width:300px; float: right;">
				<div class="input-group">

					<select class="form-control col-md-3" name="perPageNum"
						id="perPageNum" onchange="list_go(1);" style='display:none;'>
						<option value="10" ${cri.perPageNum==10 ? 'selected':'' }>정렬개수</option>
						<option value="20" ${cri.perPageNum==20 ? 'selected':'' }>20개씩</option>
						<option value="30" ${cri.perPageNum==30 ? 'selected':'' }>30개씩</option>
						<option value="50" ${cri.perPageNum==50 ? 'selected':'' }>50개씩</option>

					</select> <select class="form-select col-md-3" name="searchType"
						id="searchType">
						<option value="a" ${cri.searchType eq 'a' ? 'selected':'' }>전
							체</option>
						<option value="b" ${cri.searchType eq 'b' ? 'selected':'' }>구분</option>
						<option value="c" ${cri.searchType eq 'c' ? 'selected':'' }>신청자</option>
						<option value="d" ${cri.searchType eq 'd' ? 'selected':'' }>상담일</option>


					</select> <input class="form-control" type="text" style="width: 100px;"
						name="keyword" placeholder="검색어를 입력하세요" value="${cri.keyword }" />
					<span class="input-group-append">
						<button class="btn btn-primary" style="float: right;"
							type="button" id="searchBtn" data-card-widget="search4"
							onclick="list_go(1);">
							<i class="fa fa-fw fa-search"></i>
						</button>
					</span>
				</div>
			</div>
		</div>
		<div class="card-body" style="padding:0px;">
			<table class="table table-bordered text-center  table-hover ">
			  <thead>
				<tr style="font-size: 0.95em; background-color:#038edc;color:white;">
					
					<th style="width: 8%;">상담일</th>
					<th style="width: 5%;">상담 구분</th>
					<th style="width: 6%;">원생 이름</th>
					<th style="width: 6%;">상담 신청자</th>
					<th style="width: 6%;">일지 작성 여부</th>

				</tr>
				</thead>
			<c:if test="${!empty counseltEndList }">
							<c:forEach items="${counseltEndList }" var="coue">
							 
								<tr class="table-white" style="font-size: 0.8em;" onclick="conenddetail_go(this)">
								 	 <td style="display:none;"><input type="hidden" name="pcCode" value="${coue.pcCode }" ></td>
								 	 
								 	 <td style="font-size:;"><fmt:formatDate pattern="yyyy/MM/dd " value="${coue.meetDate}" /></td>
									<td style="font-size:;">${coue.purpose}</td>
									<td style="font-size:;">${coue.name}</td>
									<td style="font-size:;">부모님</td>
									
									
									<td><c:if test="${!empty coue.result }">
									   
									<h5><span class="badge bg-primary">완료</span></h5>
									</c:if>
									<c:if test="${empty coue.result }">
									<h5><span class="badge bg-danger">미완료</span></h5>
									</c:if>
									</td>
									
								</tr>
							</c:forEach>

						</c:if>
						<c:if test="${empty counseltEndList }">
						
							
							<td colspan='6'>상담 일지 리스트가 없습니다.</td>
							
							
							
							</c:if>
						
						
						

			

			</table>
		</div>
		<div class="card-footer">
			<nav aria-label="pds list Navigation">
				<ul class="pagination justify-content-center m-0">
					<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
				</ul>
			</nav>
		</div>
	</div>




	<!-- Main content -->

	<div class="card">
		<div class="card-header with-border">
				  <span class="badge bg-primary" style="font-size:1.2em;">상담 신청 상세 내용</span>

			<button type="button" class="btn btn-primary" style="float: right;"
				id="deleteBtn" onclick="consultresult_go(this)">저장</button>


			<div id="keyword" class="card-tools"
				style="width: 450px; float: right;">
				<div class="input-group"></div>
			</div>
		</div>
		<div class="card-body" style="padding:0px;">
			<table class="table table-bordered text-center   ">
  	
				
				<tr class="table-white">
					<th style="width: 10%; font-size: 0.8em; background-color:#038edc;color:white;" >상담구분</th>
					<th style="width: 13%;" class="conpur"></th>
					<th style="width: 8%; font-size: 0.8em; background-color:#038edc;color:white;" >상담일</th>
					<th style="width: 13%;"class="conmeetdate"></th>
					<th style="width: 10%; font-size: 0.8em; background-color:#038edc;color:white;" >상담시간</th>
					<th colspan='3' class="contime"></th>
					<td id="hidden" style="display:none;" class="pccode"></td>
					<td id="hidden2" style="display:none;" class="client"></td>
					
						<c:if test="${!empty counseltEndList }">
							<c:forEach items="${counseltEndList }" var="coue">
					<td style="display:none;"><input type='hidden' name="content" value="${coue.content}" ></td>
						<td style="display:none;"><input type='hidden' name="result" value="${coue.result}" ></td>
						<td style="display:none;"><input type='hidden' name="pcCode" value="${coue.pcCode}" ></td>
					</c:forEach>
					</c:if>



				</tr>
				<tr class="table-white">

					<th class="table-primary" style="font-size: 0.8em; background-color:#038edc;color:white;">신청자</th>
					<th class="conname"></th>
					<th class="table-primary" style="font-size: 0.8em; background-color:#038edc;color:white;">연락처</th>
					<th class="conphone"></th>
					<th class="table-primary" style="font-size: 0.8em;  padding:3px; background-color:#038edc;color:white;"><br>신청 대상자</th>
					<th>부모님</th>
					<th class="table-primary" style="font-size: 0.8em; background-color:#038edc;color:white;">연락처</th>
					<th class="conpaphone"></th>
                  



				</tr>
				<tr class="table-white">
					<th class="table-primary" style="font-size: 0.8em; background-color:#038edc;color:white; ">학교</th>
					<th class="conschool"></th>
					<th class="table-primary" style="font-size: 0.8em; background-color:#038edc;color:white;">학년</th>
					<th class="congrade"></th>
					<th class="table-primary" style="font-size: 0.8em; background-color:#038edc;color:white;" rowspan='2'><br><br><br>후속조치</th>
					<th colspan='3' rowspan='2' ><textarea class="result"
							placeholder="내용을 입력하세요" id="floatingTextarea2"
							style="height: 150px; width:420px;" ></textarea></th>
					

				</tr>

				<tr class="table-white">
					<th class="table-primary" style="font-size: 0.8em; background-color:#038edc;color:white;"><br><br>상담내용</th>
					<th colspan='3' class="content" style="text-align:left;"></th>









				</tr>





			</table>
		</div>

	</div>


	<c:if test="${from eq 'regist' }">
		<script>
			alert("등록되었습니다.");
			window.close();
			window.opener.location.reload();
		</script>
	</c:if>


<script>
  function conenddetail_go(conde){
	  
	  console.log(conde);
	  
	  //alert($(this).find("td:eq(0)").text());
	  //var client=conde.value;
	 //var content = conde.children[0].value;
	 //console.log(content);
	 //var result=$('input[name=result]').value;
	 //console.log(result);
	 // console.log(pcCode);

	  var pcCode = conde.children[0].children[0].value;
	  console.log(pcCode);
	    
	   var client=$('.client');
	   client.empty();
		var pccode=$('.pccode');
		pccode.empty();
		var conpur = $('.conpur');
		conpur.empty();
		var conmeetdate = $('.conmeetdate');
		conmeetdate.empty();
		var contime = $('.contime');
		contime.empty();
		var conname = $('.conname');
		conname.empty();
		var conphone = $('.conphone');
		conphone.empty();
		var conpaphone = $('.conpaphone');
		conpaphone.empty();
		var conschool = $('.conschool');
		conschool.empty();
		var congrade = $('.congrade');
		congrade.empty();
		
		var result = $('.result');
		result.empty();
		var content = $('.content');
		content.empty();
		 $.ajax({
			url : "conenddetail.go",
			type : "POST",
			data : {
				"pcCode" :pcCode
			},
			success : function(data) {
				
				//상담 목적
				var new_purpose;
				if(data.purpose==null){
					new_purpose="-";
				}else{
					new_purpose=data.purpose;
				}
				conpur.text(new_purpose);
				//학교
				var new_schoolName;
				if(data.schoolName==null){
					new_schoolName="-";
				}else {
					new_schoolName=data.schoolName;
				}
				conschool.text(new_schoolName);
				
				//성적
				var new_grade;
				if(data.grade==null){
					new_grade="-";
				}else{
					new_grade=data.grade;
				}congrade.text(new_grade);
				
				//내용
				var new_content;
				if(data.content==null){
					new_content="상담 내용이 존재하지 않습니다";
				}else{
					new_content=data.content;
				}content.text(new_content);
				
				//원생전화번호
				var new_phone;
				if(data.phone==null){
					new_phone="-";
				}else{
					new_phone=data.phone;
				}conphone.text(new_phone);
				
				//부모님전화번호
				var new_parentphone;
				if(data.parentPhone==null){
					new_parentphone="-";
				}else{
					new_parentphone=data.parentPhone;
				}conpaphone.text(new_parentphone);
				
				
				
				var da=timegogogo(data.meetDate);
				var dt=time(data.pcStart);
				var dq=time2(data.pcEnd);
				console.log(data);
				//conpur.text(data.purpose);
				conmeetdate.text(da);
 				//contime.text(data.pcStart)~contime.text(data.pcEnd);
				conname.text(data.name);
				
				//부모님 이름 
				
				
				//conpaphone.text(data.parentPhone);
				//conphone.text(data.phone);
				//conschool.text(data.schoolName);
				//congrade.text(data.grade);
				contime.text(dt+dq);
				pccode.text(data.pcCode);
				//content.text(data.content);
				result.text(data.result);
				client.text(data.client);
				
			
				
				
			},
			error : function() {
				//alert("err");
			},
			dataType : "json"
		}); 
	  
  }


</script>

<script>
	 function consultresult_go(con) {
			 
		
		 
		 //var pc = con.children[0].children[0].value;
		//console.log(pc);
		 
		 var pcCode = $('.pccode').text();
		 
		 //var client=$('.client').text();
		 
		 	 
	 //var result=$('input[name=result]').val();
	 
	 //console.log(result);
	 
	 //var content=$('input[name=content]').val();
	 //console.log(content);
		 
		 
		 var result=$('.result').val();
		 var content=$('.content').val();
		 console.log(pcCode);
		 console.log(result);
		 console.log(content);
		
		
		 
		 var param = {"result":result,"content":content,"pcCode":pcCode}
		
// 			var id=$('td eq:0',stuid).val();
// 			console.log(id);
			//var id = $('input[name="id"]').val(); 
			
			/*   var id= $(stuid).find('id');
			console.log(id); */			
	
			Swal.fire({
			      icon: 'success',
			      title: '저장 되었습니다.'
			      
			    }).then((result) => {
				  if (result.value) {
						$.ajax({
							url : "registconend.go",
							type : "POST",
							contentType: 'application/json',
							data : JSON.stringify(param),
							success : function(data) {
								//alert("저장되었습니다.");
								
								window.location.reload();
								 
								
							},
							error : function(error) {
								//alert("error : " + error.status);
							},
							dataType:'json'
							
						});
						
				  }
				})
		}
	 </script>

<script>
	function timegogogo(timeValue){ //Handlbars에 날짜출력함수 등록
     var dateObj=new Date(timeValue);
     var year=dateObj.getFullYear();
     var month=dateObj.getMonth()+1;
     if(month<10){
    	 month="0"+month;
     }
   
     var date=dateObj.getDate();
     if(date<10){
    	 date="0"+date;
     }
  
     return year+"/"+month+"/"+date;


}
</script>

<script>
    //시분 변환
	function time(timeValue){ 
     var dateObj=new Date(timeValue);
     var hour=dateObj.getHours();
     var minutes=dateObj.getMinutes();
    
     return hour+":"+minutes+0+'~';


}
</script>


<script>
    //시분 변환
	function time2(timeValue){ 
     var dateObj=new Date(timeValue);
     var hour=dateObj.getHours();
     var minutes=dateObj.getMinutes();
    
     return hour+":"+minutes+0;


}
</script>
	
	

</body>