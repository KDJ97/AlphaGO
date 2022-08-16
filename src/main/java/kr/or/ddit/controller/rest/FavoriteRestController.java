package kr.or.ddit.controller.rest;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.dto.FavoritesVO;
import kr.or.ddit.dto.MemberVO;
import kr.or.ddit.service.FavoritesService;

@RestController
public class FavoriteRestController {

	private static final Logger logger = LoggerFactory.getLogger(FavoriteRestController.class);

	@Autowired
	private FavoritesService favoritesService;


	@RequestMapping("/favorite/regist")
	public ResponseEntity<FavoritesVO> registFavorite(int lCode, HttpSession session){
		ResponseEntity<FavoritesVO> entity = null;

		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		String id = member.getId();


		try {
			FavoritesVO favorite = new FavoritesVO();
			favorite.setId(id);
			favorite.setlCode(lCode);

			favoritesService.regist(favorite);

			entity = new ResponseEntity<FavoritesVO>(favorite, HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<FavoritesVO>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}


		return entity;
	}

	@RequestMapping("/favorite/remove")
	public ResponseEntity<String> removeFavorite(int fno){
		ResponseEntity<String> entity = null;

		try {
			favoritesService.remove(fno);
			entity = new ResponseEntity<String>("remove", HttpStatus.OK);

		} catch (Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}


		return entity;
	}
}
