//배열을 받아 시수를 계산해주는 함수
var totalTime = 0;

var timetable = [];//시간표 테이블 좌표를 넣을 배열

// 현재 시수 결과
var timeresult = 0;

//------------------------------------------------------
$('#startDate').change(function(){
	startDate = $('#startDate').val();
	$('#start_date').text(startDate);
})
$('#endDate').change(function(){
	endDate = $('#endDate').val();
	$('#end_date').text(endDate);
})

//------------------------------------------------------------
//강의실을 선택했을때 발생하는 함수
//해당 강의실에 대한 등록 및 시간표 테이블에 뿌려줄 사용 불가능 시간을 계산
function calcTimeByRoom(sel){
	//수업 시작일 -> 2022-01-01
	var startDate = $('#startDate').val();
	//수업 종료일 -> 2022-01-01
	var endDate = $('#endDate').val();
	console.log(startDate);
	console.log(endDate);
	if(startDate=="" || endDate==""){
		alert("기간을 먼저 선택해주세요.");
		return;
	}
	
	if($(sel).val()==""){
		return;
	}
	var start = new Date(startDate);
	var end = new Date(endDate);
	if(start>end){
		alert("시작일은 종료일보다 클 수 없습니다");
		return;
	}
	
	roomCode = $(sel).val();

	$.ajax({
		url:'oneClassroom.go',
		data:{roomCode:roomCode},
		success:function(data){
			if(data!=null){
				$('#classroom_no').text(data.roomNo+"호");
			}
		},
		eroor:function(error){
			alert("error : " + error.status);
		},
		dataType:'json'
	});

	//select box 선택된 값 -> roomCode
	$.ajax({
		url:'getUseRoomTime.go',
		data:{roomCode:roomCode},
		success:function(data){
			if(data!=null){
				setCantUseRoom(data);
			}
		},
		eroor:function(error){
			alert("error : " + error.status);
		},
		dataType:'json'
	});
}

//강의실의 사용불가능한 시간을 체크한다.
function setCantUseRoom(data){
	//사용중인 날짜 배열
	var useDate = []; 
	//수업 시작일 -> 2022-01-01
	var startDate = $('#startDate').val();
	//수업 종료일 -> 2022-01-01
	var endDate = $('#endDate').val();
	
	$('.timeTable td').css("background-color","");
	$('#secTimeTable td').css("background-color", "");
	
	//선택한 날짜를 date타입으로 형변환(비교를 위해서)
	var start = new Date(startDate);
	var end = new Date(endDate);
	
	for(var i=0;i<data.length;i++){
		var useStartDate = data[i].startDate;
		var useEndDate = data[i].endDate;
		
		var sdate = useStartDate.substring(0,10);
		var edate = useEndDate.substring(0,10);
		
		var st = new Date(sdate);
		var en = new Date(edate);
		
		//선택한 수업 시작일이 진행중인 수업 종료일보다 작으면
		if(st<end){
			var period = data[i].ctperiod; //교시
			var yoil = data[i].classday; //요일 코드
			//일요일은 요일코드가 0이고 테이블의 td순서는 7이기 때문에 변환 필요
			if(yoil==0){
				yoil = 7;
			}
			console.log(yoil);
//			console.log("일 : " + sunyoil);
			var tr = $('#'+period);
			var distd = tr.find('td:eq('+(yoil-1)+')');
			console.log(distd);
			
			//해당 td에 grey로 막아줌
			$(distd).css("background-color","grey");
		}
	}
}//강의실의 사용불가능한 시간 체크 끝!!!!!!!!
//------------------------------------------------------------

