<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>


<body>


	<div class="col-xl-6">
		<div class="card">
			<div class="card-header justify-content-between d-flex align-items-center  bg" style="background:#8BDDA8;">
				<h4 class="card-title" style="#8BDDA8;">상담 일정 상세</h4>
				
			</div>
			<!-- end card header -->
			<div class="card-body">
	
		<form>
			<div class="row mb-3">
				<label for="horizontal-firstname-input"
					class="col-sm-3 col-form-label"> 
			<span class="badge" style="font-size:1.2em;background:#8BDDA8;">구분</span>
			</label>
					
					
				<div class="col-sm-9">
					<input type="text" class="form-control"
						id="horizontal-firstname-input">
				</div>
			</div>
			<!-- end row -->
			<div class="row mb-3">
				<label for="horizontal-email-input" class="col-sm-3 col-form-label"><span class="badge" style="font-size:1.2em;background:#8BDDA8;">상담일</span></label>
				<div class="col-sm-9">
					<input type="date" class="form-control"
						id="horizontal-email-input">
				</div>
			</div>
			<!-- end row -->
			<div class="row mb-3">
				<label for="horizontal-password-input"
					class="col-sm-3 col-form-label"><span class="badge" style="font-size:1.2em;background:#8BDDA8;">시작시간</span></label>
				<div class="col-sm-9">
					<input type="text" class="form-control"
						id="horizontal-password-input">
				</div>
			</div>
			
			<div class="row mb-3">
				<label for="horizontal-password-input"
					class="col-sm-3 col-form-label"><span class="badge" style="font-size:1.2em;background:#8BDDA8;">종료시간</span></label>
				<div class="col-sm-9">
					<input type="text" class="form-control"
						id="horizontal-password-input">
				</div>
			</div>
			<!-- end row -->

			<div class="row justify-content-end">
				<div class="col-sm-9">
					<div class="form-check mb-4">
						
					</div>
					<div>
					<button type="submit" class="btn btn-soft-warning ">수정</button>
					<button type="submit" class="btn btn-soft-danger ">삭제</button>
						<button type="submit" class="btn btn-soft-primary ">목록</button>
					</div>
				</div>
				<!-- end col -->
			</div>
			<!-- end row -->
		</form>
		<!-- end form -->
	</div>
</body>


