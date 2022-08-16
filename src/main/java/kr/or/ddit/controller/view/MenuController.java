package kr.or.ddit.controller.view;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MenuController {

//	@Autowired
//	MenuService menuService;
//	
//	@RequestMapping("/")
//	public String getMainMenuList(Model model, String mCode) throws Exception{
//		String url = "/test/test";
//		
//		if(mCode ==null) mCode="M000000";
//		
//		try {
//			//GNB
//			List<MenuVO> menuList = menuService.getMainMenuList("M");			
//			model.addAttribute("menuList", menuList);
//			
//			// iframe 상태유지
//			MenuVO menu = menuService.getMenuByMcode(mCode);
//			model.addAttribute("menu", menu);
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//			// Exception 처리 : log 기록...
//			throw e;
//		}
//
//		return url;
//	}
	
}
