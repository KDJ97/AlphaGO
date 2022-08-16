// apex chart를 만들기 위한 js 파일
// 작성자 : 예현의
// 작성일 : 2022-07-01



// 학교 성적 chart
var options = {
  series: [{
  name: "이전 성적",
  data: [44, 55, 41, 64, 22]
}, {
  name: "최근 성적",
  data: [53, 32, 33, 52, 13]
}],
  chart: {
  type: 'bar',
  height: 150,
  width: 210
},
plotOptions: {
  bar: {
    horizontal: false,
    dataLabels: {
      position: 'top',
    },

  }
},
dataLabels: {
  enabled: true,
  offsetX: 0,
  style: {
    fontSize: '8px',
    colors: ['#fff']
  }
},
stroke: {
  show: true,
  width: 1,
  colors: ['#fff']
},
tooltip: {
  shared: true,
  intersect: false
},
xaxis: {
  categories: ['국어', '영어', '수학', '사회', '과학'],
},
};

var chart = new ApexCharts(document.querySelector("#sch_chart"), options);
chart.render();



// 학원 성적 chart

var options = {
		series: [{
			name: "이전 성적",
			data: [53, 32, 33, 52, 13]
		}, {
			name: "최근 성적",
			data: [44, 55, 41, 64, 22]
		}],
		chart: {
			type: 'bar',
			height: 150,
			width: 210
		},
		plotOptions: {
			bar: {
				horizontal: false,
				dataLabels: {
					position: 'top',
				},

			}
		},
		dataLabels: {
			enabled: true,
			offsetX: 0,
			style: {
				fontSize: '8px',
				colors: ['#fff']
			}
		},
		stroke: {
			show: true,
			width: 1,
			colors: ['#fff']
		},
		tooltip: {
			shared: true,
			intersect: false
		},
		xaxis: {
			categories: ['국어', '영어', '수학', '사회', '과학'],
		},
};

var chart = new ApexCharts(document.querySelector("#acd_chart"), options);
chart.render();











document.addEventListener("DOMContentLoaded", function () {


    /* initialize the calendar */

    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var Draggable = FullCalendar.Draggable;

     //init dragable
/*    new Draggable(externalEventContainerEl, {
        itemSelector: '.external-event',
        eventData: function (eventEl) {
            return {
                title: eventEl.innerText,
                start: new Date(),
                className: eventEl.getAttribute('data-class')
            };
        }
    });*/

    var defaultEvents = [{
        title: 'All Day Event',
        start: new Date(y, m, 1),
        className: 'bg-primary'
    },
    {
        title: 'Long Event',
        start: new Date(y, m, d - 5),
        end: new Date(y, m, d - 2),
        className: 'bg-warning'
    },
    {
        id: 999,
        title: 'Repeating Event',
        start: new Date(y, m, d - 3, 16, 0),
        allDay: false,
        className: 'bg-info'
    },
    {
        id: 999,
        title: 'Repeating Event',
        start: new Date(y, m, d + 4, 16, 0),
        allDay: false,
        className: 'bg-primary'
    },
    {
        title: 'Meeting',
        start: new Date(y, m, d, 10, 30),
        allDay: false,
        className: 'bg-success'
    },
    {
        title: 'Lunch',
        start: new Date(y, m, d, 12, 0),
        end: new Date(y, m, d, 14, 0),
        allDay: false,
        className: 'bg-danger'
    },
    {
        title: 'Birthday Party',
        start: new Date(y, m, d + 1, 19, 0),
        end: new Date(y, m, d + 1, 22, 30),
        allDay: false,
        className: 'bg-success'
    },
    {
        title: 'Click for Google',
        start: new Date(y, m, 28),
        end: new Date(y, m, 29),
        url: 'http:google.com/',
        className: 'bg-dark'
    }];

    //var draggableEl = document.getElementById('external-events');
    var calendarEl = document.getElementById('my_calendar');

//    function addNewEvent(info) {
//        addEvent.show();
//        formEvent.classList.remove("was-validated");
//        formEvent.reset();
//        selectedEvent = null;
//        modalTitle.innerText = 'Add Event';
//        newEventData = info;
//    }

/*    function getInitialView() {
        if (window.innerWidth >= 768 && window.innerWidth < 1200) {
            return 'timeGridWeek';
        } else if (window.innerWidth <= 768) {
            return 'listMonth';
        } else {
            return 'dayGridMonth';
        }
    }*/

    var calendar = new FullCalendar.Calendar(calendarEl, {
        height: 300,
        timeZone: 'local',
        editable: false,
        droppable: true,
        selectable: true,
/*        initialView: getInitialView(),*/
        themeSystem: 'bootstrap',

       //responsive
/*        windowResize: function (view) {
            var newView = getInitialView();
            calendar.changeView(newView);
        },*/
//        eventDidMount: function (info) {
//            if (info.event.extendedProps.status === 'done') {
//
//                // Change background color of row
//                info.el.style.backgroundColor = 'red';
//
//                // Change color of dot marker
//                var dotEl = info.el.getElementsByClassName('fc-event-dot')[0];
//                if (dotEl) {
//                    dotEl.style.backgroundColor = 'white';
//                }
//            }
//        },
//        eventClick: function (info) {
//            addEvent.show();
//            formEvent.reset();
//            document.getElementById("event-title").value[0] = "";
//            selectedEvent = info.event;
//            document.getElementById("event-title").value = selectedEvent.title;
//            document.getElementById('event-category').value = selectedEvent.classNames[0];
//            newEventData = null;
//            modalTitle.innerText = 'Edit Event';
//            newEventData = null;
//        },
        dateClick: function (info) {
            addNewEvent(info);
        }
    });
    calendar.render();


});














