<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<body>
	<div class="row gx-3 gy-2">
		<div class="col-6" style="float: left;">
			<div class="card">
				<div class="card-body">
					<h5 style="font-weight: bold; margin-bottom: 15px;">
						<i class="uil-book-open" style="margin-right: 10px;"></i>오답 리스트
					</h5>
					<div class="dropdown" style="margin-bottom: 5px;">
						<button class="btn btn-soft-secondary dropdown-toggle"
							type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown"
							style="width: 130px;" aria-expanded="false">
							수업 선택<i class="mdi mdi-chevron-down" style="margin-left: 10px;"></i>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li><a class="dropdown-item" href="#">국어 </a></li>
							<li><a class="dropdown-item" href="#">수학</a></li>
							<li><a class="dropdown-item" href="#">사회</a></li>
						</ul>
						<button class="btn btn-soft-secondary dropdown-toggle"
							type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown"
							style="width: 130px;" aria-expanded="false">
							시험 선택<i class="mdi mdi-chevron-down" style="margin-left: 10px;"></i>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
							<li><a class="dropdown-item" href="#">3월 모의고사</a></li>
							<li><a class="dropdown-item" href="#">6월 모의고사</a></li>
							<li><a class="dropdown-item" href="#">9월 모의고사</a></li>
						</ul>
					</div>

					<div>
						<div id="table-pagination">
							<div role="complementary"
								style="width: 100%; text-align: center;">
								<div style="height: auto;">
									<table class="table text-center table-hover" style="height: auto;">
										<thead>
											<tr>
												<th data-column-id="name" class="gridjs-th bg-soft-purple"
													style="font-weight: bold;"><div
														class="gridjs-th-content">시험명</div></th>
												<th data-column-id="email" class="gridjs-th bg-soft-purple"
													style="font-weight: bold;"><div
														class="gridjs-th-content">문제번호</div></th>
												<th data-column-id="position"
													class="gridjs-th bg-soft-purple" style="font-weight: bold;"><div
														class="gridjs-th-content">유형</div></th>
												<th data-column-id="company"
													class="gridjs-th bg-soft-purple" style="font-weight: bold;"><div
														class="gridjs-th-content">날짜</div></th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td data-column-id="name" >3월 모의고사</td>
												<td data-column-id="email" >1</td>
												<td data-column-id="position" ><span
													class="badge rounded-pill bg-success"
													style="font-size: 0.8em; padding: 10px; weight: 100px;">비문학</span></td>
												<td data-column-id="company">2022-07-03</td>
											</tr>
											<tr>
												<td data-column-id="name" >3월 모의고사</td>
												<td data-column-id="email">1</td>
												<td data-column-id="position" ><span
													class="badge rounded-pill bg-success"
													style="font-size: 0.8em; padding: 10px; weight: 100px;">비문학</span></td>
												<td data-column-id="company">2022-07-03</td>
											</tr>
											<tr>
												<td data-column-id="name" >3월 모의고사</td>
												<td data-column-id="email" >1</td>
												<td data-column-id="position"><span
													class="badge rounded-pill bg-success"
													style="font-size: 0.8em; padding: 10px; weight: 100px;">비문학</span></td>
												<td data-column-id="company">2022-07-03</td>
											</tr>
											<tr>
												<td data-column-id="name">3월 모의고사</td>
												<td data-column-id="email" >1</td>
												<td data-column-id="position" ><span
													class="badge rounded-pill bg-success"
													style="font-size: 0.8em; padding: 10px; weight: 100px;">비문학</span></td>
												<td data-column-id="company">2022-07-03</td>
											</tr>
											<tr>
												<td data-column-id="name">3월 모의고사</td>
												<td data-column-id="email">1</td>
												<td data-column-id="position"><span
													class="badge rounded-pill bg-success"
													style="font-size: 0.8em; padding: 10px; weight: 100px;">비문학</span></td>
												<td data-column-id="company">2022-07-03</td>
											</tr>
											<tr>
												<td data-column-id="name">3월 모의고사</td>
												<td data-column-id="email">1</td>
												<td data-column-id="position"><span
													class="badge rounded-pill bg-success"
													style="font-size: 0.8em; padding: 10px; weight: 100px;">비문학</span></td>
												<td data-column-id="company">2022-07-03</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- pagenation -->
								<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
		<div class="col-6">
			<div class="card">
				<div class="card-body">
					<div class="d-flex">
						<p style="font-weight: bold;" class="flex-grow-1">3월 모의고사</p>
						<button type="button" class="btn btn-soft-secondary"
							style="margin-bottom: 10px; margin-right:5px;">취소</button>
						<button type="button" class="btn btn-soft-purple"
							style="margin-bottom: 10px;">수정완료</button>
					</div>
					<div class="bg-light" style="padding: 20px; border-radius: 10px;">
						01. 애국가(愛國歌)는 ‘나라를 사랑하는 노래’라는 뜻이에요. 우리나라는 애국가에 특별한 이름을 붙이지 않고
						국가(國歌)로 사용하고 있어요. 오늘날 불리고 있는 애국가 노랫말은 우리나라가 외세의 침략으로 위기에 처해있던
						시기(1907년 전후)에 나라 사랑하는 마음과 우리 민족의 자주의식을 북돋우기 위해 만들어진 것으로 보여져요.<br>
						<br>
						<p style="margin-left: 10px;">
							① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
							간주(看做)하면<br> ⑤ 결성(結成)되지<br>
						</p>
					</div>

					<p style="font-weight: bold; margin-top: 15px;">해설 및 답</p>
					<div class="bg-light" style="padding: 20px; border-radius: 10px;">
						<p>
							정답<span style="font-weight: bold; color: red; margin-left: 15px;">①
								소지(所持)하여야</span>
						</p>
						위기에 처해있던 시기(1907년 전후)에 나라 사랑하는 마음과 우리 민족의 자주의식을 북돋우기 위해 만들어진 것으로
						보여져요.
					</div>

					<p style="font-weight: bold; margin-top: 15px;">내 해설</p>
					<div class="bg-light" style="padding: 20px; border-radius: 10px;">
						<textarea rows="3" cols="53"></textarea>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
