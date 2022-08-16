package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.CounseltVO;
import kr.or.ddit.dto.PacounseltVO;

public class CounseltDAOImpl implements CounseltDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public int selectNextSeq() throws SQLException {
		return session.selectOne("Conselt-Mapper.selectNextSeq");
	}

	@Override
	public void registConselt(CounseltVO con) throws SQLException {
		session.update("Conselt-Mapper.registConselt", con);
	}

	@Override
	public List<CounseltVO> selectApplyingCounselt(String id) throws SQLException {
		return session.selectList("Conselt-Mapper.selectApplyingCounselt",id);
	}

	@Override
	public List<PacounseltVO> selectApplyingPacounselt(String id) throws SQLException {
		return session.selectList("Conselt-Mapper.selectApplyingPacounselt",id);
	}

	@Override
	public void deletePacounselt(int code) throws SQLException {
		session.update("Conselt-Mapper.deletePacounselt", code);
	}

	@Override
	public void deleteCounselt(int code) throws SQLException {
		session.update("Conselt-Mapper.deleteCounselt", code);
	}

	@Override
	public List<CounseltVO> selectAppliedCounselt(String id) throws SQLException {
		return session.selectList("Conselt-Mapper.selectAppliedCounselt",id);
	}

	@Override
	public List<PacounseltVO> selectAppliedPacounselt(String id) throws SQLException {
		return session.selectList("Conselt-Mapper.selectAppliedPacounselt",id);
	}

	@Override
	public CounseltVO selectCounselt(int code) throws SQLException {
		return session.selectOne("Conselt-Mapper.selectCounselt",code);
	}

	@Override
	public PacounseltVO selectPacounselt(int code) throws SQLException {
		return session.selectOne("Conselt-Mapper.selectPacounselt",code);
	}

}
