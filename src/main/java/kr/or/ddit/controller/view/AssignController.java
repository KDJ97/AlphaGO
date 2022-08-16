package kr.or.ddit.controller.view;

import java.io.File;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.command.AssignAttachModifyCommand;
import kr.or.ddit.command.AssignAttachRegistCommand;
import kr.or.ddit.command.NoticeRegistCommand;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.controller.rest.GetAssignAttachesByMultipartFileAdapter;
import kr.or.ddit.controller.rest.GetAttachesByMultipartFileAdapter;
import kr.or.ddit.dto.AssignAttachVO;
import kr.or.ddit.dto.AssignNameVO;
import kr.or.ddit.dto.AssignVO;
import kr.or.ddit.dto.AttachVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.ClassingVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.NoticeVO;
import kr.or.ddit.service.AssignService;
import kr.or.ddit.service.ClassService;
import kr.or.ddit.service.MemberService;

// 작성자 : 이유정
// 과제

@Controller
@RequestMapping("/assign")
public class AssignController {

	@Autowired
	private MemberService memberService;

	@RequestMapping("/main")
	public void main() {
	}

	@Autowired
	private AssignService assignService;

	@Autowired
	private ClassService classService;

	/**
	 * 원생이 수강중인 강의리스트, 전체 과제 리스트
	 * 
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/list")
	public String assignList(HttpSession session, Model model) {
		String url = "/assign/list";
		
		Map<String, Object> dataMap = null;
		List<AssignNameVO> assignList = null;
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
//		if (member == null) {
//			// 로그인 session 정보가 없을 때
//			url = "redirect:/common/loginTimeOut";
//			return url;
//		}

		String id = member.getId();

		try {
			dataMap = classService.getClassing(id);
			assignList = assignService.getAssign(id);
			
			dataMap.put("assignList", assignList);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		model.addAttribute("dataMap", dataMap);
		return url;
	}

	/**
	 * 강의 클릭후 과제 리스트 
	 * @param session
	 * @param name
	 * @return
	 * @throws SQLException
	 */
	@ResponseBody
	@RequestMapping("/assignlist")
	public ResponseEntity<List<AssignNameVO>> assignNameList(HttpSession session, String name) throws SQLException {
		ResponseEntity<List<AssignNameVO>> entity = null;
		List<AssignNameVO> assignNameList = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();

		//map.put("assignCode", assignCode);
		map.put("className", name);
		map.put("id", id);

		assignNameList = assignService.selectAssignName(map);

		entity = new ResponseEntity<List<AssignNameVO>>(assignNameList, HttpStatus.OK);

		return entity;
	}

