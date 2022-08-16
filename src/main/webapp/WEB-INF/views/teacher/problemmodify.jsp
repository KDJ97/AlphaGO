<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<body>
	<div class="row gx-3 gy-2">
		<div class="col-6" style="float: left;">
			<div class="card">
				<div class="card-body" style="padding: 15px;">
					<div class="d-flex mb-2">
						<div class="me-auto">
							<h5 style="font-weight: bold; margin-bottom: 15px;">
								<i class="uil-book-open" style="margin-right: 10px;"></i>문제 수정
							</h5>
						</div>
						<div>
							<button type="button" class="btn btn-soft-secondary"
								style="height: 30px; line-height: 5px; margin-right: 5px;">취소</button>
						</div>
						<div>
							<button type="button" class="btn btn-soft-warning"
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

						<div style="margin:0px 35px 0px 35px;">
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
					<hr>

					<div class="form-floating">
						<textarea class="form-control bg-light text-dark"
							placeholder="Leave a comment here" id="floatingTextarea2"
							style="height: 180px"></textarea>
						<label for="floatingTextarea2" class="text-dark"
							style="font-weight: bold;">문제 </label>
					</div>

					<div class="row" style="margin-top: 10px;">
						<div class="col-1">
							<input class="form-check-input" type="radio" name="formRadios"
								id="formRadios1" checked style="margin: 12px;">
						</div>
						<div class="col-11">
							<div class="form-floating bg-light">
								<input type="text" class="form-control bg-light text-dark"
									id="floatingTitle" placeholder="title"
									style="height: 40px; width: 100%;"> <label
									for="floatingTitle" class="text-dark"
									style="font-weight: bold; line-height: 4px;">①</label>
							</div>
						</div>
					</div>

					<div class="row" style="margin-top: 10px;">
						<div class="col-1">
							<input class="form-check-input" type="radio" name="formRadios"
								id="formRadios1" checked style="margin: 12px;">
						</div>
						<div class="col-11">
							<div class="form-floating bg-light">
								<input type="text" class="form-control bg-light text-dark"
									id="floatingTitle" placeholder="title"
									style="height: 40px; width: 100%;"> <label
									for="floatingTitle" class="text-dark"
									style="font-weight: bold; line-height: 4px;">②</label>
							</div>
						</div>
					</div>
					<div class="row" style="margin-top: 10px;">
						<div class="col-1">
							<input class="form-check-input" type="radio" name="formRadios"
								id="formRadios1" checked style="margin: 12px;">
						</div>
						<div class="col-11">
							<div class="form-floating bg-light">
								<input type="text" class="form-control bg-light text-dark"
									id="floatingTitle" placeholder="title"
									style="height: 40px; width: 100%;"> <label
									for="floatingTitle" class="text-dark"
									style="font-weight: bold; line-height: 4px;">③</label>
							</div>
						</div>
					</div>
					<div class="row" style="margin-top: 10px;">
						<div class="col-1">
							<input class="form-check-input" type="radio" name="formRadios"
								id="formRadios1" checked style="margin: 12px;">
						</div>
						<div class="col-11">
							<div class="form-floating bg-light">
								<input type="text" class="form-control bg-light text-dark"
									id="floatingTitle" placeholder="title"
									style="height: 40px; width: 100%;"> <label
									for="floatingTitle" class="text-dark"
									style="font-weight: bold; line-height: 4px;">④</label>
							</div>
						</div>
					</div>
					<div class="row" style="margin-top: 10px;">
						<div class="col-1">
							<input class="form-check-input" type="radio" name="formRadios"
								id="formRadios1" checked style="margin: 12px;">
						</div>
						<div class="col-11">
							<div class="form-floating bg-light">
								<input type="text" class="form-control bg-light text-dark"
									id="floatingTitle" placeholder="title"
									style="height: 40px; width: 100%;"> <label
									for="floatingTitle" class="text-dark"
									style="font-weight: bold; line-height: 4px;">⑤</label>
							</div>
						</div>
					</div>


					<hr>
					<div class="form-floating">
						<textarea class="form-control bg-light text-dark"
							placeholder="Leave a comment here" id="floatingTextarea2"
							style="height: 150px"></textarea>
						<label for="floatingTextarea2" class="text-dark"
							style="font-weight: bold;">해설 </label>
					</div>
				</div>
			</div>
		</div>
		<div class="col-6">
			<div class="card" style="height: 787px;">
				<div class="card-body" style="padding: 15px;">
					<div class="d-flex">
						<p style="font-weight: bold;" class="flex-grow-1">문제 미리보기</p>

					</div>

					<div class="bg-light" style="padding: 15px; border-radius: 10px;">
						<div style="margin-bottom: 5px; font-size: 1.1em;">
							<span class="badge rounded-pill bg-secondary"
								style="margin-right: 5px;">코드 123</span><br>
						</div>
						애국가(愛國歌)는 ‘나라를 사랑하는 노래’라는 뜻이에요. 우리나라는 애국가에 특별한 이름을 붙이지 않고 국가(國歌)로
						사용하고 있어요. 오늘날 불리고 있는 애국가 노랫말은 우리나라가 외세의 침략으로 위기에 처해있던 시기(1907년
						전후)에 나라 사랑하는 마음과 우리 민족의 자주의식을 북돋우기 위해 만들어진 것으로 보여져요.오늘날 불리고 있는 애국가
						노랫말은 우리나라가 외세의 침략으로 위기에 처해있던 시기(1907년 전후)에 나라 사랑하는 마음과 우리 민족의
						자주의식을 북돋우기 위해 만들어진 것으로 보여져요.<br> <br>
						<p style="margin-left: 10px; margin-bottom: 0px;">
							① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
							간주(看做)하면<br> ⑤ 결성(結成)되지
						</p>
					</div>

					<p style="font-weight: bold; margin-top: 15px;">해설 및 답</p>
					<div class="bg-light" style="padding: 15px; border-radius: 10px;">
						<p>
							정답<span style="font-weight: bold; color: red; margin-left: 15px;">①
								소지(所持)하여야</span>
						</p>
						애국가(愛國歌)는 ‘나라를 사랑하는 노래’라는 뜻이에요. 우리나라는 애국가에 특별한 이름을 붙이지 않고 국가(國歌)로
						사용하고 있어요. 오늘날 불리고 있는 애국가 노랫말은 우리나라가 외세의 침략으로 위기에 처해있던 시기(1907년
						전후)에 나라 사랑하는 마음과 우리 민족의 자주의식을 북돋우기 위해 만들어진 것으로 보여져요. 애국가(愛國歌)는
						‘나라를 사랑하는 노래’라는 뜻이에요. 우리나라는 애국가에 특별한 이름을 붙이지 않고 국가(國歌)로 사용하고 있어요.
						오늘날 불리고 있는 애국가 노랫말은 우리나라가 외세의 침략으로 위기에 처해있던 시기(1907년 전후)에 나라 사랑하는
						마음과 우리 민족의 자주의식을 북돋우기 위해 만들어진 것으로 보여져요.
					</div>

				</div>

			</div>

		</div>
	</div>
</body>
