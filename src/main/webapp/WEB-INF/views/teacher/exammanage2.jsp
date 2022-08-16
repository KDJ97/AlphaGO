<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h5 style="margin-bottom: 15px; font-weight: bold;">
		<i class="uil-clipboard-alt" style="margin-right: 10px;"></i>시험 출제
	</h5>
	<div class="row">
		<div class="col-sm-5">
			<div class="row-4">
				<div class="card" style="height: 280px;">
					<div class="card-body">
						<table class="table table-bordered text-center"
							style="width: 100%; text-align: center;">
							<tr>
								<th style="background: #8BDDA8; font-weight: bold;" colspan="2">강의명</th>

							</tr>




							<tr>

								<td style="padding: 5px;">수1 미치도록 잘해버리기</td>

								<td style="padding: 5px;"><input type="radio"
									name="chk_info" value="수1 미치도록 잘해버리기"></td>



							</tr>
							<tr>


								<td style="padding: 5px;">수1 미치도록 잘해버리기</td>

								<td style="padding: 5px;"><input type="radio"
									name="chk_info" value="수1 미치도록 잘해버리기" style=""></td>


							</tr>

							<tr>


								<td style="padding: 5px;">수1 미치도록 잘해버리기</td>

								<td style="padding: 5px;"><input type="radio"
									name="chk_info" value="수1 미치도록 잘해버리기" style=""></td>


							</tr>
							<tr>


								<td style="padding: 5px;">수1 미치도록 잘해버리기</td>

								<td style="padding: 5px;"><input type="radio"
									name="chk_info" value="수1 미치도록 잘해버리기" style=""></td>


							</tr>
							<tr>


								<td style="padding: 5px;">수1 미치도록 잘해버리기</td>

								<td style="padding: 5px;"><input type="radio"
									name="chk_info" value="수1 미치도록 잘해버리기" style=""></td>


							</tr>
							<tr>


								<td style="padding: 5px;">수1 미치도록 잘해버리기</td>

								<td style="padding: 5px;">
									<div>
										<input type="radio" name="chk_info" value="수1 미치도록 잘해버리기"
											style="margin: 0px auto;">
									</div>
							</tr>

						</table>

					</div>


				</div>
			</div>

			<!--card끝-->
			<div class="row-8">
				<div class="card" style="">
					<div class="card-body">
						<div class="d-flex align-items-start">
							<label class="form-label" for="gen-info-name-input"
								style="font-weight: bold; margin: 3px 10px 0px 0px;">시험명</label>
							<input type="text" placeholder="시험명 입력" class="form-control"
								id="gen-info-name-input" style="width: 215px; height: 30px;">
						</div>
						<hr>
						<span
							style="font-weight: bold; margin-top: 3px; margin-bottom: 10px;">시험기간</span>
						<div class="d-flex align-items-start mt-2">
							<label class="form-label" for="gen-info-name-input"
								style="margin: 2px 8px 0px 0px;">시작일</label> <input type="date"
								class="form-control" id="gen-info-name-input"
								style="width: 120px; height: 30px;"> <label
								class="form-label" for="gen-info-name-input"
								style="margin: 2px 8px 0px 8px;">종료일</label> <input type="date"
								class="form-control" id="gen-info-name-input"
								style="width: 120px; height: 30px;">
						</div>
						<hr>
						<span
							style="font-weight: bold; margin-top: 3px; margin-bottom: 10px;">시험범위</span>
						<div style="margin-top: 10px;">
							<div class="d-flex align-items-start">
								<label class="form-label" for="gen-info-name-input"
									style="margin: 5px 20px 0px 0px;">시작</label> <select
									class="form-select" name="job"
									style="width: 130px; margin-right: 10px;">
									<option value="">시작단원</option>

								</select> <label class="form-label" for="gen-info-name-input"
									style="margin: 5px 8px 0px 15px;">끝</label> <select name="job"
									class="form-select" name="job" style="width: 130px;">
									<option value="">끝단원</option>
								</select>
							</div>
							<hr>
							<div class="d-flex align-items-start">
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin: 5px 10px 0px 0px;">시험시간
									제한</label> <select name="job" class="form-select" name="job"
									style="width: 100px;">
									<option value="">제한시간</option>

								</select> <span style="margin-top: 5px; margin-left: 5px;">분</span>
							</div>
							<hr>
							<div class="d-flex align-items-start" style="margin-top: 8px;">
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin: 5px 58px 0px 0px;">문항수</label>
								<input type="number" class="form-control" placeholder="문항수"
									min="10" max="30" step="1" id="gen-info-name-input"
									style="width: 100px; height: 30px;" /><span
									style="margin-top: 5px; margin-left: 5px;">개</span>
							</div>
							<hr>
							<div class="d-flex justify-content-end">
								<button type="button" class="btn btn-sm"
									style="background-color: #8BDDA8; margin-right: 10px;">자동생성</button>
								<button type="button" class="btn btn-sm"
									style="background-color: #8BDDA8">수동생성</button>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="col-sm-7">
			<div class="col-sm-12">
				<div class="card">
					<div class="card-body">
						<div class="row gx-3 gy-2">
							<div class="col-6" style="float: left;">
								1. (가)와 (나)에 대한 설명으로 가장 적절한 것은?<br>
								<p style="margin-left: 10px;">
									① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
									간주(看做)하면<br> ⑤ 결성(結成)되지<br>
								</p>
								2. (가)와 (나)에 대한 설명으로 가장 적절한 것은?<br>
								<p style="margin-left: 10px;">
									① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
									간주(看做)하면<br> ⑤ 결성(結成)되지<br>
								</p>
								3. (가)와 (나)에 대한 설명으로 가장 적절한 것은?<br>
								<p style="margin-left: 10px;">
									① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
									간주(看做)하면<br> ⑤ 결성(結成)되지<br>
								</p>
								4. (가)와 (나)에 대한 설명으로 가장 적절한 것은?<br>
								<p style="margin-left: 10px;">
									① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
									간주(看做)하면<br> ⑤ 결성(結成)되지<br>
								</p>
								5. (가)와 (나)에 대한 설명으로 가장 적절한 것은?<br>
								<p style="margin-left: 10px;">
									① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
									간주(看做)하면<br> ⑤ 결성(結成)되지<br>
								</p>
							</div>
							<div class="col-6" style="float: left;">
								6. (가)와 (나)에 대한 설명으로 가장 적절한 것은?<br>
								<p style="margin-left: 10px;">
									① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
									간주(看做)하면<br> ⑤ 결성(結成)되지<br>
								</p>
								7. (가)와 (나)에 대한 설명으로 가장 적절한 것은?<br>
								<p style="margin-left: 10px;">
									① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
									간주(看做)하면<br> ⑤ 결성(結成)되지<br>
								</p>
								8. (가)와 (나)에 대한 설명으로 가장 적절한 것은?<br>
								<p style="margin-left: 10px;">
									① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
									간주(看做)하면<br> ⑤ 결성(結成)되지<br>
								</p>
								9. (가)와 (나)에 대한 설명으로 가장 적절한 것은?<br>
								<p style="margin-left: 10px;">
									① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
									간주(看做)하면<br> ⑤ 결성(結成)되지<br>
								</p>
								10. (가)와 (나)에 대한 설명으로 가장 적절한 것은?<br>
								<p style="margin-left: 10px;">
									① 소지(所持)하여야<br> ② 포착(捕捉)한다<br> ③ 귀결(歸結)되어도<br> ④
									간주(看做)하면<br> ⑤ 결성(結成)되지<br>
								</p>
							</div>
						</div>
					</div>

				</div>
			</div>

		</div>
	</div>
</body>
</html>