package kr.or.ddit.controller.rest;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jdk.nashorn.internal.objects.annotations.Getter;
import kr.or.ddit.command.ApplyRegistCommand;
import kr.or.ddit.command.ResumeRegsitCommand;
import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.service.ApplyService;


@RestController
@RequestMapping("/common")
public class ApplyRestController {

	@Autowired
	private ApplyService applyService;
	
	@Autowired
	String applyUploadPath;
	
	
	
	//지원서 등록
	
	@ResponseBody
	@RequestMapping(value = "/registapply", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
//	public ResponseEntity<Integer> registapply(ApplyRegistCommand command, MultipartHttpServletRequest request){
	public String registapply(ApplyRegistCommand command, MultipartHttpServletRequest request){
			
		System.out.println(command);
		ResponseEntity<Integer> entity = null;
		
		List<MultipartFile> uploadFile=command.getUploadFile();
		
		String savePath=this.applyUploadPath;
		List<ApplyVO> applyFileList = new ArrayList<ApplyVO>();
		try {
			applyFileList = GetApplyByMultipartFileAdapter.save(uploadFile, savePath);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String FileName=applyFileList.get(0).getApplyFilename();
		String uploadPath=applyFileList.get(0).getApplyUploadPath();
		
		ApplyVO apply=command.toapplyVO();
		apply.setApplyFilename(FileName);
		apply.setApplyUploadPath(uploadPath);
		/*
		try {
			int result =applyService.regist(apply);
			entity = new ResponseEntity<Integer>(result, HttpStatus.OK);
		} catch (Exception e){
			entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

		return entity;
		*/
		String check = "";
		try {
			int result =applyService.regist(apply);
			if(result>0) check="OK";
		} catch (Exception e){
			//entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
			check = "Fail";
		}
		
		return check;
	}
	
	
//	@ResponseBody
//	@RequestMapping(value = "/modifyresume", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
//public ResponseEntity<Integer> modifyresume(ResumeRegsitCommand command, MultipartHttpServletRequest request){
//	
//			
//		System.out.println(command);
//		ResponseEntity<Integer> entity = null;
//		
//		List<MultipartFile> uploadFile=command.getUploadFile();
//		
//		String savePath=this.resumeUploadPath;
//		List<ApplyVO> applyFileList = new ArrayList<ApplyVO>();
//		try {
//			applyFileList = GetApplyByMultipartFileAdapter.save(uploadFile, savePath);
//		} catch (Exception e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		
//		String FileName=applyFileList.get(0).getApplyFilename();
//		String uploadPath=applyFileList.get(0).getApplyUploadPath();
//		
//		ApplyVO apply=command.toapplyVO();
//		apply.setApplyFilename(FileName);
//		apply.setApplyUploadPath(uploadPath);
//		
//		try {
//			int result =applyService.update(apply);
//			entity = new ResponseEntity<Integer>(result, HttpStatus.OK);
//		} catch (Exception e){
//			entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//
//		return entity;
//	
//		
//	}
}
