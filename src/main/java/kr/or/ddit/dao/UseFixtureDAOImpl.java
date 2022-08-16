package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.FixtureVO;
import kr.or.ddit.dto.UseFixtVO;

public class UseFixtureDAOImpl implements UseFixtureDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	/**
	 * 모든 기자재 목록을 가져온다
	 */
	@Override
	public List<FixtureVO> getAllFixture() throws SQLException {
		List<FixtureVO> fixList = null;
		fixList = session.selectList("Classroom-Mapper.getAllFixture");
		return fixList;
	}

	@Override
	public int getUseFixtSeq() throws SQLException {
		return session.selectOne("Classroom-Mapper.getUseFixtSeq");
	}

	@Override
	public void registUseFixt(UseFixtVO useFixtVO) throws SQLException {
		session.update("Classroom-Mapper.insertUseFixt", useFixtVO);
	}

	@Override
	public void removeUseFixt(int roomCode) throws SQLException {
		session.update("Classroom-Mapper.removeUseFixt", roomCode);
	}

	@Override
	public List<UseFixtVO> getUseFixture() throws SQLException {
		return session.selectList("Classroom-Mapper.getUseFixture");
	}
	
}
