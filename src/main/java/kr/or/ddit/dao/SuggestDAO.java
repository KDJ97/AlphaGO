package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.SuggestVO;

public interface SuggestDAO {
	//등록일순으로 리스트 출력
	List<SuggestVO> selectSearchSuggestList(SearchCriteria cri) throws SQLException;
	//좋아요 순으로 리스트 출력
	List<SuggestVO> selectSearchSuggestListForLike(SearchCriteria cri) throws SQLException;
	
	int selectSearchSuggestListCount(SearchCriteria cri) throws SQLException;
	
	SuggestVO selectSuggestByLcode(int lcode) throws SQLException;
	
	void increaseViewCount(int lcode) throws SQLException;
	void increaseLikeCount(int lcode) throws SQLException;
	
	void insertSuggest(SuggestVO Suggest) throws SQLException;
	void insertSugLike(Map<String,Object> sugLikeMap) throws SQLException;
	
	void updateSuggest(SuggestVO Suggest) throws SQLException;
	
	void deleteSuggest(int lcode) throws SQLException;
	
	int selectLikeCount(int lcode) throws SQLException;
	
}
