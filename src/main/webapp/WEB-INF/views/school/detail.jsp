<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=920b14d2add732f9bc7f785681c1a295&libraries=services"></script>
	<script src="<%=request.getContextPath() %>/resources/js/kakaoMap.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
</head>
<body>
<div class="row">
	<div class="col-md-12" style="margin-top: 20px;">
		<div class="col-sm-12">
			<button type="button" style=""class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#schoolRegistModal">등록</button>
			<button onclick="removeSchool();" type="button" class="btn btn-danger"style="">삭제</button>
		</div>
		<!-- 등록 Modal 시작-->
				<div class="modal fade" id="schoolRegistModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header" style="background-color: #038edc;">
				        <h5 class="modal-title" id="staticBackdropLabel" style=" color: white;">학교 등록</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      
				      <div class="modal-body">
						<div class="row">
						  <div class="col-sm-12">
						  	<span>학교명</span>
						    <input type="text" class="form-control" id="schoolName" placeholder="학교명을 입력하세요">
						  </div>
						  <div class="col-sm-9">
						  	<span>주소</span>
						    <input type="text" class="form-control" id="sample4_roadAddress" placeholder="도로명주소" readonly>
						  </div>
						  <div class="col-sm-3" style="margin:auto;">
							<input type="button" style="margin-top: 17px;border-radius: 0.25rem;"onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="btn-soft-primary">
						  </div>
						  <div class="col-sm-12">
						  	<span>홈페이지</span>
						    <input type="text" id="schoolUrl" class="form-control" placeholder="학교 홈페이지 url을 입력하세요">
						  </div>
						  <div class="col">
						  	<span>학교등급</span>
							<select class="form-control" id="schoolRank">
								<option>등급</option>
								<option value="A">A</option>
								<option value="B">B</option>
								<option value="C">C</option>
							</select>
						  </div>
						  <div class="col">
						  	<span>학교구분</span>
							<select class="form-control" id="schoolGender">
								<option>구분</option>
								<option value="남녀공학">남녀공학</option>
								<option value="남고">남고</option>
								<option value="여고">여고</option>
							</select>
						  </div>
						</div>
				      </div>
				      
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <button type="button" onclick="registSchool();" class="btn btn-primary">등록</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 등록 모달 끝!!! -->
				
		<div id="map" style="padding:30px;height:350px;"></div>
		<table class="table" style="margin-top:5px;text-align: center;padding:10px;">
			<tbody id="schoolDetail">
			<tr>
				<td style="background-color:#038edc;color:white;">기관명</td>
				<td>${school.schoolName }</td>
			</tr>
			<tr>
				<td style="background-color:#038edc;color:white;">주소</td>
				<td>${school.schoolAddress }</td>
			</tr>
			<tr>
				<td style="background-color:#038edc;color:white;">홈페이지</td>
				<td><a href="javascript:OpenWindow('${school.schoolUrl }','학교 홈페이지','800','900')">${school.schoolUrl }</a></td>
			</tr>
			<tr>
				<td style="background-color:#038edc;color:white;">구분</td>
				<td>${school.schoolGender }</td>
			</tr>
			<tr>
				<td style="background-color:#038edc;color:white;">등급</td>
				<td>${school.schoolRank }</td>
			</tr>
			</tbody>
		</table>
	</div>
	
	
</div>
<head>
<script>
window.onload = function(){
	var address="${school.schoolAddress}";
	var name="${school.schoolName}";
	console.log(address);
	console.log(name);
	setSchoolMap(address, name);
}
</script>
<script>
	//학교 등록 요청을 하는 메서드
	function registSchool(){
		var schoolName = $('#schoolName').val();
		var schoolAddress=$('#sample4_roadAddress').val();
		var schoolUrl = $('#schoolUrl').val();
		var schoolRank = $('#schoolRank').val();
		var schoolGender = $('#schoolGender').val();
		
		console.log(schoolName);
		console.log(schoolAddress);
		console.log(schoolUrl);
		
		if(!schoolName){
			alert("학교명 입력은 필수입니다.");
			return;
		}
		if(!schoolAddress){
			alert("주소 입력은 필수입니다.");
			return;
		}
		if(!schoolUrl){
			alert("학교 URL 입력은 필수입니다.");
			return;
		}
		if(schoolRank=="등급"){
			alert("학교등급 선택은 필수입니다.");
			return;
		}
		if(schoolGender=="구분"){
			alert("학교구분 선택은 필수입니다.");
			return;
		}
		
		var schoolVO = {
				"schoolName":schoolName,
				"schoolAddress":schoolAddress,
				"schoolUrl":schoolUrl,
				"schoolRank":schoolRank,
				"schoolGender":schoolGender
			};
		
	
			
		Swal.fire({
			  icon: 'success',
		      title: '등록되었습니다.'
			}).then((result) => {
			  if (result.value) {
					$.ajax({
						url:"regist.go",
						data:JSON.stringify(schoolVO),
						contentType:"application/json",
						method:"post",
						success:function(data){
							
						},
						error:function(error){
							//alert("등록에 실패했습니다.")
						},
						dataType:"json"
					});
			  }
			})
		
	}
	</script>

	<script>
	//학교 삭제 요청을 하는 메서드
	function removeSchool(){
		var schoolCode = $('#schoolCodeForDelete').text();
		console.log(schoolCode);
		if(schoolCode){
			$.ajax({
				url:"remove.go",
				data:{"schoolCode":schoolCode},
				method:"post",
				success:function(data){
					alert("삭제를 성공하였습니다!");
					Location.reload();
				},
				error:function(error){
					alert("삭제가 불가합니다.")
				},
				dataType:"json"
			});
		}else{
			alert("삭제할 수 없습니다.");
		}
	}
	
	</script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample4_roadAddress").value = roadAddr;
                
                var guideTextBox = document.getElementById("guide");
            }
        }).open();
    }
</script>
</head>
</body>
