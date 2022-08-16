<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
  <link href="<%=request.getContextPath() %>/resources/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
  <script src="<%=request.getContextPath() %>/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
  <script src="<%=request.getContextPath() %>/resources/js/main.min.js"></script>
  <script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {


    var modalTitle = document.getElementById('modal-title');
    var formEvent = document.getElementById('form-event');
    var selectedEvent = null;
    var newEventData = null;
    var forms = document.getElementsByClassName('needs-validation');
    var selectedEvent = null;
    var newEventData = null;
    var eventObject = null;

    /* initialize the calendar */
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var Draggable = FullCalendar.Draggable;




    var defaultEvents = loadingEvents();

    //일정 불러오기
    function loadingEvents(counsel){
    	var return_value = null;

    	$.ajax({
			url:"/ddit/consulting/calenderData.go",
			method: "get",
			contentType:'application/json',
			async: false,
			success: function(success){
				return_value = success;
			},
			error: function(error){},
			dataType: "json"
    	})
    	return return_value;
    }

    var calendarEl = document.getElementById("counsert-calendar");



    //처음에 보여지는 뷰('달') 설정
    function getInitialView() {
    	return 'dayGridMonth';
    }

    var calendar = new FullCalendar.Calendar(calendarEl, {
        timeZone: 'local',
        editable: false,
        droppable: false,
        selectable: true,
        initialView: 'dayGridMonth',
        themeSystem: 'bootstrap',
        headerToolbar: {
            left: 'prev',
            center: 'title',
            right: 'next'
        },
        // responsive
        windowResize: function (view) {
            var newView = getInitialView();
            calendar.changeView(newView);
        },
        eventDidMount: function (info) {
            if (info.event.extendedProps.status === 'done') {

                // Change background color of row
                info.el.style.backgroundColor = 'red';

                // Change color of dot marker
                var dotEl = info.el.getElementsByClassName('fc-event-dot')[0];
                if (dotEl) {
                    dotEl.style.backgroundColor = 'white';
                }
            }
        },
        dateClick: function (info) {
        	var clickDate = info.dateStr;

        	if(clickDate < getToday()){
        		//이미 지난 날
        		Swal.fire({
       			  icon: 'error',
       			  title: '이미 지난 날짜는 상담일로 선택할 수 없습니다!'
       			})
       			return;
        	}



        	$('#date-input').val(clickDate);
        	$('#start_time').val('');
        	$('#end_time').val('');

        	getReservationList(clickDate);


        },
        events: defaultEvents
    });
    calendar.render();


});

  </script>

<script type="text/javascript">

$(function(){

	//캘린더 css
	$('.fc-prev-button').removeClass('btn-primary');
	$('.fc-prev-button').addClass('btn-purple');
	$('.fc-next-button').removeClass('btn-primary');
	$('.fc-next-button').addClass('btn-purple');
	$('.fc .fc-daygrid-day.fc-day-today .fc-daygrid-day-number').css('background-color', '#564ab1');

	$('#date-input').val(getToday());
	formSetting();
	getReservationList(getToday());
});

//해당 날짜의 예약정보 가져오기
function getReservationList(date){
	//초기화
	for(var i=9; i<=17; i++){
		var btnId = "#" + i + "btn";
		$(btnId).text('예약 선택');
		$(btnId).removeClass('btn-dark');
		$(btnId).addClass('btn-purple');
		$(btnId).removeAttr('disabled');
		$(btnId).attr('onclick', 'setTime('+ i +')');
	}

	//선택한 날짜가 오늘이라면 지난 시간은 선택 불가
	if(date == getToday()){
		var hourNow = new Date().getHours()
		for(var i=9; i<=hourNow; i++){
			var btnName = "#" + i + "btn";
			$(btnName).text('예약 불가');
			$(btnName).removeClass('btn-purple');
			$(btnName).addClass('btn-dark');
			$(btnName).attr('disabled', 'disabled');
			$(btnId).removeAttr('onclick');

		}
	}




	//날짜, 상담자 id, 상담종류
	var counselor = $('#datalist_input').val();
	var con_type = $('#consulting_type').val();

	if(!date){
		date = $('#date-input').val();
	}

	$.ajax({
		type: "GET",
		data : {
			'date' : date,
			'counselor' : counselor,
			'type' : con_type	//m : 원장(진로 상담), t : 선생(성적 상담)
		},
		url:"getReservationList.go",
		success : function(result){

			console.log(result);


			for(var i=0; i<result.length; i++){
				var hour = result[i].split(':')[0];
				var btnName = "#" + hour + "btn";
				$(btnName).text('예약 불가');
				$(btnName).removeClass('btn-purple');
				$(btnName).addClass('btn-dark');
				$(btnName).attr('disabled', 'disabled');
				$(btnId).removeAttr('onclick');

			}

			//printData(result, $('#datalist_input'), $('#print-datalist-template'));
		}
	});

}


function getToday(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}


