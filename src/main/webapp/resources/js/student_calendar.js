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

    //모든 일정 불러오기.
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
        editable: true,
        droppable: true,
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
        	console.log(clickDate);
        	//$('#date-input').val(clickDate);
        	info.el.style.backgroundColor = 'red';
        	console.log('red');

        },
        events: defaultEvents
    });
    calendar.render();





});

