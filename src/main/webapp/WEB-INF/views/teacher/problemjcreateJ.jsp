<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<body>
	<div class="row gx-3 gy-2">
		<div class="col-6" style="float: left;">
			<div class="card" style="height: 762px;">
				<div class="card-body" style="padding: 15px;">
					<div class="d-flex mb-2">
						<div class="me-auto d-flex justify-content-start">
							<h5
								style="font-weight: bold; margin-top: 2px; margin-bottom: 15px;">
								<i class="uil-book-open" style="margin-right: 10px;"></i>문제 출제
							</h5>
							<span class="badge rounded-pill bg-info"
								style="font-size: 1.0em; margin: 0px 0px 11px 10px;">수학</span>
						</div>

					</div>

					<div class="d-flex justify-content-start">

						<label class="form-label" for="formrow-firstname-input"
							style="font-weight: bold; margin: 2px 15px 0px 0px;">세부
							과목</label>
						<div class="dropdown" style="margin-bottom: 5px;">
							<button class="btn btn-soft-secondary dropdown-toggle"
								type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown"
								style="width: 130px; height: 30px; line-height: 10px;"
								aria-expanded="false">
								세부 과목<i class="mdi mdi-chevron-down" style="margin-left: 10px;"></i>
							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
								<li><a class="dropdown-item" href="#">수1 </a></li>
								<li><a class="dropdown-item" href="#">수2</a></li>
							</ul>

						</div>

						<label class="form-label" for="formrow-firstname-input"
							style="font-weight: bold; margin: 2px 15px 0px 44px;">시험
							범위</label>
						<div class="dropdown" style="margin-bottom: 5px;">
							<button class="btn btn-soft-secondary dropdown-toggle"
								type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown"
								style="width: 130px; height: 30px; line-height: 10px;"
								aria-expanded="false">
								시험 범위<i class="mdi mdi-chevron-down" style="margin-left: 10px;"></i>
							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
								<li><a class="dropdown-item" href="#">1단원</a></li>
								<li><a class="dropdown-item" href="#">2단원</a></li>
							</ul>
						</div>

					</div>

					<hr style="margin: 10px 0px 15px 0px;">
					<div style="margin-bottom: 5px;">
						<span style="color: orange;">*</span><span> 지문 하나당 문제 4개 출제
							가능합니다.</span>
					</div>
					<div class="form-floating">
						<textarea class="form-control bg-light text-dark"
							placeholder="Leave a comment here" id="floatingTextarea2"
							style="height: 590px"></textarea>
						<label for="floatingTextarea2" class="text-dark"
							style="font-weight: bold;">지문 </label>
					</div>


				</div>
			</div>
		</div>
		<div class="col-6">
			<div class="card">
				<div class="card-body" style="padding: 15px;">
					<div class="d-flex" style="margin-bottom: 10px;">
						<div class="me-auto d-flex justify-content-start">
							<h5>01.</h5>
						</div>
						<div>
							<button type="button" class="btn btn-soft-secondary"
								style="height: 30px; line-height: 5px; margin-right: 5px;">취소</button>
						</div>
						<div>
							<button type="button" class="btn btn-soft-warning"
								data-bs-toggle="modal" data-bs-target=".bs-example-modal-center"
								style="height: 30px; line-height: 5px; margin-right: 5px;">미리보기</button>
						</div>
						<div>
							<button type="button" class="btn btn-soft-success"
								style="height: 30px; line-height: 5px; margin-right: 5px;">완료</button>
						</div>
					</div>
					<div class="d-flex justify-content-start">

						<div>
							<label class="form-label" for="formrow-firstname-input"
								style="font-weight: bold;">문제 형식</label>
							<div class="dropdown" style="margin-bottom: 5px;">
								<button class="btn btn-soft-secondary dropdown-toggle"
									type="button" id="dropdownMenuButton1"
									data-bs-toggle="dropdown"
									style="width: 130px; height: 30px; line-height: 10px;"
									aria-expanded="false">
									객관식/주관식<i class="mdi mdi-chevron-down"
										style="margin-left: 10px;"></i>
								</button>
								<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
									<li><a class="dropdown-item" href="#">객관식 </a></li>
									<li><a class="dropdown-item" href="#">주관식</a></li>
								</ul>
							</div>
						</div>

						<div style="margin: 0px 35px 0px 35px;">
							<label class="form-label" for="formrow-firstname-input"
								style="font-weight: bold;">문제 유형</label>
							<div class="dropdown" style="margin-bottom: 5px;">
								<button class="btn btn-soft-secondary dropdown-toggle"
									type="button" id="dropdownMenuButton2"
									data-bs-toggle="dropdown"
									style="width: 130px; height: 30px; line-height: 10px;"
									aria-expanded="false">
									문제 유형<i class="mdi mdi-chevron-down" style="margin-left: 10px;"></i>
								</button>
								<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
									<li><a class="dropdown-item" href="#">문학</a></li>
									<li><a class="dropdown-item" href="#">비문학</a></li>
								</ul>
							</div>
						</div>
						<div>
							<label class="form-label" for="formrow-firstname-input"
								style="font-weight: bold;">난이도</label>

							<div class="dropdown" style="margin-bottom: 5px;">

								<button class="btn btn-soft-secondary dropdown-toggle"
									type="button" id="dropdownMenuButton2"
									data-bs-toggle="dropdown"
									style="width: 130px; height: 30px; line-height: 10px;"
									aria-expanded="false">
									난이도<i class="mdi mdi-chevron-down" style="margin-left: 10px;"></i>
								</button>
								<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
									<li><a class="dropdown-item" href="#">상</a></li>
									<li><a class="dropdown-item" href="#">중</a></li>
									<li><a class="dropdown-item" href="#">하</a></li>
								</ul>
							</div>
						</div>
					</div>
					<hr style="margin: 10px 0px 15px 0px;">

					<div class="form-floating">
						<textarea class="form-control bg-light text-dark"
							placeholder="Leave a comment here" id="floatingTextarea2"
							style="height: 180px"></textarea>
						<label for="floatingTextarea2" class="text-dark"
							style="font-weight: bold;">문제 </label>
					</div>

					<div class="form-floating" style="margin-top: 10px;">
						<textarea class="form-control bg-light text-dark"
							placeholder="Leave a comment here" id="floatingTextarea2"
							style="height: 180px"></textarea>
						<label for="floatingTextarea2" class="text-dark"
							style="font-weight: bold;">답 </label>
					</div>

					<hr>
					<div class="form-floating" style="margin-bottom: 10px;">
						<textarea class="form-control bg-light text-dark"
							placeholder="Leave a comment here" id="floatingTextarea2"
							style="height: 150px"></textarea>
						<label for="floatingTextarea2" class="text-dark"
							style="font-weight: bold;">해설 </label>
					</div>
					<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
				</div>
			</div>


		</div>

	</div>
	<!--  Large modal example -->
	<div class="modal fade bs-example-modal-center" tabindex="-1"
		role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="myLargeModalLabel">문제 미리보기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-6">
							<div style="border: 1px solid lightgray; padding: 10px;">
								<span style="font-weight: bold;">[지문]</span>'비문학 독서'라는 것이 새로 생겨나
								무지막지한 분량의 지문이 출제되며 문학파트에서는 생전 듣도 안녕하세요. 텃밭 선배 ○○○입니다. 잘 들리시나요?
								(청중의 반응을 살피며 큰 목소리로) 잘 안 들리시는 것 같으니 좀 더 크게 말씀드릴게요. 저는 텃밭을 처음 가꿀
								때 가정에서 필요한 다양한 작물을 심고 싶었어요. 아마 15제곱미터 정도의 좁은 텃밭을 가꾸기 시작하시는 여러분도
								비슷한 마음이실 거예요. 그러면 어떻게 해야 할까요? (잠시 뒤에) 작물을 심기 전에 효율 적인 배치를 위해 작물
								배치도를 그려 보면 도움이 됩니다. (화면에 자료를 제시하며) 왼쪽은 제가 첫해 심은 작물의 배치도 이고, 그 옆은
								다음 해에 그것을 수정한 배치도입니다. 첫해 배치 에는 두 가지 문제가 있었는데요, 우선 작물의 키를 고려하지
								않았다는 점이에요. 해는 동쪽에서 떠서 한낮에 남쪽을 지나 서쪽으로 지고 해가 떠 있는 반대 방향으로 그림자가
								생기죠. 작물은 광합성이 많이 이루어지는 오전부터 한낮까지 그림자의 영향을 최소한으로 받아야 잘 자랄 수 있어요.
								이를 고려해 키가 작은 작물을 동쪽과 남쪽에 배치해야 해요. 해는 동쪽에서 떠서 한낮에 남쪽을 지나 서쪽으로 지고
								해가 떠 있는 반대 방향으로 그림자가 생기죠. 작물은 광합성이 많이 이루어지는 오전부터 한낮까지 그림자의 영향을
								최소한으로 받아야 잘 자랄 수 있어요. 이를 고려해 키가 작은 작물을 동쪽과 남쪽에 배치해야 해요.
							</div>
						</div>
						<div class="col-6">
							<div style="font-weight: bold;">[문제]</div>
							<div>01. 위 발표자의 말하기에 대한 설명으로 적절하지 않은 것은?</div>

							<div style="font-weight: bold;margin-top:15px;">[답]</div>
							<div style="margin-bottom: 15px;">
								<span style="font-weight: bold; color: red;">첫해 배치 에는 두
									가지 문제가 있었는데요, 우선 작물의 키를 고려하지 않았다는 점이에요. 해는 동쪽에서 떠서 한낮에 남쪽을 지나
									서쪽으로 지고 해가 떠 있는 반대 방향으로 그림자가 생기죠.</span>
							</div>
							<div style="font-weight: bold;">[해설]</div>
							<div style="margin-bottom: 10px;">첫해 배치 에는 두 가지 문제가 있었는데요,
								우선 작물의 키를 고려하지 않았다는 점이에요. 해는 동쪽에서 떠서 한낮에 남쪽을 지나 서쪽으로 지고 해가 떠 있는
								반대 방향으로 그림자가 생기죠. 작물은 광합성이 많이 이루어지는 오전부터 한낮까지 그림자의 영향을 최소한으로 받아야
								잘 자랄 수 있어요. 이를 고려해 키가 작은 작물을 동쪽과 남쪽에 배치해야 해요. 해는 동쪽에서 떠서 한낮에 남쪽을
								지나 서쪽으로 지고 해가 떠 있는 반대 방향으로 그림자가 생기죠. 작물은 광합성이 많이 이루어지는 오전부터 한낮까지
								그림자의 영향을 최소한으로 받아야 잘 자랄 수 있어요. 이를 고려해 키가 작은 작물을 동쪽과 남쪽에 배치해야 해요.</div>
							
							<nav aria-label="Navigation">
								<ul class="pagination justify-content-center m-0">
									<li class="page-item"><a class="page-link"> <i
											class="fas fa-angle-double-left"></i>
									</a>
									<li class="page-item"><a class="page-link" href=""> <i
											class="fas fa-angle-left"></i>
									</a></li>

									<li class="page-item active"><a class="page-link">1</a></li>
									<li class="page-item "><a class="page-link">2</a></li>
									<li class="page-item "><a class="page-link">3</a></li>
									<li class="page-item "><a class="page-link">4</a></li>


									<li class="page-item"><a class="page-link" href=""> <i
											class="fas fa-angle-right"></i>
									</a></li>
									<li class="page-item"><a class="page-link" href=""> <i
											class="fas fa-angle-double-right"></i>
									</a></li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
	</div>
	<!-- /.modal -->
</body>
