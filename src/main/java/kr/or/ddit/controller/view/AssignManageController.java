package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.command.AssignModifyCommand;
import kr.or.ddit.command.AssignRegistCommand;
import kr.or.ddit.controller.rest.GetAssignByMultipartFileAdapter;
import kr.or.ddit.dto.AssignAttachVO;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.service.AssignService;
import kr.or.ddit.service.DmService;
import kr.or.ddit.service.TeacherService;

@Controller
@RequestMapping("/assignManage")
public class AssignManageController {
	
	@Autowired
	private AssignService assignService;
	@Autowired
	private DmService dmService;
	@Autowired
	private TeacherService teacherService;

	@RequestMapping("/list")
	public String list(Model model, HttpServletRequest request) throws Exception{
		String url = "assign_manage/list";

		HttpSession session=request.getSession();
		MemberVO member=(MemberVO)session.getAttribute("loginUser");
		String id=member.getId();
		
		System.out.println("로그인한 id : " + id);
		
		Map<String, Object> dataMap = assignService.selectAssignForTeacher(id);
		
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	@RequestMapping("/dm")
	public String dm(String id, Model model, HttpServletRequest request) throws Exception{
		String url ="assign_manage/dm";
		
		model.addAttribute("id",id);
		
		return url;		
	}
	@RequestMapping(value = "/send", method = RequestMethod.POST)
	public String send(@RequestParam("to")String to, @RequestParam("title")String title, @RequestParam(value = "content", defaultValue = "")String content, HttpSession session, Model model) {

		String url = "assign_manage/dm";
		
		List<String> to_list = Arrays.asList(to.split(","));

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		String from = loginUser.getId();
		
		System.out.println("to_list : " + to_list);
		
		dmService.sendDm(to_list, from, title, content);
		
		model.addAttribute("from", "send");
		
		return url;
	}
	
	@RequestMapping("/detail")
	public String detail(String id, Model model, HttpServletRequest request) throws Exception{
		String url="assign_manage/detail";

		MemberVO member = teacherService.teacherstudentDetail(id);
		
		model.addAttribute("member", member);
		
		return url;
	}
	
	
	@RequestMapping("/check")
	public String check(String name,int assignCode, String id, Model model, HttpServletRequest request) throws Exception{
		String url = "assign_manage/check";

		AssignVO assign = null;		
		AssignAttachVO attach = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map2 = new HashMap<String, Object>();
		map.put("assignCode", assignCode);
		map.put("id", id);
		map2.put("assignCode", assignCode);
		map2.put("id", id);
		map2.put("confirm", "확인 완료");
		
		try {
			assign = assignService.selectAssignDetail(assignCode);
			attach = assignService.selectAssignAttach(map);
			if(attach.getAssignCode()!=0) {
				assignService.checkHomework(map2);
			}

		} catch (Exception e1) {

			e1.printStackTrace();
		}

		// 파일명 재정의
		if (assign != null) {
			if (assign.getUploadpath() != null) {
				String fileName = assign.getFilename().split("\\$\\$")[1];
				assign.setFilename(fileName);
			}
		}
		
		// 파일명 재정의
		if (attach != null) {
			if (attach.getUploadpath() != null) {
				String fileName = attach.getFilename().split("\\$\\$")[1];
				attach.setFilename(fileName);
			}
		}

		model.addAttribute("assign", assign);
		model.addAttribute("attach", attach);
		model.addAttribute("name",name);
		return url;
	}
	
	
	@RequestMapping("/registForm")
	public String registForm(Model model, HttpServletRequest request) throws Exception{
		String url = "assign_manage/regist";
		
		HttpSession session=request.getSession();
		MemberVO member=(MemberVO)session.getAttribute("loginUser");
		String id=member.getId();
		
		Map<String, Object> dataMap = assignService.selectClassListNotFinished(id);
		
		model.addAttribute("dataMap", dataMap);
		
		return url;
	}
	
	@Resource(name = "fileUploadPath")
	private String fileUploadPath;
	
	@RequestMapping(value = "/regist", method = RequestMethod.POST, produces = "text/plain; charset=utf-8")
	public String regist(int cc,String startDate,String endDate, HttpServletRequest request, RedirectAttributes rttr, AssignRegistCommand registReq) throws Exception{
		String url = "redirect:list.go";
		
		//System.out.println("startDate : " + startDate);
		//System.out.println("endDate : " + endDate);
		
		String startDate2 = startDate.substring(0, 10) + " " + startDate.substring(11, 16);
		String endDate2 = endDate.substring(0, 10) + " " + endDate.substring(11, 16);
		
		//System.out.println("startDate2 : " + startDate2);
		//System.out.println("endDate2 : " + endDate2);
		
		AssignVO assign = registReq.toAssignVO();
		assign.setClassCode(cc);
		assign.setStartDate(startDate2);
		assign.setEndDate(endDate2);
		
		String savePath = this.fileUploadPath;
		
		try {
			List<AssignVO> assignList = GetAssignByMultipartFileAdapter.save(registReq.getUploadFile(), savePath);
			
			if(assignList==null || assignList.size()==0) {
				assignService.insertAssign(assign);
			}else {
				for(AssignVO assignVO : assignList) {
					assign.setFilename(assignVO.getFilename());
					assign.setFiletype(assignVO.getFiletype());
					assign.setUploadpath(assignVO.getUploadpath());
					
					assignService.insertAssign(assign);
				}
			}
		} catch (Exception e){
			e.printStackTrace();
		}
		return url;
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST, produces = "text/plain; charset=utf-8")
	public String modify(int assignCode, String endDate, HttpServletRequest request, RedirectAttributes rttr, AssignModifyCommand modifyReq) throws SQLException{
		String url="redirect:list.go";
		
		AssignVO assign = modifyReq.toAssignVO();
		
		String endDate2 = endDate.substring(0, 10) + " " + endDate.substring(11, 16);
		
		assign.setAssignCode(assignCode);
		assign.setEndDate(endDate2);
		System.out.println("assignVO:::" + assign);
		
		String savePath = this.fileUploadPath;
		
		try {
			List<AssignVO> assignList = GetAssignByMultipartFileAdapter.save(modifyReq.getUploadFile(), savePath);
			
			if(assignList==null || assignList.size()==0) {
				assignService.updateAssign(assign);
			}else {
				for(AssignVO assignVO : assignList) {
					assign.setFilename(assignVO.getFilename());
					assign.setFiletype(assignVO.getFiletype());
					assign.setUploadpath(assignVO.getUploadpath());
					
					assignService.updateAssign(assign);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteFile", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteFile(@RequestParam Map<String,Object> map){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String assignCodeStr = (String)map.get("assignCode");
		int assignCode = Integer.parseInt(assignCodeStr);
		
		try {
			assignService.deleteFile(assignCode);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	@ResponseBody
	@RequestMapping(value="/deleteAssign", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteAssign(@RequestParam Map<String,Object> map){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String assignCodeStr = (String)map.get("assignCode");
		int assignCode = Integer.parseInt(assignCodeStr);
		
		try {
			assignService.deleteAssign(assignCode);
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/studentAndStatus", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> studentAndStatus(@RequestParam Map<String,Object> map){
		ResponseEntity<Map<String,Object>> entity = null;
		
//		String classCode = (String)map.get("classCode");
//		String assignCode = (String)map.get("assignCode");
//		System.out.println("cc,ac : " + classCode + ", " + assignCode);
		
		Map<String,Object> dataMap = new HashMap<String,Object>();
		System.out.println("과제제출 : " + map);
		try {
			dataMap = assignService.selectRegisteredStudentAtClass(map);
			entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/assignDetail", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> assignDetail(@RequestParam Map<String,Object> map){
		ResponseEntity<Map<String,Object>> entity = null;
		
		String assignCodeStr = String.valueOf(map.get("assignCode"));
		//String classCodeStr = String.valueOf(map.get("classCode"));
		int assignCode = Integer.parseInt(assignCodeStr);
		//int classCode = Integer.parseInt(classCodeStr);
		
		
		
		Map<String,Object> dataMap = new HashMap<String,Object>();
		AssignVO assignVO = new AssignVO();
		
		try {
			assignVO = assignService.selectAssignDetail(assignCode);
			
			// 파일명 재정의
			if (assignVO != null) {
				if (assignVO.getUploadpath() != null) {
					String fileName = assignVO.getFilename().split("\\$\\$")[1];
					assignVO.setFilename(fileName);
				}
			}
			
			dataMap.put("assignVO", assignVO);
			entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.OK);
		} catch (SQLException e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(dataMap,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	
	//강사가 출제한 과제 첨부파일 다운
	@RequestMapping("/getFile")
	public String getFile(int assignCode,Model model) throws Exception{
		String url = "downloadFile";
		
		System.out.println("getFile assignCode : " + assignCode);
		
		AssignVO assign = assignService.selectAssignDetail(assignCode);
		
		model.addAttribute("savedPath", assign.getUploadpath());
		model.addAttribute("fileName", assign.getFilename());
		
		return url;
	}
	
	
	@RequestMapping("/test")
	public String test(kr.or.ddit.command.SearchCriteria cri, Model model) throws Exception{
		String url = "assign_manage/test";

		return url;
	}
}
