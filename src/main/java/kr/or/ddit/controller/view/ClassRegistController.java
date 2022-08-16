package kr.or.ddit.controller.view;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassroomVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SubjectVO;
import kr.or.ddit.dto.UseRoomVO;
import kr.or.ddit.service.ClassService;
import kr.or.ddit.service.ClassroomService;
import kr.or.ddit.service.DmService;

@Controller
@RequestMapping("/classregist")
public class ClassRegistController {
	//개설 수업 삭제는 스케줄러로 진행한다.

	@Autowired
	ClassroomService classroomService;
	@Autowired
	ClassService classService;
	
	/**
	 * 수업개설페이지 컨트롤러
	 * @param cri
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String classRegistPage(SearchCriteria cri, Model model) throws Exception{
		String url = "classregist/list";
		Map<String, Object> dataMap = classService.getClassRegElementList(cri);
		model.addAttribute("dataMap", dataMap);
		return url;
	}

	/**
	 * 수업개설페이지 강사 리스트 컨트롤러
	 * @param subjectName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getTeacherList")
	public ResponseEntity<List<MemberVO>> getTeacherList(String subjectName) {
		ResponseEntity<List<MemberVO>> entity = null;
		List<MemberVO> teacherList = null;
		System.out.println(subjectName);
		try {
			teacherList = classService.getTeacherList(subjectName);
			entity = new ResponseEntity<List<MemberVO>>(teacherList, HttpStatus.OK); 
			
		} catch (Exception e) {
			entity = new ResponseEntity<List<MemberVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	/**
	 * 강의실 상세 컨트롤러
	 * @param classCode
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/classDetail", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getClassDetail(String classCode){
		ResponseEntity<Map<String, Object>> entity = null;
		
		int classcode = Integer.parseInt(classCode);
		
		try {
			Map<String, Object> classDetail = classService.getClassDetail(classcode);
			
			entity = new ResponseEntity<Map<String, Object>>(classDetail, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	/**
	 * 수업개설페이지 강사 상세 컨트롤러
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getTeacherDetail")
	public ResponseEntity<Map<String, Object>> getTeacherDetail(String id){
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> dataMap = null;
		
		try {
			dataMap = classService.getTeacherDetail(id);
			entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	/**
	 * 
	 * @param roomCode
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getUseRoomTime")	
	public ResponseEntity<List<UseRoomVO>> getUseRoomList(String roomCode){
		ResponseEntity<List<UseRoomVO>> entity = null;
		List<UseRoomVO> list = null;
		
		try {
			list = classService.getUseRoomList(roomCode);
			entity = new ResponseEntity<List<UseRoomVO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<UseRoomVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	/**
	 * 
	 * @param roomCode
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/oneClassroom")
	public ResponseEntity<ClassroomVO> getClassroom(String roomCode){
		ResponseEntity<ClassroomVO> entity = null;
		ClassroomVO room = null;
		try {
			room = classroomService.getOneClassroom(roomCode);
			entity = new ResponseEntity<ClassroomVO>(room, HttpStatus.OK);
			
		} catch (Exception e) {
			entity = new ResponseEntity<ClassroomVO>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	/**
	 * 서브메뉴 컨트롤러
	 * @param opVal
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/subDetail", method = RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<List<SubjectVO>> getSubDetail(int opVal){
		ResponseEntity<List<SubjectVO>> entity = null;
		System.out.println(opVal);
//		int subdetailcode = Integer.parseInt(subcode);
		
		try {
			List<SubjectVO> subList = classService.getSubDetail(opVal);
			
			entity = new ResponseEntity<List<SubjectVO>>(subList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<SubjectVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@Autowired
	DmService dmService;
	
	//수업 개설 페이지 ajax를 받는 비동기 컨트롤러이다
	//수업 개설 등록임
	@ResponseBody
	@RequestMapping(value="/classOpen",method=RequestMethod.POST, produces = "application/json;charset=utf-8")
	public ResponseEntity<Integer> classOpen(@RequestBody Map<String,Object> map, HttpSession session){
		ResponseEntity<Integer> entity = null;
		System.out.println(map);
		int res = 0;
		
		//쪽지를 보낼 강사 id
		List<String> to = new ArrayList<String>();
		to.add((String) map.get("id"));
		
		//현재 로그인된 아이디 꺼내기(원장)
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		String from = loginUser.getId();
		
		String title = "'" + map.get("className") + "' 수업계획서 제출 요청";
		String content="수업명 : " + map.get("className");
		dmService.sendDm(to, from, title, content);
		
		try {
			res = classService.updateClassOpen(map);
			entity = new ResponseEntity<Integer>(res, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

}




















