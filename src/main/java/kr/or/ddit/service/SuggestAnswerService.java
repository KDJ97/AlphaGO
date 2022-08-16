package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.Map;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.SuggestAnswerVO;

public interface SuggestAnswerService {

	//답글 리스트 조회
	Map<String, Object> getSuggestAnswerList(int lcode, SearchCriteria cri) throws SQLException;
	
	//답글 개수
	int getSuggestAnswerCount(int lcode) throws SQLException;
	
	//등록
	void registSuggestAnswer(SuggestAnswerVO suggestAnswer) throws SQLException;
	
	//수정
	void modifySuggestAnswer(SuggestAnswerVO suggestAnswer) throws SQLException;
	
	//삭제
	void removeSuggestAnswer(int col) throws SQLException;
}
