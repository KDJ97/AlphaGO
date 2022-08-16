function oneBarGraph(data1, category){
	var options = {
		series : [ {
			data : data1
		},
// 		{
// 			data : [ 53, 32, 33, 52, 13 ]
// 		} 
		],
		chart : {
			type : 'bar',
			height : 430,
			toolbar:{
				show:false
			}

		},
		plotOptions : {
			bar : {
				horizontal : true,
				dataLabels : {
					position : 'top',
				},
			}
		},
		dataLabels : {
			enabled : true,
			offsetX : -6,
			style : {
				fontSize : '12px',
				colors : [ '#fff' ]
			}
		},
		stroke : {
			show : true,
			width : 1,
			colors : [ '#fff' ]
		},
//		tooltip : {
//			shared : true,
//			intersect : false
//		},
		xaxis : {
			categories : category,
		},
	};
	var chart = new ApexCharts(document.querySelector("#chart"), options);
	chart.render();
}

function twoBarGraph(data1, data2, category){
	var options = {
			series : [
				{name:'학교평균', data : data1},
				{name:'학생평균', data : data2}
			],
			chart : {
				type : 'bar',
				height : 430,
				toolbar:{
					show:false
				}
			},
			plotOptions : {
				bar : {
					horizontal : true,
					dataLabels : {
						position : 'top',
					},
				}
			},
			dataLabels : {
				enabled : true,
				offsetX : -6,
				style : {
					fontSize : '12px',
					colors : [ '#fff' ]
				}
			},
			stroke : {
				show : true,
				width : 1,
				colors : [ '#fff' ]
			},
//			tooltip : {
//				shared : true,
//				intersect : false
//			},
			xaxis : {
				categories : category,
			},
	};
	var chart = new ApexCharts(document.querySelector("#chart"), options);
	chart.render();
}