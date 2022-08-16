package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.dto.SHUnivVO;
import kr.or.ddit.dto.SchoolScoreVO;
import kr.or.ddit.dto.UniversityVO;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.service.ScoreService;

// 작성자 : 예현의
// 작성일  : 2022-07-06
// 원생 성적관리 메뉴의 Controller

@Controller
public class ScoreController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private ScoreService scoreService;

	private static final Logger logger = LoggerFactory.getLogger(SchoolController.class);

	// 학교 성적 상세보기
	@RequestMapping(value = "/sscore/detail")
	public String sscore(@RequestParam(defaultValue = "")String id, HttpSession session, Model model) throws Exception{
		String url = "score/school_detail";

		//원생 접근

		if(id.equals("")) {
			id = ((MemberVO)session.getAttribute("loginUser")).getId();
			model.addAttribute("from", "student");
		}

		if(id.equals(((MemberVO)session.getAttribute("loginUser")).getId())) {
			model.addAttribute("from", "student");
		}


		MemberVO member = memberService.getMember(id);
		model.addAttribute("member", member);


		Map<String, Object> subjectMap = scoreService.getScoreListBySubjectMap(id);
		model.addAttribute("subjectMap", subjectMap);


		//희망 대학 목표점수
		Map<String, UniversityVO> uniMap = memberService.getSHUniList(id);
		model.addAttribute("uniMap", uniMap);




		//합격예측 대학 리스트
		Map<String, List<PacounseltVO>> predictionUniMap = scoreService.getPredictionPassUni(id);
		model.addAttribute("predictionUniMap", predictionUniMap);

		return url;
	}



	// 학원 성적 상세보기
	@RequestMapping(value = "/ascore/detail")
	public String ascore(@RequestParam(defaultValue = "")String id, HttpSession session, Model model) throws Exception {
		String url = "score/academy_detail";
		//원생 접근
		if(id.equals(((MemberVO)session.getAttribute("loginUser")).getId())) {
			model.addAttribute("from", "student");
		}

		if(id.equals("")) {
			id = ((MemberVO)session.getAttribute("loginUser")).getId();
			model.addAttribute("from", "student");
		}

		MemberVO member = memberService.getMember(id);
		model.addAttribute("member", member);

		//듣는 수업 리스트
		List<ClassVO> classList = scoreService.getClassNameListById(id);
		model.addAttribute("classList", classList);

		//과목별 성적 리스트
		Map<String, List<Map<String, String>>> subjectMap = scoreService.getSubjectScoreData(id);
		model.addAttribute("subjectMap", subjectMap);

		//과목별 성적 영역 리스트
		Map<String, Object> subAreaData = scoreService.getSubjectAreaData(id);
		model.addAttribute("subAreaData", subAreaData);


		//과목별 평균
		Map<String, Double> subjectAvgMap = scoreService.getAllSubjectScoreDataAvg();
		model.addAttribute("subjectAvgMap", subjectAvgMap);

		return url;
	}

	@ResponseBody
	@RequestMapping("/sscore/getScoreList")
	public List<SchoolScoreVO> getScoreList(SchoolScoreVO score) throws SQLException{
		return scoreService.getScoreList(score);
	}

	@ResponseBody
	@RequestMapping("/sscore/removeScoreData")
	public void removeScoreData(int sscode) throws SQLException{
		scoreService.deleteScoreDate(sscode);
	}

	@ResponseBody
	@RequestMapping("/sscore/insertScoreData")
	public int insertScoreData(SchoolScoreVO score) throws SQLException{
		scoreService.insertScore(score);

		return score.getSscode();
	}

	@ResponseBody
	@RequestMapping("/sscore/modifyScoreData")
	public void modifyScoreData(SchoolScoreVO score) throws SQLException{
		scoreService.modifyScore(score);
	}

	@ResponseBody
	@RequestMapping("/ascore/getAcademyScoreList")
	public List<AcademyScoreVO> getAcademyScoreList(String id, int classCode) throws SQLException{
		return scoreService.getAcademyScoreList(id, classCode);
	}

	@ResponseBody
	@RequestMapping("/ascore/getExamData")
	public Map<String, String> getExamData(int examCode) throws SQLException{
		return scoreService.getExamData(examCode);
	}



}