//테이블  td클릭시 시수 계산하는 함수(사용함수 : calcTotalTime)
function calcTime(td){
	//수업 시작일 값 가져오기
	var startDate = $('#startDate').val(); //문자열 2022-01-01
	//수업 종료일 값 가져오기
	var endDate = $('#endDate').val(); //문자열 2022-01-01
	
	if(!startDate && !endDate){
		alert("시작일과 종료일이 선택 되지 않았습니다.");
		return;
	}
	if(!$('#selectRoom').val()){
		alert("사용할 수업실 호수를 선택해주세요.");
		return;
	}
	if($(td).css("background-color")=="rgb(128, 128, 128)"){
		alert("이미 사용중인 시간대 입니다.");
		return;
	}
	
	//요일 번호 0,1,2,3,4,5,6
	var ctday = $(td).children(0).text();
//	console.log(ctday);
	var intday = parseInt(ctday);
//	console.log(intday);
	
	// n교시
	var ctperiod = $(td).parent().children().eq(0).text();
	var indexNum = ctperiod.lastIndexOf("교");
	console.log(indexNum);
	ctperiod=ctperiod.substring(0,indexNum);
//	console.log($(td).parent().children().eq(0).text());
	
	var arrSt = '('+intday+',' + ctperiod +')';
	
	if(timetable.length==0){
		timetable.push(arrSt);
	}else{
		for(var i=0;i<timetable.length;i++){
			var ionum = timetable.lastIndexOf(arrSt);
			console.log("위치 : " + ionum)
			console.log(timetable[i])
			if(ionum>-1){ //배열에 같은 요소가 있으면 삭제
				//해당 요소가 있는지 검사
				//있으면 삭제
				timetable.splice(ionum,1);
				i--//splice로 배열의 길이가 즉시 변경되기 때문에 -를 해준다
				break;
			}
			if(arrSt!=timetable[i]){//배열에 같은 요소가 없으면 값 넣기
				timetable.push(arrSt);
				break;
			}
		}
	}
	console.log("timetable : "+timetable);
	
	//요일수 계산 함수!!!!!!!!!!
	calcTotalTime(timetable);
	
	//세번째 페이지 테이블에 선택 시간 색상 채우기
	setSecondTable(timetable);
	
}

//마지막 페이지 시간표 css 세팅
function setSecondTable(table){ 
	//이전 css 지우기
	$('#secTimeTable').find('td').css('background-color','');
	
	for(var i=0;i<timetable.length;i++){
//		console.log(timetable[i]);
		var timearr = timetable[i].split(/[',','(',')']/);
		timearr.splice(0,1);
		timearr.splice(2,1);
		
		var yoilcode = timearr[0];//요일
		var classperiod = timearr[1];//교시
		
		if(yoilcode==0) yoilcode=6; //일요일은 td의 6번째기 때문에 6으로 세팅
		
		console.log(yoilcode);
		var tr = $('#secTimeTable').find('#'+classperiod);
		var distd = tr.find('td:eq('+(yoilcode-1)+')');
//		console.log(tr);
		console.log(distd);
		
		$(distd).css("background-color", "#6666FF");
	}
}

