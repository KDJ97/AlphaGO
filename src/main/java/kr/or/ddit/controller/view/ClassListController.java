package kr.or.ddit.controller.view;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ClassroomVO;
import kr.or.ddit.dto.TimeDetailVO;
import kr.or.ddit.dto.UseRoomVO;
import kr.or.ddit.service.ClassService;
import kr.or.ddit.service.ClassroomService;

@Controller
@RequestMapping("/classlist")
public class ClassListController {

	@Autowired
	ClassService classService;
	@Autowired
	ClassroomService classroomService;
	/**
	 * 수업 목록을 불러오는 컨트롤러
	 * @param cri 페이징을 위해 SearchCriteria를 사용
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String classList(SearchCriteria cri, Model model) throws Exception{
		String url = "classlist/list";
		Map<String, Object> dataMap = classService.selectSearchClassListInClassList(cri); 
		model.addAttribute("dataMap", dataMap);
		return url;
	}
	
	/**
	 * 수업 상세 정보를 가져오는 컨트롤러
	 * @param classCode
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/detail")
	public String detail(String classCode,Model model) throws Exception{
		String url="classlist/detail";
//		int classcode = Integer.parseInt(classCode);
		System.out.println(classCode);
		
		Map<String, Object> dataMap= classService.classDetail(classCode);
		dataMap.put("classCode", classCode);
		
		model.addAttribute("dataMap", dataMap);
		return url;
	}
	
	@RequestMapping("/registForm")
	public String registForm(SearchCriteria cri, Model model) throws Exception{
		String url="classlist/regist";
		Map<String, Object> dataMap = classService.getClassRegElementList(cri);
		model.addAttribute("dataMap", dataMap);
		return url;
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
	
	@ResponseBody
	@RequestMapping("/selectClassByEndDate")
	public ResponseEntity<List<ClassVO>> selectClassByEndDate(){
		ResponseEntity<List<ClassVO>> entity=null;
		try {
			List<ClassVO> classList = classService.selectClassByEndDate();
			entity = new ResponseEntity<List<ClassVO>>(classList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ClassVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	@ResponseBody
	@RequestMapping("/selectClassByStartDate")
	public ResponseEntity<List<ClassVO>> selectClassByStartDate(){
		ResponseEntity<List<ClassVO>> entity=null;
		try {
			List<ClassVO> classList = classService.selectClassByStartDate();
			entity = new ResponseEntity<List<ClassVO>>(classList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<ClassVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping("/selectTimeDetailByClassCode")
	public ResponseEntity<List<TimeDetailVO>> selectTimeDetailByClassCode(String classCode){
		ResponseEntity<List<TimeDetailVO>> entity=null;
		try {
			List<TimeDetailVO> classList = classService.selectTimeDetailByClassCode(classCode);
			entity = new ResponseEntity<List<TimeDetailVO>>(classList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<TimeDetailVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
}










