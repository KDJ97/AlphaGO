package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.MenuVO;

public interface MenuService {
	
	/**
	 * 권한에 따른 리스트 반환
	 * @return 메뉴리스트 반환
	 * @throws SQLException
	 */
	List<MenuVO> getMainMenuList(String auth)throws SQLException;
	
	List<MenuVO> getSubMenuList(String mCode)throws SQLException;
	
	MenuVO getMenuByMcode(String mCode)throws SQLException;
	
	MenuVO getMenuByMname(String mName)throws SQLException;
}
