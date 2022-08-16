package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.FavoritesVO;

public interface FavoritesService {

	void regist(FavoritesVO favorite) throws SQLException;

	List<FavoritesVO> getFavoritesListById(String id) throws SQLException;

	void remove(int fno) throws SQLException;

	// 즐겨찾기 삭제
	void removeFav(String id, int lCode) throws SQLException;

}
