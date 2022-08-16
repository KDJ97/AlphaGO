package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.dao.FavoritesDAO;
import kr.or.ddit.dto.FavoritesVO;

public class FavoritesServiceImpl implements FavoritesService {

	private FavoritesDAO favoritesDAO;
	public void setFavoritesDAO(FavoritesDAO favoritesDAO) {
		this.favoritesDAO = favoritesDAO;
	}

	@Override
	public void regist(FavoritesVO favorite) throws SQLException {
		// fno_seq.nextVal
		int fno = favoritesDAO.selectFavoritesSeqNext();
		favorite.setFno(fno);

		// insert FavoritesVO
		favoritesDAO.insertFav(favorite);
	}

	@Override
	public List<FavoritesVO> getFavoritesListById(String id) throws SQLException {
		return favoritesDAO.selectFavoritesListById(id);
	}

	@Override
	public void remove(int fno) throws SQLException {
		favoritesDAO.deleteFav(fno);
	}

	@Override
	public void removeFav(String id, int lCode) throws SQLException {
		FavoritesVO fav = new FavoritesVO();
		fav.setId(id);
		fav.setlCode(lCode);

		favoritesDAO.deleteFavByIdAndLCode(fav);
	}



}
