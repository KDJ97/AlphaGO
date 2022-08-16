<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="classList" value="${dataMap.classList }" />
<c:set var="unregiClassList" value="${dataMap2.unregisteredClassList }" />
<c:set var="cri" value="${dataMap.cri }" />
<c:set var="cri2" value="${dataMap2.cri }" />

<head>

<script>
function pc(t){
	$('#ff').val($(t).attr("id"));
}
</script>
<!-- ----------------------------------------------------------------------------------------------------------------------------------------  -->
<!-- ----------------------------------------------------------------------------------------------------------------------------------------  -->
<!-- ----------------------------------------------------------------------------------------------------------------------------------------  -->
<script>
function search_go(){
	var keyword1 = document.getElementById('keyword1').value;
	var keyword2 = document.getElementById('keyword2').value;
	
	console.log(keyword1);
	
	//url을 바꿔준다
	window.history.replaceState("test", null, "list.go?keyword="+keyword1+"&keyword2="+keyword2);
	
	
	if(keyword1 == null || keyword1 ==""){
		alert("검색할 수업을 입력하세요");
	}
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/searchList.go",
		method:"GET",
		data:{
			"keyword":keyword1
		},
		dataType:"json",
		success:function(res){
			str="";
			if(res.classList==null){
				str+='	<tr>';
				str+='		<td colspan="6"><strong>해당 내용이 없습니다.</strong></td>';
				str+='	</tr>';
			}else{
				$.each(res.classList,function(i,v){
					str+='	<tr id="' + v.classCode + '" class="regiTr" onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200);  style="font-size:0.85em;cursor:pointer;text-align:left;">';
					str+='		<td>' + v.classCode + '</td>';
					str+='		<td>' + v.subjectName + '</td>';
					str+='		<td>' + v.classRank + '</td>';
					str+='		<td>' + v.className + '</td>';
					str+='		<td>' + v.startDate.substring(0,10) + '</td>';
					str+='		<td>' + v.endDate.substring(0,10) + '</td>';
					str+='	</tr>';
				})
			}
		$('#classTbody').html(str);
		},
		error:function(error){
			alert("검색 실패ㅠㅠ");
		}
	});
	
}
</script>
<script>
function search_go2(){
	
	var keyword2 = document.getElementById('keyword2').value;
	var keyword1 = document.getElementById('keyword1').value;
	
	console.log(keyword2);
	
	var cpType = $('#cpType option:selected').val();
	
	
	//url을 바꿔준다
	window.history.replaceState("test", null, "list.go?keyword="+keyword1+"&keyword2="+keyword2);
	
	if(keyword2 == null || keyword2 ==""){
		alert("검색할 수업을 입력하세요");
	}
	
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/searchList2.go",
		method:"GET",
		data:{
			"keyword":keyword2,
			"cpType":cpType
		},
		dataType:"json",
		success:function(res){
			
			str="";
			if(res.unregisteredClassList==null){
				str+='	<tr>';
				str+='		<td colspan="7"><strong>해당 내용이 없습니다.</strong></td>';
				str+='	</tr>';
			}else{
				$.each(res.unregisteredClassList,function(i,v){
					str+='	<tr onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="font-size:0.85em;">';
					str+='		<td>' + v.classCode + '</td>';
					str+='		<td>' + v.subjectName + '</td>';
					str+='		<td>' + v.classRank + '</td>';
					str+='		<td style="text-align:left;">' + v.className + '</td>';
					str+='		<td>' + v.startDate.substring(0,10) + '</td>';
					str+='		<td>' + v.endDate.substring(0,10) + '</td>';
					str+='		<td>';
					if(v.cpcheck=='미제출'){
						str+='<button onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="height: 20px; line-height: 0px;" class="btn btn-danger sibal" id="'+v.classCode+'">'+v.cpcheck+'</button>';
					}
					if(v.cpcheck=='제출'){
						str+='<button onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="height: 20px; line-height: 0px;" class="btn btn-primary sibal" id="'+v.classCode+'">'+v.cpcheck+'</button>';
					}
					if(v.cpcheck=='반려'){
						str+='<button onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="height: 20px; line-height: 0px;" class="btn btn-success sibal" id="'+v.classCode+'">'+v.cpcheck+'</button>';
					}
					if(v.cpcheck=='승인'){
						str+='<button onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="height: 20px; line-height: 0px;" class="btn btn-secondary sibal" id="'+v.classCode+'">'+v.cpcheck+'</button>';
					}
					if(v.cpcheck=='임시저장'){
						str+='<button onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="height: 20px; line-height: 0px;" class="btn btn-warning sibal" id="'+v.classCode+'">'+v.cpcheck+'</button>';
					}
					
					str+='		</td>';
					str+='	</tr>';
				})
			}
		$('#unregiClassTbody').html(str);
		},
		error:function(error){
			alert("검색 실패ㅠㅠ");
		}
	});
}
</script>
<script>
//cpcheck select박스 바꿀때
$('#cpType').change(function(){
	var cpType = $('#cpType option:selected').val();
	$.ajax({
		url:"<%=request.getContextPath()%>/tclass/searchList2.go",
		method:"GET",
		data:{
			"cpType":cpType
		},
		dataType:"json",
		success:function(res){
			str="";
			if(res.unregisteredClassList==null){
				str+='	<tr>';
				str+='		<td colspan="7"><strong>해당 내용이 없습니다.</strong></td>';
				str+='	</tr>';
			}else{
				$.each(res.unregisteredClassList,function(i,v){
					str+='	<tr onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="font-size:0.85em;">';
					str+='		<td>' + v.classCode + '</td>';
					str+='		<td>' + v.subjectName + '</td>';
					str+='		<td>' + v.classRank + '</td>';
					str+='		<td style="text-align:left;">' + v.className + '</td>';
					str+='		<td>' + v.startDate.substring(0,10) + '</td>';
					str+='		<td>' + v.endDate.substring(0,10) + '</td>';
					str+='		<td>';
					if(v.cpcheck=='미제출'){
						str+='<button onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="height: 20px; line-height: 0px;" class="btn btn-danger sibal" id="'+v.classCode+'">'+v.cpcheck+'</button>';
					}
					if(v.cpcheck=='제출'){
						str+='<button onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="height: 20px; line-height: 0px;" class="btn btn-primary sibal" id="'+v.classCode+'">'+v.cpcheck+'</button>';
					}
					if(v.cpcheck=='반려'){
						str+='<button onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="height: 20px; line-height: 0px;" class="btn btn-success sibal" id="'+v.classCode+'">'+v.cpcheck+'</button>';
					}
					if(v.cpcheck=='승인'){
						str+='<button onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="height: 20px; line-height: 0px;" class="btn btn-secondary sibal" id="'+v.classCode+'">'+v.cpcheck+'</button>';
					}
					if(v.cpcheck=='임시저장'){
						str+='<button onclick=OpenWindow("ingDetail.go?classCode='+v.classCode+'","수업계획서",1000,1200); style="height: 20px; line-height: 0px;" class="btn btn-warning sibal" id="'+v.classCode+'">'+v.cpcheck+'</button>';
					}
					
					str+='		</td>';
					str+='	</tr>';
				})
			}
		$('#unregiClassTbody').html(str);
		},
		error:function(error){
			alert("검색 실패ㅠㅠ");
		}
	});
})

