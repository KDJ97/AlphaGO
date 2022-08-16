package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.SuggestAnswerVO;

public interface SuggestAnswerDAO {

	int selectSuggestAnswerSeqNextValue() throws SQLException;
	List<SuggestAnswerVO> selectSuggestAnswerListPage (int lcode, SearchCriteria cri) throws SQLException;
	int countSuggestAnswer(int lcode) throws SQLException;
	
	void insertSuggestAnswer(SuggestAnswerVO suggestAnswer) throws SQLException;
	void updateSuggestAnswer(SuggestAnswerVO suggestAnswer) throws SQLException;
	void deleteSuggestAnswer(int col) throws SQLException;
	
	
}
