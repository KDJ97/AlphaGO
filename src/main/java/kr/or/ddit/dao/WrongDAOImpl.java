package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.Criteria;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.command.YJSearchCriteria;
import kr.or.ddit.dto.ExamVO;
import kr.or.ddit.dto.WrongVO;

public class WrongDAOImpl implements WrongDAO {

	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}
	
	/**
	 * selectbox examlist
	 */
	@Override
	public List<ExamVO> selectExam(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Wrong-Mapper.selectExam", map);
	}

	/**
	 * 오답리스트
	 */
	@Override
	public List<WrongVO> selectWrong(String id, YJSearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		cri.setId(id);
		
		return session.selectList("Wrong-Mapper.selectWrong", cri, rowBounds);
	}

	/**
	 * 오답리스트 카운트
	 */
	@Override
	public int selectWrongCount(String id, YJSearchCriteria cri) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		cri.setId(id);
		
		int count = session.selectOne("Wrong-Mapper.selectWrongCount", cri);
		return count;
	}

	@Override
	public WrongVO selectDetailWrong(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Wrong-Mapper.selectDetailWrong", map);
	}

	@Override
	public WrongVO selectDetailMain(String id) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Wrong-Mapper.selectDetailMain", id);
	}

	@Override
	public List<WrongVO> selectTname(int examCode) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Wrong-Mapper.selectTname", examCode);
	}

	@Override
	public int updateQuestion(Map<String, Object> map) throws SQLException {
		int count = session.update("Wrong-Mapper.updateQuestion", map);
		return count;
	}

	@Override
	public WrongVO selectSname(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Wrong-Mapper.selectSname", map);
	}

	@Override
	public int insertSolution(Map<String, Object> map) throws SQLException {
		int count = session.update("Wrong-Mapper.updateSolution", map);
		return count;
	}

	@Override
	public String selectJimoon(int problemCode) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectOne("Wrong-Mapper.selectJimoon", problemCode);
	}

}