</script>
<!-- ----------------------------------------------------------------------------------------------------------------------------------------  -->
<!-- ----------------------------------------------------------------------------------------------------------------------------------------  -->
<!-- ----------------------------------------------------------------------------------------------------------------------------------------  -->



</head>

<title>수업계획서</title>

<body>
	<input type="hidden" id="tt">
	<div class="card">
		<section class="content-header">
			<div class="container-fluid">
				<div class="row md-2">
					<div class="col-sm-6">
						<h5 style="margin-bottom: 15px; font-weight: bold; margin-top:20px; margin-left:10px;">
							<i class="uil-book-open" style="margin-right: 10px;"></i>수업계획서
						</h5>
					</div>
					<div class="col-sm-6">
						<ol style="float: right; margin: 20px;"
							class="breadcrumb float-sm-right">
							<li class="breadcrumb-item"><a href="list.go"> <i
									class="fa fa-dashboard"></i>수업관리
							</a></li>
							<li class="breadcrumb-item active">수업계획서관리</li>
						</ol>
					</div>
				</div>
			</div>
		</section>
		<hr style="margin-top:0px;">
		<div id="keyword" class="card-tools" style="">
			<div class="col-md-3" style="float: left;">
				<span style="margin: 10px 0px 0px 20px; margin-bottom: 5px; font-size: 15px;"
					class="badge bg-success">진행중인 수업목록</span>
			</div>
			<div class="col-md-9" style="float: right;">

				<span style="float: right;" class="input-group-append">
					<button style="margin-right: 20px;" style="margin-left:20px;"
						class="btn btn-primary" type="button" onclick="search_go();"
						data-card-widget="search">
						<i class="fa fa-fw fa-search"></i>
					</button>
				</span> <input class="form-control col-sm-6"
					style="width: 150px; float: right;" type="text" name="keyword"
					placeholder="수업명으로 검색" id="keyword1" value="${cri.keyword }" />
			</div>
		</div>
		<div class="card-body"
			style="height: 250px; overflow: auto; padding-top: 5px;">
			<table class="table table text-center">
				<thead>
					<tr style="font-weight: bold; border-top:2px solid #8BDDA8;border-bottom:2px solid #8BDDA8;">
						<th style="width: 6%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">번 호</th>
						<th style="width: 6%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">과목</th>
						<th style="width: 6%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">Rank</th>
						<th style="width: 52%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">수업명</th>
						<th style="width: 10%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">시작일</th>
						<th style="width: 10%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">종료일</th>
					</tr>
				</thead>
				<tbody id="classTbody">
					<c:if test="${empty classList }">
						<tr>
							<td colspan="6"><strong>해당 내용이 없습니다.</strong></td>
						</tr>
					</c:if>
					<c:forEach items="${classList }" var="classes">
						<tr id="regi${classes.classCode }" class="regiTr" onclick="OpenWindow('ingDetail.go?classCode=${classes.classCode}','수업계획서',1000,1200);"  style='font-size: 0.85em; cursor: pointer;'>
							<td class="regiTd">
							${classes.classCode }
							<input type="hidden" id="ff" />
							</td>
							<td>${classes.subjectName }</td>
							<td>${classes.classRank }</td>
							<td style="text-align: left;">${classes.className }</td>
							<td>${fn:substring(classes.startDate,0,10) }</td>
							<td>${fn:substring(classes.endDate,0,10) }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<hr>

		<div id="keyword" class="card-tools" style="">
			<div class="col-md-3" style="float: left;">
				<span style="margin: 10px 0px 0px 20px; font-size: 15px;"
					class="badge bg-success">미등록 수업목록</span>
			</div>
			<div class="col-md-9" style="float: right;">

				<span style="float: right;" class="input-group-append">
					<button style="margin-right: 20px;" style="margin-left:20px;"
						class="btn btn-primary" type="button" onclick="search_go2();"
						data-card-widget="search">
						<i class="fa fa-fw fa-search"></i>
					</button>
				</span> <input class="form-control col-sm-6" style="width: 150px; float: right;" type="text" name="keyword2"
					id="keyword2" placeholder="수업명으로 검색" value="${cri2.keyword }" />
					<select id="cpType" name="cpType" class="form-select" style="width: 100px; float: right;">
						<option value="전체" ${cri2.cpcheck eq '전체' ? 'selected':'' }>전체</option>
						<option value="0" ${cri2.cpcheck eq '미제출' ? 'selected':'' }>미제출</option>
						<option value="1" ${cri2.cpcheck eq '제출' ? 'selected':'' }>제출</option>
						<option value="2" ${cri2.cpcheck eq '반려' ? 'selected':'' }>반려</option>
						<option value="4" ${cri2.cpcheck eq '임시저장' ? 'selected':'' }>임시저장</option>
					</select>
			</div>
		</div>
		<div class="card-body"
			style="height: 250px; padding-top: 5px; overflow: auto;">
			<table id="ttt" class="table table text-center">
				<thead>
					<tr style="border-top:2px solid #8BDDA8;border-bottom:2px solid #8BDDA8;">
						<th style="width: 6%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">번호</th>
						<th style="width: 6%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">과목</th>
						<th style="width: 6%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">Rank</th>
						<th style="width: 47%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">수업명</th>
						<th style="width: 10%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">시작일</th>
						<th style="width: 10%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">종료일</th>
						<th style="width: 13%; font-weight: bold; padding-top: 8px; padding-bottom: 8px;">수업계획서</th>
					</tr>
				</thead>
				<tbody id="unregiClassTbody">
					<c:if test="${empty unregiClassList }">
						<tr>
							<td colspan="7"><strong>해당 내용이 없습니다.</strong></td>
						</tr>
					</c:if>
					<c:forEach items="${unregiClassList }" var="unregiClass"
						varStatus="i">
						<tr onclick="OpenWindow('ingDetail.go?classCode=${unregiClass.classCode}','수업계획서',1000,1200);" style="font-size: 0.85em;cursor: pointer;">
							<td>${unregiClass.classCode }</td>
							<td>${unregiClass.subjectName }</td>
							<td>${unregiClass.classRank }</td>
							<td style="text-align: left;">${unregiClass.className }</td>
							<td>${fn:substring(unregiClass.startDate,0,10) }</td>
							<td>${fn:substring(unregiClass.endDate,0,10) }</td>
							<td>
							<input id="unregiClassCode" type="hidden" value="${unregiClass.classCode }" />
							<c:if test="${unregiClass.cpcheck eq '미제출' }">
								<button onclick="OpenWindow('ingDetail.go?classCode=${unregiClass.classCode}','수업계획서',1000,1200);" style="height: 20px; line-height: 0px;" class="btn btn-danger sibal" id="${unregiClass.classCode }">${unregiClass.cpcheck }</button>
							</c:if>
							<c:if test="${unregiClass.cpcheck eq '제출' }">
								<button onclick="OpenWindow('ingDetail.go?classCode=${unregiClass.classCode}','수업계획서',1000,1200);" style="height: 20px; line-height: 0px;" class="btn btn-primary sibal" id="${unregiClass.classCode }">${unregiClass.cpcheck }</button>
							</c:if>
							<c:if test="${unregiClass.cpcheck eq '반려' }">
								<button onclick="OpenWindow('ingDetail.go?classCode=${unregiClass.classCode}','수업계획서',1000,1200);" style="height: 20px; line-height: 0px;" class="btn btn-success sibal" id="${unregiClass.classCode }">${unregiClass.cpcheck }</button>
							</c:if>
							<c:if test="${unregiClass.cpcheck eq '승인' }">
								<button onclick="OpenWindow('ingDetail.go?classCode=${unregiClass.classCode}','수업계획서',1000,1200);" style="height: 20px; line-height: 0px;" class="btn btn-secondary sibal" id="${unregiClass.classCode }">${unregiClass.cpcheck }</button>
							</c:if>
							<c:if test="${unregiClass.cpcheck eq '임시저장' }">
								<button onclick="OpenWindow('ingDetail.go?classCode=${unregiClass.classCode}','수업계획서',1000,1200);" style="height: 20px; line-height: 0px;" class="btn btn-warning sibal" id="${unregiClass.classCode }">${unregiClass.cpcheck }</button>
							</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="card-footer">
			
		</div>

	</div>

	<!-- Modal 진행중인 수업목록 수업계획서 수정-->
