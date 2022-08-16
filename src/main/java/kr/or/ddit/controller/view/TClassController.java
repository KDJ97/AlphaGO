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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassPlanVO;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.HomeworkPlanVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.WeekPlanVO;
import kr.or.ddit.service.TclassService;

@Controller
@RequestMapping("/tclass")
public class TClassController {
	
	@Autowired
	private TclassService tclassService;

	@RequestMapping("/list")
	public String list(kr.or.ddit.command.SearchCriteria cri,HttpServletRequest request, Model model) throws Exception{
		String url = "tclass/list";
		
		String keyword2 = request.getParameter("keyword2");
		
		HttpSession session=request.getSession();
		MemberVO member=(MemberVO)session.getAttribute("loginUser");
		String id=member.getId();
		
		SearchCriteria cri2 = new SearchCriteria();
		
		cri2.setKeyword(keyword2);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("cri", cri2);
		map.put("id",id);
		
		Map<String, Object> dataMap = tclassService.classList(cri);
		Map<String, Object> dataMap2 = tclassService.unregisteredClassList(map);
		
		List<ClassVO> classVOList = (List<ClassVO>) dataMap.get("classList");
		List<ClassVO> classVOList2 = (List<ClassVO>) dataMap2.get("unregisteredClassList");
		List<ClassVO> test22 = new ArrayList<ClassVO>();
		List<ClassVO> test33 = new ArrayList<ClassVO>();
		
		
		if(classVOList.size()>0 && classVOList!=null) {
			for(int i=0; i<classVOList.size(); i++) {
				if(id.equals(classVOList.get(i).getId())) {
					test22.add(classVOList.get(i));
				}
			}
		}
		System.out.println("test22: "+test22);
		dataMap.put("classList", test22);
		
		if(classVOList2.size()>0 && classVOList2!=null) {
			for(int i=0; i<classVOList2.size(); i++) {
				if(id.equals(classVOList2.get(i).getId())) {
					test33.add(classVOList2.get(i));
				}
			}
		}
		System.out.println("test33: "+test33);
		dataMap2.put("unregisteredClassList", test33);
		
		model.addAttribute("dataMap",dataMap);
		model.addAttribute("dataMap2",dataMap2);
		model.addAttribute("keyword2",keyword2);
		
		return url;
	}
	
	@RequestMapping("/ingDetail")
	public String ingDetail(int classCode, HttpServletRequest request, Model model) throws Exception{
		String url = "tclass/ingDetail";
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		dataMap = tclassService.selectRegisteredClassForModal(classCode);
		
		model.addAttribute("dataMap",dataMap);
		
		return url;
	}
	@RequestMapping("/unregisteredDetail")
	public String unregisteredDetail(int classCode, HttpServletRequest request, Model model) throws Exception{
		String url = "tclass/unregisteredDetail";
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		dataMap = tclassService.selectUnregisteredClassForModal(classCode);
		
		model.addAttribute("dataMap",dataMap);
		
		return url;
	}
	
