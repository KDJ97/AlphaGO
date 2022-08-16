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

    var defaultEvents = loadingEvents();
    
    //모든 일정 불러오기.
    function loadingEvents(){
    	var return_value = null;
    	
    	$.ajax({
			url:"master/calendar/list.go",
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
    var calendarEl = document.getElementById('hd-calender');

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
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
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