<!-- 	<div class="modal fade" id="classTr" tabindex="-1" -->
<!-- 		aria-labelledby="exampleModalLabel" aria-hidden="true"> -->
<!-- 		<div class="modal-dialog modal-lg modal-dialog-scrollable"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				<div class="modal-header"> -->
<!-- 					<h5 class="modal-title" id="exampleModalLabel">수업계획서</h5> -->
<!-- 					<button type="button" class="btn-close" data-bs-dismiss="modal" -->
<!-- 						aria-label="Close"></button> -->
<!-- 				</div> -->
<!-- 				<div class="modal-body" id="regiModal"> -->
<!-- 					<div id="regiTable1"></div> -->

<!-- 					<table id="regiTable2" class="table table-bordered text-center"> -->

<!-- 					</table> -->

<!-- 					<div id="regiTable3"></div> -->

<!-- 					<div id="registed"></div> -->

<!-- 					<div id="registedHW"></div> -->

<!-- 				</div> -->
<!-- 				<div class="modal-footer"> -->
<!-- 					<button id="modifyBtn" type="button" class="btn btn-primary">수정</button> -->
<!-- 					<button type="button" class="btn btn-secondary" -->
<!-- 						data-bs-dismiss="modal" id="modalClose1">닫기</button> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->

	<!-- Modal 미등록 수업계획서 등록 -->