	@ResponseBody
	@RequestMapping(value="/searchList",method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> searchList(@RequestParam Map<String,Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		String key = (String)map.get("keyword");
		SearchCriteria cri = new SearchCriteria();
		cri.setKeyword(key);
		System.out.println("controller1에서 key1:"+key);
		
		HttpSession session=request.getSession();
		MemberVO member=(MemberVO)session.getAttribute("loginUser");
		String id=member.getId();
		
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<ClassVO> test22 = new ArrayList<ClassVO>();
		try {
			dataMap = tclassService.classList(cri);
			List<ClassVO> classVOList = (List<ClassVO>) dataMap.get("classList");
			if(classVOList.size()>0 && classVOList!=null) {
				for(int i=0; i<classVOList.size(); i++) {
					if(id.equals(classVOList.get(i).getId())) {
						test22.add(classVOList.get(i));
					}
				}
			}
			dataMap.put("classList", test22);
			entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value="/searchList2",method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> searchList2(@RequestParam Map<String,Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String key2 = (String)map.get("keyword");
		String cpType = (String)map.get("cpType");
		
		HttpSession session=request.getSession();
		MemberVO member=(MemberVO)session.getAttribute("loginUser");
		String id=member.getId();
		
		Map<String,Object> map2 = new HashMap<String,Object>();
		map2.put("keyword", key2);
		map2.put("cpcheck", cpType);
		map2.put("id",id);
		
		Map<String,Object> dataMap = new HashMap<String,Object>();
		try {
			dataMap = tclassService.unregisteredClassList(map2);
			entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/unregiClass",method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> unregiClass(@RequestParam Map<String,Object> map){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String strClassCode = (String)map.get("classCode");
		int classCode = Integer.parseInt(strClassCode);
		System.out.println("classCode : "+classCode);
		
		Map<String, Object> ctMap = new HashMap<String, Object>();
		try {
			ctMap = tclassService.selectUnregisteredClassForModal(classCode);
			entity = new ResponseEntity<Map<String,Object>>(ctMap,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(ctMap,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/regiClass",method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> regiClass(@RequestParam Map<String,Object> map){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String strClassCode = (String)map.get("classCode");
		int classCode = Integer.parseInt(strClassCode);
		System.out.println("classCode : "+classCode);
		
		Map<String, Object> ctMap = new HashMap<String, Object>();
		try {
			ctMap = tclassService.selectRegisteredClassForModal(classCode);
			entity = new ResponseEntity<Map<String,Object>>(ctMap,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(ctMap,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/registerClassPlan",method=RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> registerClassPlan(@RequestParam Map<String,Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String textbook = (String)map.get("tb");
		String cphd = String.valueOf(map.get("cphd"));
		String subName = (String)map.get("subName");
		String classCode = (String)map.get("classCode");
		int subCode=0;
		if(subName.equals("국어")) { subCode = 1;}
		if(subName.equals("수학")) { subCode = 2;}
		if(subName.equals("사회")) { subCode = 3;}
		if(subName.equals("과학")) { subCode = 4;}
		if(subName.equals("영어")) { subCode = 5;}
		if(subName.equals("미선택")) { subCode = 0;}
		String[] weeks = request.getParameterValues("weeksArr");
		String[] cps = request.getParameterValues("cpsArr");
		String[] hwnos = request.getParameterValues("hwnoArr");
		String[] hwPlans = request.getParameterValues("hwPlanArr");
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap.put("classCode", classCode);
		dataMap.put("weeks", weeks);
		dataMap.put("cps", cps);
		dataMap.put("hwnos", hwnos);
		dataMap.put("hwPlans", hwPlans);
		dataMap.put("cphd", cphd);
		dataMap.put("textbook", textbook);
		dataMap.put("subCode", subCode);
		
		try {
			tclassService.registClassPlan(dataMap);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value="/saveClassPlan",method=RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> saveClassPlan(@RequestParam Map<String,Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String textbook = (String)map.get("tb");
		String cphd = String.valueOf(map.get("cphd"));
		String subName = (String)map.get("subName");
		String classCode = (String)map.get("classCode");
		int subCode=0;
		if(subName.equals("국어")) { subCode = 1;}
		if(subName.equals("수학")) { subCode = 2;}
		if(subName.equals("사회")) { subCode = 3;}
		if(subName.equals("과학")) { subCode = 4;}
		if(subName.equals("영어")) { subCode = 5;}
		if(subName.equals("미선택")) { subCode = 0;}
		String[] weeks = request.getParameterValues("weeksArr");
		String[] cps = request.getParameterValues("cpsArr");
		String[] hwnos = request.getParameterValues("hwnoArr");
		String[] hwPlans = request.getParameterValues("hwPlanArr");
		
		System.out.println("-----tclassCOntroller-77-----");
		System.out.println("hwnos[0]:" + hwnos[0]);
		System.out.println("hwPlans[1]:" + hwPlans[1]);
		
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap.put("classCode", classCode);
		dataMap.put("weeks", weeks);
		dataMap.put("cps", cps);
		dataMap.put("hwnos", hwnos);
		dataMap.put("hwPlans", hwPlans);
		dataMap.put("cphd", cphd);
		dataMap.put("textbook", textbook);
		dataMap.put("subCode", subCode);
		
		try {
			tclassService.saveClassPlan(dataMap);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/registerWeekPlan",method=RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> registerWeekPlan(@RequestParam Map<String,Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String cpno = String.valueOf(map.get("cpno"));
		String[] inputArr = request.getParameterValues("inputArr");
		String[] taArr = request.getParameterValues("taArr");
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap.put("cpno", cpno);
		dataMap.put("inputArr", inputArr);
		dataMap.put("taArr", taArr);
		
		try {
			tclassService.registWeekPlan(dataMap);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/registerHomeworkPlan",method=RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> registerHomeworkPlan(@RequestParam Map<String,Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String cpno = String.valueOf(map.get("cpno"));
		String[] inputArr = request.getParameterValues("inputArr");
		String[] taArr = request.getParameterValues("taArr");
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap.put("cpno", cpno);
		dataMap.put("inputArr", inputArr);
		dataMap.put("taArr", taArr);
		
		try {
			tclassService.registHomeworkPlan(dataMap);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value="/registerTextbookAndCphead",method=RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> registerTextbookAndCphead(@RequestParam Map<String,Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String tbInupt = String.valueOf(map.get("tbInupt"));
		String cpheadTa = String.valueOf(map.get("cpheadTa"));
		String subName = String.valueOf(map.get("subName"));
		String classCode = String.valueOf(map.get("classCode"));
		int subCode=0;
		if(subName.equals("국어")) { subCode = 1;}
		if(subName.equals("수학")) { subCode = 2;}
		if(subName.equals("사회")) { subCode = 3;}
		if(subName.equals("과학")) { subCode = 4;}
		if(subName.equals("영어")) { subCode = 5;}
		if(subName.equals("미선택")) { subCode = 0;}
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap.put("tbInupt", tbInupt);
		dataMap.put("cpheadTa", cpheadTa);
		dataMap.put("subCode", subCode);
		dataMap.put("classCode", classCode);
		
		try {
			tclassService.registTextbookAndCphead(dataMap);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteWeekPlan",method =RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> deleteWeekPlan(@RequestParam Map<String,Object> map){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String wpnoStr = String.valueOf(map.get("wpno"));
		int wpno = Integer.parseInt(wpnoStr);
		
		System.out.println("deleteWeekPlan에서 wpno88 :" + wpno);
		
		try {
			tclassService.deleteClassPlan(wpno);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteHomeworkPlan",method =RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> deleteHomeworkPlan(@RequestParam Map<String,Object> map){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String homeworkplanStr = String.valueOf(map.get("homeworkplan"));
		int homeworkplan = Integer.parseInt(homeworkplanStr);
		
		System.out.println("deleteHomework에서 homeworkplan :" + homeworkplan);
		
		try {
			tclassService.deleteHomeworkPlan(homeworkplan);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/updateWeekPlan", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateWeekPlan(@RequestParam Map<String, Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String[] inputArr = request.getParameterValues("inputArr");
		String[] taArr = request.getParameterValues("taArr");
		String[] wpnoArr = request.getParameterValues("wpnoArr");
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap.put("wpnoArr", wpnoArr);
		dataMap.put("inputArr", inputArr);
		dataMap.put("taArr", taArr);
		
		
		try {
			tclassService.updateWeekPlan(dataMap);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	@ResponseBody
	@RequestMapping(value="/updateHomeworkPlan", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateHomeworkPlan(@RequestParam Map<String, Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String[] inputArr = request.getParameterValues("inputArr");
		String[] taArr = request.getParameterValues("taArr");
		String[] homeworkplanArr = request.getParameterValues("homeworkplanArr");
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap.put("homeworkplanArr", homeworkplanArr);
		dataMap.put("inputArr", inputArr);
		dataMap.put("taArr", taArr);
		
		try {
			tclassService.updateHomeworkPlan(dataMap);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value="/updateClassPlan", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateClassPlan(@RequestParam Map<String, Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String tbInupt = String.valueOf(map.get("tbInupt"));
		String cpheadTa = String.valueOf(map.get("cpheadTa"));
		String cpno = String.valueOf(map.get("cpno"));
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap.put("tbInupt", tbInupt);
		dataMap.put("cpheadTa", cpheadTa);
		dataMap.put("cpno", cpno);
		
		try {
			tclassService.updateClassPlan(dataMap);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping(value="/updateClassPlanForSubmit", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateClassPlanForSubmit(@RequestParam Map<String, Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String tbInupt = String.valueOf(map.get("tbInupt"));
		String cpheadTa = String.valueOf(map.get("cpheadTa"));
		String cpno = String.valueOf(map.get("cpno"));
		String classCode = String.valueOf(map.get("classCode"));
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap.put("tbInupt", tbInupt);
		dataMap.put("cpheadTa", cpheadTa);
		dataMap.put("cpno", cpno);
		dataMap.put("classCode", classCode);
		
		try {
			tclassService.updateClassPlanForSubmit(dataMap);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/updateClassPlanForTempSave", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateClassPlanForTempSave(@RequestParam Map<String, Object> map, HttpServletRequest request){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String tbInupt = String.valueOf(map.get("tbInupt"));
		String cpheadTa = String.valueOf(map.get("cpheadTa"));
		String cpno = String.valueOf(map.get("cpno"));
		String classCode = String.valueOf(map.get("classCode"));
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap.put("tbInupt", tbInupt);
		dataMap.put("cpheadTa", cpheadTa);
		dataMap.put("cpno", cpno);
		dataMap.put("classCode", classCode);
		
		try {
			tclassService.updateClassPlanForTempSave(dataMap);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	
	@RequestMapping("/review")
	public String review(Model model, HttpServletRequest request) throws Exception{
		String url = "tclass/review";

		HttpSession session=request.getSession();
		MemberVO member=(MemberVO)session.getAttribute("loginUser");
		String id=member.getId();
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		dataMap = tclassService.selectClassForReview(id);
		
		model.addAttribute("dataMap",dataMap);
		
		return url;
	}
	
	@ResponseBody
	@RequestMapping("/getReview")
	ResponseEntity<Map<String, Object>> getReview(@RequestParam Map<String, Object> map){
		ResponseEntity<Map<String, Object>> entity = null;
		
		String classCode = (String) map.get("classCode");
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		try {
			dataMap = tclassService.selectReview(classCode);
			entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	@ResponseBody
	@RequestMapping("/getReviewDetail")
	ResponseEntity<Map<String, Object>> getReviewDetail(@RequestParam Map<String, Object> map){
		ResponseEntity<Map<String, Object>> entity = null;
		
		String reviewCode = (String) map.get("reviewCode");
		
		Map<String,Object> dataMap = new HashMap<String, Object>();
		try {
			ClassReviewVO classReviewVO = tclassService.selectReviewDetail(reviewCode);
			dataMap.put("classReviewVO", classReviewVO);
			entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(dataMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@RequestMapping("/star")
	public String star(kr.or.ddit.command.SearchCriteria cri, Model model) throws Exception{
		String url = "tclass/rater-js-master/rater-js-master/example/index";

		return url;
	}
	
	
}
