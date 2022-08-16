package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.AssignNameVO;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SubjectVO;
import kr.or.ddit.service.ClassService;
import kr.or.ddit.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	private ClassService classService;
	
	@Autowired
	private ReviewService reviewService;
	
   @RequestMapping("/main")
   public void main() {}
   
   // �닔媛뺥썑湲� �쟾泥� �닔�뾽 由ъ뒪�듃
   @RequestMapping(value = "/list")
	public String reviewList(HttpSession session, Model model) {
		String url = "/review/list";
		List<ClassVO> classList = new ArrayList();
		List<ClassReviewVO> revList = new ArrayList();
		Map<String, Object> dataMap = null;
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();
		
		try {
			dataMap = classService.getClassing(id);
			revList = reviewService.selectReviewAll();
			classList = reviewService.classList(id);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("classList", classList);
		model.addAttribute("revList", revList);
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
   
   /**
	 * 媛뺤쓽 �겢由��썑 �썑湲� 由ъ뒪�듃 
	 * @param session
	 * @param name
	 * @return
	 * @throws SQLException
	 */
	@ResponseBody
	@RequestMapping("/reviewList")
	public ResponseEntity<Map<String, Object>> reviewList(HttpSession session, String classCode) {
		ResponseEntity<Map<String, Object>> entity = null;
		double avg = 0;
		
		List<ClassReviewVO> revList = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			avg = reviewService.reviewAvg(classCode);
			avg = Math.round((avg * 1000)/ 1000); 
			revList = reviewService.reviewClass(classCode);
			 
			map.put("avg", avg);
			map.put("revList", revList);
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			
		} catch (SQLException e1) {
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
	}
	
	 // �닔媛뺥썑湲� �벑濡�
	@RequestMapping(value = "/regist")
	public String regist(HttpSession session, Model model, String title, String content, String classCode, int starScore) {
		String url = "redirect:/review/list.go?from=regist&classCode=" + classCode;
		ClassReviewVO vo = new ClassReviewVO();
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();
		vo.setStarScore(starScore);
		vo.setClassCode(classCode);
		vo.setContent(content);
		vo.setTitle(title);
		vo.setId(id);
		
		try {
			reviewService.insertReview(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return url;
	}
	
	@RequestMapping(value = "/registForm")
	public String registForm(HttpSession session, Model model, String classCode) {
		String url = "/review/regist";
		ClassVO vo = new ClassVO();
		try {
			vo = reviewService.infoClass(classCode);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("review", vo);
		return url;
	}
  
}






















