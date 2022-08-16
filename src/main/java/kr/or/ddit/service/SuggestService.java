package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.Map;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.SuggestVO;

public interface SuggestService {

	//리스트 조회
	Map<String, Object> getSuggestList(SearchCriteria cri, String selectedOrder) throws SQLException;
	
	//상세보기
	SuggestVO getSuggest(int lcode) throws SQLException;
	
	//수정화면 상세
	SuggestVO getSuggestForModify(int lcode) throws SQLException;
	
	//등록
	void regist(SuggestVO suggest) throws SQLException;
	
	//수정
	void modify(SuggestVO suggset) throws SQLException;
	
	//삭제
	void remove(int lcode) throws SQLException;
	
	//좋아요
	void like(int lcode) throws SQLException;
	
	//좋아요 Count
	int likeCount(int lcode) throws SQLException;
	
	//SUG_LIKE 등록
	void registSUGLIKE(Map<String,Object> sugLikeMap) throws SQLException;
}
