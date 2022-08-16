package kr.or.ddit.controller.view;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/web")
public class PdfTestController {

	
	@RequestMapping("/pdfviewtest")
	public String pdfviewtest() throws Exception {
		String url = "web/pdfviewtest";
		return url;
	}
	
	@RequestMapping("/viewer")
	public String viewer() throws Exception {
		String url = "web/viewer";
		return url;
	}
	
}
