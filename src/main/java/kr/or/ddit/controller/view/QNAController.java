package kr.or.ddit.controller.view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/qna")
public class QNAController {

	@RequestMapping("/list")
	public String list() throws Exception{
		String url = "qna/list";
		return url;
	}
	
	@RequestMapping("/registForm")
	public String registForm() throws Exception{
		String url = "qna/regist";
		return url;
	}

	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	public String regist() throws Exception{
		String url = "redirect:/qna/list.go";
		//작업
		return url;
	}
	
	@RequestMapping("/detail")
	public String detail() throws Exception{
		String url = "qna/detail";
		//작업
		return url;
	}
	
}
