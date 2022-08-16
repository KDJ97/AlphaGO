package kr.or.ddit.controller.view;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.command.PacounseltDateCommand;
import kr.or.ddit.command.TeachermasCommand;
import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.dto.MemberCountVO;
import kr.or.ddit.dto.ResumeVO;
import kr.or.ddit.dto.SchoolVO;
import kr.or.ddit.dto.SubdetailClassingVO;
import kr.or.ddit.service.ApplyService;
import kr.or.ddit.service.MHomeService;

@Controller
@RequestMapping("/master")
public class DJ_MasterController {

	@Autowired
	MHomeService mhomeService;
	 
	@Autowired
	ApplyService applyService;
	
	@RequestMapping("/home")
	public String home(Model model) throws Exception{
		String url = "master/home";
		return url;
	}
	
	@ResponseBody
	@RequestMapping("/selectTeacherAttendList")
	public ResponseEntity<List<TeachermasCommand>> selectTeacherAttendList(){
		ResponseEntity<List<TeachermasCommand>> entity = null;
		List<TeachermasCommand> list = null;
		
		try {
			list = mhomeService.selectTeacherAttendList();
			entity = new ResponseEntity<List<TeachermasCommand>>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<TeachermasCommand>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping("/selectCounseltList")
	public ResponseEntity<List<PacounseltDateCommand>> selectCounseltList(){
		ResponseEntity<List<PacounseltDateCommand>> entity = null;
		List<PacounseltDateCommand> list = null;
		try {
			list = mhomeService.selectCounseltList();
			entity = new ResponseEntity<List<PacounseltDateCommand>>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<PacounseltDateCommand>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping("/selectMemberCountList")
	public ResponseEntity<List<MemberCountVO>> selectMemberCountList(){
		ResponseEntity<List<MemberCountVO>> entity = null;
		List<MemberCountVO> list = null;
		try {
			list = mhomeService.selectMemberCount();
			entity = new ResponseEntity<List<MemberCountVO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<MemberCountVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping("/selectSubdetailClassingCountList")
	public ResponseEntity<List<SubdetailClassingVO>> selectSubdetailClassingCountList(){
		ResponseEntity<List<SubdetailClassingVO>> entity = null;
		List<SubdetailClassingVO> list = null;
		try {
			list = mhomeService.selectSubdetailClassingCountList();
			entity = new ResponseEntity<List<SubdetailClassingVO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<SubdetailClassingVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	@ResponseBody
	@RequestMapping("/selectSchoolCountBySchoolCodeFromMember")
	public ResponseEntity<List<SchoolVO>> selectSchoolCountBySchoolCodeFromMember(){
		ResponseEntity<List<SchoolVO>> entity = null;
		List<SchoolVO> list = null;
		try {
			list = mhomeService.selectSchoolCountBySchoolCodeFromMember();
			entity = new ResponseEntity<List<SchoolVO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<SchoolVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping("/selectApplyList")
	public ResponseEntity<List<ApplyVO>> selectApplyList(){
		ResponseEntity<List<ApplyVO>> entity = null;
		List<ApplyVO> list = null;
		try {
			list = mhomeService.selectApplyList();
			entity = new ResponseEntity<List<ApplyVO>>(list, HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<ApplyVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return entity;
	}
	
	@RequestMapping("/getFile")
	public String getFile(String applyCode, Model model) throws Exception {
		String url = "downloadFile";
		
		int applycode = Integer.parseInt(applyCode);
		ApplyVO apply = applyService.selectApplyByApplyCode(applycode);
		
		model.addAttribute("savedPath", apply.getApplyUploadPath());
		model.addAttribute("fileName", apply.getApplyFilename());
		return url;
	}
}



