<!-- 	<div class="modal fade" id="insertBtn" tabindex="-1" -->
<!-- 		aria-labelledby="exampleModalLabel" aria-hidden="true"> -->
<!-- 		<div class="modal-dialog modal-lg modal-dialog-scrollable"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				<div class="modal-header"> -->
<!-- 					<h5 class="modal-title" id="exampleModalLabel">수업계획서</h5> -->
<!-- 					<button type="button" class="btn-close" data-bs-dismiss="modal" -->
<!-- 						aria-label="Close"></button> -->
<!-- 				</div> -->
<!-- 				<div class="modal-body"> -->
<!-- 					<table id="unregiTable1" style="height: 10px;" -->
<!-- 						class="table table-bordered text-center"> -->

<!-- 					</table> -->
<!-- 					<table id="unregiTable2" class="table table-bordered text-center"> -->

<!-- 					</table> -->
<!-- 					<table class="table table-bordered text-center"> -->
<!-- 						<tr> -->
<!-- 							<td style="background-color: #8BDDA8; font-weight: bold;">교재</td> -->
<!-- 							<td><input class="tbClass" -->
<!-- 								style="text-align: left; width: 99%;" type="text" value=""></td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td -->
<!-- 								style="background-color: #8BDDA8; font-weight: bold; padding-top: 55px;">수업개요</td> -->
<!-- 							<td style="text-align: left;"><textarea class="cpheadClass" -->
<!-- 									rows="5" cols="91%"></textarea></td> -->
<!-- 						</tr> -->
<!-- 					</table> -->
<!-- 					<table id="unregisted" style="height: 20px;" -->
<!-- 						class="table table-bordered text-center"> -->
<!-- 						<tr style="height: 20px;"> -->
<!-- 							<th -->
<!-- 								style="width: 10%; background-color: #8BDDA8; font-weight: bold;">주차</th> -->
<!-- 							<th -->
<!-- 								style="width: 90%; background-color: #8BDDA8; font-weight: bold;">수업계획 -->
<!-- 								<button onclick="addRow3();" -->
<!-- 									style="float: right; height: 25px; line-height: 0px; text-align: center; margin-right: 5px;" -->
<!-- 									class="btn btn-secondary">추가</button> -->
<!-- 							</th> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td><input class="weekClass" type="text" -->
<!-- 								style="width: 30px;" -->
<!-- 								onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" /></td> -->
<!-- 							<td><textarea class="cpClass" rows="1" cols="85%"></textarea> -->
<!-- 								<button class="btn btn-secondary wxbt" -->
<!-- 									style="float: right; height: 25px; line-height: 0px; text-align: center;">X</button> -->
<!-- 							</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td><input class="weekClass" type="text" -->
<!-- 								style="width: 30px;" -->
<!-- 								onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" /></td> -->
<!-- 							<td><textarea class="cpClass" rows="1" cols="85%"></textarea> -->
<!-- 								<button class="btn btn-secondary wxbt" -->
<!-- 									style="float: right; height: 25px; line-height: 0px; text-align: center;">X</button> -->
<!-- 							</td> -->
<!-- 						</tr> -->
<!-- 					</table> -->
<!-- 					<table id="unregistedHW" class="table table-bordered text-center"> -->
<!-- 						<tr> -->
<!-- 							<th -->
<!-- 								style="width: 10%; background-color: #8BDDA8; font-weight: bold;">No</th> -->
<!-- 							<th -->
<!-- 								style="width: 90%; background-color: #8BDDA8; font-weight: bold;">과제계획 -->
<!-- 								<button onclick="addRow4();" -->
<!-- 									style="float: right; height: 25px; line-height: 0px; text-align: center; margin-right: 5px;" -->
<!-- 									class="btn btn-secondary">추가</button> -->
<!-- 							</th> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td><input class="hwnoClass" type="text" -->
<!-- 								style="width: 30px;" -->
<!-- 								onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" /></td> -->
<!-- 							<td><textarea class="hwPlanClass" rows="1" cols="85%"></textarea> -->
<!-- 								<button class="btn btn-secondary wxbt" -->
<!-- 									style="float: right; height: 25px; line-height: 0px; text-align: center;">X</button> -->
<!-- 							</td> -->
<!-- 						</tr> -->
<!-- 						<tr> -->
<!-- 							<td><input class="hwnoClass" type="text" -->
<!-- 								style="width: 30px;" -->
<!-- 								onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" /></td> -->
<!-- 							<td><textarea class="hwPlanClass" rows="1" cols="85%"></textarea> -->
<!-- 								<button class="btn btn-secondary wxbt" -->
<!-- 									style="float: right; height: 25px; line-height: 0px; text-align: center;">X</button> -->
<!-- 							</td> -->
<!-- 						</tr> -->
<!-- 					</table> -->
<!-- 				</div> -->
<!-- 				<div id="unregiModalfooter" class="modal-footer"> -->
<!-- 					<button type="button" class="btn btn-primary" id="regiCPbtn">등록</button> -->
<!-- 					<button type="button" class="btn btn-secondary" -->
<!-- 						data-bs-dismiss="modal" id="closebtn">닫기</button> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->


	<c:if test="${from eq 'regist' }">
		<script>
	alert("건의글 등록이 성공했습니다.");
	window.opener.location.reload();
	window.close();
</script>
	</c:if>

</body>






