package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.ClassReviewVO;
import kr.or.ddit.dto.ClassVO;
import kr.or.ddit.dto.SubjectVO;

public class ReviewDAOImpl implements ReviewDAO {
	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<ClassVO> classList(String id) throws SQLException {
		// TODO Auto-generated method stub
		return session.selectList("Review-Mapper.classList", id);
	}

	@Override
	public List<ClassReviewVO> selectReviewAll() throws SQLException {

		return session.selectList("Review-Mapper.reviewAll");
	}

//	@Override
//	public int selectReviewAllCount() throws SQLException {
//		int count = session.selectOne("Review-Mapper.reviewAllCount");
//		return count;
//	}

	@Override
	public double reviewAvg(String classCode) throws SQLException {
		if(session.selectOne("Review-Mapper.reviewAvg", classCode) == null) {
			return 0;
		}
		return session.selectOne("Review-Mapper.reviewAvg", classCode);
	}

	@Override
	public List<ClassReviewVO> reviewClass(String classCode) throws SQLException {
		return session.selectList("Review-Mapper.reviewClass", classCode);
	}

	@Override
	public String selectSeq() throws SQLException {
		return session.selectOne("Review-Mapper.selectSeq");
	}

	@Override
	public int insertReview(ClassReviewVO vo) throws SQLException {
		return session.update("Review-Mapper.insertReview", vo);
	}

	@Override
	public ClassVO infoClass(String classCode) throws SQLException {
		return session.selectOne("Review-Mapper.infoClass", classCode);
	}

}
