package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.MenuVO;

public interface MenuDAO {

	/**
	 * 권한에 맞는 메뉴를 가져오는 리스트
	 * @return 메뉴리스트 반환
	 */
	// 메인메뉴
	List<MenuVO> selectMainMenu(String auth) throws SQLException;
	
	// 서브메뉴
	List<MenuVO> selectSubMenu(String mCode) throws SQLException;

	// 메뉴정보
	MenuVO selectMenuByMcode(String mCode) throws SQLException;
	MenuVO selectMenuByMname(String mName) throws SQLException;
	
}
