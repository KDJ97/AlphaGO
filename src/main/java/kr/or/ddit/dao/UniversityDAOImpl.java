package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.dto.UniversityVO;

public class UniversityDAOImpl implements UniversityDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<UniversityVO> selectAllUniList() throws SQLException {
		return session.selectList("University-Mapper.selectAllUniList");
	}

	@Override
	public UniversityVO selectUniByCode(String code) throws SQLException {
		return session.selectOne("University-Mapper.selectUniByCode", code);
	}

	@Override
	public List<UniversityVO> selectUniListByStandard(Map<String, String> keyMap) throws SQLException {
		return session.selectList("University-Mapper.selectUniListByStandard", keyMap);
	}

}
