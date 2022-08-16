package kr.or.ddit.service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Month;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.ClassDAO;
import kr.or.ddit.dao.ClassroomDAO;
import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.AssignAttachVO;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.CareerVO;
import kr.or.ddit.dto.CertificateVO;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ClassingVO;
import kr.or.ddit.dto.ClassroomVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SubDetailVO;
import kr.or.ddit.dto.SubjectVO;
import kr.or.ddit.dto.TimeDetailVO;
import kr.or.ddit.dto.UseRoomVO;

public class ClassServiceImpl implements ClassService {
	private ClassDAO classDAO;
	public void setClassDAO(ClassDAO classDAO) {
		this.classDAO = classDAO;
	}

	private ClassroomDAO classroomDAO;
	public void setClassroomDAO(ClassroomDAO classroomDAO) {
		this.classroomDAO = classroomDAO;
	}

	/**
	 * 수업관리에서-수업목록을 불러오는 서비스
	 */
	@Override
	public Map<String, Object> getSearchClassList(SearchCriteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<ClassVO> classList = classDAO.selectSearchClassList(cri);
		int totalCount = classDAO.selectSearchClassListCount(cri);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);

		dataMap.put("classList", classList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}

	@Override
	public List<SubjectVO> getSubDetail(int subcode) throws SQLException {
		List<SubjectVO> subList = null;
		subList = classDAO.getSubDetail(subcode);
		return subList;
	}

	/**
	 * 수업 상세 정보 받기(수업관리)
	 */
	@Override
	public Map<String, Object> getClassDetail(int class_code) throws SQLException {
		Map<String, Object> classDetailMap = new HashMap<String, Object>();

		ClassVO classvo = classDAO.getClassDetail(class_code);

//		System.out.println(classvo.getSubject_code());
		int subjectCode = Integer.parseInt(classvo.getSubjectCode());
		List<SubjectVO> subDetailList = classDAO.getSubDetail(subjectCode);

		if(classvo!=null && subDetailList!=null) {
			classDetailMap.put("classvo", classvo);
			classDetailMap.put("subDetailList", subDetailList);
		}
		return classDetailMap;
	}

	/**
	 * 수업 상세 정보 받기(수업목록)
	 */
	@Override
	public Map<String, Object> getClassDeepDetail(int class_code) throws SQLException {
		Map<String, Object> classDetailMap = new HashMap<String, Object>();
		String classCode = String.valueOf(class_code);

		ClassVO classvo = classDAO.getClassDetail(class_code);
		String startDate = classvo.getStartDate();
		String endDate = classvo.getEndDate();
		String newStart = startDate.substring(0, 11);
		String newEnd = endDate.substring(0, 11);
		classvo.setStartDate(newStart);
		classvo.setEndDate(newEnd);

//		System.out.println(classvo.getSubject_code());
		int subjectCode = Integer.parseInt(classvo.getSubjectCode());
		List<SubjectVO> subDetailList = classDAO.getSubDetail(subjectCode);

		if(classvo!=null && subDetailList!=null) {
			classDetailMap.put("classvo", classvo);
			classDetailMap.put("subDetailList", subDetailList);
		}
		//시간 상세 테이블에 있는 해당 수업 일정 정보들 불러오기
		List<TimeDetailVO> timeList = classDAO.selectClassTimeDetail(classCode);
		//해당 수업이 진행되는 강의실 호수를 담을 리스트
		List<String> roomNoList = new ArrayList<String>();
		for(TimeDetailVO tdvo : timeList) {
			roomNoList.add(tdvo.getRoomNo());
			//DB에 들어있는 숫자로 표기되어있는 요일을 '월,화..'로 바꿔주는 작업
			String dbyoil = tdvo.getClassday();
			String yoil = formatYoil(dbyoil);
//			System.out.println(yoil);
			tdvo.setClassday(yoil);
		}
		//강의실 호수 중복제거
		Set<String> set1 = new HashSet<String>(roomNoList);
		List<String> newRoomNoList =new ArrayList<String>(set1);
//		System.out.println(timeList);

		//해당 수업을 수강하는 원생들의 id리스트
		List<ClassingVO> idList = classDAO.selectClassIngMemberList(classCode);
		System.out.println("idList : " + idList);
		//해당 수업을 수강하는 원생 정보 리스트를 넣어 보내줄 리스트
		List<MemberVO> memberInfo = new ArrayList<MemberVO>();
		for(ClassingVO classingVO : idList) {
			String id = classingVO.getId();
//			System.out.println("id : " + id);
			MemberVO Info = classDAO.selectSchoolDetail(id);
			memberInfo.add(Info);
		}
//		System.out.println(memberInfo.toString());

		//jsp에 보내줄 데이터 담기(수업상세, 수업일정, 수업 수강생) 3가지
		classDetailMap.put("classvo", classvo);//수업상세
		classDetailMap.put("newRoomNoList", newRoomNoList);//수업진행 강의실 호수
		classDetailMap.put("timeList", timeList);//수업 일정 리스트
		classDetailMap.put("memberInfo", memberInfo);//해당 수업 수강생 리스트

		return classDetailMap;
	}

