package kr.or.ddit.controller.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.dto.DmVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.dto.MenuVO;
import kr.or.ddit.service.DmService;
import kr.or.ddit.service.MemberService;
import kr.or.ddit.service.MenuService;


@Controller
public class CommonController {

	@Autowired
	MenuService menuService;

	@Autowired
	MemberService memberService;

	@Autowired
	private DmService dmService;

	@RequestMapping("/main")
	public String home(HttpServletRequest request) {
		String url = "";

		HttpSession session = request.getSession();
		String auth = (String) session.getAttribute("auth");

		if(auth.equals("M")) {
			url = "redirect:/master/home.go";
		}else if(auth.equals("S")) {
			url = "redirect:member/home.go";
		}else if(auth.equals("T")) {
			url = "redirect:/teacher/home.go";
		}
		return url;
	}

	@RequestMapping("/index")
	public String index(@RequestParam(defaultValue = "M000000") String mCode,
			HttpServletRequest request,	Model model) throws Exception {
		String url = "test/test";

		//세션에서 로그인 유저의 auth가져오기 (auth는 LoginSuccessHandler에서 가져옴)
		HttpSession session = request.getSession();
		String session_auth = (String) session.getAttribute("auth");
		if(session_auth == null) {
			//로그인 session 정보가 없을 때
			url = "redirect:/common/loginTimeOut";
//			logger.info("sessoion+auth 정보가 없음");
			return url;
		}
		System.out.println("Auth from session in CommonController index.go: " + session_auth);
//		if(session_auth.equals("T")) mCode="T000000";
//		if(session_auth.equals("S")) mCode="S000000";

		//메인메뉴 리스트
		List<MenuVO> menuList = menuService.getMainMenuList(session_auth);
		if(menuList!=null) System.out.println("메인메뉴 개수 : " + menuList.size());

		Map<String, Object> subMap = new HashMap<String, Object>();
		List<MenuVO> submenuList = new ArrayList<MenuVO>();
		List<MenuVO> tempSubList = null;

		//메인메뉴 mcode로 서브메뉴 뽑아오기
		int i = 1;
		for(MenuVO menu : menuList) {
			if(!menu.getMname().equals("HOME")) {
				tempSubList = menuService.getSubMenuList(menu.getMcode());
				for(int j = 0; j < tempSubList.size(); j++) {
					submenuList.add(tempSubList.get(j));
				}
//				subMap.put(menu.getMcode(), submenuList);
				i++;
			}
		}
//		if(subMap!=null) System.out.println("subMap : " + subMap);
		if(submenuList!=null) System.out.println("submenuList 개수 : " + submenuList.size());

		MenuVO menu = menuService.getMenuByMcode(mCode);

		model.addAttribute("menuList", menuList);
		model.addAttribute("submenuList", submenuList);
//		model.addAttribute("subMap", subMap);
		model.addAttribute("menu", menu);



		//header 쪽지 List
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if(loginUser!=null) {
			List<DmVO> dmList = dmService.getNotReadDm(loginUser.getId());
			model.addAttribute("notReadDmList", dmList);
			System.out.println("dmList 갯수 : " + dmList.size());
		}

		return url;
	}

	@RequestMapping(value = "/common/loginForm", method = RequestMethod.GET)
	public String loginForm(@RequestParam(defaultValue = "") String error,
							HttpServletResponse response) {
		String url = "common/loginForm";

		if(error.equals("-1")) {
			response.setStatus(302);
		}
		return url;
	}

	@RequestMapping("/security/accessDenied")
	public void accessDenied() {}

	@RequestMapping("/common/loginTimeOut")
	public String loginTimeOut(Model model) throws Exception{
		String url = "security/sessionOut";

		model.addAttribute("message", "세션이 만료되었습니다.\\n다시 로그인 하세요!");
		return url;
	}


//	@RequestMapping(value = "/common/login", method = RequestMethod.POST)
//	public String login(Model model,
//					String id,
//					String pwd,
//					HttpSession session) throws Exception{
//
//		String url = "redirect:/index.do";
//
//		try {
//			memberService.login(id, pwd);
//			session.setAttribute("loginUser", memberService.getMember(id));
//
//		} catch (NotFoundIdException|InvalidPasswordException e) {
//			url = "common/login_fail";
//		} catch (SQLException e) {
//			e.printStackTrace();
//			throw e;
//		}
//		return url;
//	}

	@RequestMapping(value = "/common/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		String url = "redirect:/";
		session.invalidate();
		return url;
	}
}






















