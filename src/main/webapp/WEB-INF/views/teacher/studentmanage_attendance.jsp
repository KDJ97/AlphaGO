<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<script src="<%=request.getContextPath() %>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
<script type="text/javascript">
var options = {
  series: [20, 1, 1, 2, 4],
  chart: {
    height: 300,
    type: 'donut',
  },
  legend: {
    position: 'bottom'
  },
  dataLabels: {
    dropShadow: {
      enabled: false,
    }
  },
  labels: ['출석', '결석', '지각', '조퇴', '외출'],
  colors: ["#038edc", "#f34e4e", "#f7cc53", "#74788d", "#564ab1"]
};

var chart = new ApexCharts(document.querySelector("#att_chart"), options);
chart.render();

</script>

</head>
<body>
  <div class="row">
	<h4>출결조회</h4>
    <div class="col-4">
      <div class="card">
		<div class="card-header with-border">
			<div id="keyword" class="card-tools" style="width: 350px; float: right;">
				<div class="input-group">
					<select class="form-select col-md-3" name="searchType"
						id="searchType">
						<option value="t" ${cri.searchType eq 't' ? 'selected':'' }>전체</option>
						<option value="c" ${cri.searchType eq 'c' ? 'selected':'' }>학생명</option>
					</select>
					<input class="form-control" type="text" style="width: 130px;"
						name="keyword" placeholder="검색어를 입력하세요." value="${cri.keyword }" />
					<span class="input-group-append">
						<button class="btn btn-success" style="float: right;"
							type="button" id="searchBtn" data-card-widget="search"
							onclick="list_go(1);">
							<i class="fa fa-fw fa-search"></i>
						</button>
					</span>
				</div>
			</div>
		</div>
		<div class="card-body">

				<table class="table table-hover text-center">
				   <thead>
					<tr style="background:#8BDDA8;">
						<th style="font-weight: bold;">이름</th>
						<th style="font-weight: bold;">전화번호</th>
						<th style="font-weight: bold;">출결</th>
					</tr>
				   </thead>
					<tr style="cursor: pointer;">
						<td style="">이형범</td>
						<td style="">010-1234-5555</td>
						<td style=""><span class="badge rounded-pill badge-soft-primary" style="font-size: 1.0em;">출석</span></td>
					</tr>
					<tr style="cursor: pointer;">
						<td style="">이형범</td>
						<td style="">010-1234-5555</td>
						<td style=""><span class="badge rounded-pill badge-soft-primary" style="font-size: 1.0em;">출석</span></td>
					</tr>
					<tr style="cursor: pointer;">
						<td style="">이형범</td>
						<td style="">010-1234-5555</td>
						<td style=""><span class="badge rounded-pill badge-soft-primary" style="font-size: 1.0em;">출석</span></td>
					</tr>
					<tr style="cursor: pointer;">
						<td style="">이형범</td>
						<td style="">010-1234-5555</td>
						<td style=""><span class="badge rounded-pill badge-soft-primary" style="font-size: 1.0em;">출석</span></td>
					</tr>
					<tr style="cursor: pointer;">
						<td style="">이형범</td>
						<td style="">010-1234-5555</td>
						<td style=""><span class="badge rounded-pill badge-soft-primary" style="font-size: 1.0em;">출석</span></td>
					</tr>
					<tr style="cursor: pointer;">
						<td style="">이형범</td>
						<td style="">010-1234-5555</td>
						<td style=""><span class="badge rounded-pill badge-soft-primary" style="font-size: 1.0em;">출석</span></td>
					</tr>
					<tr style="cursor: pointer;">
						<td style="">이형범</td>
						<td style="">010-1234-5555</td>
						<td style=""><span class="badge rounded-pill badge-soft-primary" style="font-size: 1.0em;">출석</span></td>
					</tr>
					<tr style="cursor: pointer;">
						<td style="">이수민</td>
						<td style="">010-5555-6666</td>
						<td style=""><span class="badge rounded-pill badge-soft-danger" style="font-size: 1.0em;">결석</span></td>
					</tr>
					<tr style="cursor: pointer;">
						<td style="">이수민</td>
						<td style="">010-5555-6666</td>
						<td style=""><span class="badge rounded-pill badge-soft-danger" style="font-size: 1.0em;">결석</span></td>
					</tr>
					<tr style="cursor: pointer;">
						<td style="">이수민</td>
						<td style="">010-5555-6666</td>
						<td style=""><span class="badge rounded-pill badge-soft-danger" style="font-size: 1.0em;">결석</span></td>
					</tr>
					<tr style="cursor: pointer;">
						<td style="">이수민</td>
						<td style="">010-5555-6666</td>
						<td style=""><span class="badge rounded-pill badge-soft-danger" style="font-size: 1.0em;">결석</span></td>
					</tr>
					<tfoot>
		             <tr>
		               <td colspan="5" style="padding-bottom: 0px;">
		                 <div class="d-flex justify-content-center">
			          	  <ul class="pagination pagination-rounded">
			               <li class="page-item disabled">
			                   <span class="page-link"><i class="mdi mdi-chevron-left"></i></span>
			               </li>
			               <li class="page-item"><a class="page-link" href="#">1</a></li>
			               <li class="page-item active">
			                   <span class="page-link">
			                       2
			                       <span class="sr-only">(current)</span>
			                   </span>
			               </li>
			               <li class="page-item"><a class="page-link" href="#">3</a></li>
			               <li class="page-item">
			                   <a class="page-link" href="#"><i class="mdi mdi-chevron-right"></i></a>
			               </li>
			              </ul>
		                 </div>
			           </td>
		             </tr>

		          </tfoot>
				</table>

			</div><!-- 			학생 출결정보나오는리스트 끝 -->
		</div>
    </div>
    <div class="col-8">
    	<div class="card">
			<div class="card-header with-border">
			  <div class="hstack gap-3">
                 <div class="p-1 px-2" style="vertical-align: middle;"><span style="font-weight: bold; font-size: 1.2em;"><i class="uil uil-user me-2"></i>이수민</span></div>
                 <div class="ms-auto">
                    <input class="form-control" type="month" value="2019-08" id="example-month-input">
                 </div>
                 <div>
                    <button type="button" class="btn btn-soft-primary">저장</button>
                 </div>
               </div>
			</div>
			<br>
			<div class="card-body">
			  <div>
				<table class="table text-center" style="vertical-align: middle;">
				  <thead>
					<tr style="background:#8BDDA8;">
						<th style="font-weight: bold;">일자</th>
						<th style="font-weight: bold;">출석시간</th>
						<th style="font-weight: bold;">하원시간</th>
						<th style="font-weight: bold;">출결</th>
						<th style="font-weight: bold;">사유 </th>
					</tr>
				  </thead>
					<tr>
						<td style="">2022.04.06</td>
						<td style="">18:00</td>
						<td style="">20:20</td>
						<td style="">
							<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                                   <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
                                   <label class="btn btn-outline-primary btn-sm" for="btnradio1">출석</label>

                                   <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
                                   <label class="btn btn-outline-danger btn-sm" for="btnradio2">결석</label>

                                   <input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off">
                                   <label class="btn btn-outline-warning btn-sm" for="btnradio3">지각</label>

                                   <input type="radio" class="btn-check" name="btnradio" id="btnradio4" autocomplete="off">
                                   <label class="btn btn-outline-purple btn-sm" for="btnradio4">외출</label>

                                   <input type="radio" class="btn-check" name="btnradio" id="btnradio5" autocomplete="off">
                                   <label class="btn btn-outline-secondary btn-sm" for="btnradio5">조퇴</label>

                               </div>
						</td>
						<td>
						  <input type="text" class="form-control" maxlength="20"placeholder="사유를 입력해주세요(20자이내)">
						</td>
					</tr>
					<tr>
						<td style="">2022.04.06</td>
						<td style="">18:00</td>
						<td style="">20:20</td>
						<td style="">
							<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                                   <input type="radio" class="btn-check" name="btnradio1" id="btnradio11" autocomplete="off" >
                                   <label class="btn btn-outline-primary btn-sm" for="btnradio1">출석</label>

                                   <input type="radio" class="btn-check" name="btnradio1" id="btnradio21" autocomplete="off" checked>
                                   <label class="btn btn-outline-danger btn-sm" for="btnradio21">결석</label>

                                   <input type="radio" class="btn-check" name="btnradio1" id="btnradio31" autocomplete="off">
                                   <label class="btn btn-outline-warning btn-sm" for="btnradio31">지각</label>

                                   <input type="radio" class="btn-check" name="btnradio1" id="btnradio41" autocomplete="off">
                                   <label class="btn btn-outline-purple btn-sm" for="btnradio41">외출</label>

                                   <input type="radio" class="btn-check" name="btnradio1" id="btnradio51" autocomplete="off">
                                   <label class="btn btn-outline-secondary btn-sm" for="btnradio51">조퇴</label>
                               </div>
						</td>
						<td>
						  <input type="text" class="form-control" maxlength="20"placeholder="사유를 입력해주세요(20자이내)">
						</td>
					</tr>
				</table>
			  </div><!--스크롤 나오게하려고 조작한 곳  -->
		    </div><!-- 학생 출결정보나오는리스트 끝 -->
		</div>
		<div class="card">
		  <div class="card-header">
		    <span style="font-weight: bold; font-size: 1.2em;"><i class="uil uil-notes me-2"></i>출결 월별 분석</span>
		  </div>
	 	  <div class="card-body">
			  <!-- 출석 그래프 넣을곳 -->
			  <div id="att_chart" style="height: 100px;"></div>
			  <hr>
		      <table class="table table-bordered text-center" style="width: 100%;top-margin:100px;">
		        <thead>
					<tr style="background:#8BDDA8;">
						<th style="font-weight: bold;">이름</th>
						<th style="font-weight: bold;">출석일</th>
						<th style="font-weight: bold;">결석일</th>
						<th style="font-weight: bold;">지각일</th>
						<th style="font-weight: bold;">조퇴일</th>
						<th style="font-weight: bold;">외출일</th>
						<th style="font-weight: bold;">출석율</th>
					</tr>
		        </thead>
				<tr>
					<td style="">이형범</td>
					<td style="">20</td>
					<td style="">1</td>
					<td style="">1</td>
					<td style="">2</td>
					<td style="">4</td>
					<td style="">71%</td>
				</tr>
			</table>
		</div>
	  </div>
    </div>
  </div>

</body>
</html>