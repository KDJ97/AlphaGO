//----------전체 원생수 차트 시작--------------
function allMemberCnt(memdata, months){
	var options = {
		series : [ {
			name : "원생수",
			data : memdata
		} ],
		chart : {
			width: 500,
			height : 250,
			type : 'line',
			zoom : {
				enabled : false
			},
			toolbar:{
				show:false
			}

		},
		dataLabels : {
			enabled : false
		},
		stroke : {
			curve : 'straight'
		},
	//	title : {
	//		align : 'left'
	//	},
		grid : {
			row : {
				colors : [ '#f3f3f3', 'transparent' ], // takes an array which will
														// be repeated on columns
				opacity : 0.5
			},
		},
		xaxis : {
			categories : months
		}
	};
	
	var chart = new ApexCharts(document.querySelector("#allcnt_chart"), options);
	chart.render();
}
// ----------전체 원생수 차트 끝--------------

// ----------과목별 원생수 차트 시작-----------
function donutGraph(names, datas){
	var options = {
	        series: datas,//!! 인트형 배열 
	        chart: {
	        width: '100%',
	        height: 250,
	        type: 'pie'
	      },
	      labels: names,//!!!라벨 string 배열
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
	//      title: {
	//        text: "Monochrome Pie"
	//      },
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
	
	var chart = new ApexCharts(document.querySelector("#subcnt_chart"), options);
	chart.render();
}
// ----------과목별 원생수 차트 끝-----------

//----------학교별 원생수 차트 시작-----------
function donutGraph2(names, datas){
	var options = {
	        series: datas,
	        chart: {
	        width: '100%',
	        height: 250,
	        type: 'pie'
	      },
	      labels: names,
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
	//      title: {
	//        text: "Monochrome Pie"
	//      },
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
	
	var chart = new ApexCharts(document.querySelector("#schoolcnt_chart"), options);
	chart.render();
}
// ----------학교별 원생수 차트 끝----------- 


	
	
	
	
	
	
	
	
	
	
	
	