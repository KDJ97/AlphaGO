package kr.or.ddit.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.command.PageMaker;
import kr.or.ddit.command.SearchCriteria;
import kr.or.ddit.dao.LboardDAO;
import kr.or.ddit.dao.SuggestAnswerDAO;
import kr.or.ddit.dao.SuggestDAO;
import kr.or.ddit.dto.LboardVO;
import kr.or.ddit.dto.SuggestVO;

public class SuggestServiceImpl implements SuggestService {

	private SuggestDAO suggestDAO;
	public void setSuggestDAO(SuggestDAO suggestDAO) {
		this.suggestDAO = suggestDAO;
	}
	
	private LboardDAO lboardDAO;
	public void setLboardDAO(LboardDAO lboardDAO) {
		this.lboardDAO = lboardDAO;
	}
	
	private SuggestAnswerDAO suggestAnswerDAO;
	public void setSuggestAnswerDAO(SuggestAnswerDAO suggestAnswerDAO) {
		this.suggestAnswerDAO = suggestAnswerDAO;
	}

	@Override
	public Map<String, Object> getSuggestList(SearchCriteria cri, String selectedOrder) throws SQLException {
		Map<String, Object> dataMap=null;
		try {
			 dataMap = new HashMap<String, Object>();
			 List<SuggestVO> suggestList = new ArrayList<SuggestVO>();
			 System.out.println("serviceImpl에서  selectedOrder : " + selectedOrder);
			// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기.
			if(selectedOrder.equals("like")) {
				suggestList = suggestDAO.selectSearchSuggestListForLike(cri);
			}else {
				suggestList = suggestDAO.selectSearchSuggestList(cri);
			}
			
			// 전체 suggest 개수
			int totalCount = suggestDAO.selectSearchSuggestListCount(cri);

			// PageMaker 생성.
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(totalCount);

			dataMap.put("suggestList", suggestList);
			dataMap.put("pageMaker", pageMaker);
			dataMap.put("selectedOrder", selectedOrder);

			return dataMap;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dataMap;
	}

	@Override
	public SuggestVO getSuggest(int lcode) throws SQLException {
		SuggestVO suggest = null ;
		try {
			suggest = suggestDAO.selectSuggestByLcode(lcode);
			
			
			suggestDAO.increaseViewCount(lcode);
			return suggest;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return suggest;
	}

	@Override
	public SuggestVO getSuggestForModify(int lcode) throws SQLException {
		SuggestVO suggest = null ;
		try {
			suggest = suggestDAO.selectSuggestByLcode(lcode);
			
			//answer count 입력
			int answercnt = suggestAnswerDAO.countSuggestAnswer(suggest.getLcode());
			suggest.setAnswercnt(answercnt);
			
			return suggest;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return suggest;
	}

	@Override
	public void regist(SuggestVO suggest) throws SQLException {
			
		int lcode = lboardDAO.selectLboardSeqNext();
		
		LboardVO lboard = new LboardVO();
		lboard.setLcode(lcode);
		lboard.setBcode("SUGGEST");
		
		System.out.println(lboard.toString());
		
		lboardDAO.insertLboard(lboard);
		suggest.setLcode(lcode);
		
		System.out.println(suggest.toString());
		
		suggestDAO.insertSuggest(suggest);
	}

	@Override
	public void modify(SuggestVO suggset) throws SQLException {
		suggestDAO.updateSuggest(suggset);
	}

	@Override
	public void remove(int lcode) throws SQLException {
		suggestDAO.deleteSuggest(lcode);
	}

	@Override
	public void like(int lcode) throws SQLException {
		try {
			suggestDAO.increaseLikeCount(lcode);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int likeCount(int lcode) throws SQLException {
		int likeCount = suggestDAO.selectLikeCount(lcode);
		return likeCount;
	}

	@Override
	public void registSUGLIKE(Map<String, Object> sugLikeMap) throws SQLException {
		suggestDAO.insertSugLike(sugLikeMap);
	}

}
