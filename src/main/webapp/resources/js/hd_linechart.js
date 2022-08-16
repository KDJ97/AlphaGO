 var options = {
          series: [{
            name: "Desktops",
            data: [10, 41, 35, 51, 49, 62, 69, 91, 148]
        }],
          chart: {
          height: 350,
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
          text: ,
          align: 'left'
        },
        grid: {
          row: {
            colors: ['#f3f3f3', 'transparent'], // takes an array which will be
												// repeated on columns
            opacity: 0.5
          },
        },
        xaxis: {
          categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        }
        };

        var chart = new ApexCharts(document.querySelector("#chart_upgrade"), options);
        chart.render();
        // 라인 끝
        
        
 
       // 도넛 시작
        
        
        var options = {
                series: [44, 55, 41, 17, 15],
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