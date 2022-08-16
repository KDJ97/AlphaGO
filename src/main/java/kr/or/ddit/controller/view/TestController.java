package kr.or.ddit.controller.view;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


// 작성자 : 예현의
// 작성일 : 2022-06-29
// 삭제되도 되는 테스트 코드를 위한 컨트롤러

@Controller
public class TestController {
	private static final Logger logger = LoggerFactory.getLogger(TestController.class);
	
	@RequestMapping("/test")
	public String testSitemesh() {
		String url = "test/test";
		logger.info("sitemesh test 컨트롤러 출력");
		return url;
	}
	
	

	
}
