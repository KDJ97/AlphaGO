<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<style type="text/css">
.card{
    margin-bottom: 10px;
}
</style>
<script type="text/javascript">
<c:if test="${!empty reload}">
	window.parent.location.reload();
</c:if>

$('div#pictureView').css({
	'background-image' : 'url(<%=request.getContextPath()%>/member/getPicture.do?id=${loginUser.id})',
	'background-position' : 'center',
	'background-size' : 'cover',
	'background-repeat' : 'no-repeat'
});
</script>
</head>
<body>
	<div class="d-flex justify-content-between mb-2">
		<h5 style="font-weight: bold;">
			<i class="uil-unlock-alt" style="margin-right: 10px;"></i>개인정보
		</h5>
		<button type="button" class="btn btn-purple"
			style="height: 30px; line-height: 12px;"
			onclick="location.href='modifyForm.go'">수정하기</button>
	</div>
	<div class="row">
		<div class="col-4" style="padding: 0px;">
			<div class="card" style="padding-left: 15px; padding-right: 15px; height: 666px;">
				<div class="card-body">
					<div style="text-align: center;">
						<div class="rounded-circle" id="pictureView"
										style="border: 1px solid lightgrey; height: 150px; width: 150px; margin: 0 auto;"></div>
					</div>
					<div class="mt-3 mb-3">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 35px;">이름</label>${sessionScope.loginUser.name }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-3">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 21px;">아이디</label>${sessionScope.loginUser.id }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-3">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 35px;">학교</label>${sessionScope.loginUser.schoolName }
						<hr style="margin: 5px 0 0 0;">
					</div>
					<div class="mb-2">
						<label class="form-label" for="gen-info-name-input"
							style="font-weight: bold; margin-right: 35px;">학년</label>${sessionScope.loginUser.grade }학년
						<hr style="margin: 5px 0 0 0;">
					</div>
				</div>
			</div>
		</div>
		<div class="col-8">
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-purple text-white">
										01</div>
								</div>
							</div>
							<div class="flex-grow-1" style="padding-top: 3px;">
								<h5 class="card-title"><b>연락처 정보</b></h5>
							</div>
						</div>
						<div class="card-body">
							<div class="mb-2">
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 68px;">핸드폰 번호</label>${sessionScope.loginUser.phone }
								<hr style="margin: 5px 0 0 0;">
							</div>
							<div class="mb-2">
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 20px;">학부모 핸드폰
									번호</label>${loginUser.parentPhone }
								<hr style="margin: 5px 0 0 0;">
							</div>
							<div>
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 68px;">이메일 주소</label>${loginUser.email }
								<hr style="margin: 5px 0 0 0;">
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-purple text-white">
										02</div>
								</div>
							</div>
							<div class="flex-grow-1" style="padding-top: 3px;">
								<h5 class="card-title"><b>주소 정보</b></h5>
							</div>
						</div>
						<div class="card-body">
							<div class="mb-2">
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 113px;">주소</label>${loginUser.address }
								<hr style="margin: 5px 0 0 0;">
							</div>
							<div>
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 80px;">상세 주소</label>${loginUser.detailAddress }
								<hr style="margin: 5px 0 0 0;">
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-header d-flex align-items-center">
							<div class="flex-shrink-0 me-3">
								<div class="avatar-sm">
									<div
										class="avatar-title rounded-circle bg-purple text-white">
										03</div>
								</div>
							</div>
							<div class="flex-grow-1" style="padding-top: 3px;">
								<h5 class="card-title"><b>희망대학</b></h5>
							</div>
						</div>
						<div class="card-body">
							<div class="mb-2">
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 100px;">1지망</label>${loginUser.fuUni }
								<hr style="margin: 5px 0 0 0;">
							</div>
							<div class="mb-2">
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 100px;">2지망</label>${loginUser.suUni }
								<hr style="margin: 5px 0 0 0;">
							</div>
							<div>
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin-right: 100px;">3지망</label>${loginUser.tuUni }
								<hr style="margin: 5px 0 0 0;">
							</div>
						</div>
					</div>
				</div>
			</div>

</body>