function formSetting(){
	var con_type = $('#consulting_type').val();

	if(con_type == 't'){
		$('#datalist_label').text('강사');
		$.ajax({
			type: "GET",
			async: false,
			data : {
				'authority' : 'ROLE_TEACHER'
			},
			url:"getCounselorList.go",
			success : function(result){
				printData(result, $('#datalist_input'), $('#print-datalist-template'));
			}
		});

// 		$('textarea').removeAttr('readonly');
// 		$('textarea').prev().css('display', '');
// 		$('textarea').css('display', '');
	}

	if(con_type == 'm'){
		$('#datalist_label').text('원장');
		$.ajax({
			type: "GET",
			async: false,
			data : {
				'authority' : 'ROLE_MASTER'
			},
			url:"getCounselorList.go",
			success : function(result){
				printData(result, $('#datalist_input'), $('#print-datalist-template'));
			}
		});

		//textarea 제거
// 		$('textarea').prev().css('display', 'none');
// 		$('textarea').css('display', 'none');
	}
}

$("#consulting_type").on("change", function(){
	$('#start_time').val('');
	$('#end_time').val('');
	formSetting();
	getReservationList();

});

$("#datalist_input").on("change", function(){
	$('#start_time').val('');
	$('#end_time').val('');
	getReservationList();
});

function setTime(start_hour){
	var end_hour = start_hour + 1;
	if(start_hour == 9) start_hour = '09';
	$('#start_time').val(start_hour + ":00");
	$('#end_time').val(end_hour + ":00");
}

function submit(){
	var start_time = $('#start_time').val();
	var end_time = $('#end_time').val();
	var content = $('textarea').val();

	if((start_time == null || start_time == '') || (end_time == null || end_time == '')){
		Swal.fire({
		  icon: 'error',
		  title: '신청 시간을 선택해주세요!'
		})
		return;
	}

	if(content == null || content.trim() == ''){
		Swal.fire({
		  icon: 'error',
		  title: '내용을 입력해주세요!'
		})
		return;
	}

	//원장 상담일때
	var newForm = $('<form></form>');
	if($('#consulting_type').val() == 'm'){
		newForm.attr("name","newForm");
		newForm.attr("method","post");
		newForm.attr("action","registPacounselt");

		var dateStr = $('#date-input').val();

		var pcStart = new Date(dateStr + " " + start_time);
		var pcEnd = new Date(dateStr + " " + end_time);

		newForm.append($('<input/>', {type: 'hidden', name: 'counSelor', value:$('#datalist_input').val() }));
		newForm.append($('<input/>', {type: 'hidden', name: 'client', value:'${loginUser.id}' }));
		newForm.append($('<input/>', {type: 'hidden', name: 'meetDate', value: pcStart }));
		newForm.append($('<input/>', {type: 'hidden', name: 'pcStart', value: pcStart }));
		newForm.append($('<input/>', {type: 'hidden', name: 'pcEnd', value: pcEnd }));
		newForm.append($('<input/>', {type: 'hidden', name: 'purpose', value: '진로상담' }));
		newForm.append($('<input/>', {type: 'hidden', name: 'title', value: '진로상담' }));
		newForm.append($('<input/>', {type: 'hidden', name: 'content', value: $('textarea').val() }));


		newForm.appendTo('body');
	}


	if($('#consulting_type').val() == 't'){
		newForm.attr("name","newForm");
		newForm.attr("method","post");
		newForm.attr("action","registCounselt");

		var dateStr = $('#date-input').val();

		var conStart = new Date(dateStr + " " + start_time);
		var conEnd = new Date(dateStr + " " + end_time);
		newForm.append($('<input/>', {type: 'hidden', name: 'counselor', value:$('#datalist_input').val() }));
		newForm.append($('<input/>', {type: 'hidden', name: 'client', value:'${loginUser.id}' }));
		newForm.append($('<input/>', {type: 'hidden', name: 'purpose', value: '성적상담' }));
		newForm.append($('<input/>', {type: 'hidden', name: 'title', value: '성적상담' }));
		newForm.append($('<input/>', {type: 'hidden', name: 'content', value: $('textarea').val() }));
		newForm.append($('<input/>', {type: 'hidden', name: 'meetdate', value: conStart }));
		newForm.append($('<input/>', {type: 'hidden', name: 'conStart', value: conStart }));
		newForm.append($('<input/>', {type: 'hidden', name: 'conEnd', value: conEnd }));
		newForm.append($('<input/>', {type: 'hidden', name: 'status', value: '0' }));


		newForm.appendTo('body');

	}

	Swal.fire({
	  title: '상담이 신청되었습니다',
	  icon: 'success'
	}).then((result) => {
		newForm.submit();
	})


}


$('#date-input').change(function(){
	if($(this).val() < getToday()){
		//이미 지난 날
		Swal.fire({
		  icon: 'error',
		  title: '이미 지난 날짜는 상담일로 선택할 수 없습니다!'
		})
		return;
	}
	$('#start_time').val('');
	$('#end_time').val('');

	getReservationList($(this).val());

});
</script>


