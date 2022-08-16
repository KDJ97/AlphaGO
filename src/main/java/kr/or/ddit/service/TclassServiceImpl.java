package kr.or.ddit.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.TclassDAO;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.ClassPlanVO;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassTimeVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.HomeworkPlanVO;
import kr.or.ddit.dto.TecounseltVO;
import kr.or.ddit.dto.WeekPlanVO;

public class TclassServiceImpl implements TclassService{

	private TclassDAO tclassDAO;
	public void setTclassDAO(TclassDAO tclassDAO) {
		this.tclassDAO = tclassDAO;
	}
	@Override
	public Map<String, Object> classList(SearchCriteria cri) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<ClassVO> classList = null;
		
		classList = tclassDAO.selectSearchClassList(cri);
		dataMap.put("classList", classList);
		dataMap.put("cri", cri);
		return dataMap;
	}
	@Override
	public Map<String, Object> unregisteredClassList(Map<String,Object> map) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<ClassVO> unregisteredClassList = null;
		
		unregisteredClassList = tclassDAO.selectSearchUnregisteredClassList(map);
		for(int i=0; i<unregisteredClassList.size(); i++) {
			if(unregisteredClassList.get(i).getCpcheck().equals("0")) {
				unregisteredClassList.get(i).setCpcheck("미제출");
			}
			if(unregisteredClassList.get(i).getCpcheck().equals("1")) {
				unregisteredClassList.get(i).setCpcheck("제출");
			}
			if(unregisteredClassList.get(i).getCpcheck().equals("2")) {
				unregisteredClassList.get(i).setCpcheck("반려");
			}
			if(unregisteredClassList.get(i).getCpcheck().equals("3")) {
				unregisteredClassList.get(i).setCpcheck("승인");
			}
			if(unregisteredClassList.get(i).getCpcheck().equals("4")) {
				unregisteredClassList.get(i).setCpcheck("임시저장");
			}
		}
		
		dataMap.put("unregisteredClassList", unregisteredClassList);
		dataMap.put("cri", (SearchCriteria)map.get("cri"));
		return dataMap;
	}
	@Override
	public Map<String, Object> selectUnregisteredClassForModal(int classCode) throws SQLException {
		
		ClassVO dataVO = new ClassVO();
		Map<String, Object> ctMap = new HashMap<String, Object>();
		
		dataVO = tclassDAO.selectClassForModal(classCode);
		List<ClassTimeVO> timetable = tclassDAO.selectClassTime(classCode);
		for(int i=0; i<timetable.size(); i++) {
			ClassTimeVO ctvo = timetable.get(i);
			System.out.println(ctvo.getClassday());
			if(ctvo.getClassday().equals("0")) {
				ctvo.setClassday("일");
			}
			if(ctvo.getClassday().equals("1")) {
				ctvo.setClassday("월");
			}
			if(ctvo.getClassday().equals("2")) {
				ctvo.setClassday("화");
			}
			if(ctvo.getClassday().equals("3")) {
				ctvo.setClassday("수");
			}
			if(ctvo.getClassday().equals("4")) {
				ctvo.setClassday("목");
			}
			if(ctvo.getClassday().equals("5")) {
				ctvo.setClassday("금");
			}
			if(ctvo.getClassday().equals("6")) {
				ctvo.setClassday("토");
			}
		}
		ClassPlanVO classPlanVO = tclassDAO.selectCPNOandTextbook(classCode);
		List<WeekPlanVO> weekPlan = tclassDAO.selectWeekPlan(classCode);
		List<HomeworkPlanVO> homeworkPlan = tclassDAO.selectHomeworkPlan(classCode);
		
		ctMap.put("dataVO", dataVO);
		ctMap.put("timetable", timetable);
		ctMap.put("classPlanVO", classPlanVO);
		ctMap.put("weekPlan", weekPlan);
		ctMap.put("homeworkPlan", homeworkPlan);
		return ctMap;
	}
	
	@Override
	public Map<String, Object> selectRegisteredClassForModal(int classCode) throws SQLException {
		System.out.println("----------------------------------");
		ClassVO dataVO = new ClassVO();
		Map<String, Object> ctMap = new HashMap<String, Object>();
		
		dataVO = tclassDAO.selectClassForModal(classCode);
		
		//일자 수 차이 계산
		String endDateStr = dataVO.getEndDate();
		String startDateStr = dataVO.getStartDate();
		Date startDate = new Date();
		Date endDate = new Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			endDate = transFormat.parse(endDateStr);
			startDate = transFormat.parse(startDateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		double sd = startDate.getTime();
		double ed = endDate.getTime();
		double diffSec = (ed-sd)/1000; //초 차이
		double diffDays = diffSec / (24*60*60); //일자수 차이

		int totalWeek = (int)Math.ceil(diffDays/7);  //수업 총 몇주차인지 
		
		//수업 요일 세팅
		List<ClassTimeVO> timetable = tclassDAO.selectClassTime(classCode);
		for(int i=0; i<timetable.size(); i++) {
			ClassTimeVO ctvo = timetable.get(i);
			System.out.println(ctvo.getClassday());
			if(ctvo.getClassday().equals("0")) {
				ctvo.setClassday("일");
			}
			if(ctvo.getClassday().equals("1")) {
				ctvo.setClassday("월");
			}
			if(ctvo.getClassday().equals("2")) {
				ctvo.setClassday("화");
			}
			if(ctvo.getClassday().equals("3")) {
				ctvo.setClassday("수");
			}
			if(ctvo.getClassday().equals("4")) {
				ctvo.setClassday("목");
			}
			if(ctvo.getClassday().equals("5")) {
				ctvo.setClassday("금");
			}
			if(ctvo.getClassday().equals("6")) {
				ctvo.setClassday("토");
			}
		}
		ClassPlanVO classPlanVO = tclassDAO.selectCPNOandTextbook(classCode);
		List<WeekPlanVO> weekPlan = tclassDAO.selectWeekPlan(classCode);
		List<HomeworkPlanVO> homeworkPlan = tclassDAO.selectHomeworkPlan(classCode);
		
		dataVO.setTotalWeek(totalWeek);
		
		ctMap.put("dataVO", dataVO);
		ctMap.put("timetable", timetable);
		ctMap.put("classPlanVO", classPlanVO);
		ctMap.put("weekPlan", weekPlan);
		ctMap.put("homeworkPlan", homeworkPlan);
		
		return ctMap;
	}
	
	@Override
	public void registClassPlan(Map<String,Object> map) throws SQLException {
		int cpno = tclassDAO.selectClassPlanSeqNextValue();
		
		String cphd = (String)map.get("cphd");
		String textbook = (String)map.get("textbook");
		int subCode = (int)map.get("subCode");
		String[] weeks = (String[])map.get("weeks");
		String[] cps = (String[])map.get("cps");
		String[] hwnos = (String[])map.get("hwnos");
		String[] hwPlans = (String[])map.get("hwPlans");
		String classCode = (String)map.get("classCode");
		
		
		ClassPlanVO classPlan = new ClassPlanVO();
		WeekPlanVO wkPlan = new WeekPlanVO();
		HomeworkPlanVO hwPlanVO = new HomeworkPlanVO();
		ClassVO classVO = new ClassVO();
		
		classPlan.setCpno(cpno);
		classPlan.setCphead(cphd);
		classPlan.setSubject_code(subCode);
		classPlan.setTextbook(textbook);
		
		tclassDAO.insertClassPlan(classPlan);
		
		if(weeks!=null) {
			for(int i=0; i<weeks.length; i++) {
				int wpno = tclassDAO.selectWeekPlanSeqNextValue();
				wkPlan.setWpno(wpno);
				if(!weeks[i].equals("")&&weeks[i]!=null) {
					wkPlan.setWeek(Integer.parseInt(weeks[i]));
				}
				if(!cps[i].equals("")&&cps[i]!=null) {
					wkPlan.setContent(cps[i]);
				}
				wkPlan.setCpno(cpno);
				tclassDAO.insertWeekPlan(wkPlan);
			}
		}
		if(hwnos!=null) {
			for(int i=0; i<hwnos.length; i++) {
				int homework = tclassDAO.selectHomeworkPlanSeqNextValue();
				hwPlanVO.setHomeworkplan(homework);
				hwPlanVO.setCpno(cpno);
				if(!hwnos[i].equals("")&&hwnos[i]!=null) {
					hwPlanVO.setNo(Integer.parseInt(hwnos[i]));
				}
				if(!hwPlans[i].equals("")&&hwPlans[i]!=null) {
					hwPlanVO.setContent(hwPlans[i]);
				}
				tclassDAO.insertHomeworkPlan(hwPlanVO);
			}
		}
		
		classVO.setClassCode(classCode);
		classVO.setCpno(Integer.toString(cpno));
		classVO.setCpcheck("1");
		
		tclassDAO.updateClassToRegisterClassPlan(classVO);
		
	}
	@Override
	public void saveClassPlan(Map<String,Object> map) throws SQLException {
		int cpno = tclassDAO.selectClassPlanSeqNextValue();
		
		String cphd = (String)map.get("cphd");
		String textbook = (String)map.get("textbook");
		int subCode = (int)map.get("subCode");
		String[] weeks = (String[])map.get("weeks");
		String[] cps = (String[])map.get("cps");
		String[] hwnos = (String[])map.get("hwnos");
		String[] hwPlans = (String[])map.get("hwPlans");
		String classCode = (String)map.get("classCode");
		
		System.out.println("------tclassService56----------");
		System.out.println("cphd : " + cphd);
		System.out.println("classCode : " + classCode);
		System.out.println("textbook : " + textbook);
		System.out.println("subCode : " + subCode);
		System.out.println("weeks[0] : " + weeks[0]);
		System.out.println("cps[1] : " + cps[1]);
		System.out.println("hwPlans[1] : " + hwPlans[1]);
		System.out.println("hwnos[1] : " + hwnos[1]);
		
		ClassPlanVO classPlan = new ClassPlanVO();
		WeekPlanVO wkPlan = new WeekPlanVO();
		HomeworkPlanVO hwPlanVO = new HomeworkPlanVO();
		ClassVO classVO = new ClassVO();
		
		classPlan.setCpno(cpno);
		classPlan.setCphead(cphd);
		classPlan.setSubject_code(subCode);
		classPlan.setTextbook(textbook);
		
		tclassDAO.insertClassPlan(classPlan);
		
		for(int i=0; i<weeks.length; i++) {
			int wpno = tclassDAO.selectWeekPlanSeqNextValue();
			wkPlan.setWpno(wpno);
			if(!weeks[i].equals("")&&weeks[i]!=null) {
				wkPlan.setWeek(Integer.parseInt(weeks[i]));
			}
			if(!cps[i].equals("")&&cps[i]!=null) {
				wkPlan.setContent(cps[i]);
			}
			wkPlan.setCpno(cpno);
			tclassDAO.insertWeekPlan(wkPlan);
		}
		
		for(int i=0; i<hwnos.length; i++) {
			int homework = tclassDAO.selectHomeworkPlanSeqNextValue();
			hwPlanVO.setHomeworkplan(homework);
			hwPlanVO.setCpno(cpno);
			if(!hwnos[i].equals("")&&hwnos[i]!=null) {
				hwPlanVO.setNo(Integer.parseInt(hwnos[i]));
			}
			if(!hwPlans[i].equals("")&&hwPlans[i]!=null) {
				hwPlanVO.setContent(hwPlans[i]);
			}
			tclassDAO.insertHomeworkPlan(hwPlanVO);
		}
		
		classVO.setClassCode(classCode);
		classVO.setCpno(Integer.toString(cpno));
		classVO.setCpcheck("4");
		
		tclassDAO.updateClassToRegisterClassPlan(classVO);
		
	}
	@Override
	public void deleteClassPlan(int wpno) throws SQLException {
		tclassDAO.deleteClassPlan(wpno);
	}
	@Override
	public void deleteHomeworkPlan(int homeworkplan) throws SQLException {
		tclassDAO.deleteHomeworkPlan(homeworkplan);
	}
	@Override
	public void registWeekPlan(Map<String, Object> map) throws SQLException {
		String cpnoStr = String.valueOf(map.get("cpno"));
		int cpno = Integer.parseInt(cpnoStr);
		String[] inputArr = (String[])map.get("inputArr");
		String[] taArr = (String[])map.get("taArr");
		
		WeekPlanVO weekPlanVO = new WeekPlanVO();
		
		if(inputArr != null) {
			for(int i=0; i<inputArr.length; i++) {
				int wpno = tclassDAO.selectWeekPlanSeqNextValue();
				weekPlanVO.setWpno(wpno);
				weekPlanVO.setCpno(cpno);
				if(!inputArr[i].equals("")&&inputArr[i]!=null) {
					weekPlanVO.setWeek(Integer.parseInt(inputArr[i]));
				}
				weekPlanVO.setContent(taArr[i]);
				tclassDAO.insertWeekPlan(weekPlanVO);
			}
		}
		
	}
	
	@Override
	public void registHomeworkPlan(Map<String, Object> map) throws SQLException {
		String cpnoStr = String.valueOf(map.get("cpno"));
		int cpno=0;
		if(cpnoStr != null && cpnoStr != "") {
			cpno = Integer.parseInt(cpnoStr);
		}
		String[] inputArr = (String[])map.get("inputArr");
		String[] taArr = (String[])map.get("taArr");
		
		HomeworkPlanVO homeworkPlanVO = new HomeworkPlanVO();
		
		if(inputArr != null) {
			for(int i=0; i<inputArr.length; i++) {
				int homeworkplan = tclassDAO.selectHomeworkPlanSeqNextValue();
				homeworkPlanVO.setHomeworkplan(homeworkplan);
				homeworkPlanVO.setCpno(cpno);
				if(!inputArr[i].equals("")&&inputArr[i]!=null) {
					homeworkPlanVO.setNo(Integer.parseInt(inputArr[i]));
				}
				homeworkPlanVO.setContent(taArr[i]);
				tclassDAO.insertHomeworkPlan(homeworkPlanVO);
			}
		}
	}
	
	
	@Override
	public void updateWeekPlan(Map<String, Object> map) throws SQLException {
		String[] inputArr = (String[])map.get("inputArr");
		String[] taArr = (String[])map.get("taArr");
		String[] wpnoArr = (String[])map.get("wpnoArr");
		
		WeekPlanVO weekPlanVO = new WeekPlanVO();
		
		for(int i=0; i<inputArr.length; i++) {
			weekPlanVO.setWeek(Integer.parseInt(inputArr[i]));
			weekPlanVO.setWpno(Integer.parseInt(wpnoArr[i]));
			weekPlanVO.setContent(taArr[i]);
			tclassDAO.updateWeekPlan(weekPlanVO);
		}
	}
	@Override
	public void updateHomeworkPlan(Map<String,Object> map) throws SQLException {
		String[] inputArr = (String[])map.get("inputArr");
		String[] taArr = (String[])map.get("taArr");
		String[] homeworkplanArr = (String[])map.get("homeworkplanArr");
		
		HomeworkPlanVO homeworkPlanVO = new HomeworkPlanVO();
		
		for(int i=0; i<inputArr.length; i++) {
			homeworkPlanVO.setNo(Integer.parseInt(inputArr[i]));
			homeworkPlanVO.setHomeworkplan(Integer.parseInt(homeworkplanArr[i]));
			homeworkPlanVO.setContent(taArr[i]);
			tclassDAO.updateHomeworkPlan(homeworkPlanVO);
		}
	}
	@Override
	public void registTextbookAndCphead(Map<String, Object> map) throws SQLException {
		int cpno = tclassDAO.selectClassPlanSeqNextValue();
		
		String cphd = (String)map.get("cpheadTa");
		String textbook = (String)map.get("tbInupt");
		String classCode = (String)map.get("classCode");
		int subCode = (int)map.get("subCode");
		
		
		ClassPlanVO classPlan = new ClassPlanVO();
		ClassVO classVO = new ClassVO();
		
		classPlan.setCpno(cpno);
		classPlan.setCphead(cphd);
		classPlan.setSubject_code(subCode);
		classPlan.setTextbook(textbook);
		
		tclassDAO.insertClassPlan(classPlan);
		
		classVO.setClassCode(classCode);
		classVO.setCpno(Integer.toString(cpno));
		classVO.setCpcheck("4");
		
		tclassDAO.updateClassToRegisterClassPlan(classVO);
	}
	@Override
	public void updateClassPlan(Map<String,Object> map) throws SQLException {
		String tbInupt = String.valueOf(map.get("tbInupt"));
		String cpheadTa = String.valueOf(map.get("cpheadTa"));
		String cpno = String.valueOf(map.get("cpno"));
		
		ClassPlanVO classPlanVO = new ClassPlanVO();
		classPlanVO.setCpno(Integer.parseInt(cpno));
		classPlanVO.setCphead(cpheadTa);
		classPlanVO.setTextbook(tbInupt);
		
		tclassDAO.updateClassPlan(classPlanVO);
	}
	@Override
	public void updateClassPlanForSubmit(Map<String, Object> map) throws SQLException {
		String tbInupt = String.valueOf(map.get("tbInupt"));
		String cpheadTa = String.valueOf(map.get("cpheadTa"));
		String cpno = String.valueOf(map.get("cpno"));
		String classCode = String.valueOf(map.get("classCode"));
		
		ClassPlanVO classPlanVO = new ClassPlanVO();
		classPlanVO.setCpno(Integer.parseInt(cpno));
		classPlanVO.setCphead(cpheadTa);
		classPlanVO.setTextbook(tbInupt);
		
		tclassDAO.updateClassPlan(classPlanVO);
		
		ClassVO classVO = new ClassVO();
		classVO.setClassCode(classCode);
		classVO.setCpno(cpno);
		classVO.setCpcheck("1");
		
		if(classCode!=null&&!classCode.equals("")) {
			tclassDAO.updateClassToRegisterClassPlan(classVO);
		}
		
	}
	@Override
	public void updateClassPlanForTempSave(Map<String, Object> map) throws SQLException {
		String tbInupt = String.valueOf(map.get("tbInupt"));
		String cpheadTa = String.valueOf(map.get("cpheadTa"));
		String cpno = String.valueOf(map.get("cpno"));
		String classCode = String.valueOf(map.get("classCode"));
		
		ClassPlanVO classPlanVO = new ClassPlanVO();
		classPlanVO.setCpno(Integer.parseInt(cpno));
		classPlanVO.setCphead(cpheadTa);
		classPlanVO.setTextbook(tbInupt);
		
		tclassDAO.updateClassPlan(classPlanVO);
		
		ClassVO classVO = new ClassVO();
		classVO.setClassCode(classCode);
		classVO.setCpno(cpno);
		classVO.setCpcheck("4");
		
		if(classCode!=null&&!classCode.equals("")) {
			tclassDAO.updateClassToRegisterClassPlan(classVO);
		}
		
	}
	@Override
	public List<ClassVO> selectClassesForHome(String id) throws SQLException {
		return tclassDAO.selectClassesForHome(id);
	}
	@Override
	public Map<String,Object> selectProgressForHome(String cpno) throws SQLException {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		//해당 수업계획서의 weekPlan 리스트 
		List<WeekPlanVO> wpList = tclassDAO.selectProgressForHome(cpno);
		//해당 수업계획서가 총 몇주차인지 반환
		double weekCount = tclassDAO.weekPlanCount(cpno);
		
		//해당 수업의 시작날짜,종료날짜를  double으로 변환
		double startDate = wpList.get(0).getStartDate().getTime();
		double endDate = wpList.get(0).getEndDate().getTime();
		
		//현재날짜
		double sysDate = new Date().getTime();
		
		//진도율 구하기
		double progressRate = Math.round((sysDate-startDate)/(endDate-startDate)*100*10)/10.0;		
		
		//1주마다 진행되는 퍼센트.
		double perWeek = Math.round(1/weekCount*100*10)/10.0;
		
		System.out.println("perWeek : "+ perWeek);
		
		map.put("wpList", wpList);
		map.put("progressRate", progressRate);
		map.put("perWeek", perWeek);
		map.put("weekCount", weekCount);
		
		return map;
	}
	
	@Override
	public Map<String, Object> selectClassForReview(String id) throws SQLException {
		
		List<ClassVO> classListForReview = tclassDAO.selectClassForReview(id);
		List<ClassReviewVO> classAllReviewList = tclassDAO.selectAllReview(id);
		
		//별점을 퍼센트로 구하기
		for(int i=0; i<classAllReviewList.size(); i++) {
			int starScoreRate = (int) (classAllReviewList.get(i).getStarScore()*20);
			classAllReviewList.get(i).setStarScoreRate(starScoreRate);
		}
		
		//평균 리뷰 점수 구하기
		double avgPoint=0;
		for(int i=0; i<classListForReview.size(); i++) {
			String classCode = classListForReview.get(i).getClassCode();
			double totalPoint = 0;
			List<ClassReviewVO> classReviewList = tclassDAO.selectReview(classCode);
			for(int j=0; j<classReviewList.size(); j++) {
				totalPoint += classReviewList.get(j).getStarScore();
			}
			avgPoint = Math.round(totalPoint/(classReviewList.size())*10)/10.0; 
			classListForReview.get(i).setAvgPoint(avgPoint);
		}
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("classListForReview", classListForReview);
		map.put("classAllReviewList", classAllReviewList);
		
		return map;
	}
	
	@Override
	public Map<String, Object> selectReview(String classCode) throws SQLException {
		
		
		List<ClassReviewVO> classReviewList = tclassDAO.selectReview(classCode);
		
		//별점을 퍼센트로 구하기
		for(int i=0; i<classReviewList.size(); i++) {
			int starScoreRate = (int) (classReviewList.get(i).getStarScore()*20);
			classReviewList.get(i).setStarScoreRate(starScoreRate);
		}
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("classReviewList", classReviewList);
		
		return map;
	}
	@Override
	public ClassReviewVO selectReviewDetail(String reviewCode) throws SQLException {
		
		ClassReviewVO classReview = tclassDAO.selectReviewDetail(reviewCode);
		int starScoreRate = (int)classReview.getStarScore()*20;
		classReview.setStarScoreRate(starScoreRate);
		
		return classReview;
	}
	@Override
	public List<TecounseltVO> selectTodayConsult(String id) throws SQLException {
		return tclassDAO.selectTodayConsult(id);
	}
	@Override
	public List<AssignVO> selectTodayHomework(String id) throws SQLException {
		return tclassDAO.selectTodayHomework(id);
	}
	@Override
	public List<ExamVO> selectTodayTest(String id) throws SQLException {
		return tclassDAO.selectTodayTest(id);
	}
	
	
	
}


















