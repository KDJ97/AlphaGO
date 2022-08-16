package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ClassingVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SubjectVO;
import kr.or.ddit.service.ClassService;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.service.ReviewService;
import kr.or.ddit.service.ScoreService;
import kr.or.ddit.service.TclassService;


@Controller
@RequestMapping("/class")
public class ClassController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private ClassService classService;


	@Autowired
	private ScoreService scoreService;

	@Autowired
	private TclassService tclassService;

	@Autowired
	private ReviewService reviewService;

   // 수강신청
   @RequestMapping(value = "/list", method = RequestMethod.GET)
	public String classList(SearchCriteria cri, HttpSession session, Model model) throws Exception{
		String url = "class/list";

		cri.setPerPageNum(5);

		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		Map<String, Object> dataMap = classService.getApplicationClassList(member.getId(), cri);
		List<ClassVO> classList = (List<ClassVO>) dataMap.get("classList");
		for(ClassVO vo : classList) {

			//수업명
			String name = memberService.getMember(vo.getId()).getName();
			vo.setName(name);

			//과목 코드
			SubjectVO sub = classService.selectSubjectBySubdetail(Integer.parseInt(vo.getSubdetailCode()));
			vo.setSubjectCode(sub.getSubjectCode());

			//평균 평점
			double point = reviewService.reviewAvg(vo.getClassCode());
			vo.setAvgPoint(point);
		}

		model.addAttribute("dataMap", dataMap);

		//추천수업
		Map<String, Object> scoreDataMap = scoreService.getScoreListBySubjectMap(member.getId());
		double korAvg = (double) scoreDataMap.get("korAvg");
		double mathAvg = (double) scoreDataMap.get("mathAvg");
		double socialAvg = (double) scoreDataMap.get("socialAvg");
		double scienceAvg = (double) scoreDataMap.get("scienceAvg");
		double engAvg = (double) scoreDataMap.get("engAvg");

		String grade = member.getGrade();

		ClassVO kor = classService.getRecomendClass(korAvg, grade, 1);
		ClassVO math = classService.getRecomendClass(mathAvg, grade, 2);
		ClassVO social = classService.getRecomendClass(socialAvg, grade, 3);
		ClassVO science = classService.getRecomendClass(scienceAvg, grade, 4);
		ClassVO eng = classService.getRecomendClass(engAvg, grade, 5);

		model.addAttribute("kor", kor);
		model.addAttribute("math", math);
		model.addAttribute("social", social);
		model.addAttribute("science", science);
		model.addAttribute("eng", eng);

		return url;
	}

   @RequestMapping(value = "/registClassing")
   public String registClassing(ClassingVO vo, RedirectAttributes rttr) {
	   String url = "redirect:/class/list.go";

	   try {
		classService.registClassing(vo);
		rttr.addFlashAttribute("from", "regist");
	} catch (SQLException e) {
		e.printStackTrace();
		rttr.addFlashAttribute("from", "registError");
	}

	   return url;
   }

   @RequestMapping("/openPdf")
	public String detail(int classCode, Model model) throws Exception{
		String url="class/openPdf";
		//등록된 수업 계획서 정보
		Map<String, Object> dataMap = tclassService.selectRegisteredClassForModal(classCode);

		model.addAttribute("dataMap", dataMap);

		return url;
	}


   @ResponseBody
   @RequestMapping(value = "/checkOverStudent")
   public int checkOverStudent(int code) throws SQLException{
	   int result = 0; //신청가능
	   String stuCnt = classService.selectOverStuCnt(code);
	   if(stuCnt != null) {
		   result = 1;
	   }

	   return result;
   }

   @ResponseBody
   @RequestMapping(value = "/checkClassing")
   public int checkClassing(ClassingVO vo) throws SQLException{
	   int result = 0; //없음
	   ClassingVO classing = classService.getClassingByclassingVO(vo);
	   if(classing != null) {
		   result = 1;	//있음
	   }

	   return result;
   }

}






















