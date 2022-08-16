package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.FavoritesVO;

public class FavoritesDAOImpl implements FavoritesDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public int selectFavoritesSeqNext() throws SQLException {
		return session.selectOne("Favorites-Mapper.selectFavoritesSeqNext");
	}

	@Override
	public void insertFav(FavoritesVO fav) throws SQLException {
		session.update("Favorites-Mapper.insertFav", fav);
	}

	@Override
	public List<FavoritesVO> selectFavoritesListById(String id) throws SQLException {
		return session.selectList("Favorites-Mapper.selectFavoritesListById", id);
	}

	@Override
	public void deleteFav(int fno) throws SQLException {
		session.update("Favorites-Mapper.deleteFav", fno);
	}

	@Override
	public void deleteFavByIdAndLCode(FavoritesVO fav) throws SQLException {
		session.update("Favorites-Mapper.deleteFavByIdAndLCode", fav);
	}

}
