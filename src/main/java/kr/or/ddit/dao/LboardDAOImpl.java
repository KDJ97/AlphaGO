package kr.or.ddit.dao;

import java.sql.SQLException;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.LboardVO;

public class LboardDAOImpl implements LboardDAO{

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public void insertLboard(LboardVO lboard) throws SQLException {
		session.update("Lboard-Mapper.insertLboard", lboard);
	}

	@Override
	public int selectLboardSeqNext() throws SQLException {
		int lboard_seq = session.selectOne("Lboard-Mapper.selectLboardSeqNext");
		return lboard_seq;
	}

}
