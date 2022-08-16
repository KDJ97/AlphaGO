package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dto.FavoritesVO;

public interface FavoritesDAO {

	// 시퀀스
	int selectFavoritesSeqNext() throws SQLException;

	// insert
	void insertFav(FavoritesVO fav) throws SQLException;

	// select by id
	List<FavoritesVO> selectFavoritesListById(String id) throws SQLException;

	void deleteFav(int fno) throws SQLException;

	void deleteFavByIdAndLCode(FavoritesVO fav) throws SQLException;

}
