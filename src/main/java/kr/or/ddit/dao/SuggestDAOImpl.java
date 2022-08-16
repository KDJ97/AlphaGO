package kr.or.ddit.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dto.SuggestVO;

public class SuggestDAOImpl implements SuggestDAO{
	
	private SqlSession session;
	public void setSession(SqlSession session) {
		this.session = session;
	}

	@Override
	public List<SuggestVO> selectSearchSuggestList(SearchCriteria cri) throws SQLException {
		int startRow = cri.getStartRowNum();
		int endRow = startRow+cri.getPerPageNum();
		
		Map<String, Object> dataParam = new HashMap<String, Object>();
		dataParam.put("startRow", startRow);
		dataParam.put("endRow", endRow);
		dataParam.put("searchType", cri.getSearchType());
		dataParam.put("keyword", cri.getKeyword());
		
		List<SuggestVO> suggestList = session.selectList("Suggest-Mapper.selectSearchSuggestList", dataParam);
		
		return suggestList;
	}
	
	@Override
	public List<SuggestVO> selectSearchSuggestListForLike(SearchCriteria cri) throws SQLException {
		int startRow = cri.getStartRowNum();
		int endRow = startRow+cri.getPerPageNum()-1;
		
		Map<String, Object> dataParam = new HashMap<String, Object>();
		dataParam.put("startRow", startRow);
		dataParam.put("endRow", endRow);
		dataParam.put("searchType", cri.getSearchType());
		dataParam.put("keyword", cri.getKeyword());
		
		List<SuggestVO> suggestList = session.selectList("Suggest-Mapper.selectSearchSuggestListForLike", dataParam);
		
		return suggestList;
	}

	@Override
	public int selectSearchSuggestListCount(SearchCriteria cri) throws SQLException {
		int count = session.selectOne("Suggest-Mapper.selectSearchSuggestListCount", cri);
		return count;
	}

	@Override
	public void increaseViewCount(int lcode) throws SQLException {
		session.update("Suggest-Mapper.increaseViewCount",lcode);
		
	}

	@Override
	public void increaseLikeCount(int lcode) throws SQLException {
		session.update("Suggest-Mapper.increaseLikeCount",lcode);
	}
	@Override
	public void insertSuggest(SuggestVO Suggest) throws SQLException {
		session.update("Suggest-Mapper.insertSuggest", Suggest);
	}

	@Override
	public void updateSuggest(SuggestVO Suggest) throws SQLException {
		session.update("Suggest-Mapper.updateSuggest",Suggest);
		
	}

	@Override
	public void deleteSuggest(int lcode) throws SQLException {
		session.update("Suggest-Mapper.deleteSuggest", lcode);
		
	}

	@Override
	public SuggestVO selectSuggestByLcode(int lcode) throws SQLException {
		SuggestVO suggest = session.selectOne("Suggest-Mapper.selectSuggestByLcode", lcode);
		return suggest;
	}

	@Override
	public int selectLikeCount(int lcode) throws SQLException {
		int likeCount = session.selectOne("Suggest-Mapper.selectLikeCount",lcode);
		return likeCount;
	}

	@Override
	public void insertSugLike(Map<String, Object> sugLikeMap) throws SQLException {
		session.update("Suggest-Mapper.insertSugLike",sugLikeMap);
	}

	



}
