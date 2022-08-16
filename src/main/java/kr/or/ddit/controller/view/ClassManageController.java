package kr.or.ddit.controller.view;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.SubjectVO;
import kr.or.ddit.service.ClassService;

@Controller
@RequestMapping("/classmanage")
public class ClassManageController {
	@Autowired
	ClassService classService;
	
	/**
	 * 강의실 관리로 가는 컨트롤러
	 * @param cri
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list")
	public String classmanage(SearchCriteria cri, Model model) throws Exception{
		String url = "classmanage/list";
		
		Map<String, Object> dataMap = classService.getSearchClassList(cri);
		
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	/**
	 * 수업 상세 컨트롤러
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
	 * 수업관리- 등록 컨트롤러
	 * @param classVO
	 * @param rttr
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/classregistGo")
	public String classregist(ClassVO classVO, RedirectAttributes rttr) throws Exception{
		String url = "redirect:/classmanage/list.go";
//		System.out.println(classVO);
		classService.registClass(classVO);
		
		rttr.addFlashAttribute("from", "regist");
		
		return url;
	}
	
	/**
	 * 수업관리- 페이지 삭제 컨트롤러
	 * @param classVO
	 * @param rttr
	 * @return
	 */
	@RequestMapping("/classremove")
	public String classremove(ClassVO classVO, RedirectAttributes rttr){
		String url = "redirect:/classmanage/list.go";
		try {
			classService.removeClass(classVO);
			rttr.addFlashAttribute("from", "removeSuccess");
		} catch (Exception e) {
			e.printStackTrace();
			rttr.addFlashAttribute("from", "removeFail");
		}
		return url;
	}
}
















