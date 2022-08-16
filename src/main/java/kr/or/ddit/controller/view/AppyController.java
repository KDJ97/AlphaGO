package kr.or.ddit.controller.view;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.dto.ResumeVO;
import kr.or.ddit.service.ResumeService;

@Controller
@RequestMapping("/common")
public class AppyController {

	@Autowired
	ResumeService resumeService;
	
	
	@RequestMapping("/getFile")
	public String getFile(Model model) throws Exception {
		String url = "downloadFile";

		  ResumeVO resume=resumeService.selectResumeByResumeCode();
		   
		   model.addAttribute("savedPath",resume.getUploadPath());
		   model.addAttribute("fileName",resume.getFileName());

		return url;
	}
	
}