	/**
	 * 과제 상세 화면
	 * @param model
	 * @param from
	 * @param session
	 * @param assignCode
	 * @return
	 */
	@RequestMapping(value = "/detail")
	public String assignDetail(Model model, String from, HttpSession session, int assignCode) {
		String url = "/assign/detail";

		AssignVO assign = null;
		AssignAttachVO attach = null;

		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");

		String id = member.getId();
		
		map.put("assignCode", assignCode);
		map.put("id", id);
		
	    try {
			assign = assignService.selectAssignDetail(assignCode);
			attach = assignService.selectAssignAttach(map);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

		// 파일명 재정의
		if (assign != null) {
			if (assign.getUploadpath() != null) {
				String fileName = assign.getFilename().split("\\$\\$")[1];
				assign.setFilename(fileName);
			}
		}
		
		model.addAttribute("attach", attach);
		model.addAttribute("assign", assign);
		model.addAttribute("from", from);
		
		return url;
	}

	@RequestMapping("/registForm")
	public String registForm() throws Exception {
		String url = "assign/regist";
		return url;
	}
	
	@Resource(name = "fileUploadPath")
	private String fileUploadPath;
	
	/**
	 * 과제 제출 화면 출력
	 * @param assignCode
	 * @param session
	 * @param model
	 * @param registReq
	 * @return
	 */
	@RequestMapping(value = "/regist", method = RequestMethod.GET, produces = "text/plain; charset=utf-8")
	public String assignRegistForm(int assignCode, HttpSession session, Model model, AssignAttachRegistCommand registReq) {
		String url = "assign/regist";
		
		AssignVO assign = null;		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		String id = member.getId();
		
		try {

			assign = assignService.selectAssignDetail(assignCode);

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

		model.addAttribute("assign", assign);

		return url;
	}
	
	/**
	 * 과제 제출 
	 * @param assignCode
	 * @param session
	 * @param rttr
	 * @param registReq
	 * @return
	 */
	@RequestMapping(value = "/regist", method = RequestMethod.POST, produces = "text/plain; charset=utf-8")
	public String assignRegist(int assignCode, HttpSession session, RedirectAttributes rttr, AssignAttachRegistCommand registReq) {
		String url = "redirect:/assign/detail.go";
	
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		String id = member.getId();
		
		AssignAttachVO attach = registReq.toAssignAttachVO();
		attach.setAssignCode(assignCode);
		attach.setId(id);
		attach.setStatus("제출 완료");
		
		String savePath = this.fileUploadPath;
		
		try {
			List<AssignAttachVO> attachList = GetAssignAttachesByMultipartFileAdapter.save(registReq.getUploadFile(), savePath);
			
			if(attachList==null || attachList.size()==0) {				
				assignService.insertAssignAttach(attach);
				
			} else {
				for(AssignAttachVO attVo : attachList) {
					attach.setFilename(attVo.getFilename());
					attach.setFiletype(attVo.getFiletype());
					attach.setUploadpath(attVo.getUploadpath());
					
					assignService.insertAssignAttach(attach);
				}
			}
			
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		rttr.addAttribute("assignCode", attach.getAssignCode());
		
		return url;
	}

	@RequestMapping("/modifyForm")
	public String modifyForm() throws Exception {
		String url = "assign/modify";
		return url;
	}
	
	/**
	 * 과제 수정 화면 출력내용
	 * @param assignCode
	 * @param session
	 * @param model
	 * @param registReq
	 * @return
	 */
	@RequestMapping(value = "/modify", method = RequestMethod.GET, produces = "text/plain; charset=utf-8")
	public String assignModifyForm(int assignCode, HttpSession session, Model model, AssignAttachRegistCommand registReq) {
		String url = "assign/modify";
		
		AssignVO assign = null;		
		AssignAttachVO attach = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		String id = member.getId();
		
		map.put("assignCode", assignCode);
		map.put("id", id);	
		
		try {
			assign = assignService.selectAssignDetail(assignCode);
			attach = assignService.selectAssignAttach(map);

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
		return url;
	}
	
	/**
	 * 과제 수정 
	 * @param assignCode
	 * @param session
	 * @param rttr
	 * @param registReq
	 * @return
	 * @throws SQLException 
	 */

	@RequestMapping(value = "/modify", method = RequestMethod.POST, produces = "text/plain; charset=utf-8")
	public String assignModify(int assignCode, HttpSession session, RedirectAttributes rttr, AssignAttachModifyCommand modifyReq) throws SQLException {
		String url = "redirect:/assign/detail.go";
	
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		String id = member.getId();
		
		AssignAttachVO attach = modifyReq.toAssignAttachVO();
		attach.setAssignCode(assignCode);
		attach.setId(id);
		
		String savePath = this.fileUploadPath;
		
		try {
			List<AssignAttachVO> attachList = GetAssignAttachesByMultipartFileAdapter.save(modifyReq.getUploadFile(), savePath);
		
			if(attachList==null || attachList.size()==0) {
			
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("assignCode", assignCode);
				map.put("id", id);
				AssignAttachVO oldAttach = assignService.selectAssignAttach(map);

				if(modifyReq.getDeleteFile() !=null && modifyReq.getDeleteFile()[0] != null) {	
					System.out.println("삭제");
					File deleteFile = new File(oldAttach.getUploadpath(), oldAttach.getFilename());
					if (deleteFile.exists()) {
						deleteFile.delete(); // File 삭제
					}
					attach.setFilename(null);
					attach.setFiletype(null);
					attach.setUploadpath(null);
				} else {
					attach.setFilename(oldAttach.getFilename());
					attach.setFiletype(oldAttach.getFiletype());
					attach.setUploadpath(oldAttach.getUploadpath());	
				}
				
				assignService.updateAssignAttach(attach);
			}else {
				for(AssignAttachVO attVo : attachList) {
					attach.setFilename(attVo.getFilename());
					attach.setFiletype(attVo.getFiletype());
					attach.setUploadpath(attVo.getUploadpath());
					
					assignService.updateAssignAttach(attach);				
					
				}
			}
			
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		rttr.addAttribute("assignCode", attach.getAssignCode());
		return url;
	}
	
	/**
	 * 원생이 제출한 과제 첨부파일 다운
	 * @param assignCode
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getAttachFile")
	public String getAttachFile(int assignCode, HttpSession session, Model model) throws Exception {
		String url = "downloadFile";
		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		String id = member.getId();
		
		map.put("id", id);
		map.put("assignCode", assignCode);
		
		AssignAttachVO attach = assignService.selectAssignAttach(map);

		model.addAttribute("savedPath", attach.getUploadpath());
		model.addAttribute("fileName", attach.getFilename());
		return url;
	}
	
	/**
	 * 강사가 출제한 과제 첨부파일 다운
	 * @param assignCode
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getFile")
	public String getAssignFile(int assignCode, Model model) throws Exception {
		String url = "downloadFile";
		AssignVO assign = assignService.selectAssignDetail(assignCode);

		model.addAttribute("savedPath", assign.getUploadpath());
		model.addAttribute("fileName", assign.getFilename());
		return url;
	}
	
	/**
	 * 과제 삭제
	 * @param assignCode
	 * @param rttr
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/remove")
	public String remove(int assignCode, RedirectAttributes rttr, HttpSession session) throws Exception {
		String url = "redirect:/assign/detail.go";

		Map<String, Object> map = new HashMap<String, Object>();
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		String id = member.getId();
		map.put("id", id);
		map.put("assignCode", assignCode);
		
		assignService.deleteAssignAttach(map);

		rttr.addAttribute("assignCode", assignCode);
		rttr.addAttribute("from", "remove");

		return url;
	}
}
