/**
 *  작성자 : 예현의
 *  작성일 : 2022-07-06
 */

// 학교성적 chart list

// 국어
 var options = {
    series: [{
    data: [21, 22, 10]
  }],
    chart: {
    height: 250,
    width: 340,
    type: 'bar',
    events: {
      click: function(chart, w, e) {
        // console.log(chart, w, e)
      }
    }
  },
  plotOptions: {
    bar: {
      columnWidth: '45%',
      distributed: true,
    }
  },
  dataLabels: {
    enabled: false
  },
  legend: {
    show: false
  },
  xaxis: {
    categories: [
      ['John'],
      ['Joe'],
      ['Jake']
    ],
    labels: {
      style: {
        fontSize: '12px'
      }
    }
  }
  };

  var chart = new ApexCharts(document.querySelector("#kor_chart"), options);
  chart.render();


// 국어 성적 추이
var options = {
    series: [{
      name: "홍길동",
      data: [10, 41, 35, 51, 49, 62, 69, 91, 100]
  }],
    chart: {
    height: 250,
    width: 340,
    type: 'line',
    zoom: {
      enabled: false
    }
  },
  dataLabels: {
    enabled: false
  },
  stroke: {
    curve: 'straight'
  },
  title: {
    text: '국어 성적 추이',
    align: 'left'
  },
  grid: {
    row: {
      colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
      opacity: 0.5
    },
  },
  xaxis: {
    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
  }
  };

  var chart = new ApexCharts(document.querySelector("#kor_line_chart"), options);
  chart.render();
  
  
// 영어
  var options = {
    series: [{
    data: [21, 22, 10]
  }],
    chart: {
    height: 250,
    width: 340,
    type: 'bar',
    events: {
      click: function(chart, w, e) {
        // console.log(chart, w, e)
      }
    }
  },
  plotOptions: {
    bar: {
      columnWidth: '45%',
      distributed: true,
    }
  },
  dataLabels: {
    enabled: false
  },
  legend: {
    show: false
  },
  xaxis: {
    categories: [
      ['John'],
      ['Joe'],
      ['Jake']
    ],
    labels: {
      style: {
        fontSize: '12px'
      }
    }
  }
  };

  var chart = new ApexCharts(document.querySelector("#eng_chart"), options);
  chart.render();
  
  
