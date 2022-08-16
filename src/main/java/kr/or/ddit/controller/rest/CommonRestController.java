package kr.or.ddit.controller.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.dto.ApplyVO;
import kr.or.ddit.dto.MenuVO;
import kr.or.ddit.dto.PacounseltVO;
import kr.or.ddit.service.ApplyService;
import kr.or.ddit.service.MenuService;


@RestController
public class CommonRestController {

	@Autowired
	private MenuService menuService;

	@RequestMapping("/subMenu")
	public ResponseEntity<List<MenuVO>> subMenuToJSON(String mCode){
		ResponseEntity<List<MenuVO>> entity = null;
		
		List<MenuVO> subMenu = null;
		
		try {
			subMenu = menuService.getSubMenuList(mCode);
//			for(MenuVO menu : subMenu) {
//				System.out.println("Mcode : " + menu.getMcode());
//			}
			
			entity = new ResponseEntity<List<MenuVO>>(subMenu, HttpStatus.OK);
//			System.out.println(entity);
		} catch (Exception e) {
			entity = new ResponseEntity<List<MenuVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
		return entity;
	}
	
	
	

}
