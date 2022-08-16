/*
Template Name: Dashonic - Admin & Dashboard Template
Author: Pichforest
Website: https://Pichforest.com/
Contact: Pichforest@gmail.com
File: Calendar init js
*/

document.addEventListener("DOMContentLoaded", function () {




    var addEvent = new bootstrap.Modal(document.getElementById('datailCalendar'), {
        keyboard: false






   })
    document.getElementById('insertCalendar');
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
//    var externalEventContainerEl = document.getElementById('external-events');

    // init dragable
//    new Draggable(externalEventContainerEl, {
//        itemSelector: '.external-event',
//        eventData: function (eventEl) {
//            return {
//                title: eventEl.innerText,
//                start: new Date(),
//                className: eventEl.getAttribute('data-class')
//            };
//        }
//    });


 //등록
	function insert_go(pc) {

		//pcCode를 받아오기
		var pcCode = pc
		console.log(pcCode);

		//상담리스트에서pcStart value값 받아오기
		var pcStart = $('input[name=pcStart]').val();
		console.log(pcStart);

		//상담 리스트에서 pcEnd value값 받아오기
		var pcEnd = $('input[name=pcEnd]').val();
		console.log(pcEnd);

		//상담 리스트에서 제목 받아오기
		var title = $('input[name=title]').val();
		console.log(title);


//		const date=new Date(pcStart);
//		console.log(date);

		//pccode 저장
		var param = {
			"pcCode" : pcCode
		}

		//pc코드 data에 넣어서 registcalender에 넘기기
		$.ajax({
			url : "/ddit/mconsulting/registcalender.go",
			type : "POST",
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(data) {
				alert("승인되었습니다.");

				window.location.reload();

			},
			error : function(error) {
				alert("error : " + error.status);
			},
			dataType : 'json'

		});
	}


//메시지 전송
	function cancel_go() {

		//content 쓴 텍스트 val로 가져오기


		var content=$('#smscontent').val();

		//content 받아서 controller에 넘기기
		$.ajax({
			url : "/ddit/mconsulting/sendsms.go",
			type : "POST",
			contentType : 'application/json',
			data : {


				"content":content
			},
			success : function(data) {
				alert("메시지가 전송되었습니다.");

				window.location.reload();

			},
			error : function(error) {
				alert("error : " + error.status);
			},
			dataType : 'json'

		});
	}



//삭제
 function delcal_go(){

	 //pccode value값 가져오기
	 var pcCode = $('input[name=pcCode]').val();





	//pccode controller에 넘기기
	$.ajax({
		url : "/ddit/mconsulting/remove.go",
		type : "POST",
		data : {
			"pcCode" :pcCode
		},
		success : function(data) {

			alert("삭제되었습니다.")
			window.location.reload();

		},
		error : function(error) {
			alert("error : " + error.status);
		},
	});
}






//수정
 function modify_go() {


//	 var currentDate = new Date(meetdate);
//	 currentDate = JSON.stringify(meetdate);





	 //pcCode 값 가져오기
	 var pccode = $('input[name=pcCode]').val();
	 console.log(pccode);


	 //상담일 값 가져오기
	 var meetdate = $('input[name=meetDate]').val();
	 console.log(meetdate);

	 //var meet=new Date(meetdate)

	 //상담시작일 value값 가져오기
	 var pcstart= $('input[name=pcStart1]').val();
	// var meet=new Date(pcstart)
	 console.log(pcstart);

	 //상담끝나느시간 value값 가져오기
	 var pcend= $('input[name=pcEnd1]').val();
	 console.log(pcend);



	 //param에 담기
	 var param = {"meetDate":meetdate,"pcStart":pcstart,"pcEnd":pcend,"pcCode":pccode}

	//data에 담아서 controller에 넘기기
		$.ajax({
			url :"/ddit/mconsulting/modfiycalender.go",
			type : "POST",
			contentType: 'application/json',
			data : JSON.stringify(param),
			success : function(data) {
				alert("수정되었습니다.");

				window.location.reload();


			},
			error : function(error) {
				alert("error : " + error.status);
			},
			dataType:'json'

		});
	}


    var defaultEvents = loadingEvents();

    //모든 일정 불러오기.
    function loadingEvents(counsel){
    	var return_value = null;



    	$.ajax({
			url:"/ddit/mconsulting/list.go",
			method: "post",
			contentType:'application/json',
			async: false,
			success: function(success){
				console.log("load list: " + success);
				return_value = success;
			},
			error: function(error){
				alert("load error : " + error.status);
			},
			dataType: "json"
    	})
    	return return_value;
    }






//    var draggableEl = document.getElementById('external-events');
    var calendarEl = document.getElementById('hd-calendar');

    function addNewEvent(info) {
//        addEvent.show();
//        formEvent.classList.remove("was-validated");
//        formEvent.reset();
//        selectedEvent = null;
//        modalTitle.innerText = 'Add Event';
//        newEventData = info;
    }

    //처음에 보여지는 뷰('달') 설정
    function getInitialView() {
    	return 'dayGridMonth';
    }

    function clickDetail(info){
    	 addEvent.show();

         console.log(info);

         formEvent.reset();
         document.getElementById("event-title").value[0] = "";
         selectedEvent = info.event;
         document.getElementById("event-title").value = selectedEvent.title;
         document.getElementById('event-category').value = selectedEvent.classNames[0];
         newEventData = null;
         modalTitle.innerText = 'Edit Event';
         newEventData = null;
     	alert("event Click");
    }



    var calendar = new FullCalendar.Calendar(calendarEl, {
        timeZone: 'local',
        editable: true,
        droppable: true,
        selectable: true,
        initialView: 'dayGridMonth',
        themeSystem: 'bootstrap',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
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
        eventClick: function (info) {
        	clickDetail(info);
        },
        dateClick: function (info) {
//        	alert("event Click")
//            addNewEvent(info);
        },
        events: defaultEvents
    });
    calendar.render();

    /*Add new event*/
    // Form to add new event

    formEvent.addEventListener('submit', function (ev) {
        ev.preventDefault();

        var updatedTitle = document.getElementById("event-title").value;
        var updatedCategory = document.getElementById('event-category').value;

        // validation
        if (forms[0].checkValidity() === false) {
            forms[0].classList.add('was-validated');
        } else {
            if (selectedEvent) {
                selectedEvent.setProp("title", updatedTitle);
                selectedEvent.setProp("classNames", [updatedCategory]);
            } else {
                var newEvent = {
                    title: updatedTitle,
                    start: newEventData.date,
                    allDay: newEventData.allDay,
                    className: updatedCategory
                }
                calendar.addEvent(newEvent);
            }
            addEvent.hide();
        }
    });

    document.getElementById("btn-delete-event").addEventListener("click", function (e) {
        if (selectedEvent) {
            selectedEvent.remove();
            selectedEvent = null;
            selectedEvent.hide();
        }
    });
    document.getElementById("btn-new-event").addEventListener("click", function (e) {
        addNewEvent({ date: new Date(), allDay: true });
    });
});

