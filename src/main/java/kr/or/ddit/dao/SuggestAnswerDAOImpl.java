package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.SuggestAnswerVO;

public class SuggestAnswerDAOImpl implements SuggestAnswerDAO{
	
	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public int selectSuggestAnswerSeqNextValue() throws SQLException {
		int col = session.selectOne("SuggestAnswer-Mapper.selectSuggestAnswerSeqNextValue");
		return col;
	}

	@Override
	public List<SuggestAnswerVO> selectSuggestAnswerListPage(int lcode, SearchCriteria cri) throws SQLException {
		int offset = cri.getStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds=new RowBounds(offset,limit);
		
		List<SuggestAnswerVO> suggestAnswerList = session.selectList("SuggestAnswer-Mapper.selectSuggestAnswerList", lcode, rowBounds);
		return suggestAnswerList;
	}

	@Override
	public int countSuggestAnswer(int lcode) throws SQLException {
		int count = session.selectOne("SuggestAnswer-Mapper.countSuggestAnswer", lcode);
		return count;
	}

	@Override
	public void insertSuggestAnswer(SuggestAnswerVO suggestAnswer) throws SQLException {
		session.update("SuggestAnswer-Mapper.insertSuggestAnswer", suggestAnswer);
	}

	@Override
	public void updateSuggestAnswer(SuggestAnswerVO suggestAnswer) throws SQLException {
		
	}

	@Override
	public void deleteSuggestAnswer(int col) throws SQLException {
		session.update("SuggestAnswer-Mapper.deleteSuggestAnswer", col);
	}

}