// 영어 성적 추이
  var options = {
		  series: [{
			  name: "홍길동",
			  data: [10, 41, 35, 51, 49, 62, 69, 91, 100]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '영어 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#eng_line_chart"), options);
  chart.render();
  
// 수학
  var options = {
		  series: [{
			  data: [21, 22, 10]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'bar',
			  events: {
				  click: function(chart, w, e) {
					  // console.log(chart, w, e)
				  }
			  }
		  },
		  plotOptions: {
			  bar: {
				  columnWidth: '45%',
				  distributed: true,
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  legend: {
			  show: false
		  },
		  xaxis: {
			  categories: [
				  ['John'],
				  ['Joe'],
				  ['Jake']
				  ],
				  labels: {
					  style: {
						  fontSize: '12px'
					  }
				  }
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#math_chart"), options);
  chart.render();
  
  
// 수학 성적 추이
  var options = {
		  series: [{
			  name: "홍길동",
			  data: [10, 41, 35, 51, 49, 62, 69, 91, 100]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '수학 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#math_line_chart"), options);
  chart.render();
  
// 사회
  var options = {
		  series: [{
			  data: [21, 22, 10]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'bar',
			  events: {
				  click: function(chart, w, e) {
					  // console.log(chart, w, e)
				  }
			  }
		  },
		  plotOptions: {
			  bar: {
				  columnWidth: '45%',
				  distributed: true,
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  legend: {
			  show: false
		  },
		  xaxis: {
			  categories: [
				  ['John'],
				  ['Joe'],
				  ['Jake']
				  ],
				  labels: {
					  style: {
						  fontSize: '12px'
					  }
				  }
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#social_chart"), options);
  chart.render();
  
  
// 사회 성적 추이
  var options = {
		  series: [{
			  name: "홍길동",
			  data: [10, 41, 35, 51, 49, 62, 69, 91, 100]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '사회 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#social_line_chart"), options);
  chart.render();
  
// 과학
  var options = {
		  series: [{
			  data: [21, 22, 10]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'bar',
			  events: {
				  click: function(chart, w, e) {
					  // console.log(chart, w, e)
				  }
			  }
		  },
		  plotOptions: {
			  bar: {
				  columnWidth: '45%',
				  distributed: true,
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  legend: {
			  show: false
		  },
		  xaxis: {
			  categories: [
				  ['John'],
				  ['Joe'],
				  ['Jake']
				  ],
				  labels: {
					  style: {
						  fontSize: '12px'
					  }
				  }
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#science_chart"), options);
  chart.render();
  
  
// 과학 성적 추이
  var options = {
		  series: [{
			  name: "홍길동",
			  data: [10, 41, 35, 51, 49, 62, 69, 91, 100]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '과학 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#science_line_chart"), options);
  chart.render();
  
  
  
  
  
  
  //학원 성적
  
  //국어 line
  var options = {
		  series: [{
			  name: "홍길동",
			  data: [10, 41, 35, 51, 49, 62, 69, 91, 100]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '국어 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#acd_kor_line_chart"), options);
  chart.render();
  
  //국어 영역

  var options = {
          series: [{
          name: 'Series 1',
          data: [80, 50, 30, 40, 100, 20],
        }],
          chart: {
		  height: 250,
		  width: 340,
          type: 'radar',
        },
        xaxis: {
          categories: ['January', 'February', 'March', 'April', 'May', 'June']
        }
  };
  
  var chart = new ApexCharts(document.querySelector("#acd_kor_chart"), options);
  chart.render();

  
  
  
  //영어 line
  var options = {
		  series: [{
			  name: "홍길동",
			  data: [10, 41, 35, 51, 49, 62, 69, 91, 100]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '영어 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#acd_eng_line_chart"), options);
  chart.render();
  
  //영어 영역
  
  var options = {
		  series: [{
			  name: 'Series 1',
			  data: [80, 50, 30, 40, 100, 20],
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'radar',
		  },
		  xaxis: {
			  categories: ['January', 'February', 'March', 'April', 'May', 'June']
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#acd_eng_chart"), options);
  chart.render();
  
  
  //수학 line
  var options = {
		  series: [{
			  name: "홍길동",
			  data: [10, 41, 35, 51, 49, 62, 69, 91, 100]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '수학 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#acd_math_line_chart"), options);
  chart.render();
  
  //수학 영역
  
  var options = {
		  series: [{
			  name: 'Series 1',
			  data: [80, 50, 30, 40, 100, 20],
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'radar',
		  },
		  xaxis: {
			  categories: ['January', 'February', 'March', 'April', 'May', 'June']
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#acd_math_chart"), options);
  chart.render();
  
  
  //사회 line
  var options = {
		  series: [{
			  name: "홍길동",
			  data: [10, 41, 35, 51, 49, 62, 69, 91, 100]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '사회 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#acd_social_line_chart"), options);
  chart.render();
  
  //사회 영역
  
  var options = {
		  series: [{
			  name: 'Series 1',
			  data: [80, 50, 30, 40, 100, 20],
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'radar',
		  },
		  xaxis: {
			  categories: ['January', 'February', 'March', 'April', 'May', 'June']
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#acd_social_chart"), options);
  chart.render();

  
  //과학 line
  var options = {
		  series: [{
			  name: "홍길동",
			  data: [10, 41, 35, 51, 49, 62, 69, 91, 100]
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'line',
			  zoom: {
				  enabled: false
			  }
		  },
		  dataLabels: {
			  enabled: false
		  },
		  stroke: {
			  curve: 'straight'
		  },
		  title: {
			  text: '과학 성적 추이',
			  align: 'left'
		  },
		  grid: {
			  row: {
				  colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
				  opacity: 0.5
			  },
		  },
		  xaxis: {
			  categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#acd_science_line_chart"), options);
  chart.render();
  
  //과학 영역
  
  var options = {
		  series: [{
			  name: 'Series 1',
			  data: [80, 50, 30, 40, 100],
		  }],
		  chart: {
			  height: 250,
			  width: 340,
			  type: 'radar',
		  },
		  xaxis: {
			  categories: ['January', 'February', 'March', 'April', 'May']
		  }
  };
  
  var chart = new ApexCharts(document.querySelector("#acd_science_chart"), options);
  chart.render();