	@Override
	public void registClass(ClassVO classVO) throws SQLException {
//		System.out.println("class from Service : " + classVO);
		int classSeq = classDAO.getClassCode();
//		System.out.println(classSeq);
//		System.out.println(classVO.getClassCode());
		String class_code = String.valueOf(classSeq);
		classVO.setClassCode(class_code);

		classDAO.registClass(classVO);
	}

	@Override
	public void removeClass(ClassVO classVO) throws SQLException {
		ClassVO getClass = classDAO.getClassDetail(Integer.parseInt(classVO.getClassCode()));
		classDAO.removeClass(getClass);
	}

	@Override
	public List<MemberVO> getTeacherList(String subjectName) throws SQLException {
		List<MemberVO> teacherList = null;
		String subName = "";
		switch (subjectName) {
		case "1":
			subName = "국어";
			break;
		case "2":
			subName = "수학";
			break;
		case "3":
			subName = "영어";
			break;
		case "4":
			subName = "사회";
			break;
		case "5":
			subName = "과학";
			break;
		}

		teacherList = classDAO.getTeacherList(subName);
		return teacherList;
	}

	@Override
	public Map<String, Object> getTeacherDetail(String id) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();

		MemberVO teacher = classDAO.getTeacherById(id);
		List<CertificateVO> cerList = classDAO.getCertificateList(id);

		dataMap.put("teacher", teacher);
		dataMap.put("cerList", cerList);

