package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.dto.DmVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.service.DmService;
import kr.or.ddit.service.MemberService;

//작성자 : 예현의
//작성일 : 2022-07-01
//쪽지함 Controller


@Controller
@RequestMapping("/note")
public class NoteController {

	private static final Logger logger = LoggerFactory.getLogger(NoteController.class);

	@Autowired
	private DmService dmService;

	@Autowired
	private MemberService memberService;


	@RequestMapping("/sendList")
	public ModelAndView noteSendList(HttpSession session, ModelAndView mnv) throws SQLException, Exception {
		logger.info("note sendList 컨트롤러 출력");

		String url = "note/sendList";

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		if(loginUser == null) logger.info("loginUser가 null 입니다.");

		String id = loginUser.getId();
		logger.info("loginUser의 id : " + id);

		try {
			List<DmVO> dmList = dmService.getSendList(id);
			int reciveCnt = dmService.selectNewDm(id);
			mnv.addObject("reciveCnt", reciveCnt);
			mnv.addObject("dmList", dmList);

			logger.info("dmList개수 : "  + dmList.size());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		mnv.setViewName(url);

		return mnv;
	}
	@RequestMapping("/reciveList")
	public ModelAndView noteReciveList(HttpSession session, ModelAndView mnv) throws SQLException, Exception{
		logger.info("note reciveList 컨트롤러 출력");
		String url = "note/reciveList";

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		String id = loginUser.getId();
		logger.info("loginUser의 id : " + id);

		try {
			List<DmVO> dmList = dmService.getReciveList(id);
			int reciveCnt = dmService.selectNewDm(id);
			mnv.addObject("reciveCnt", reciveCnt);
			mnv.addObject("dmList", dmList);

			logger.info("dmList개수 : "  + dmList.size());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		mnv.setViewName(url);


		return mnv;
	}

	@RequestMapping("/detail")
	public ModelAndView noteDetail(String code, String from, HttpSession session, ModelAndView mnv) throws SQLException, Exception {
		logger.info("note datail 컨트롤러 출력");
		String url = "note/detail";

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		String id = loginUser.getId();



		DmVO dm = null;
		MemberVO receiver = null;
		MemberVO sender = null;
		try {
			dm = dmService.getDm(code, from);
			receiver = memberService.getMember(dm.getDmReceiver());
			sender = memberService.getMember(dm.getDmSender());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		int reciveCnt = dmService.selectNewDm(id);
		mnv.addObject("reciveCnt", reciveCnt);

		logger.info("code : " + code + ", from : " + from);
		logger.info("loginUser의 id : " + id);
		logger.info("reciveCnt : " + reciveCnt);


		mnv.addObject("from", from);
		mnv.addObject("reciveCnt", reciveCnt);
		mnv.addObject("dm", dm);
		mnv.addObject("receiver", receiver);
		mnv.addObject("sender", sender);
		mnv.setViewName(url);
		return mnv;
	}

	@RequestMapping("/registForm")
	public ModelAndView noteInsert(HttpSession session, ModelAndView mnv) throws SQLException, Exception{
		String url = "note/regist";
		logger.info("note regist 컨트롤러 출력");

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		String id = loginUser.getId();
		int reciveCnt = dmService.selectNewDm(id);
		mnv.addObject("reciveCnt", reciveCnt);
		mnv.setViewName(url);
		return mnv;
	}

	@RequestMapping(value = "/regist", method = RequestMethod.POST)
	public String regist(@RequestParam("to")String to, @RequestParam("title")String title, @RequestParam(value = "content", defaultValue = "")String content, HttpSession session, Model model) {
		String url = "redirect:sendList.go";

		List<String> to_list = Arrays.asList(to.split(","));

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		String from = loginUser.getId();

		logger.info("from : " + from);
		logger.info("to_list : " + to_list.toString());
		logger.info("title : " + title);
		logger.info("content : " + content);

		dmService.sendDm(to_list, from, title, content);


		return url;
	}


	@RequestMapping("/delete")
	public String noteDelete(String code, String div) throws SQLException, Exception{
		logger.info("note delete 컨트롤러 출력");
		logger.info("code : " + code);
		logger.info("div : " + div);
		String url = "redirect:sendList.go";
		if("R".equals(div)) url = "redirect:reciveList.go";

		dmService.deleteDm(code, div);

		return url;
	}

}
