package kr.or.ddit.controller.rest;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.command.ResumeRegsitCommand;
import kr.or.ddit.dto.ResumeVO;
import kr.or.ddit.service.ResumeService;

@RestController
@RequestMapping("/mresume")
public class ResumeRestController {

	
	@Autowired
	private ResumeService resumeService;
	
	@Autowired
	String resumeUploadPath;
	
	
	@ResponseBody
	@RequestMapping(value = "/modifyresume", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
  
 
	public String modifyresume(ResumeRegsitCommand command,MultipartHttpServletRequest request){
				
		System.out.println(command);
		ResponseEntity<Integer> entity = null;
		
		List<MultipartFile> uploadFile=command.getUploadFile();
		
		String savePath=resumeUploadPath;
		List<ResumeVO> resumeFileList = new ArrayList<ResumeVO>();
		try {
			resumeFileList =GetResumeByMultipartFileAdapter.save(uploadFile, savePath);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String FileName=resumeFileList.get(0).getFileName();
		String uploadPath=resumeFileList.get(0).getUploadPath();
		
		System.out.println("fileName from controller" + FileName);
		System.out.println("uploadPath from controller" + uploadPath);
		
		ResumeVO resume=new ResumeVO();
		resume.setFileName(FileName);
		resume.setUploadPath(uploadPath);
		
		
		
//		try {
//			int result =resumeService.regist(resume);
//			entity = new ResponseEntity<Integer>(result, HttpStatus.OK);
//		} catch (Exception e){
//			entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
//		}
//
//		return entity;
		String check = "";
		try {
			int update=resumeService.update(resume);
			int result =resumeService.regist(resume);
			if(result>0) check="OK";
			else if(update>0)check="OK";
		} catch (Exception e){
			//entity = new ResponseEntity<Integer>(HttpStatus.INTERNAL_SERVER_ERROR);
			check = "Fail";
		}
		
		return check;
		
	}
	
}