		return dataMap;
	}

	/**
	 * 수업 개설에 필요한 모든 데이터들 반환
	 */
	@Override
	public Map<String, Object> getClassRegElementList(SearchCriteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<ClassVO> classList = classDAO.selectSearchClassList(cri);
		int totalCount = classDAO.selectSearchClassListCount(cri);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);

		List<ClassroomVO> roomList = classroomDAO.getClassroom();

		dataMap.put("classList", classList);
		dataMap.put("roomList", roomList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}

	@Override
	public Map<String, Object> getClassing(String id) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<ClassingVO> classingList = classDAO.getClassing(id);
		dataMap.put("classingList", classingList);

		return dataMap;
	}

	@Override
	public List<UseRoomVO> getUseRoomList(String roomCode) throws SQLException {
		List<UseRoomVO> list = classDAO.getUseRoomList(roomCode);
		return list;
	}

	/**
	 * 수업을 개설하는 service
	 */
	@Override
	public int updateClassOpen(Map<String, Object> map) throws SQLException {
		boolean check1 = true;
		boolean check2 = true;
		int cnt = 0;

		ClassVO classVO = new ClassVO();
		//class테이블에 넣을 데이터-----------
		String classCode = String.valueOf(classDAO.getClassCode());
		String startDate = (String) map.get("startDate");
		String endDate = (String) map.get("endDate");
		String id = (String) map.get("id");
		String totalTime=(String) map.get("totalTime");
		String subdetailCode=(String) map.get("subdetailCode");
		String classGrade = (String) map.get("classGrade");
		String stuCnt = (String) map.get("stuCnt");
		String classPrice = (String) map.get("classPrice");
		String classRank = (String) map.get("classRank");
		String className = (String) map.get("className");
		classVO.setClassCode(classCode);
		classVO.setStartDate(startDate);
		classVO.setEndDate(endDate);
		classVO.setId(id);
		classVO.setTotalTime(totalTime);
		classVO.setSubdetailCode(subdetailCode);
		classVO.setClassGrade(classGrade);
		classVO.setStuCnt(stuCnt);
		classVO.setClassPrice(classPrice);
		classVO.setClassRank(classRank);
		classVO.setClassName(className);

		System.out.println(classVO);
		int fres = classDAO.registClass(classVO);
//		System.out.println(fres);
		if(fres<1) check1=false;

		if(check1) {
			//time_detail에 넣을 데이터-----
			String roomCode = (String) map.get("roomCode");
			List<String> timeList = (List<String>) map.get("timetable");
			//(x, y)
			//-> x: 요일
			//-> y: 교시
			for (int i = 0; i < timeList.size(); i++) {
				String time = timeList.get(i);
				//substring 써야할듯
				int a = time.indexOf("(");
				String tempTime1 = time.substring(a+1);
				int b = tempTime1.lastIndexOf(")");
				String tempTime2 = tempTime1.substring(0, b);

				String timearr[] = tempTime2.split(",");
	//					System.out.println(timearr[0]);//요일코드
	//					System.out.println(timearr[1]);//교시
				String classDay = timearr[0];
				String ctperiod = timearr[1];

				TimeDetailVO timeDetailVO = new TimeDetailVO();
				//타임 코드 시퀀스 뽑아와서 셋 하기
				String timecode = String.valueOf(classDAO.getTimedetailSeq());
				//
				Map<String, String> periodMap = parsePeriod(ctperiod);
				String startTime=periodMap.get("startTime");
				String endTime=periodMap.get("endTime");

				timeDetailVO.setStartTime(startTime);
				timeDetailVO.setEndTime(endTime);
				timeDetailVO.setTimeCode(timecode);
				timeDetailVO.setClassCode(classCode);
				timeDetailVO.setRoomCode(roomCode);
				timeDetailVO.setClassday(classDay);
				timeDetailVO.setCtperiod(ctperiod);

				System.out.println(timeDetailVO.toString());

				int res = classDAO.registTimeDetail(timeDetailVO);
				if(res>0) cnt++;
			}
			if(cnt<timeList.size()) check2=false;
		}

		int result = 0;

		boolean totalCheck = check1 && check2;
		if(totalCheck) {
			result = 1;
		}else if(!totalCheck) {
			result = 0;
		}

		return result;
	}

	/**
	 * 수업목록에서 사용하는 수업 리스트와 수강생 수
	 */
	@Override
	public Map<String, Object> selectSearchClassListInClassList(SearchCriteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<ClassVO> classList = classDAO.selectSearchClassListInClassList(cri);
		int totalCount = classDAO.selectSearchClassListCount(cri);

		for(ClassVO classVO : classList) {
			String oldStart = classVO.getStartDate();
			String oldEnd = classVO.getEndDate();

			String newStart = oldStart.substring(0, 10);
			String newEnd = oldEnd.substring(0, 10);
			//날짜 잘라넣기
			classVO.setStartDate(newStart);
			classVO.setEndDate(newEnd);

			//수강생 수를 stucnt 컬럼에 넣어서 보낼거임(정원X, 수강생수 O)
			String classCode = classVO.getClassCode();
			List<ClassingVO> classingList = classDAO.selectClassIngMemberList(classCode);
			String stucnt = String.valueOf(classingList.size());
			classVO.setStuCnt(stucnt);
		}

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);

		dataMap.put("classList", classList);
		dataMap.put("pageMaker", pageMaker);

		return dataMap;
	}





	/**
	 * 교시를 시간으로 바꿔주는 함수
	 * @param ctperiod
	 * @return
	 */
	private Map<String, String> parsePeriod(String ctperiod){
		Map<String, String> map = new HashMap<String, String>();
		String startTime="";
		String endTime="";

		if(ctperiod.equals("1")) {
			startTime="09:00";
			endTime="10:00";
		}
		if(ctperiod.equals("2")) {
			startTime="10:00";
			endTime="11:00";
		}
		if(ctperiod.equals("3")) {
			startTime="11:00";
			endTime="12:00";
		}
		if(ctperiod.equals("4")) {
			startTime="12:00";
			endTime="13:00";
		}
		if(ctperiod.equals("5")) {
			startTime="13:00";
			endTime="14:00";
		}
		if(ctperiod.equals("6")) {
			startTime="14:00";
			endTime="15:00";
		}
		if(ctperiod.equals("7")) {
			startTime="15:00";
			endTime="16:00";
		}
		if(ctperiod.equals("8")) {
			startTime="16:00";
			endTime="17:00";
		}
		if(ctperiod.equals("9")) {
			startTime="17:00";
			endTime="18:00";
		}
		if(ctperiod.equals("10")) {
			startTime="18:00";
			endTime="19:00";
		}
		if(ctperiod.equals("11")) {
			startTime="19:00";
			endTime="20:00";
		}
		if(ctperiod.equals("12")) {
			startTime="20:00";
			endTime="21:00";
		}
		if(ctperiod.equals("13")) {
			startTime="21:00";
			endTime="22:00";
		}

		map.put("startTime", startTime);
		map.put("endTime", endTime);

		return map;
	}


	//DB에 들어있는 숫자로 표기되어있는 요일을 '월,화..'로 바꿔주는 작업
	private String formatYoil(String dbyoil) {
		String yoil = "";
		switch (dbyoil) {
		case "0":
			yoil = "일";
			break;
		case "1":
			yoil = "월";
			break;
		case "2":
			yoil = "화";
			break;
		case "3":
			yoil = "수";
			break;
		case "4":
			yoil = "목";
			break;
		case "5":
			yoil = "금";
			break;
		case "6":
			yoil = "토";
			break;
		}

		return yoil;
	}

	/**
	 * 수업 상세페이지 작업하는 서비스
	 */
	@Override
	public Map<String, Object> classDetail(String classCode) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();

		//해당수업 담당 강사의 정보(아이디,이름,과목,전공,경력)
		MemberVO teacher = classDAO.getTeacherByClassCode(classCode);
		String id = teacher.getId();
		//담당 강사의 경력 사항
		List<CareerVO> careerList = classDAO.getCareer(id);
		//담당 강사의 자격증
		List<CertificateVO> cerList = classDAO.getCertificateList(id);
		//담당 강사의 리뷰(평균 계산용)
		List<ClassReviewVO> reviewList = classDAO.selectClassReviewById(id);
		//담당 강사 수업의 후기들
		List<ClassReviewVO> classReviewList = classDAO.selectClassReview(classCode);

		double avgSum=0.0;
		int listCnt = classReviewList.size();//리뷰개수
		for(ClassReviewVO vo : classReviewList) {
			avgSum += vo.getStarScore();
		}
		double avgRes= avgSum/listCnt;
		teacher.setReviewScore(avgRes);//강사 후기 점수 평균
