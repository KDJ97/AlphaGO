package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.dto.AcademyScoreVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.ProblemVO;
import kr.or.ddit.dto.WrongVO;
import kr.or.ddit.service.ClassService;
import kr.or.ddit.service.ExamService;

@Controller
@RequestMapping("/exam")
public class ExamController {
   
   @Autowired
   private ExamService examService;
   
   @Autowired
   private ClassService classService;
   
   @RequestMapping("/main")
   public void main() {}
   
   
   /**
    * 수강중인 수업 리스트
    * @param session
    * @param model
    * @return
    */
   @RequestMapping(value = "/list")
	public String examList(HttpSession session, Model model) {
		String url = "/exam/list";
		
		Map<String, Object> dataMap = null;
		List<ExamVO> examList = null;
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();

		try {
			dataMap = classService.getClassing(id);
			examList = examService.getExam(id);
			
			dataMap.put("examList", examList);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("dataMap", dataMap);
		return url;
	}
   
   /**
    * 수업 선택 후 시험 리스트
    * @param session
    * @param name
    * @return
    * @throws SQLException
    */
    @ResponseBody
	@RequestMapping("/examlist")
	public ResponseEntity<List<ExamVO>> examNameList(HttpSession session, String name) throws SQLException {
		ResponseEntity<List<ExamVO>> entity = null;
		List<ExamVO> examNameList = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();

		map.put("className", name);
		map.put("id", id);

		examNameList = examService.selectExamList(map);

		entity = new ResponseEntity<List<ExamVO>>(examNameList, HttpStatus.OK);

		return entity;
	}
   
   /**
    * 지문 유무 체크후 페이지 자르기
    * @param model
    * @param session
    * @param examCode
    * @return
    */
   @RequestMapping(value = "/detail")
	public String examDetail(Model model, HttpSession session, int examCode) {
		String url = "/exam/detail";
		
		
		
		Map<String, Object> dataMap = null;
		
		try {
			dataMap = examService.problemPrint(examCode);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
      
   /**
    * 리스트에서 시험결과 클릭시
    * @param model
    * @param examCode
    * @param session
    * @return
    */
    @RequestMapping(value = "/result", method = RequestMethod.GET)
	public String examResult(Model model, int examCode, HttpSession session) {
		String url = "/exam/result";
		

		Map<String, Object> dataMap = null;
		Map<String, Object> dataMap1 = null;
		Map<String, Object> dataMap2 = null;
		   
		try {
			dataMap = examService.resultExam(examCode, session); // score, achievement
			dataMap1 = examService.checkWrong(examCode, session); // wrongList
			dataMap2 = examService.problemPrint(examCode); // pagination
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("dataMap", dataMap);
		model.addAttribute("dataMap1", dataMap1);
		model.addAttribute("dataMap2", dataMap2);

		List<Integer> wCodeList = new ArrayList<Integer>();

		List<WrongVO> wrongList = (List<WrongVO>) dataMap1.get("wrongList");
		for (WrongVO w : wrongList) {
			wCodeList.add(w.getProblemCode());
		}

		model.addAttribute("wCodeList", wCodeList);
		
		return url;
	}

   /**
    * 시험응시 직후 시험결과 
    * @param request
    * @param examCode
    * @param problem
    * @return
 * @throws Exception 
    */
   @RequestMapping(value = "/check")
   public String check(Model model, HttpServletRequest request, int examCode, HttpSession session, int problem) throws SQLException {
	   String url = "redirect:/exam/result.go?examCode=" + examCode;

	   examService.checkExam(request, examCode, session, problem);

	   return url;
   }
}