<script type="text/x-handlebars-template" id="print-datalist-template">
{{#each .}}
  <option value="{{id}}">{{name}}</option>
{{/each}}
</script>


</head>

<body>
	<div class="row gx-3 gy-2">
		<div class="col-6" style="float: left;">
			<div class="card">
				<div class="card-body">
					<h5 style="margin-bottom: 15px; font-weight: bold;">
						<i class="uil-calender" style="margin-right: 10px;"></i>상담신청


						 <a href="<%=request.getContextPath() %>/consulting/list.go">
						<button type="button"
							style="float: right; height: 30px; padding-top: 5px; display: flex;"
							class="btn btn-secondary btn-rounded">상담관리 목록으로 가기</button></a>
					</h5>
					<div class="row pt-3">
					  <div class="col-4 pt-2">
						<span style="font-weight: bold;">구분</span>
					  </div>
					  <div class="col-8">
						<select id="consulting_type" class="form-select">
							<option value="t">성적 상담</option>
							<option value="m">진로 상담</option>
						</select>
					  </div>
					</div>

					<hr>

					<div class="row">
					  <div class="col-4 pt-2">
						<span id="datalist_label" style="font-weight: bold;">강사</span>
					  </div>
					  <div class="col-8">
						<select class="form-select"  id="datalist_input"></select>
  					  </div>
					</div>

					<hr>

					<div class="row">
					  <div class="col-4"><span style="font-weight: bold;">신청자</span></div>
					  <div class="col-8"><span style="font-weight: bold;">${loginUser.name }</span></div>
					</div>
					<hr>
					<div class="col-sm-12">
					  <div class="row">
						<div class="col-4" style="font-weight: bold;">예약일</div>
						<div class="col-4" style="font-weight: bold;">시작시간</div>
						<div class="col-4" style="font-weight: bold;">종료시간</div>
					  </div>
						<hr>
					  <div class="row">
						<div class="col-4" style="font-weight: bold; float: left;">
						  <input id="date-input" class="form-control" type="date" >
						</div>
						<div class="col-4" style="font-weight: bold;">
							<input class="form-control" type="time" id="start_time" readonly>
					    </div>
						<div  class="col-4" style="font-weight: bold;">
							<input class="form-control" type="time" id="end_time" readonly>
						</div>
					  </div>



					</div>

					<hr>

					<p style="font-weight: bold;">내용</p>
					<textarea class="form-control" placeholder="내용을 입력하세요" style="height: 202px; margin-bottom: 10px; resize: none;"></textarea>

					<button class="btn btn-purple"
						style="float: right; margin-left: 7px;" type="button" onclick="submit()">신청하기</button>



				</div>
			</div>
		</div>
		<div class="col-6">
			<div class="card">
				<div class="card-body">

					<!-- 캘린더 -->
				<div id="counsert-calendar"  ></div>



					<table class="table   table-bordered text-center">

						<tr class="table-white" style="font-size: 0.95em;">
							<th class="bg-secondary text-white font-size-16" style="width: 1%; font-weight: bold; vertical-align: middle;">09:00</th>
							<th style="width: 3%;">
							  <button id="9btn" onclick="setTime(9)"
							  	type="button" class="btn btn-purple">예약 선택</button>
							</th>
							<th class="bg-secondary text-white font-size-16" style="width: 1%; font-weight: bold; vertical-align: middle;">10:00</th>
							<th style="width: 3%;">
							  <button id="10btn" onclick="setTime(10)"
							  type="button" class="btn btn-purple">예약 선택</button>
							  <!-- <button type="button"class="btn btn-dark" disabled>예약 불가</button> -->
							</th>


						</tr>
						<tr class="table-white">
							<th class="bg-secondary text-white font-size-16" style="font-weight: bold; vertical-align: middle;">11:00</th>
							<th>
							  <button id="11btn" onclick="setTime(11)"
							  type="button" class="btn btn-purple">예약 선택</button>
							</th>
							<th class="bg-secondary text-white font-size-16" style="font-weight: bold; vertical-align: middle;">13:00</th>
							<th>
							  <button id="13btn" onclick="setTime(13)"
							  type="button" class="btn btn-purple">예약 선택</button>
							</th>


						</tr>

						<tr class="table-white">
							<th class="bg-secondary text-white font-size-16" style="font-weight: bold; vertical-align: middle;">14:00</th>
							<th>
							  <button id="14btn" onclick="setTime(14)"
							  type="button" class="btn btn-purple">예약 선택</button>
							</th>
							<th class="bg-secondary text-white font-size-16" style="font-weight: bold; vertical-align: middle;">15:00</th>
							<th>
							  <button id="15btn" onclick="setTime(15)"
							  type="button" class="btn btn-purple">예약 선택</button>
							</th>
						</tr>

						<tr class="table-white">
							<th class="bg-secondary text-white font-size-16" style="font-weight: bold; vertical-align: middle;">16:00</th>
							<th>
							  <button id="16btn" onclick="setTime(16)"
							  type="button" class="btn btn-purple">예약 선택</button>
							</th>
							<th class="bg-secondary text-white font-size-16" style="font-weight: bold; vertical-align: middle;">17:00</th>
							<th>
							  <button id="17btn" onclick="setTime(17)"
							  type="button" class="btn btn-purple">예약 선택</button>
							</th>
						</tr>

					</table>

				</div>
			</div>


		</div>
	</div>

</body>