//--------------------------------------------------------------------------
		//detail에 보내줄 원생 목록
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		//수업 수강하는 원생 id, classCode, classRegdate(수업신청일), name
		List<ClassingVO> classingList = classDAO.selectClassingByClassCode(classCode);

		int attachRes = 0;//과제 제출 개수 넣을 변수
		int assignCnt = 0;//과제 개수
		double percent = 0.0;

		double scoreAvg = 0.0;//점수 평균넣을 변수
		int scoreSum=0; //점수 합계
		int score = 0;

		if(classingList !=null && classingList.size()>0)
		for(ClassingVO classingVO : classingList) {
			//원생의 수업 등록일 보다 큰 과제 리스트(assignCode, classCode,startDate,endDate)
			List<AssignVO> assignList = classDAO.selectAssignByDate(classingVO);
			assignCnt=assignList.size();//과제 개수를 넣어줌
			for(AssignVO assignVO : assignList) {
				AssignAttachVO asatVO = new AssignAttachVO();
				asatVO.setId(classingVO.getId());
				asatVO.setAssignCode(assignVO.getAssignCode());

				int attachCnt = classDAO.selectAssignAttachCheckCount(asatVO);
				if(attachCnt>0)	attachRes += attachCnt;//과제 제출한 경우에 넣어주기
			}
			percent = ((double)attachRes/assignCnt)*100;//과제 제출율 구하기
//			System.out.println("percent : " + percent);

			List<AcademyScoreVO> scoreList = classDAO.selectExamScoreById(classingVO);
			if(scoreList!=null&&scoreList.size()>0)
			for(AcademyScoreVO scoreVO : scoreList) {
				score = scoreVO.getAcademyScore();
				scoreSum+=score;
			}//점수합계 구하기
			int listSize = scoreList.size();
			System.out.println("시험점수 개수 : " + listSize);
			System.out.println("시험점수 합 : " + scoreSum);
			if(scoreSum!=0) {
				scoreAvg = (double)scoreSum/listSize;//점수 평균 구하기
				System.out.println("점수 평균 : " + scoreAvg);
			}
			double acheive=0;
			if(scoreAvg!=0.0&&percent!=0.0) {
				acheive = (scoreAvg+percent)/2;//성취도 계산
				System.out.println("성취도 : " + acheive);
			}

			String totalAcheive = "";//최종 수업 성취도(A B C)
			if(acheive>=90.0) {
				totalAcheive = "A";
			}else if(acheive>=80.0 && acheive<90.0) {
				totalAcheive = "B";
			}else if(acheive>0.0&&acheive<80.0){
				totalAcheive = "C";
			}else {
				totalAcheive = "-";
			}

			MemberVO member = new MemberVO();//멤버VO 인스턴스 생성
			member.setId(classingVO.getId());
			member.setName(classingVO.getName());
			member.setAssignAttachPercent(percent);
			member.setScoreAvg(scoreAvg);
			member.setAcheive(acheive);
			member.setTotalAcheive(totalAcheive);

			memberList.add(member);//리스트에 추가
			scoreSum=0;
			percent=0;
			acheive=0;
			attachRes=0;
			assignCnt=0;
			scoreAvg=0;
		}
