<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="member" value="${member2 }" />
<c:set var="careerVOList" value="${careerVOList }" />

<head>
<script>
function ProblemPictureThumb(contextPath){
	
	 for(var target of document.querySelectorAll('.myPicture')){	
		 
		 target.style.backgroundImage="url('"+contextPath+"/teacher/getPicture.go')";
		 target.style.backgroundPosition="center";
		 target.style.backgroundRepeat="no-repeat";
		 target.style.backgroundSize="cover";
	}
}
</script>
<script>
$(function(){
	ProblemPictureThumb('<%=request.getContextPath()%>');
})
</script>
</head>

<body>
	<div class="d-flex justify-content-between mb-2">
		<h5 style="font-weight: bold;">
			<i class="uil-unlock-alt" style="margin-right: 10px;"></i>개인정보
		</h5>
		<button type="button" class="btn btn-success"
			style="height: 30px; line-height: 12px;"
			onclick="location.href='modifyForm.go'">수정하기</button>
	</div>
	<div class="row">
		<div class="col-4">
			<div class="card" style="padding-left: 15px; padding-right: 15px;">
				<div class="card-body">
					<div style="text-align: center;">
						<div class="myPicture" style="border-radius: 50%; margin:auto; width: 150px; height: 150px;">
						
						</div>
					</div>
					<div class="mt-3 mb-3">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 35px;">이름</label>${member.name }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-3">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 21px;">아이디</label>${member.id }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-3">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 35px;">전공</label>${member.major }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-3">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 35px;">과목</label>${member.subject }
						<hr style="margin: 5px 0 0 0;">
					</div>
				</div>
			</div>
		</div>
		<div class="col-8">
			<div class="card" style="padding: 10px;">
				<div class="card-body">
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-success text-purple">
										01</div>
								</div>
							</div>
							<div class="flex-grow-1">
								<h5 class="card-title">연락처 정보</h5>
							</div>
						</div>
						<div class="card-body">
							<div class="mb-2">
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 68px;">핸드폰 번호</label>${member.phone }
								<hr style="margin: 5px 0 0 0;">
							</div>
							<div>
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 68px;">이메일 주소</label>${member.email }
								<hr style="margin: 5px 0 0 0;">
							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-success text-purple">
										02</div>
								</div>
							</div>
							<div class="flex-grow-1">
								<h5 class="card-title">주소 정보</h5>
							</div>
						</div>
						<div class="card-body">
							<div class="mb-2">
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 113px;">주소</label>${member.address }
								<hr style="margin: 5px 0 0 0;">
							</div>
							<div>
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 80px;">상세 주소</label>${member.detailAddress }
								<hr style="margin: 5px 0 0 0;">
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-success text-purple">
										03</div>
								</div>
							</div>
							<div class="flex-grow-1">
								<h5 class="card-title">경력사항</h5>
							</div>
						</div>
						<div class="card-body">
							<c:forEach items="${careerVOList }" var="careerVO" varStatus="i">
							<div class="mb-2">
								<label class="form-label" for="gen-info-name-input" style="font-weight: bold; margin-right: 100px;">${i.count }.</label>
								(<fmt:formatDate value="${careerVO.startDate }" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${careerVO.endDate }" pattern="yyyy-MM-dd"/>) 
								<span>${careerVO.cacontent } </span>
								
								<hr style="margin: 5px 0 0 0;">
							</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
