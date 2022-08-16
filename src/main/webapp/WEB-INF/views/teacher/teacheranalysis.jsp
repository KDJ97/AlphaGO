<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<style>
table {
	width: 100%;
	border: 1px solid #444444;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #444444;
	padding: 10px;
}
}
</style>


</head>
<body>
	<div class="row">
		<div class="card">
			<div class="col-md-12">

				<div class="col-md-2" style="float: left;">
					<p style="text-align: center;"><span class="badge badge-soft-primary" style="font-size:1.2em; ">희망대학</span></p>
					<table class="table table-bordered text-center  table-hover ">
						<tr style="font-size: 0.95em;background:#8BDDA8;">
							<th style="width: 5%;">학부모</th>
							<th style="width: 5%;">원생</th>
						</tr>


						<tr class="table-white">
							<th>서울대</th>
							<th>경희대</th>
						</tr>
						<tr class="table-white">
							<th>연세대</th>
							<th>한양대</th>
						</tr>

						<tr class="table-white">
							<th>고려대</th>
							<th>서강대</th>
						</tr>



					</table>


				</div>
				<div class="col-md-5" style="float: right;">
					<p style="text-align: center; float: center;"><span class="badge badge-soft-primary" style="font-size:1.2em;">부모님 희망대학 내신 등급</span></p>

					<div id="chart_bar"></div>
				</div>

				<div class="col-md-5" style="float: right;">
					<p style="text-align: center;"><span class="badge badge-soft-primary" style="font-size:1.2em;">원생 희망대학 내신 등급</span></p>

					<div id="chart_bar2"></div>
				</div>

			</div>

			<div class="col-md-12">


				<div class="col-sm-5" style="float: left; margin-left: 30px;">
					<p style="text-align: center; float: center;"><span class="badge badge-soft-primary" style="font-size:1.2em;">학부모 희망대학 과목별 내신
						등급</span></p>

					<div>
						<table class="table table-bordered text-center  table-hover ">
							<tr style="font-size: 0.95em;background:#8BDDA8;" >
								<th style="width: 10%;">대학/과목</th>
								<th style="width: 5%;">국어</th>
								<th style="width: 5%;">수학</th>
								<th style="width: 5%;">영어</th>
								<th style="width: 5%;">사회</th>
								<th style="width: 5%;">과학</th>
							</tr>


							<tr class="table-white">
								<th>서울대</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
							</tr>
							<tr class="table-white">
								<th>연세대</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
							</tr>

							<tr class="table-white">
								<th>고려대</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
							</tr>



						</table>

					</div>

				</div>

				<div class="col-sm-5" style="float: right; margin-right: 30px;">
					<p style="text-align: center; float: center;">
						<span class="badge badge-soft-primary" style="font-size: 1.2em;">학부모
							희망대학 과목별 내신 등급</span>
					</p>
					<div>
						<table class="table table-bordered text-center  table-hover ">
							<tr style="font-size: 0.95em;background:#8BDDA8;">
								<th style="width: 10%;">대학/과목</th>
								<th style="width: 5%;">국어</th>
								<th style="width: 5%;">수학</th>
								<th style="width: 5%;">영어</th>
								<th style="width: 5%;">사회</th>
								<th style="width: 5%;">과학</th>
							</tr>


							<tr class="table-white">
								<th>경희대</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
							</tr>
							<tr class="table-white">
								<th>한양대</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
							</tr>

							<tr class="table-white">
								<th>서강대</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
								<th>1</th>
							</tr>



						</table>

					</div>

				</div>
			</div>



			<div class="col-md-12" style="float: left;">
				<p style="text-align: center;">
					<span class="badge badge-soft-success" style="font-size: 1.2em;">합격예측</span>
				</p>
				<table class="table table-bordered text-center  table-hover ">



					<tr class="table-danger">
						<th style="width: 15;"%>상향</th>
						<th>경희대,한양대,서울대</th>
					</tr>
					<tr class="table-primary">
						<th style="width: 15%;">적정</th>
						<th>아주대,세종대,과기대</th>
					</tr>

					<tr class="table-warning">
						<th style="width: 15%;">하향</th>
						<th>충남대,전북대,상명대</th>
					</tr>



				</table>




			</div>

			<div class="col-md-12">
				<div class="col-md-4" style="float: left; padding: 10px;">


					<p style="text-align: center;">
						<span class="badge badge-soft-danger" style="font-size: 1.2em;">상향
							대학 과목별 내신 등급</span>
					</p>

					<table border="1" class="table myclass">
						<tr style="font-size: 0.5em; background: #d07684;"
							class="table-danger ">
							<th style="width: 13%;">대학/과목</th>
							<th style="width: 5%;">국어</th>
							<th style="width: 5%;">수학</th>
							<th style="width: 5%;">영어</th>
							<th style="width: 5%;">사회</th>
							<th style="width: 5%;">과학</th>
						</tr>


						<tr class="table-white" style="font-size: 0.5em;">
							<th>서울대</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
						</tr>
						<tr class="table-white" style="font-size: 0.5em;">
							<th>한양대</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>

						</tr>

						<tr class="table-white" style="font-size: 0.5em;">
							<th>경희대</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
						</tr>
					</table>

				</div>

				<div class="col-md-4" style="float: left; padding: 10px;">


					<p style="text-align: center;">
						<span class="badge badge-soft-primary" style="font-size: 1.2em;">적정
							대학 과목별 내신 등급</span>
					</p>

					<table border="1" class="table myclass">
						<tr style="font-size: 0.5em; background: #d07684;"
							class="table-primary ">
							<th style="width: 13%;">대학/과목</th>
							<th style="width: 5%;">국어</th>
							<th style="width: 5%;">수학</th>
							<th style="width: 5%;">영어</th>
							<th style="width: 5%;">사회</th>
							<th style="width: 5%;">과학</th>
						</tr>


						<tr class="table-white" style="font-size: 0.5em;">
							<th>아주대</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
						</tr>
						<tr class="table-white" style="font-size: 0.5em;">
							<th>세종대</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>

						</tr>

						<tr class="table-white" style="font-size: 0.5em;">
							<th>과기대</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
						</tr>
					</table>

				</div>
				<div class="col-md-4" style="float: left; padding: 10px;">


					<p style="text-align: center;">
						<span class="badge badge-soft-warning" style="font-size: 1.2em;">하향
							대학 과목별 내신 등급</span>
					</p>

					<table border="1" class="table myclass">
						<tr style="font-size: 0.5em; background: #d07684;"
							class="table-warning ">
							<th style="width: 13%;">대학/과목</th>
							<th style="width: 5%;">국어</th>
							<th style="width: 5%;">수학</th>
							<th style="width: 5%;">영어</th>
							<th style="width: 5%;">사회</th>
							<th style="width: 5%;">과학</th>
						</tr>


						<tr class="table-white" style="font-size: 0.5em;">
							<th>충남대</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
						</tr>
						<tr class="table-white" style="font-size: 0.5em;">
							<th>전북대</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>

						</tr>

						<tr class="table-white" style="font-size: 0.5em;">
							<th>상명대</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
							<th>1</th>
						</tr>
					</table>

				</div>
			</div>

			<div class="col-sm-12">

				<div class="col-sm-12">
					<p style="font-size: 1.1em; color: red; margin-left: 200px;">※분석결과:수학이
						부족하며 영어도 부족합니다.앞으로 이렇게 가면 원하는대학에 못갑니다.</p>
				</div>


			</div>


		</div>
	</div>


</body>
