<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>


<body>


	<div class="col-xl-6">
		<div class="card">
			<div class="card-header justify-content-between d-flex align-items-center"style="background:#8BDDA8;">
				<h4 class="card-title" style="primary">메시지</h4>
				
			</div>
			<!-- end card header -->
			<div class="card-body">
	
		<form>
		
		<div class="col-sm-6">
		  <span class="badge" style="font-size:1.2em;background:#8BDDA8;">
					받는사람
					</span>
				</div>
			<div class="row mb-3">
			   
				
					
					
				<div class="col-sm-4">
					<input type="text"  placeholder="010-1231-1234" class="form-control"
						id="horizontal-firstname-input"  >
				</div>
			</div>
			<!-- end row -->
			
			
			<div class="col sm-6">
				  <span class="badge" style="font-size:1.2em;background:#8BDDA8;">
				제목
				</span>
				</div>
				<div class="row mb-3">
				<div class="col-sm-9">
					<input type="text" class="form-control"
						id="horizontal-email-input">
				</div>
			</div>
			
			<div class="col sm-6">
				 <span class="badge badge-soft-danger" style="width:100%; font-size:1.2em;">반려 사유</span>
				
				</div>
					<!-- end row -->
					<textarea class="form-control" placeholder="내용을 입력하세요"
						id="floatingTextarea2" style="height: 100px"></textarea>
					<!-- end row -->

			<div class="row justify-content-end">
				<div class="col-sm-9">
					<div class="form-check mb-4">
						
					</div>
					<div>
					
						<button type="submit" class="btn btn-soft-success" style="float:right;">보내기</button>
					</div>
				</div>
				<!-- end col -->
			</div>
			<!-- end row -->
		</form>
		<!-- end form -->
	</div>
</body>


