package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.dto.AssignNameVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.StudyPlanVO;
import kr.or.ddit.dto.StudyPlanerVO;
import kr.or.ddit.service.AssignService;
import kr.or.ddit.service.ExamService;
import kr.or.ddit.service.ScoreService;
import kr.or.ddit.service.StudyPlanService;

@Controller
@RequestMapping("/studyplan")
public class StudyplanController {

	private static final Logger logger = LoggerFactory.getLogger(StudyplanController.class);

	@Autowired
	private StudyPlanService studyplanService;

	@Autowired
	private ScoreService scoreService;

	@Autowired
	private AssignService assignService;

	@Autowired
	private ExamService examService;


	@RequestMapping("/list")
	public String list(@RequestParam(defaultValue = "now")String date, HttpSession session, Model model) throws Exception {
		String url = "studyplan/list";

		if(date.equals("now")) {
			LocalDate now = LocalDate.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
			date = now.format(formatter);
		}

		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		//계획코드 가져오기
		int spCode = studyplanService.getSpCode(date, member.getId());
		StudyPlanerVO planer = studyplanService.getStudyPlaner(spCode);

		List<StudyPlanVO> planList = studyplanService.getPlanList(spCode);


		model.addAttribute("date", date);
		model.addAttribute("planer", planer);
		model.addAttribute("planList", planList);


		//성적
		Map<String, Object> scoreDataMap = scoreService.getScoreListBySubjectMap(member.getId());
		model.addAttribute("scoreDataMap", scoreDataMap);


		//일정
		List<AssignNameVO> assignList = assignService.getAssign(member.getId());
		List<ExamVO> examList = examService.getExam(member.getId());
		List<Map<String, Object>> scheduleList = settingSchedule(assignList, examList);

		model.addAttribute("scheduleList", scheduleList);

		return url;
	}




	@RequestMapping("/modifyForm")
	public String modifyForm(HttpServletRequest request, Model model) throws Exception {
		String url = "studyplan/modify";

		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		//계획코드 가져오기
		int spCode = studyplanService.getSpCode(request.getParameter("date"), member.getId());
		StudyPlanerVO planer = studyplanService.getStudyPlaner(spCode);

		List<StudyPlanVO> planList = studyplanService.getPlanList(spCode);

		model.addAttribute("planer", planer);
		model.addAttribute("planList", planList);
		model.addAttribute("date", request.getParameter("date"));

		//성적
		Map<String, Object> scoreDataMap = scoreService.getScoreListBySubjectMap(member.getId());
		model.addAttribute("scoreDataMap", scoreDataMap);

		//일정
		List<AssignNameVO> assignList = assignService.getAssign(member.getId());
		List<ExamVO> examList = examService.getExam(member.getId());
		List<Map<String, Object>> scheduleList = settingSchedule(assignList, examList);

		model.addAttribute("scheduleList", scheduleList);

		return url;
	}

	@RequestMapping("/modify")
	public String modify(HttpServletRequest request, Model model) throws SQLException {
		String url = "redirect:list.go";


		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		int spCode = studyplanService.getSpCode(request.getParameter("date"), member.getId());
		StudyPlanerVO planer = studyplanService.getStudyPlaner(spCode);

		planer.setStudyTime(Integer.parseInt(request.getParameter("study_time")));
		planer.setFeedback(request.getParameter("feedback"));
//		planer.setAchieveRate();

		studyplanService.updatePlaner(planer);



		for(int i = 0; i < 5; i++) {
			String status = request.getParameter(i + "status");
			String subject_code = request.getParameter(i + "s");
			String study_plan = request.getParameter(i + "p");
			String study_result = request.getParameter(i + "chk");
			String planCode = request.getParameter(i + "code");

			//plan 항목 수정
			if(subject_code != null && study_plan != null && study_result != null ) {
				StudyPlanVO stp = new StudyPlanVO();
				stp.setSpCode(spCode);
				stp.setStudyPlan(study_plan);
				stp.setSubjectCode(Integer.parseInt(subject_code));
				stp.setStudyResult(
					study_result.equals("false") ? 0 : 1
				);
				logger.info(i + "번째 : " + stp );


				if(status != null && status.equals("insert")) {  //insert
					int max = studyplanService.getMaxPlanCode();
					stp.setPlanCode(max);
					studyplanService.insertPlan(stp);
				}else if(status != null && status.equals("update")) {	//update
					stp.setPlanCode(Integer.parseInt(planCode));
					studyplanService.updatePlan(stp);
				}



			}
		}

		return url;
	}

	@RequestMapping("/calendar")
	public String CalendarTest() {
		String url = "studyplan/calendar";
		return url;
	}


	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public void delete(int planCode) throws SQLException{
		studyplanService.deletePlan(planCode);
	}

	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public void check(int code) throws SQLException{
		studyplanService.checkPlan(code);
	}

	private List<Map<String, Object>> settingSchedule(List<AssignNameVO> assignList, List<ExamVO> examList) throws Exception {
		//디데이 d-day, 날짜 date, 일정명 name
		Date today = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");

		List<Map<String, Object>> dataList = new ArrayList<Map<String,Object>>();

		for(AssignNameVO assign : assignList) {
			Map<String, Object> data = new HashMap<String, Object>();

			String dateStr = assign.getStartDate();
			Date date = new Date(dateFormat.parse(dateStr).getTime());
			long calculate = today.getTime() - date.getTime();

			int Ddays = (int) (calculate / (24*60*60*1000));

			System.out.println("Ddays : " + Ddays);

			data.put("Ddays", Ddays);
			data.put("date", dateStr);
			data.put("name", "[과제] " + assign.getTitle());

			dataList.add(data);
		}

		for(ExamVO exam : examList) {
			Map<String, Object> data = new HashMap<String, Object>();

			String dateStr = exam.getStartDate();
			Date date = new Date(dateFormat.parse(dateStr).getTime());
			long calculate = today.getTime() - date.getTime();
			int Ddays = (int) (calculate / (24*60*60*1000));

			System.out.println("Ddays : " + Ddays);

			data.put("Ddays", Ddays);
			data.put("date", dateStr);
			data.put("name", "[시험] " + exam.getExamName());

			dataList.add(data);
		}

		// time(String) 오름차순
		Collections.sort(dataList, new Comparator<Map<String, Object>>() {
			@Override
			public int compare(Map<String, Object> o1, Map<String, Object> o2) {
				String time1 = (String) o1.get("date");
				String time2 = (String) o2.get("date");
				return time2.compareTo(time1);
			}
		});

		return dataList;

	}


}
