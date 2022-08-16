package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.command.YJSearchCriteria;
import kr.or.ddit.dto.AssignNameVO;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.WrongVO;
import kr.or.ddit.service.ClassService;
import kr.or.ddit.service.DmService;
import kr.or.ddit.service.WrongService;

@Controller
@RequestMapping("/wrong")
public class WrongController {

	@Autowired
	private DmService dmService;

   @Autowired
   private ClassService classService;
   
   @Autowired
   private WrongService wrongService;
   
   @RequestMapping("/main")
   public void main() {}
   
   // 오답노트 리스트
   @RequestMapping(value = "/list")
	public String wrongList(YJSearchCriteria cri ,@RequestParam(defaultValue = "") String wno,  HttpSession session, Model model) {
		String url = "/wrong/list";
		
		System.out.println("wno : " + wno);
		
		Map<String, Object> dataMap = null;
		Map<String, Object> dataMap1 = null;
		WrongVO vo = new WrongVO();
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		String id = member.getId();
		
		try {
			dataMap1 = classService.getClassing(id); // 셀렉트박스 수업 리스트
			dataMap = wrongService.selectWrong(id, cri); // 오답리스트	
			vo = wrongService.selectDetailMain(id); // 오답상세 디폴트 화면
			dataMap.put("wrongDetail", vo);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.addAttribute("dataMap", dataMap);
		model.addAttribute("dataMap1", dataMap1);
		model.addAttribute("cate", cri.getCateType());
		model.addAttribute("search", cri.getSearchType());
		model.addAttribute("wno", wno);
		
		
		return url;
	}
   
   /**
    * 셀렉트 박스 수업선택후 시험선택 리스트 
    * @param session
    * @param name
    * @return
    * @throws SQLException
    */
   @ResponseBody
   @RequestMapping(value = "/examList")
   public ResponseEntity<List<ExamVO>> examList(HttpSession session, String name) throws SQLException {
		ResponseEntity<List<ExamVO>> entity = null;
		List<ExamVO> wrongList = null;
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map1 = new HashMap<String, Object>();
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();
		
		map.put("className", name);
		map.put("id", id);
		wrongList = wrongService.selectExam(map);
		
		entity = new ResponseEntity<List<ExamVO>>(wrongList, HttpStatus.OK);

		return entity;
	}
   
   @ResponseBody
   @RequestMapping(value = "/wrongDetail")
   public ResponseEntity<WrongVO> examDetail(HttpSession session, int wno, int problemCode) throws SQLException {
		ResponseEntity<WrongVO> entity = null;
		WrongVO wrongVO = new WrongVO();
		Map<String, Object> map = new HashMap<String, Object>();
		String jimoon = "";
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();
		
		map.put("wno", wno);
		map.put("id", id);
		wrongVO = wrongService.selectDetailWrong(map);
		jimoon = wrongService.selectJimoon(problemCode);
		
		if(wrongVO.getProblemPrint() == null) {
			if(jimoon != null) {
				wrongVO.setProblemPrint(jimoon);
			}
		}
		
		entity = new ResponseEntity<WrongVO>(wrongVO, HttpStatus.OK);

		return entity;
	}
   
   // 지문 조회
   @RequestMapping(value = "/jimoon")
	public String wrongJimoon(int problemCode, Model model, HttpSession session, int wno) {
		String url = "/wrong/jimoon";
		String jimoon = "";
		
		WrongVO wrongVO = new WrongVO();
		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();	
		map.put("wno", wno);
		map.put("id", id);
		
		try {
			wrongVO = wrongService.selectDetailWrong(map);
			jimoon = wrongService.selectJimoon(problemCode);
			
			if(wrongVO.getProblemPrint() == null) {
				if(jimoon != null) {
					wrongVO.setProblemPrint(jimoon);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.addAttribute("wrong", wrongVO);
		return url;
	}

// 오답노트 해설 등록
   @RequestMapping(value = "/regist")
	public String wrongRegist(int wno, Model model, String content) {
		String url = "/wrong/regist";
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("wno", wno);
		map.put("content", content);
		try {
			wrongService.insertSolution(map);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		return url;
	}
   
// 오답노트 해설 등록
   @RequestMapping(value = "/registForm")
	public String wrongSolRegist(HttpSession session, int wno, Model model) {
		String url = "/wrong/regist";
		
		return url;
	}
   
// 오답노트 질문등록
   @RequestMapping(value = "/questionForm")
	public String questionDetail(HttpSession session, int wno, Model model, int examCode) {
		String url = "/wrong/question";
		WrongVO wrongVO = new WrongVO();
		WrongVO vo = new WrongVO();
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();
		
		List<WrongVO> wList = new ArrayList<WrongVO>();
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();
		
		map.put("wno", wno);
		map.put("id", id);
		
		map2.put("wno", wno);
		map2.put("id", id);
		
		try {
			wList = wrongService.selectTname(examCode);
			vo = wrongService.selectSname(map);
			wrongVO = wrongService.selectDetailWrong(map);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("wrongDetail", wrongVO);
		model.addAttribute("tName", wList);
		model.addAttribute("sName", vo);
		
		return url;
	}

//오답노트 질문등록
@RequestMapping(value = "/question")
	public String questionRegist(HttpSession session, int wno, String question, int examCode) {
		String url = "redirect:/wrong/questionForm.go?wno=" + wno + "&examCode=" + examCode;
		Map<String, Object> updateMap = new HashMap<String, Object>();
		List<WrongVO> wList = new ArrayList<WrongVO>();
		
		updateMap.put("wno", wno);
		updateMap.put("question", question);

		try {
			wrongService.updateQuestion(updateMap); // 질문 등록
			
			wList = wrongService.selectTname(examCode);
			
			//쪽지를 받을 사람
		     List<String> to = new ArrayList<String>();
		     to.add(wList.get(0).getId());
		      
		     //쪽지를 보내는 사람
		     MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		     String from = loginUser.getId();
		      
		     String title= "오답 질문";
		     String content= "질문 내용 : " + question;
		     dmService.sendDm(to, from, title, content);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return url;
	}
}






