//		System.out.println(memberList.toString());
		//---------------------------------------------
		//수업 수익 계산
		//해당 수업 시수, 수업료가 들어있는 VO
		ClassVO cvo = classDAO.getTotalTimeByClassCode(classCode);
		//수강생 수
		int classingCnt = classingList.size();
		//해당 수업의 수업료
		int classPrice = Integer.parseInt(cvo.getClassPrice());
		//담당강사의 시급
		int timepay = Integer.parseInt(teacher.getTimepay());
		//해당 수업의 시수
		int totalTime = Integer.parseInt(cvo.getTotalTime());
		//교재비
		int bookPrice = 8000;

		//수업 수강료 총합
		int classTotalPrice = classingCnt*classPrice;
		//교재비 총합
		int bookTotalPrice = classingCnt*bookPrice;
		//강사 인건비
		int teacherPay = timepay*totalTime;

		//총합
		int totalPay = classTotalPrice - (bookTotalPrice + teacherPay);

		//강사 상세 + 강사 후기 정보
		dataMap.put("teacher", teacher);
		dataMap.put("careerList", careerList);
		dataMap.put("cerList", cerList);
		dataMap.put("reviewList", reviewList);
		dataMap.put("classReviewList", classReviewList);
		//---------------------------------------
		//학생 정보
		dataMap.put("memberList", memberList);
		//---------------------
		//수업 재무
		dataMap.put("classingCnt", classingCnt);
		dataMap.put("classPrice", classPrice);
		dataMap.put("timepay", timepay);
		dataMap.put("totalTime", totalTime);
		dataMap.put("bookPrice", bookPrice);
		dataMap.put("classTotalPrice", classTotalPrice);
		dataMap.put("bookTotalPrice", bookTotalPrice);
		dataMap.put("teacherPay", teacherPay);
		dataMap.put("totalPay", totalPay);

		return dataMap;
	}

	/**
	 * 이번달의 수업 종료일이 다가오는 수업들의 리스트를 추출한다.
	 */
	@Override
	public List<ClassVO> selectClassByEndDate() throws SQLException {
		//결과를 다시 담아서 보내줄 수업 리스트
		List<ClassVO> resultList = new ArrayList<ClassVO>();

		//종료일이 오늘보다 큰 수업리스트
		List<ClassVO> classList = classDAO.selectClassByEndDate();
		for(ClassVO classVO : classList ) {
			LocalDate localDate = LocalDate.now();//오늘 날짜

			String end_date = classVO.getEndDate();//종료일
			int year = Integer.parseInt(end_date.substring(0, 4));
			int month = Integer.parseInt(end_date.substring(5, 7));
			int days = Integer.parseInt(end_date.substring(8,10));

			LocalDate endDate = LocalDate.of(year, month, days);
			Month mon = localDate.getMonth();
			Month endMon = endDate.getMonth();
//			System.out.println(mon.equals(endMon));

			if(mon.equals(endMon)) {
				end_date = end_date.substring(5, 7)+"/"+end_date.substring(8,10);
				classVO.setEndDate(end_date);
				resultList.add(classVO);
			}
		}
		return resultList;
	}

	/**
	 * 이번달의 수업 시작일이 다가오는 수업들의 리스트를 추출한다.
	 */
	@Override
	public List<ClassVO> selectClassByStartDate() throws SQLException {
		//결과를 다시 담아서 보내줄 수업 리스트
		List<ClassVO> resultList = new ArrayList<ClassVO>();
		//시작일이 오늘보다 큰 수업리스트
		List<ClassVO> classList = classDAO.selectClassByStartDate();
		System.out.println(classList);
		for(ClassVO classVO : classList ) {
//			System.out.println(classVO);
			LocalDate localDate = LocalDate.now();//오늘 날짜

			String start_date = classVO.getStartDate();//종료일
			int year = Integer.parseInt(start_date.substring(0, 4));
			int month = Integer.parseInt(start_date.substring(5, 7));
			int days = Integer.parseInt(start_date.substring(8,10));

			LocalDate endDate = LocalDate.of(year, month, days);
			Month mon = localDate.getMonth();
			Month endMon = endDate.getMonth();
//			System.out.println(mon.equals(endMon));

			if(mon.equals(endMon)) {
				start_date = start_date.substring(5, 7)+"/"+start_date.substring(8,10);
				classVO.setStartDate(start_date);
				resultList.add(classVO);
			}
		}
		return resultList;
	}

	@Override
	public List<TimeDetailVO> selectTimeDetailByClassCode(String classCode) throws SQLException {
		return classDAO.selectTimeDetailByClassCode(classCode);
	}

	@Override
	public Map<String, Object> getApplicationClassList(String id, Criteria cri) throws SQLException {

		SearchCriteria searchCri = (SearchCriteria) cri;
		Map<String, Object> dataMap = new HashMap<String, Object>();

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(classDAO.selectApplicationClassListCount(id, searchCri));

		List<ClassVO> classList = classDAO.selectApplicationClassList(id, searchCri);

		dataMap.put("classList", classList);
		dataMap.put("pageMaker", pageMaker);



		return dataMap;
	}

	@Override
	public SubjectVO selectSubjectBySubdetail(int code) throws SQLException {
		return classDAO.selectSubjectBySubdetail(code);
	}

	@Override
	public String selectOverStuCnt(int code) throws SQLException {
		return classDAO.selectOverStuCnt(code);
	}

	@Override
	public void registClassing(ClassingVO vo) throws SQLException {
		classDAO.registClassing(vo);
	}

	@Override
	public ClassVO getRecomendClass(double avg, String grade, int subjectCode) throws SQLException {
		//학생의 과목별 학교성적 평균

		String rank;

		if(subjectCode == 4 || subjectCode == 3) {
			if(avg >= 40.0) {
				rank = "A";
			}else if(avg >= 30.0){
				rank = "B";
			}else {
				rank ="C";
			}
		}else {
			if(avg >= 80.0) {
				rank = "A";
			}else if(avg >= 70.0){
				rank = "B";
			}else {
				rank ="C";
			}
		}

		return classDAO.selectRecomendClass(grade, rank, subjectCode);
	}

	@Override
	public ClassingVO getClassingByclassingVO(ClassingVO vo) throws SQLException {
		return classDAO.getClassingByclassingVO(vo);
	}

}













