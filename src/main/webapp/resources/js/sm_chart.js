   var options = {
          series: [{
            name: "Desktops",
            data: [40, 51, 60]
        }],
          chart: {
          height: 300,
          width:500,
          type: 'line',
          zoom: {
            enabled: false
          }
        },
        dataLabels: {
          enabled: false
        },
//        stroke: {
//          curve: 'straight'
//        },
//        title: {
//          text: 'Product Trends by Month',
//          align: 'left'
//        },
        grid: {
          row: {
            colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
            opacity: 0.5
          },
        },
        xaxis: {
          categories: ['1-1', '1-2', '1-3'],
        }
        };

        var chart = new ApexCharts(document.querySelector("#chart"), options);
        chart.render();
        
        
        
        var options = {
                series: [{
                  name: "Desktops",
                  data: [40, 51, 60]
              }],
                chart: {
                height: 350,
                width:240,
                type: 'line',
                zoom: {
                  enabled: false
                }
              },
              dataLabels: {
                enabled: false
              },
//              stroke: {
//                curve: 'straight'
//              },
//              title: {
//                text: 'Product Trends by Month',
//                align: 'left'
//              },
              grid: {
                row: {
                  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
                  opacity: 0.5
                },
              },
              xaxis: {
                categories: ['1-1', '1-2', '1-3'],
              }
              };

              var chart = new ApexCharts(document.querySelector("#chart2"), options);
              chart.render();
        
        
        
        var options = {
      		  series: [{
      			  name: 'Series 1',
      			  data: [80, 50, 30, 40, 100, 20],
      		  }],
      		  chart: {
      			  height: 350,
      			  width: 270,
      			  type: 'radar',
      		  },
      		  xaxis: {
      			  categories: ['January', 'February', 'March', 'April', 'May', 'June']
      		  }
        };
        
        var chart = new ApexCharts(document.querySelector("#acd_social_chart2"), options);
        chart.render();
        
        
        
        
        
        var options = {
                series: [${dayMap.day1}, ${dayMap.day2}, ${dayMap.day3}, ${dayMap.day4}, ${dayMap.day5}],
                labels:['출근', '결근', '지각', '외출', '조퇴'],
          	  colors: ['#038edc', '#f34e4e', '#f7cc53', '#564ab1', '#74788d'],
                chart: {
                type: 'donut',
              },
              responsive: [{
                breakpoint: 480,
                options: {
                  chart: {
                    width: 200
                  },
                  legend: {
                    position: 'bottom'
                  }
                }
              }]
              };

              var chart = new ApexCharts(document.querySelector("#chart_donut"), options);
              chart.render();
        
              
              
              
              
              var options = {
                      series: [{
                      name: 'Net Profit',
                      data: [44, 55, 57]
                    }, {
                      name: 'Revenue',
                      data: [76, 85, 101]
                    }, {
                      name: 'Free Cash Flow',
                      data: [35, 41, 36]
                    }],
                      chart: {
                      type: 'bar',
                      height: 350,
                      width:230
                    },
                    plotOptions: {
                      bar: {
                        horizontal: false,
                        columnWidth: '55%',
                        endingShape: 'rounded'
                      },
                    },
                    dataLabels: {
                      enabled: false
                    },
                    stroke: {
                      show: true,
                      width: 2,
                      colors: ['transparent']
                    },
                    xaxis: {
                      categories: ['Feb', 'Mar', 'Apr'],
                    },
                    yaxis: {
                      title: {
                        text: '$ (thousands)'
                      }
                    },
                    fill: {
                      opacity: 1
                    },
                    tooltip: {
                      y: {
                        formatter: function (val) {
                          return "$ " + val + " thousands"
                        }
                      }
                    }
                    };

                    var chart = new ApexCharts(document.querySelector("#barchart"), options);
                    chart.render();
                  
          
                    
                    
                    
                    //원생 막대차트
             
                    var d1 = $('.d1').text();
                    var d2 = $('.d2').text();
                    var d3 = $('.d3').text();
                    var d4 = $('.d4').text();
                    var d5 = $('.d5').text();
                    var aver4=(Number(d1)+Number(d2)+Number(d3)+Number(d4)+Number(d5))/5;
                    var e1 = $('.e1').text();
                    var e2 = $('.e2').text();
                    var e3 = $('.e3').text();
                    var e4 = $('.e4').text();
                    var e5 = $('.e5').text();
                    var aver5=(Number(e1)+Number(e2)+Number(e3)+Number(e4)+Number(e5))/5;
                    var f1 = $('.f1').text();
                    var f2 = $('.f2').text();
                    var f3 = $('.f3').text();
                    var f4 = $('.f4').text();
                    var f5 = $('.f5').text();
                    var aver6=(Number(f1)+Number(f2)+Number(f3)+Number(f4)+Number(f5))/5;
              
                    
                    var mygrade1=$('.mygrade').text();
                
                    
                    var fu1=$('.d').text();
                    var su2=$('.e').text();
                    var cu3=$('.f').text();
                    
                 
                    var options = {
                    		   series: [
                    	            { name: '희망대학 평균', data: [aver4,aver5,aver6] },
                    	            { name: '원생 평균', data: [mygrade1,mygrade1,mygrade1] }
                    	        ]
                    			,
                            chart: {
                            type: 'bar',
                            height: 235,
                            toolbar:{
                            	show:false
                            }
                          },
                          plotOptions: {
                            bar: {
                              horizontal:true,
                              dataLabels: {
                                position: 'top',
                              },
                            }
                          },
                          dataLabels: {
                            enabled: true,
                            offsetX: -6,
                            style: {
                              fontSize: '12px',
                              colors: ['#fff']
                            }
                          },
                          stroke: {
                            show: true,
                            width: 1,
                            colors: ['#fff']
                          },
                     /*     tooltip: {
                            shared: true,
                            intersect: false
                          },*/
                          xaxis: {
                        	  categories: [fu1,su2,cu3],
                          },
                          };

                          var chart = new ApexCharts(document.querySelector("#chart_bar"), options);
                          chart.render();
              
                         
                          
                          
                      
                          
                          
                          //학부모 막대차트
                          
                          
                          //원생성적 등급
                        
                          
                          var gr = $('.abc').text();
                          var gr1 = $('.ab').text();
                          var gr2 = $('.aa').text();
                          var gr3 = $('.bb').text();
                          var gr4 = $('.cc').text();
                          
                          var aver=(Number(gr)+Number(gr1)+Number(gr2)+Number(gr3)+Number(gr4))/5;
        
                          
                          var b1 = $('.b1').text();
                          var b2 = $('.b2').text();
                          var b3 = $('.b3').text();
                          var b4 = $('.b4').text();
                          var b5 = $('.b5').text();
                          
                          var aver2=(Number(b1)+Number(b2)+Number(b3)+Number(b4)+Number(b5))/5;
                          
                          
                          var c1 = $('.c1').text();
                          var c2 = $('.c2').text();
                          var c3 = $('.c3').text();
                          var c4 = $('.c4').text();
                          var c5 = $('.c5').text();
                          
                          var aver3=(Number(c1)+Number(c2)+Number(c3)+Number(c4)+Number(c5))/5;
                          
                          
                          var mygrade=$('.mygrade').text();
                          
                          var fu=$('.a').text();
                          var su=$('.b').text();
                          var cu=$('.c').text();
                        
                          var options = {
                        		  series: [
                      	            { name: '희망대학 평균', data: [aver,aver2,aver3] },
                      	            { name: '원생 평균', data: [mygrade, mygrade,mygrade] }
                      	        ]
                      			,
                                chart: {
                                    type: 'bar',
                                    height: 235,
                                    toolbar:{
                                    	show:false
                                    }
                                  },
                                plotOptions: {
                                  bar: {
                                    horizontal: true,
                                    dataLabels: {
                                      position: 'top',
                                    },
                                  }
                                },
                                dataLabels: {
                                  enabled: true,
                                  offsetX: -6,
                                  style: {
                                    fontSize: '12px',
                                    colors: ['#fff']
                                  },
                                  legend:{
                                	  show:false
                                  }
                                },
                                stroke: {
                                  show: true,
                                  width: 1,
                                  colors: ['#fff']
                                },
                               
                                tooltip: {
                                  shared:false,
                                  intersect: false
                                },
                                xaxis: {
                                  categories: [fu,su,cu],
                                },
                                };

                                var chart = new ApexCharts(document.querySelector("#chart_bar2"), options);
                                chart.render();
                    
        
        
              
              
              //캘린더
                                /*
                                Template Name: Dashonic - Admin & Dashboard Template
                                Author: Pichforest
                                Website: https://Pichforest.com/
                                Contact: Pichforest@gmail.com
                                File: Calendar init js
                                */

                                document.addEventListener("DOMContentLoaded", function () {

//                                    var addEvent = new bootstrap.Modal(document.getElementById('event-modal'), {
//                                        keyboard: false
//                                    })
//                                    document.getElementById('event-modal');
//                                    var modalTitle = document.getElementById('modal-title');
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
                                    var externalEventContainerEl = document.getElementById('external-events');

                                    // init dragable
//                                    new Draggable(externalEventContainerEl, {
//                                        itemSelector: '.external-event',
//                                        eventData: function (eventEl) {
//                                            return {
//                                                title: eventEl.innerText,
//                                                start: new Date(),
//                                                className: eventEl.getAttribute('data-class')
//                                            };
//                                        }
//                                    });

                                    var defaultEvents = [
//                                    {
//                                        title: 'Birthday Party',
//                                        start: new Date(y, m, d + 1, 19, 0),
//                                        end: new Date(y, m, d + 1, 22, 30),
//                                        allDay: false,
//                                        className: 'bg-success'
//                                    }
                                    ];

//                                    var draggableEl = document.getElementById('external-events');
                                    var calendarEl = document.getElementById('hd_calendar');

                                    function addNewEvent(info) {
                                        addEvent.show();
                                        formEvent.classList.remove("was-validated");
                                        formEvent.reset();
                                        selectedEvent = null;
                                        modalTitle.innerText = 'Add Event';
                                        newEventData = info;
                                    }

                                    function getInitialView() {
                                        if (window.innerWidth >= 768 && window.innerWidth < 1200) {
                                            return 'timeGridWeek';
                                        } else if (window.innerWidth <= 768) {
                                            return 'listMonth';
                                        } else {
                                            return 'dayGridMonth';
                                        }
                                    }

                                    var calendar = new FullCalendar.Calendar(calendarEl, {
                                    	contentHeight: "auto",
                                        timeZone: 'local',
                                        editable: true,
                                        droppable: true,
                                        selectable: true,
                                        initialView: getInitialView(),
                                        themeSystem: 'bootstrap',
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
//                                        eventClick: function (info) {
//                                            addEvent.show();
//                                            formEvent.reset();
//                                            document.getElementById("event-title").value[0] = "";
//                                            selectedEvent = info.event;
//                                            document.getElementById("event-title").value = selectedEvent.title;
//                                            document.getElementById('event-category').value = selectedEvent.classNames[0];
//                                            newEventData = null;
//                                            modalTitle.innerText = 'Edit Event';
//                                            newEventData = null;
//                                        },
//                                        dateClick: function (info) {
//                                            addNewEvent(info);
//                                        },
                                        events: defaultEvents
                                    });
                                    calendar.render();

                                    /*Add new event*/
                                    // Form to add new event

//                                    formEvent.addEventListener('submit', function (ev) {
//                                        ev.preventDefault();
                                //
//                                        var updatedTitle = document.getElementById("event-title").value;
//                                        var updatedCategory = document.getElementById('event-category').value;
                                //
//                                        // validation
//                                        if (forms[0].checkValidity() === false) {
//                                           forms[0].classList.add('was-validated');
//                                        } else {
//                                            if (selectedEvent) {
//                                                selectedEvent.setProp("title", updatedTitle);
//                                                selectedEvent.setProp("classNames", [updatedCategory]);
//                                            } else {
//                                                var newEvent = {
//                                                    title: updatedTitle,
//                                                    start: newEventData.date,
//                                                    allDay: newEventData.allDay,
//                                                   className: updatedCategory
//                                                }
//                                                calendar.addEvent(newEvent);
//                                            }
//                                           addEvent.hide();
//                                        }
//                                    });

//                                    document.getElementById("btn-delete-event").addEventListener("click", function (e) {
//                                        if (selectedEvent) {
//                                            selectedEvent.remove();
//                                            selectedEvent = null;
//                                            selectedEvent.hide();
//                                        }
//                                    });
//                                    document.getElementById("btn-new-event").addEventListener("click", function (e) {
//                                        addNewEvent({ date: new Date(), allDay: true });
//                                    });
                                });
                                
                                
                                
                                var options = {
                                        series: [25, 15, 44, 55, 41, 17],
                                        chart: {
                                        width: 250,
                                        height: 230,
                                        type: 'pie',
                                      },
                                      labels: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
                                      theme: {
                                        monochrome: {
                                          enabled: true
                                        }
                                      },
                                      plotOptions: {
                                        pie: {
                                          dataLabels: {
                                            offset: -5
                                          }
                                        }
                                      },
                                      title: {
                                        text: "Monochrome Pie"
                                      },
                                      dataLabels: {
                                        formatter(val, opts) {
                                          const name = opts.w.globals.labels[opts.seriesIndex]
                                          return [name, val.toFixed(1) + '%']
                                        }
                                      },
                                      legend: {
                                        show: false
                                      }
                                      };

                                var chart = new ApexCharts(document.querySelector("#subcnt_chart2"), options);
                                chart.render();
                                
                                
                                
                                
                                
                                
                                var options = {
                                		series : [ {
                                			name :"증감률",
                                			data : [1,0.7,1.2,1.8,1,0.2,0.3,0.8]
                                		} ],
                                		chart : {
                                			width :430,
                                			height :300,
                                			type : 'line',
                                			zoom : {
                                				enabled : false
                                			}
                                		},
                                		dataLabels : {
                                			enabled : false
                                		},
                                		stroke : {
                                			curve :'straight'
                                		},
                                		title : {
                                			text : '성적 증감률',
                                			align : 'left'
                                		},
                                		grid : {
                                			row : {
                                				colors : ['#f3f3f3', 'transparent' ], // takes an array which will
                                														// be repeated on columns
                                				opacity : 0.5
                                			},
                                		},
                                		xaxis : {
                                			categories : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월']
                                		}
                                	};

                                	var chart = new ApexCharts(document.querySelector("#student_grade"), options);
                                	chart.render();