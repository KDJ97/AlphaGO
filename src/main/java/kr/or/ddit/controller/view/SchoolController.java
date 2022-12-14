package kr.or.ddit.controller.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.SchoolScoreVO;
import kr.or.ddit.dto.SchoolVO;
import kr.or.ddit.service.SchoolService;

@Controller
@RequestMapping("/school")
public class SchoolController {

	@Autowired
	SchoolService schoolService;
	
	@RequestMapping("/list")
	public String schoolList(Model model, SearchCriteria cri) throws Exception{
		String url = "school/list";
		
		Map<String, Object> dataMap = schoolService.selectSearchSchoolList(cri);
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	@RequestMapping("/detail")
	public String schoolDetail(String schoolCode, Model model) throws Exception{
		String url = "school/detail";
		
		SchoolVO school = schoolService.getSchoolDetail(schoolCode);
//		System.out.println(school.toString());
		model.addAttribute("school", school);
		
		return url;
	}
	
	@ResponseBody
	@RequestMapping("/selectMemberList")
	public ResponseEntity<List<MemberVO>> selectMemberList() {
		ResponseEntity<List<MemberVO>> entity = null;
		List<MemberVO> memberList = null;
		try {
			memberList = schoolService.selectMemberList();
			entity = new ResponseEntity<List<MemberVO>>(memberList, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<MemberVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	/**
	 * ?????? ?????? ?????? ?????? ?????????, ?????? ?????? ????????? ??????
	 * @param schoolCode
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getSchoolDetail")
	public ResponseEntity<Map<String, Object>> getSchoolDetail(@RequestParam String schoolCode){
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<MemberVO> memList = new ArrayList<MemberVO>();
		List<SchoolScoreVO> scoreList = new ArrayList<SchoolScoreVO>(); 
		try {
			memList = schoolService.selectMemberBySchoolCode(schoolCode);//???????????? ???????????????
//			System.out.println(memList);
			scoreList = schoolService.selectSchoolScoreAvg(schoolCode);//???????????? ??????
			
			dataMap.put("scoreList", scoreList);//?????????, ????????????, ????????????
			dataMap.put("memberList", memList);
			entity = new ResponseEntity<Map<String, Object>>(dataMap, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	/**
	 * ?????? ????????? ?????? ?????? ????????? ?????? ?????????, ?????? ?????? ?????? ?????? ????????? ??????(????????????)
	 * @param SchoolScoreVO
	 * @return 
	 */
	@ResponseBody
	@RequestMapping(value="/getStudentScore", method=RequestMethod.POST,produces = "application/json;charset=utf-8")
	public ResponseEntity<Map<String, Object>> getStudentScore(@RequestBody SchoolScoreVO schoolScoreVO){
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> dataMap = new HashMap<String, Object>();
//		System.out.println(schoolScoreVO);
		
		String schoolCode = schoolScoreVO.getSchoolCode();
		
		//?????? ????????? ????????? ?????? ?????? (??????,??????,??????,??????,??????)
		List<SchoolScoreVO> scoreList = new ArrayList<SchoolScoreVO>();
		//?????? ?????? ???????????? ????????? ?????? ????????? ?????? ?????????
		List<SchoolScoreVO> scoreByIdList = new ArrayList<SchoolScoreVO>();
		
		try {
			//?????? ????????? ????????? ?????? ?????? (??????,??????,??????,??????,??????)
			scoreList = schoolService.selectSchoolScoreAvg(schoolCode);
			scoreByIdList = schoolService.selectSchoolScoreById(schoolScoreVO);
//			System.out.println();
//			System.out.println("?????? ??????" + scoreList);
//			System.out.println("?????? ??????" + scoreByIdList);
			
			dataMap.put("scoreList", scoreList);
			dataMap.put("scoreByIdList", scoreByIdList);
			
			entity = new ResponseEntity<Map<String, Object>>(dataMap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	
	
	
	
	
	/**
	 * ?????? ??????
	 * @param schoolCode
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/remove",method=RequestMethod.POST,produces="application/json;charset=utf-8")
	public ResponseEntity<Integer> removeSchool(@RequestParam String schoolCode){
		ResponseEntity<Integer> entity = null;
		int result = 0;
		try {
			result = schoolService.removeSchool(schoolCode);
			entity = new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	/**
	 * ?????? ??????
	 * @param schoolVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/regist",method=RequestMethod.POST,produces = "application/json;charset=utf-8")
	public ResponseEntity<Integer> registSchool(@RequestBody SchoolVO schoolVO){
		ResponseEntity<Integer> entity = null;
		int result=0;
//		System.out.println(schoolVO);
		try {
			result=schoolService.insertSchool(schoolVO);
			entity = new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	
	
	
 }