//요일수 계산해주는 함수 (사용함수 : lcDateCountDay, multiTime) 
function calcTotalTime(arr){
	//배열이 비어있을 시 리턴
	if(arr.length < 1) return;
	
	//수업 시작일 값 가져오기
	var startDate = $('#startDate').val(); //문자열 2022-01-01
	//수업 종료일 값 가져오기
	var endDate = $('#endDate').val(); //문자열 2022-01-01
	
	var startSplit = startDate.split('-');
	var endSplit = endDate.split('-');
	var start = startSplit[0]+startSplit[1]+startSplit[2];
	var end = endSplit[0]+endSplit[1]+endSplit[2];
	console.log(start);//20220101
	console.log(end);//20220812
	
	var sdate = new Date(startDate);
	var edate = new Date(endDate);
	//요일별 개수
	var mon = 0;
	var tue = 0;
	var wed = 0;
	var thu = 0;
	var fri = 0;
	var sat = 0;
	var sun = 0;
	
	for(var i=0;i<arr.length;i++){
		var str = arr[i];
//		console.log(str);
		var arr2 = str.split(/[',','(',')']/);
		arr2.splice(0,1);
		arr2.splice(2,1);
//		console.log(arr2[0]);//['2','4']
		
		if(arr2[0]=='1'){
			mon++;
		}
		if(arr2[0]=='2'){
			tue++;
		}
		if(arr2[0]=='3'){
			wed++;
		}
		if(arr2[0]=='4'){
			thu++;
		}
		if(arr2[0]=='5'){
			fri++;
		}
		if(arr2[0]=='6'){
			sat++;
		}
		if(arr2[0]=='0'){
			sun++;
		}
	}//요일수 계산 for문 끝
	console.log("mon : " + mon);
	console.log("tue : " + tue);
	console.log("wed : " + wed);
	console.log("thu : " + thu);
	console.log("fri : " + fri);
	console.log("sat : " + sat);
	console.log("sun : " + sun);
	
	//기간별 월요일 개수
	var moncnt = lcDateCountDay(sdate, edate, 1);
	var tuecnt = lcDateCountDay(sdate, edate, 2);
	var wedcnt = lcDateCountDay(sdate, edate, 3);
	var thucnt = lcDateCountDay(sdate, edate, 4);
	var fricnt = lcDateCountDay(sdate, edate, 5);
	var satcnt = lcDateCountDay(sdate, edate, 6);
	var suncnt = lcDateCountDay(sdate, edate, 0);
	
	//기간별 요일수 X 요일별 수업 시간
	var monres = multiTime(moncnt, mon);
	var tueres = multiTime(moncnt, tue);
	var wedres = multiTime(moncnt, wed);
	var thures = multiTime(moncnt, thu);
	var frires = multiTime(moncnt, fri);
	var satres = multiTime(moncnt, sat);
	var sunres = multiTime(moncnt, sun);
	
	// 현재 시수 변수에 넣어주기
	timeresult = monres + tueres + wedres + thures + frires + satres + sunres;
	console.log("현재 시수 : "+timeresult);
	
	// 현재 시수 값 뿌려주기
	$('#setTotal').empty();
	$('#setTotal').append(timeresult);
	$('#totalTime').val(timeresult);
	$('#total_time').text(timeresult);
}

//기간별 요일수 X 요일별 수업 시간
function multiTime(daycnt, dayclass){
	var res = daycnt * dayclass;
//	console.log(daycnt);
//	console.log(dayclass);
//	console.log("res : " + res);
	return res;
}
//------------------------------------------------------------
//테이블 클릭 시 토글로 색 변경
function setColor(td){
	//수업 시작일,종료일 값 가져오기
	var startDate = $('#startDate').val(); //문자열 2022-01-01
	var endDate = $('#endDate').val(); //문자열 2022-01-01
	if(!$('#selectRoom').val()){
		return;
	}
	//td 색상변경
	addFlip(td);
}

//클래스에 flipped 추가해 td색상 바꾸기
function addFlip(td){
	var cln = $(td).attr("class");
//	console.log(cln);
	
	if(typeof cln == 'undefined'||cln==''){
		$(td).attr("class","flipped");
	}else{
		$(td).attr("class","");
	}
}
//------------------------------------------------------------

//요일 수 계산
//parm d1 : Date 타입 
//parm d2 : Date 타입 
//daycode : 요일코드
function lcDateCountDay(d1,d2, daycode) {
  var count=0;
  var tmp;
  for (var i=0; i<=(d2-d1)/1000/60/60/24; i++) {
    tmp=new Date(d1);
    tmp.setDate(tmp.getDate()+i);
 //0(일요일), 1(월요일), 2(화요일), 3(수요일), 4(목요일) 5(금요일), 6(토요일)
    if (tmp.getDay()==daycode) {
      count++;
    }
  }
  return count;//if문이 0이니 일요일 개수 출력
}
//------------------------------------------------------------
const getDateDiff = (d1, d2) => {
	  const date1 = new Date(d1);
	  const date2 = new Date(d2);
	  
	  const diffDate = date1.getTime() - date2.getTime();
	  
	  return Math.abs(diffDate / (1000 * 60 * 60 * 24)); // 밀리세컨 * 초 * 분 * 시 = 일
	}
//------------------------------------------------------------


//날짜 형식의 데이터를 문자열로 바꿔주는 함수
function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}
//------------------------------------------------------------
//특정 날짜의 요일을 구하는 함수
function getDate(stringDate){ //날짜문자열 형식은 자유로운 편
    var week = ['일', '월', '화', '수', '목', '금', '토'];
    var dayOfWeek = week[new Date(stringDate).getDay()];
    return dayOfWeek;
}
//------------------------------------------------------------









